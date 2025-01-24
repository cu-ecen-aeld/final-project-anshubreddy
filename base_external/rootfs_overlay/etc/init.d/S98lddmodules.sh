#!/bin/sh

# Script that loads/unloads both scull and fault drivers
# Based off of: https://github.com/cu-ecen-aeld/ldd3/blob/master/scull/scull_load, https://github.com/cu-ecen-aeld/ldd3/blob/master/scull/scull_unload
# https://github.com/cu-ecen-aeld/ldd3/blob/master/misc-modules/module_load, https://github.com/cu-ecen-aeld/ldd3/blob/master/misc-modules/module_unload

# Function to load scull driver
load_scull()
{
    module="scull"
    device="scull"
    mode="664"

    # Group: since distributions do it differently, look for wheel or use staff
    if grep -q '^staff:' /etc/group; then
        group="staff"
    else
        group="wheel"
    fi

    modprobe $module || exit 1

    # retrieve major number
    major=$(awk "\$2==\"$module\" {print \$1}" /proc/devices)

    # Remove stale nodes and replace them, then give gid and perms
    # Usually the script is shorter, it's scull that has several devices in it.

    rm -f /dev/${device}[0-3]
    mknod /dev/${device}0 c $major 0
    mknod /dev/${device}1 c $major 1
    mknod /dev/${device}2 c $major 2
    mknod /dev/${device}3 c $major 3
    ln -sf ${device}0 /dev/${device}
    chgrp $group /dev/${device}[0-3] 
    chmod $mode  /dev/${device}[0-3]

    rm -f /dev/${device}pipe[0-3]
    mknod /dev/${device}pipe0 c $major 4
    mknod /dev/${device}pipe1 c $major 5
    mknod /dev/${device}pipe2 c $major 6
    mknod /dev/${device}pipe3 c $major 7
    ln -sf ${device}pipe0 /dev/${device}pipe
    chgrp $group /dev/${device}pipe[0-3] 
    chmod $mode  /dev/${device}pipe[0-3]

    rm -f /dev/${device}single
    mknod /dev/${device}single  c $major 8
    chgrp $group /dev/${device}single
    chmod $mode  /dev/${device}single

    rm -f /dev/${device}uid
    mknod /dev/${device}uid   c $major 9
    chgrp $group /dev/${device}uid
    chmod $mode  /dev/${device}uid

    rm -f /dev/${device}wuid
    mknod /dev/${device}wuid  c $major 10
    chgrp $group /dev/${device}wuid
    chmod $mode  /dev/${device}wuid

    rm -f /dev/${device}priv
    mknod /dev/${device}priv  c $major 11
    chgrp $group /dev/${device}priv
    chmod $mode  /dev/${device}priv
}

# Function to unload scull driver
unload_scull()
{
    module="scull"
    device="scull"

    # invoke rmmod with all arguments we got
    rmmod $module $* || exit 1

    # Remove stale nodes

    rm -f /dev/${device} /dev/${device}[0-3] 
    rm -f /dev/${device}priv
    rm -f /dev/${device}pipe /dev/${device}pipe[0-3]
    rm -f /dev/${device}single
    rm -f /dev/${device}uid
    rm -f /dev/${device}wuid
}

# Function to load driver
load_module()
{
    module=$1
    # Use the same name for the device as the name used for the module
    device=$1
    # Support read/write for owner and group, read only for everyone using 644
    mode="664"

    if [ $# -ne 1 ]; then
        echo "Wrong number of arguments"
        echo "usage: $0 module_name"
        echo "Will create a corresponding device /dev/module_name associated with module_name.ko"
        exit 1
    fi

    set -e
    # Group: since distributions do it differently, look for wheel or use staff
    # These are groups which correspond to system administrator accounts
    if grep -q '^staff:' /etc/group; then
        group="staff"
    else
        group="wheel"
    fi

    modprobe $module || exit 1

    echo "Get the major number (allocated with allocate_chrdev_region) from /proc/devices"
    major=$(awk "\$2==\"$module\" {print \$1}" /proc/devices)

    if [ ! -z ${major} ]; then
        echo "Remove any existing /dev node for /dev/${device}"
        rm -f /dev/${device}
        echo "Add a node for our device at /dev/${device} using mknod"
        mknod /dev/${device} c $major 0
        echo "Change group owner to ${group}"
        chgrp $group /dev/${device}
        echo "Change access mode to ${mode}"
        chmod $mode  /dev/${device}
    else
        echo "No device found in /proc/devices for driver ${module} (this driver may not allocate a device)"
    fi
}

# Function to unload a driver
unload_module()
{
    module=$1
    device=$1

    if [ $# -ne 1 ]; then
        echo "Wrong number of arguments"
        echo "usage: $0 module_name"
        echo "Will unload the module specified by module_name and remove assocaited device"
        exit 1
    fi

    # invoke rmmod with all arguments we got
    rmmod $module || exit 1

    # Remove stale nodes

    rm -f /dev/${device}
}

# Main logic
case $1 in
    start)
        load_scull || exit 1
        load_module faulty || exit 1
        modprobe hello || exit 1
        ;;
    stop)
        unload_scull || exit 1
        unload_module faulty || exit 1
        rmmod hello || exit 1
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac

exit 0
