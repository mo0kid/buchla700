#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
BR_DIR="${BUILDROOT_DIR:-$REPO_DIR/buildroot}"
IMAGE="$BR_DIR/output/images/sdcard.img"

if [ -z "$1" ]; then
    echo "Usage: $0 /dev/sdX"
    echo ""
    echo "Writes the Buildroot SD card image to the specified device."
    echo "WARNING: This will erase all data on the target device."
    echo ""
    if [ "$(uname)" = "Darwin" ]; then
        echo "Available disks:"
        diskutil list external
    else
        echo "Available block devices:"
        lsblk -d -o NAME,SIZE,MODEL
    fi
    exit 1
fi

DEVICE="$1"

if [ ! -f "$IMAGE" ]; then
    echo "Image not found: $IMAGE"
    echo "Run build.sh first."
    exit 1
fi

if [ ! -b "$DEVICE" ]; then
    echo "Not a block device: $DEVICE"
    exit 1
fi

SIZE=$(stat -f%z "$IMAGE" 2>/dev/null || stat -c%s "$IMAGE" 2>/dev/null)
echo "Writing $IMAGE ($(( SIZE / 1048576 )) MB) to $DEVICE"
echo "This will ERASE all data on $DEVICE."
read -p "Continue? [y/N] " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Aborted."
    exit 1
fi

if [ "$(uname)" = "Darwin" ]; then
    diskutil unmountDisk "$DEVICE"
    sudo dd if="$IMAGE" of="$DEVICE" bs=4m
    sync
    diskutil eject "$DEVICE"
else
    sudo umount "${DEVICE}"* 2>/dev/null || true
    sudo dd if="$IMAGE" of="$DEVICE" bs=4M status=progress
    sync
fi

echo "Done. Remove SD card and boot the RPi."
