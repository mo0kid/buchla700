Buchla 700 Firmware
-------------------

This repository, buchla-68k.git, contains a port of the Buchla 700
firmware source code to a modern GCC-based cross-compilation
environment.

The resulting executable code needs to be run on emulated Buchla 700
hardware, such as the one in the companion repository, buchla-emu.git.

The source code was originally released on Aaron Lanterman's Buchla
700 Preservation Page:

  http://lanterman.ece.gatech.edu/buchla700/

Aaron seems to have received the source code directly from Lynx Crowe,
the developer.

The licensing conditions are a little vague; Lynx released the source
code "for noncommercial personal and educational use" and "as-is with
no guarantees of completeness or correctness."

While our modifications are in the public domain, Lynx's request still
applies to the underlying original code. Please respect that.

Note that this is just the code that runs on the Buchla 700's Motorola
68k CPU:

  1. The BIOS and ROMP debug monitor.

  2. The MIDAS VII GUI-driven editing and control software.

In particular, there's no code for anything related to the actual
sound generation.


Building with a GCC cross-compiler
----------------------------------

*** Setting up the cross-toolchain

To build the code, you need a cross-toolchain, i.e., GCC and binutils,
for the m68k-none-elf target. Let us show you, how we built the one
that we use, binutils 2.28 and GCC 6.3.0. It lives in /opt/cross-m68k.

First, binutils:

  tar jxvf binutils-2.28.tar.bz2
  cd binutils-2.28

  mkdir build
  cd build

  ../configure --prefix=/opt/cross-m68k --target=m68k-none-elf

  make -j2
  make install

Second, GCC:

  # Important! Otherwise, the GCC build won't find the binutils that
  # we just made!

  export PATH="/opt/cross-m68k/bin:${PATH}"

  tar jxvf gcc-6.3.0.tar.bz2
  cd gcc-6.3.0

  mkdir build
  cd build

  ../configure --prefix=/opt/cross-m68k --target=m68k-none-elf \
      --enable-languages=c --without-headers

  # Don't build everything, because features like GCC's stack
  # protector will otherwise cause trouble.

  make -j2 all-gcc all-target-libgcc
  make install-gcc install-target-libgcc

Now, as we put /opt/cross-m68k/bin in our PATH, we should be able to
run the cross-compiler as follows:

  user@host:~$ m68k-none-elf-gcc --version
  m68k-none-elf-gcc (GCC) 6.3.0
  Copyright (C) 2016 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  user@host:~$

*** Cross-compiling the source code

Once you have the cross-toolchain in place, invoke

  make bios.abs

from the top-level directory of this repository to build the BIOS and
ROMP debug monitor.

To build MIDAS VII, invoke

  make midas.abs

instead.


Building with Alcyon C
----------------------

Lynx developed the Buchla 700 firmware on an 68k-based Atari system
with the Alcyon C compiler, assembler, and linker from Atari's TOS
Developer Kit.

If you want to relive this experience, you can do so thanks to the
Hatari emulator, which emulates a suitable Atari system. Here's the
idea:

  * The hatari/c subdirectory contains the Atari C compiler,
    assembler, and linker. It is turned into a hard drive image for
    the emulator's C: drive.

  * The hatari/d subdirectory is shared with the emulator, i.e., it is
    not turned into a hard drive image. It is the emulator's D: drive.

    Any changes to this directory from inside the emulator are
    instantaneously visible outside the emulator, and vice versa. We
    use this as a means of communication between these two worlds.

    The subdirectories under hatari/d contain links to the original
    source code files. In addition, the compiled results go to
    hatari/d/out.

  * We have a Python script (hatari/rem.py) that acts as a remote
    control for the emulator. It issues the commands required to
    compile or assemble the source code files.

You PATH needs to be set, such that the shell can find the Hatari
executable:

  user@host:~$ hatari --version

  Hatari v2.0.0 - the Atari ST, STE, TT and Falcon emulator.

  Hatari is free software licensed under the GNU General Public License.

  user@host:~$

We use Hatari 2.0.0 with version 0.9.8 of the open-source TOS
replacement EmuTOS.

Now you need to run two things in parallel, the remote control Python
script as well as the Hatari emulator. The Python script goes
first. In one shell window, invoke

  make rem

from the top-level directory of the repository to start the
script. The script then waits for the emulator to come up and connect
to it. Now run Hatari. In another shell window, invoke

  make emu

from the top-level directory of the repository. This creates a hard
drive image from hatari/c and starts the emulator with appropriate
command line options.

When the EmuTOS desktop comes up, open the C:\BIN folder and run
SH.TTP without any parameters. This opens a Unix-like shell, the Okami
Shell. This is the shell that the Python script expects to control.

Now, back in the window with the Python script, press the enter
key. This tells the Python script to start sending commands to the
shell in the emulator.

Compiling the C and assembly language files of the source code takes
quite a while. Once the process is complete, the hatari/d/out
directory contains the following files:

  * C source code (.c) files get compiled into assembly language
    source code (.s) files, and then assembled into object (.o) files.

    We keep both, .s and .o files. This proved useful when porting the
    original source code to the cross-toolchain, because we could
    compare the compiler output of the cross-toolchain to the original
    output of the Alcyon C toolchain.

    This made us realize, for example, that Alcyon C uses 16-bit int
    values, whereas GCC defaults to 32-bit int values.

  * Assembly language source code (.s) files get assembled into object
    (.o) files. We keep those, too.

  * Some of the object files (.o) get archived into static library
    (.a) files.

  * bios.abs, which is the BIOS and ROMP debug monitor.

  * midas.abs is notably absent. Its object (.o) files are all there,
    but our Atari TOS Developer Kit is newer than Lynx's and it comes
    with a different linker (aln), which is not entirely compatible
    with the older linker that Lynx used (link68).

    While it would be possible to get linking to work with aln, we
    decided to focus our attention on the cross-toolchain instead.

For your convenience, all the .s, .o, and .a files, as well as
bios.abs can also be found in the alcyon subdirectory of this
repository. Just in case you are interested in them, but would prefer
not to go through the emulator exercise.


Pitfalls
--------

There are a few differences between the Alcyon compiler and a
modern-day GCC cross-compiler for the Motorola 68k.

  * Alcyon uses 16-bit integers, whereas GCC defaults to 32-bit
    integers. That's why we pass the -mshort option to GCC.

  * The Alcyon compiler's ABI assumes that registers A2 and D2 are
    saved by the caller of a function, if needed. GCC, however,
    assumes that it's the called function that is responsible for
    preserving A2 and D2.

    Right now, we work around this issue by passing the -ffixed-d2 and
    -ffixed-a2 options to GCC. This prevents GCC from using these two
    registers at all when generating code.

    Ultimately, we should fix the hand-written assembly language
    functions to preserve A2 and D2, so that GCC code generation can
    use all registers.
