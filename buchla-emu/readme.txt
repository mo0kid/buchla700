Buchla 700 Hardware Emulator
----------------------------

This repository, buchla-emu.git, contains a software emulation of the
Buchla 700's hardware.

It is minimalistic; it emulates just enough of the hardware to be able
to run the firmware from the companion repository, buchla-68k.git.

We don't have access to original hardware, so this is our best guess
based on the firmware source code published by Lynx Crowe - the
firmware's developer - via Aaron Lanterman:

  http://lanterman.ece.gatech.edu/buchla700/

See the buchla-68k.git repository for the firmware source code.


Building the emulator
---------------------

The emulator uses SDL2, an abstraction layer for low-level machine
access on Linux, OS X, and Windows. It can be obtained from the
project's website:

  https://libsdl.org/

The SDL2 website also hosts the SDL2_net and SDL2_ttf projects, which
add support for networking and TrueType fonts to SDL2

SDL2_ttf, in turn, requires the FreeType library, which is available
from the FreeType website:

  https://www.freetype.org/

Currently, we build the emulator natively on Linux and OS X. The
Windows version is cross-compiled on Linux using a x86_64-w64-mingw32
cross-toolchain.

For Linux and OS X, our Makefile expects all of the above libraries to
reside in /opt/sdl2. This is how we typically install them:

  # Build and install FreeType first

  tar zxvf freetype-2.7.1.tar.gz
  cd freetype-2.7.1
  mkdir build
  cd build

  # Skip the optional features (compressed fonts, etc.) that would
  # create more dependencies

  ../configure --prefix=/opt/sdl2 \
    --without-zlib --without-bzip2 --without-png --without-harfbuzz

  make
  make install

  # Then build and install SDL2

  tar zxvf SDL2-2.0.5.tar.gz
  cd SDL2-2.0.5
  mkdir build
  cd build

  ../configure --prefix=/opt/sdl2

  make
  make install

  # Build and install SDL2_ttf, now that we have FreeType and SDL2

  tar zxvf SDL2_ttf-2.0.14.tar.gz
  cd SDL2_ttf-2.0.14
  mkdir build
  cd build

  ../configure --prefix=/opt/sdl2 \
    --with-sdl-prefix=/opt/sdl2 --with-freetype-prefix=/opt/sdl2

  make
  make install

  # Build and install SDL2_net last

  tar zxvf SDL2_net-2.0.1.tar.gz
  cd SDL2_net-2.0.1
  mkdir build
  cd build

  ../configure --prefix=/opt/sdl2 --with-sdl-prefix=/opt/sdl2

  make
  make install

  # Build and install RtMidi

  tar zxvf rtmidi-3.0.0.tar.gz
  cd rtmidi-3.0.0
  mkdir build
  cd build

  ../configure --prefix=/opt/rtmidi

  make
  make install

Now that we have everything in place, invoke

  make buchla

from the top-level directory of this repository to build the emulator.

The cross-build for Windows is done similarly, with the following
differences when configuring the libraries:

  * We use "--prefix=/opt/sdl2-win" instead of "--prefix=/opt/sdl2",
    so that the Windows versions of the SDL2 libraries go to a
    different directory. That's where our Makefile expects to find
    them when cross-building.

    Analogously, we use "--prefix=/opt/rtmidi-win" when building
    RtMidi.

  * We additionally specify "--host=x86_64-w64-mingw32" to enable
    cross-compilation.

Then, to cross-build the emulator, invoke

  make buchla.exe WIN=1

from the top-level directory of this repository. Defining the "WIN"
variable selects the cross-toolchain and "/opt/sdl2-win" as the
library directory.

In addition to the emulator, we need to build the mkdisk utility,
which we'll use to create a 720-KiB floppy disk image that can be read
by the Buchla firmware.

Building mkdisk works pretty much like building the emulator. On Linux
and OS X, invoke

  make mkdisk

from the top-level directory of this repository. To cross-build the
Windows version, invoke

  make mkdisk.exe WIN=1

instead.


Running the emulator
--------------------

This is where this repository, buchla-emu, meets its companion
repository, buchla-68k. We assume that you built the following files
according to the instructions in the buchla-68k repository:

  bios.abs
  midas.abs

Please copy (or symlink) them into the top-level directory of this
repository, buchla-emu.

bios.abs contains the Buchla 700's BIOS code. The file is loaded by
the emulator directly to emulate the BIOS PROM.

midas.abs is the MIDAS VII software. Unlike the BIOS, which resides in
a PROM, it is loaded from a floppy disk. To create this floppy disk,
we need the mkdisk utility.

mkdisk expects to be run from inside the directory that contains
midas.abs and produces a disk image file, buchla.disk in the same
directory. For example, on Linux:

  ~/buchla-emu$ ls -l midas.abs
  lrwxrwxrwx 1 emu emu 23 Jul 30 18:07 midas.abs -> ../buchla-68k/midas.abs
  ~/buchla-emu$ ./mkdisk
  ~/buchla-emu$ ls -l buchla.disk
  -rw-r--r-- 1 emu emu 737280 Aug  6 09:44 buchla.disk

Now we have everything in place to run the emulator. On Linux and OS X
you can invoke it directly from the top-level directory of this
repository:

  ~/buchla-emu$ ./buchla

If you prefer to install the emulator elsewhere, be sure to copy the
following files:

  buchla | buchla.exe     emulator executable (.exe for Windows)
  vera.ttf                emulator font
  bios.abs                BIOS code
  buchla.disk             disk image

This also applies to copying the cross-compiled Windows emulator to a
Windows machine.

If you would like to keep the BIOS code, disk image, and font separate
from the emulator executable, check out the emulator's -b, -d, and -f
command line options. Use -h for an overview of all available options.


Cross-debugging the firmware
----------------------------

While the emulator is running, it listens on TCP port 12053 for
incoming connections from a GDB cross-debugger. This allows for
comfortable source-level debugging of the cross-compiled BIOS and
MIDAS VII code, while it runs in the emulator.

We assume that you have a GCC cross-toolchain in /opt/cross-m68k, as
described in the buchla-68k repository. Based on that, we build a
GDB cross-debugger:

  # If you haven't yet done so, add the cross-toolchain to your
  # PATH, so that the GDB build can find it.

  export PATH="/opt/cross-m68k/bin:${PATH}"

  tar zxvf gdb-7.12.tar.gz
  cd gdb-7.12

  mkdir build
  cd build

  ../configure --prefix=/opt/cross-m68k --target=m68k-none-elf

  make -j2
  make install

The Buchla firmware uses its own (Atari-like) object and executable
file format. However, the cross-toolchain and the cross-debugger
support the ELF standard.

When you built the BIOS and MIDAS VII software, you ended up with two
files in the Buchla's executable file format, bios.abs and midas.abs.
However, the cross-build process also produces matching ELF files,
bios.elf and midas.elf, suitable for the cross-debugger.

Depending on whether you would like to cross-debug the BIOS or MIDAS
VII, you'd specify either bios.elf or midas.elf when invoking the
cross-debugger.

To follow along the following example, copy (or symlink) bios.elf and
midas.elf from the buchla-68k repository into the top-level directory
of this repository.

In order to open a debug session for the BIOS, run the cross-debugger
with bios.abs and connect it to the running emulator using GDB's

  target remote :12053

command. 12053 is the port on which the emulator listens for incoming
GDB connections.

  host:~/buchla-emu$ m68k-none-elf-gdb ./bios.elf
  GNU gdb (GDB) 7.12
  Copyright (C) 2016 Free Software Foundation, Inc.
  [...]
  (gdb) target remote :12053
  Remote debugging using :12053
  trwzsup () at rom/bios.s:832
  832           move.l  0(a0,d0),d0     | Get routine address
  (gdb)

From here on, everything is pretty much standard GDB, for example:

  (gdb) break pscan
  Breakpoint 1 at 0x105a64: file rom/romp.c, line 3403.
  (gdb) cont
  [...]
  (gdb) bt
  #0  pscan () at rom/romp.c:3403
  #1  0x00105e96 in main () at rom/romp.c:3587
  #2  0x00105fd6 in Croot (cp=0x0) at prolog/croot.c:141
  #3  0x00105f52 in start1 () at prolog/fsmain.s:59
  (gdb)

In order to debug MIDAS VII, run the cross-debugger with midas.elf,
instead:

  host:~/buchla-emu$ m68k-none-elf-gdb ./midas.elf
  GNU gdb (GDB) 7.12
  Copyright (C) 2016 Free Software Foundation, Inc.
  [...]


Emulated hardware
-----------------

Here's what we currently emulate:

  * Motorola 68000 CPU. This is actually the Musashi CPU emulator by
    Karl Stenerud:

      https://github.com/kstenerud/Musashi

  * Intel 82716: Video chip.

  * Epson SED1335: LCD controller.

  * Western Digital WD1772: Floppy disk controller.

  * Rockwell R65C52: Serial console and MIDI ports.

  * Motorola MC6840: Timers.

  * Unknown item #1: A program running on a microcontroller. It
    converts the analog signals from the Buchla's controller pads to
    digital values.

    Neither the program, nor the microcontroller are known, but the
    protocol (known from the firmware source code) is pretty simple
    and self-explanatory.

The next development milestone will hopefully emulate the following
additional components:

  * National Semiconductor LMC835: Equalizer.

  * General Instrument AY-3-8910: A sound chip, which is not used for
    sound generation, but only for its I/O ports. It connects the CPU
    to the above equalizer chip.

  * A few indicator LEDs.

  * Unknown item #2: The actual sound generator, referred to by the
    firmware source code as "the FPU." This is the biggest unknown so
    far. Judging from the firmware source code it consist of two
    parts:

      1. The function generator that generates the 15 different
         parameter envelopes for each of the 12 voices:

           - 4x FM modulator (oscillator) frequency.

           - 6x FM modulator (oscillator) envelope.

           - 1x Output signal amplitude envelope.

           - 1x Output signal filter envelope.

           - 1x Output signal filter resonance envelope.

           - 1x Output signal stereo location.

           - 1x "Dynamics" - whatever that is.

         The firmware feeds the the points of the envelopes drawn in
         the MIDAS VII instrument editor to the function generator,
         which then interpolates between them.

      2. The digital oscillator.

         XXX - Details to be filled in.

         We don't know how many of the envelopes not related to FM
         (e.g., the filter) are actually used digitally. At least some
         of the envelopes probably control analog circuits.

    This "two FPU parts" hypothesis would be in line with the "four
    computers" marketing claim from the Buchla 700 marketing copy. The
    four "computers" would be the Motorola 68000, the microcontroller
    that does the A/D conversion of the pad inputs, plus the two parts
    that constitute "the FPU."

    The firmware source code archive indicates that the FPU is based
    on micro-programmable hardware. We recently ran this by Lynx, the
    developer of the firmware, who generously agreed to meet up with
    us in Oakland, CA. While he did not work on the FPU and thus was
    not familiar with its implementation details, he was able to
    confirm that the FPU is based on AMD's Am2900 family.

If you have access to an actual Buchla 700, please do contact us. It
would be great to be able to compare the emulation to real hardware.

If your Buchla is non-functional, this is also fine. We might be able
to gain some insights from reading out the FPU microcode PROMs or from
figuring out how the FPU chips are wired together.
