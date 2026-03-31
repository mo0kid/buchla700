#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
BR_EXT="$REPO_DIR/buchla-rpi/buildroot"
BR_DIR="${BUILDROOT_DIR:-$REPO_DIR/buildroot}"

if [ ! -d "$BR_DIR" ]; then
    echo "Buildroot not found at $BR_DIR"
    echo "Clone it:"
    echo "  git clone https://github.com/buildroot/buildroot.git $BR_DIR"
    exit 1
fi

# Check that firmware data files exist
for f in bios.abs midas.abs vera.ttf; do
    if [ ! -f "$REPO_DIR/buchla-emu/$f" ]; then
        echo "Missing $f in buchla-emu/ — run 'make' in buchla-emu/ first"
        exit 1
    fi
done

# Buildroot requires a Linux host — use Docker on macOS
if [ "$(uname)" = "Darwin" ]; then
    echo "macOS detected — building inside Docker container"

    DOCKER_IMAGE="buchla-buildroot"
    VOLUME_NAME="buchla-buildroot-output"

    # Build Docker image if needed
    if ! docker image inspect "$DOCKER_IMAGE" > /dev/null 2>&1; then
        echo "Building Docker image (one-time)..."
        docker build -t "$DOCKER_IMAGE" "$REPO_DIR/buchla-rpi"
    fi

    # Create a Docker volume for build output (avoids macOS VirtioFS permission issues)
    docker volume create "$VOLUME_NAME" > /dev/null 2>&1 || true

    # Clean stale macOS-compiled kconfig if present
    if [ -d "$BR_DIR/output/build/buildroot-config" ]; then
        echo "Cleaning stale macOS build artifacts..."
        rm -rf "$BR_DIR/output"
    fi

    # Dirclean packages that need rebuilding (e.g. after config changes)
    if [ -n "$DIRCLEAN" ]; then
        echo "Cleaning packages: $DIRCLEAN"
        docker run --rm \
            -v "$REPO_DIR:/repo" \
            -v "$VOLUME_NAME:/output" \
            -e FORCE_UNSAFE_CONFIGURE=1 \
            "$DOCKER_IMAGE" \
            bash -c "cd /repo/buildroot && make BR2_EXTERNAL=/repo/buchla-rpi/buildroot O=/output $DIRCLEAN"
    fi

    echo "Building (this takes 30-60 min on first run)..."
    docker run --rm \
        -v "$REPO_DIR:/repo" \
        -v "$VOLUME_NAME:/output" \
        -e FORCE_UNSAFE_CONFIGURE=1 \
        "$DOCKER_IMAGE" \
        bash -c "cd /repo/buildroot && make BR2_EXTERNAL=/repo/buchla-rpi/buildroot O=/output buchla700_rpi3_defconfig && make O=/output -j\$(nproc)"

    # Copy the SD card image out of the Docker volume
    mkdir -p "$BR_DIR/output/images"
    docker run --rm \
        -v "$VOLUME_NAME:/output:ro" \
        -v "$BR_DIR/output/images:/dest" \
        "$DOCKER_IMAGE" \
        cp /output/images/sdcard.img /dest/

    echo ""
    echo "Done. Image at: $BR_DIR/output/images/sdcard.img"
    exit 0
fi

# Linux native build
# Buildroot rejects PATH entries containing spaces
clean_path=""
IFS=':'
for p in $PATH; do
    case "$p" in
        *\ *|*"	"*) ;;  # skip entries with spaces or tabs
        *) clean_path="${clean_path:+$clean_path:}$p" ;;
    esac
done
unset IFS
export PATH="$clean_path"

cd "$BR_DIR"
make BR2_EXTERNAL="$BR_EXT" buchla700_rpi3_defconfig
make -j"$(nproc)"

echo ""
echo "Done. Image at: $BR_DIR/output/images/sdcard.img"
