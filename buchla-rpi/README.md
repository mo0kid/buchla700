# Buchla 700 — Raspberry Pi 3B+ Embedded Image

Standalone embedded Linux image that boots directly into the Buchla 700 emulator.
No desktop environment — BusyBox init launches the emulator at boot.

## Requirements

- Raspberry Pi 3B+ (or 3B)
- microSD card (4 GB+)
- Headphone jack for audio (or I2S DAC HAT)
- WiFi for iPad controller connection
- Optional: HDMI display

## Quick Start

### 1. Clone Buildroot

```sh
git clone https://github.com/buildroot/buildroot.git
```

### 2. Configure WiFi

Edit `buchla-rpi/buildroot/overlay/etc/wpa_supplicant.conf` with your WiFi
credentials before building.

### 3. Build the image

```sh
./buchla-rpi/scripts/build.sh
```

First build takes 30-60 minutes. Subsequent rebuilds are incremental.

### 4. Write to SD card

```sh
./buchla-rpi/scripts/flash.sh /dev/sdX
```

### 5. Boot

Insert the SD card and power on the RPi. The emulator starts automatically
and listens for the iPad controller over WiFi.

## Cross-compile only (without Buildroot)

To build just the emulator binary for aarch64:

```sh
cd buchla-emu
make RPI=1
```

This requires an aarch64 cross-compiler and SDL2/RtMidi libraries built for
aarch64. Override library paths with:

```sh
make RPI=1 RPI_SDL2=/path/to/sdl2 RPI_RTMIDI=/path/to/rtmidi
```

## Audio

Default output is the headphone jack (bcm2835 PWM audio at 48 kHz).

For an I2S DAC HAT, add the DAC's device tree overlay to `config.txt` and
update `overlay/etc/asound.conf` to point to the DAC's ALSA device. No code
changes needed.

## Architecture

```
Buildroot → Linux kernel + BusyBox + SDL2/ALSA → buchla emulator
                                                 ↕
                                        iPad controller (WiFi/OSC)
```

- SDL2 uses KMS/DRM backend (direct framebuffer, no X11)
- HDMI display shows CRT emulation when connected, headless when not
- Boot to audio-ready target: <5 seconds
- Image size: ~32 MB
