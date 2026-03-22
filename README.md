# Buchla 700

A software emulation of the [Buchla 700](https://en.wikipedia.org/wiki/Buchla_electronic_musical_instruments) digital music synthesizer (1989), paired with an iPad touch controller that communicates over OSC.

The project consists of three components:

| Directory | Description |
|-----------|-------------|
| `buchla-emu` | Hardware emulator and DSP engine (C, runs on macOS / Linux / Windows) |
| `buchla-ctl` | iPad touch controller (C++ / JUCE, runs on iPad via Xcode) |
| `buchla-68k` | Original Buchla 700 firmware source (68000 assembly / C) |

## Screenshots

### Emulator (buchla-emu)

![Buchla 700 Emulator](Buchla700Screenshot.PNG)

The emulator faithfully reproduces the Buchla 700's CRT display, showing envelope curves, bar graph parameter levels, FM configuration routing, oscillator tunings, waveshape previews, and the MIDAS VII editing interface.

### iPad Controller (buchla-ctl)

![Buchla Control iPad App](BuchlaControlScreenshot.PNG)

The iPad controller provides a touch interface with 14 bar-graph faders, 14 mode buttons, an XY pad, tempo/time-scaling knobs, and a 24-key touch keyboard with Y-axis expression.

---

## buchla-emu — Hardware Emulator

A full-system emulator of the Buchla 700 hardware, including:

- **Motorola 68000 CPU** via the Musashi emulation core
- **Intel 82716 video** — CRT display with bar graphs, envelope curves, and text
- **Epson SED1335 LCD** controller
- **Western Digital WD1772** floppy disk controller (720 KB FAT12 images)
- **Rockwell R65C52** dual serial/MIDI ports
- **Motorola MC6840** triple timer
- **Microcontroller** A/D conversion emulation

### Digital Sound Synthesis (DSP)

The emulator includes a complete recreation of the Buchla 700 audio engine:

- 12 polyphonic voices, each with 4 oscillators
- Frequency modulation (FM) with 12 routing configurations
- Waveshaping via WSA/WSB lookup tables (254 words per table per voice)
- 4-pole analog-modeled OTA ladder filter per voice
- DC blocking and stereo panning
- 16 envelope function generators per voice with interpolation
- Global effects: phase shifter, 7-band graphic EQ (LMC835), aural exciter
- 48 kHz, 16-bit stereo audio output

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Cmd+F` | Toggle fullscreen |
| `F5` | Open file dialog to swap disk image (macOS only) |
| Drag & drop | Drop a `.disk` file onto the window to swap disk |
| `Escape` | Quit |

### CLI Usage

```
buchla [-h] [-a] [-t] [-v comp [-v comp [...]]] [-b bios] [-d disk] [-f font] [-m port]
```

| Flag | Description |
|------|-------------|
| `-h` | Show help |
| `-a` | Auto-boot MIDAS VII (sends `r` then `go $10000` to the ROMP monitor) |
| `-t` | Play a 440 Hz test tone to verify the audio path |
| `-v comp` | Enable verbose logging for a component (may be repeated). Components: `sdl`, `gdb`, `cpu`, `fpu`, `vid`, `tim`, `lcd`, `ser`, `mid`, `fdd`, `snd`, `led`, `kbd`, `osc`, `all` |
| `-b bios` | BIOS ROM file (default: `bios.abs`) |
| `-d disk` | Disk image file (default: `buchla.disk`) |
| `-f font` | Console and LCD font (default: `vera.ttf`) |
| `-m port` | MIDI port number, 0-15 (default: 0). Use `-m list` to list available ports |

#### Auto-boot example

```sh
cd buchla-emu
./buchla -a
```

This boots directly into MIDAS VII without manual ROMP interaction.

#### Verbose logging example

```sh
./buchla -a -v fpu -v osc
```

Boots MIDAS VII with FPU register and OSC network logging enabled.

### GDB Debugger

A GDB-compatible cross-debugger stub listens on TCP port **12053**, allowing remote debugging of the 68000 firmware with `m68k-none-elf-gdb`.

---

## buchla-ctl — iPad Touch Controller

A JUCE-based iPad application that provides a hardware-style touch interface for the emulator, communicating over OSC (UDP).

### Interface Layout

- **14 bar-graph faders** — Locn, Level, Ind 1-6, Frq 1-4, Filtr, Reson (jog/shuttle style: touch above or below center to move the value)
- **14 mode buttons** — Quiet, ROMP, Lamp, Clock, P/R, GoTo, Instr, Asgmt, Load, Other, Voice, Init
- **XY controller pad** — 2D touch with grid, mapped to HT/VT parameters
- **Tempo Multiplier knob** — 0.5x to 1.5x in 0.1 steps
- **Time Scaling knob** — 0.5x to 1.5x in 0.1 steps
- **24-key touch keyboard** — with Y-axis expression control
- **Three fader modes** — Normal (synth parameters), Other (phase shift / CV), EQ (7-band stereo graphic EQ). Cycle with the Other/EQ/Prmtr button.

### OSC Communication

The iPad controller sends and receives messages on configurable UDP ports (default: send 9001, receive 9002). Both devices must be on the same local network.

---

## Installation

### Prerequisites (all platforms)

The emulator links against static libraries. You need to build or install the following into `/opt/sdl2` and `/opt/rtmidi` (or adjust paths in the Makefile):

- [SDL2](https://www.libsdl.org/) (core)
- [SDL2_net](https://github.com/libsdl-org/SDL_net) (networking)
- [SDL2_ttf](https://github.com/libsdl-org/SDL_ttf) (font rendering)
- [FreeType](https://freetype.org/) (used by SDL2_ttf)
- [RtMidi](https://www.music.mcgill.ca/~gary/rtmidi/) (MIDI I/O)

### macOS

```sh
# Install dependencies via Homebrew (used as fallback paths)
brew install sdl2 sdl2_net sdl2_ttf freetype rtmidi

# Build static libs into /opt/sdl2 and /opt/rtmidi, or adjust Makefile paths.
# The Makefile automatically falls back to /opt/homebrew/lib/ for
# SDL2_net, freetype, and rtmidi if they are not found in /opt/sdl2.

cd buchla-emu
make
```

**Required files** in `buchla-emu/`:
- `bios.abs` — BIOS ROM (built from `buchla-68k` or provided)
- `midas.abs` — MIDAS VII software
- `vera.ttf` — Bitstream Vera Sans Mono font
- `buchla.disk` — 720 KB FAT12 disk image (created by `make` via `mkdisk`)

Run the emulator:
```sh
./buchla -a          # auto-boot into MIDAS VII
```

### Linux

```sh
# Install build dependencies (Debian/Ubuntu)
sudo apt install build-essential libasound2-dev

# Build SDL2, SDL2_net, SDL2_ttf, freetype, and rtmidi from source
# and install static libraries to /opt/sdl2 and /opt/rtmidi.
# See each library's documentation for ./configure --prefix=/opt/sdl2 etc.

cd buchla-emu
make
```

The Linux build links against ALSA (`-lasound`) for MIDI support.

### Windows (cross-compile from Linux)

The Makefile supports cross-compilation using MinGW:

```sh
# Install cross-compiler
sudo apt install mingw-w64

# Build SDL2, SDL2_net, SDL2_ttf, freetype, and rtmidi for Windows
# and install to /opt/sdl2-win and /opt/rtmidi-win.

cd buchla-emu
make WIN=1
```

This produces `buchla.exe`. Copy it alongside `bios.abs`, `midas.abs`, `vera.ttf`, and `buchla.disk`.

### iPad Controller (buchla-ctl)

Requires macOS with Xcode and an Apple Developer account.

```sh
# JUCE must be available at one of:
#   ./JUCE/            (local copy)
#   ../Taunus/JUCE/    (sibling project)
#   ~/JUCE/            (home directory)

cd buchla-ctl

# Generate Xcode project
cmake -B build_ios -G Xcode \
  -DCMAKE_SYSTEM_NAME=iOS \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=15.0

# Open in Xcode, select your development team, then build & deploy to iPad
open build_ios/BuchlaControl.xcodeproj
```

The iPad and the machine running `buchla-emu` must be on the same local network. The controller auto-discovers the emulator on common local IP addresses.

---

## Building the Firmware (buchla-68k)

The firmware source can be rebuilt with a 68000 cross-toolchain:

```sh
cd buchla-68k
# Requires m68k-none-elf-gcc cross-compiler
make
```

This produces `bios.abs` and `midas.abs` which should be copied into `buchla-emu/`.

---

## Acknowledgements

This project is based on the work of the [Buchla Emulation Project](https://bob.lopatic.de/), which created the original open-source emulation of the Buchla 700 hardware. Their careful reverse-engineering and documentation of the 700's architecture made this project possible.

---

*In memory of **Don Buchla** (1937–2016) — visionary instrument designer, pioneer of voltage-controlled synthesis, and creator of some of the most expressive and uncompromising electronic musical instruments ever made. The 700 was his last major instrument design: a machine that refused to simplify, insisting instead that the player rise to meet it. His instruments didn't follow convention — they asked what music could become if you abandoned the assumptions of the past. We are still finding out.*

---

## License

GNU General Public License v3.0 — see [gpl.txt](buchla-emu/gpl.txt).
