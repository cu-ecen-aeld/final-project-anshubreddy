#!/bin/bash

set -e

#BOARD_DIR="$(dirname $0)"
BOARD_DIR="/home/anshumaanbreddy/ECEA_5307/Final_Project/final-project-anshubreddy/buildroot/board/raspberrypi3"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

for arg in "$@"
do
 case "${arg}" in
     --add-serial)
     echo "Copying init script for serial port configuration"
     mkdir -p "${TARGET_DIR}/etc/init.d"
     cp "${BOARD_DIR}/../../../base_external/rootfs_overlay/etc/init.d/S99serial_setup" "${TARGET_DIR}/etc/init.d/"
     ;;
 esac
done

# Ensure the script is executable
chmod +x "${TARGET_DIR}/etc/init.d/S99serial_setup"

# Pass an empty rootpath
trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

genimage \
 --rootpath "${ROOTPATH_TMP}"   \
 --tmppath "${GENIMAGE_TMP}"    \
 --inputpath "${BINARIES_DIR}"  \
 --outputpath "${BINARIES_DIR}" \
 --config "${GENIMAGE_CFG}"

exit $?
