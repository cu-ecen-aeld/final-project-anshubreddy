#!/bin/sh
# Shared definitions for buildroot scripts

# The defconfig from the buildroot directory we use for qemu builds
QEMU_DEFCONFIG=configs/qemu_aarch64_virt_defconfig
# Default hardware platform for Raspberry Pi 3B board, especially when building
RPI3_DEFCONFIG=configs/raspberrypi3_64_defconfig
# The place we store customizations to the qemu configuration
MODIFIED_QEMU_DEFCONFIG=base_external/configs/aesd_qemu_defconfig

# Place where customizations are stored to RPi configuration
MODIFIED_RPI3_DEFCONFIG=base_external/configs/aesd_rpi_defconfig

# The defconfig from the buildroot directory we use for the project
AESD_DEFAULT_DEFCONFIG=${RPI3_DEFCONFIG}
AESD_MODIFIED_DEFCONFIG=${MODIFIED_RPI3_DEFCONFIG}
AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT=../${AESD_MODIFIED_DEFCONFIG}
