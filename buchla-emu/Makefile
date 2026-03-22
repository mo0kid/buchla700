OS :=			$(shell uname)

ifndef WIN
GCC :=			gcc
GPP :=			g++
SDL2 :=			/opt/sdl2
SDL2_HB :=		/opt/homebrew
RTMIDI :=		/opt/rtmidi
EXT :=
else
GCC :=			x86_64-w64-mingw32-gcc
GPP :=			x86_64-w64-mingw32-g++
SDL2 :=			/opt/sdl2-win
RTMIDI :=		/opt/rtmidi-win
EXT :=			.exe
endif

SDL2_INC :=		$(SDL2)/include
SDL2_LIB :=		$(SDL2)/lib

RTMIDI_INC :=	$(RTMIDI)/include
RTMIDI_LIB :=	$(RTMIDI)/lib

FLAGS :=		-std=c99 -O2 -gdwarf-4

FLAGS_CPU :=	$(FLAGS) -pthread -I cpu -I build

FLAGS_EMU :=	$(FLAGS) -pthread \
				-fno-strict-aliasing -fno-inline -fno-omit-frame-pointer \
				-Wall -Wextra \
				-Wpedantic -Wconversion -Wsign-conversion -Wshadow \
				-Wstrict-prototypes -Wmissing-declarations -Wredundant-decls \
				-I cpu -I emu -I build -I $(SDL2_INC) -I $(RTMIDI_INC)

FLAGS_AUX :=	$(FLAGS) -Wall -Wextra \
				-Wpedantic -Wconversion -Wsign-conversion -Wshadow \
				-Wstrict-prototypes -Wmissing-declarations -Wredundant-decls

ifndef WIN
ifeq ($(OS), Linux)
FLAGS_EMU +=	-D EMU_LINUX
FLAGS_LNK :=	$(FLAGS) -pthread -Wall -Wextra
LIBS :=			$(SDL2_LIB)/libSDL2.a \
				$(SDL2_LIB)/libSDL2_net.a \
				$(SDL2_LIB)/libSDL2_ttf.a \
				$(SDL2_LIB)/libfreetype.a \
				$(RTMIDI_LIB)/librtmidi.a \
				-ldl -lm -lasound
endif

ifeq ($(OS), Darwin)
FLAGS_EMU +=	-D EMU_OS_X -I /opt/homebrew/include
FLAGS_LNK :=	$(FLAGS) -Wall -Wextra
LIBS :=			$(SDL2_LIB)/libSDL2.a \
				$(firstword $(wildcard $(SDL2_LIB)/libSDL2_net.a $(SDL2_HB)/lib/libSDL2_net.a)) \
				$(SDL2_LIB)/libSDL2_ttf.a \
				$(firstword $(wildcard $(SDL2_LIB)/libfreetype.a $(SDL2_HB)/lib/libfreetype.a)) \
				$(firstword $(wildcard $(RTMIDI_LIB)/librtmidi.a $(SDL2_HB)/lib/librtmidi.a)) \
				-framework AppKit \
				-framework AudioToolbox \
				-framework Carbon \
				-framework CoreAudio \
				-framework CoreFoundation \
				-framework CoreGraphics \
				-framework CoreHaptics \
				-framework CoreMIDI \
				-framework CoreVideo \
				-framework ForceFeedback \
				-framework GameController \
				-framework IOKit \
				-framework Metal \
				-l iconv
endif
else
FLAGS_EMU +=	-D EMU_WIN
FLAGS_LNK :=	$(FLAGS) -Wall -Wextra -static
LIBS :=			-l mingw32 \
				$(SDL2_LIB)/libSDL2.a \
				$(SDL2_LIB)/libSDL2main.a \
				$(SDL2_LIB)/libSDL2_net.a \
				$(SDL2_LIB)/libSDL2_ttf.a \
				$(SDL2_LIB)/libfreetype.a \
				$(RTMIDI_LIB)/librtmidi.a \
				-l gdi32 \
				-l imm32 \
				-l iphlpapi \
				-l ole32 \
				-l oleaut32 \
				-l version \
				-l winmm \
				-l ws2_32
endif

HEADERS :=		$(wildcard cpu/*.h) $(wildcard emu/*.h)

all:			buchla$(EXT) buchla.disk

build/gen:
				gcc $(FLAGS) -o build/gen cpu/m68kmake.c

GEN_C :=		m68kopac.c m68kopdm.c m68kopnz.c m68kops.c
GEN_H :=		m68kops.h

GEN_CP :=		$(GEN_C:%=build/%)
GEN_HP :=		$(GEN_H:%=build/%)

GEN_O :=		$(GEN_C:.c=.o)
GEN_OP :=		$(GEN_O:%=build/%)

$(GEN_CP) $(GEN_HP): \
				build/gen
				cd cpu; ../build/gen ../build

build/%.o:		build/%.c $(HEADERS)
				$(GCC) $(FLAGS_CPU) -c -o $@ $<

CPU_C :=		m68kcpu.c m68kdasm.c
CPU_O :=		$(CPU_C:.c=.o)
CPU_OP :=		$(CPU_O:%=build/%)

build/%.o:		cpu/%.c $(HEADERS) $(GEN_HP)
				$(GCC) $(FLAGS_CPU) -c -o $@ $<

EMU_C :=		main.c cpu.c vid.c fpu.c tim.c lcd.c ser.c mid.c fdd.c snd.c \
				led.c kbd.c sdl.c gdb.c dsp.c osc.c
EMU_O :=		$(EMU_C:.c=.o)
EMU_OP :=		$(EMU_O:%=build/%)

ifeq ($(OS), Darwin)
EMU_OP +=		build/dlg.o
endif

build/%.o:		emu/%.c $(HEADERS)
				$(GCC) $(FLAGS_EMU) -c -o $@ $<

build/%.o:		emu/%.m $(HEADERS)
				$(GCC) -O2 -gdwarf-4 -Wall -Wextra -c -o $@ $<

buchla$(EXT):	$(CPU_OP) $(GEN_OP)	$(EMU_OP)
				$(GPP) $(FLAGS_LNK) -o buchla$(EXT) \
				$(CPU_OP) $(GEN_OP) $(EMU_OP) \
				$(LIBS)

mkdisk$(EXT):	emu/mkdisk.c
				$(GCC) $(FLAGS_AUX) -o mkdisk$(EXT) emu/mkdisk.c

buchla.disk:	mkdisk$(EXT) midas.abs
				./mkdisk$(EXT)

run:			buchla$(EXT) buchla.disk
				./buchla$(EXT) ${EMU_OPTS}

val:			buchla$(EXT) buchla.disk
				valgrind --leak-resolution=high --track-fds=yes --leak-check=full \
				--show-reachable=yes --suppressions=misc/buchla.supp \
				./buchla$(EXT) ${EMU_OPTS}

pack:
				./pack.sh

clean:
				rm -f build/gen build/*.c build/*.h build/*.o
				rm -f buchla$(EXT)
				rm -f mkdisk$(EXT)
				rm -f buchla.disk
