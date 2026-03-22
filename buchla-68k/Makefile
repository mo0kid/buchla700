CROSS_DIR :=	/opt/cross-m68k/bin
CROSS_TRI :=	m68k-none-elf
CROSS_PRE :=	$(CROSS_DIR)/$(CROSS_TRI)

CROSS_GCC :=	$(CROSS_PRE)-gcc
CROSS_AS :=		$(CROSS_PRE)-as
CROSS_AR :=		$(CROSS_PRE)-ar
CROSS_OBJC :=	$(CROSS_PRE)-objcopy
CROSS_OBJD :=	$(CROSS_PRE)-objdump
CROSS_NM :=		$(CROSS_PRE)-nm

FLAGS :=		-Os -m68000 -Wall -Wextra -gdwarf-4

# -mshort sets the size of an int to 16 bits; important for interop with the
# hand-written assembly language code

FLAGS_COM :=	$(FLAGS) -mshort -std=c99 -ffreestanding -nostdinc \
				-fno-strict-aliasing -fno-inline -fno-omit-frame-pointer \
				-Wconversion -Wsign-conversion -Wshadow -Wstrict-prototypes \
				-Wmissing-declarations -Wredundant-decls \
				-I include

# the hand-written assembly language code doesn't preserve d2 and a2; don't use
# them until this is fixed

FLAGS_COM +=	-ffixed-d2 -ffixed-a2

FLAGS_ASM :=	$(FLAGS) -Wa,--register-prefix-optional,--base-size-default-16
FLAGS_LNK :=	$(FLAGS) -mshort -std=c99 -ffreestanding -nostdlib

HEADERS :=		$(wildcard include/*.h)

all:			bios.abs midas.abs

PROLOG_C :=		croot.c
PROLOG_S :=		fsmain.s

PROLOG_CO :=	$(PROLOG_C:.c=.o)
PROLOG_SO :=	$(PROLOG_S:.s=.o)
PROLOG_OBJ :=	$(PROLOG_CO:%=build/%) $(PROLOG_SO:%=build/%)

build/%.o:		prolog/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		prolog/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

prolog.a:		$(PROLOG_OBJ)
				rm -f prolog.a
				$(CROSS_AR) rcs prolog.a $(PROLOG_OBJ)

LIBCIO_C :=		atoi.c atol.c blkrd.c blkwr.c close.c clusmap.c conin.c conwr.c \
				dirfns.c fgets.c filesys.c filname.c flread.c fopen.c fprintf.c \
				fputs.c fread.c fscanf.c fseek.c fsinit.c fsize.c fstubs.c ftell.c \
				fwrite.c getbuff.c getc.c getl.c getw.c lseek.c open.c posit.c putc.c \
				putl.c putw.c read.c readrn.c rename.c scan.c setbuf.c ungetc.c \
				unlink.c write.c writern.c

LIBCIO_S :=		ptcl12.s

LIBCIO_CO :=	$(LIBCIO_C:.c=.o)
LIBCIO_SO :=	$(LIBCIO_S:.s=.o)
LIBCIO_OBJ :=	$(LIBCIO_CO:%=build/%) $(LIBCIO_SO:%=build/%)

build/%.o:		libcio/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		libcio/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

libcio.a:		$(LIBCIO_OBJ)
				rm -f libcio.a
				$(CROSS_AR) rcs libcio.a $(LIBCIO_OBJ)

VLIB_C := 		cg2.c cg3.c glcinit.c lseg.c vbfill4.c vclrs.c vhinit.c vmput.c \
				vobjfns.c vputs.c vputsv.c vsetpal.c vsinit.c vspray4.c vtext.c \
				vwputm.c

VLIB_S :=		acctrl.s glcplot.s tsplot4.s vbank.s vclrav.s vcputs.s vcputsv.s \
				viint.s vputa.s vputc.s vputcv.s vputp.s vsetav.s vsetcv.s vsplot4.s \
				vvputsv.s vwputp.s vwputs.s

VLIB_CO :=		$(VLIB_C:.c=.o)
VLIB_SO :=		$(VLIB_S:.s=.o)
VLIB_OBJ :=		$(VLIB_CO:%=build/%) $(VLIB_SO:%=build/%)

build/%.o:		vlib/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		vlib/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

vlib.a:			$(VLIB_OBJ)
				rm -f vlib.a
				$(CROSS_AR) rcs vlib.a $(VLIB_OBJ)

IOLIB_C :=		dofmt.c mdump.c pause.c printf.c rawio.c sprintf.c waitcr.c
IOLIB_S :=		hwdefs.s rtraps.s setipl.s setsr.s traps.s

IOLIB_CO :=		$(IOLIB_C:.c=.o)
IOLIB_SO :=		$(IOLIB_S:.s=.o)
IOLIB_OBJ :=	$(IOLIB_CO:%=build/%) $(IOLIB_SO:%=build/%)

build/%.o:		iolib/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		iolib/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

iolib.a:		$(IOLIB_OBJ)
				rm -f iolib.a
				$(CROSS_AR) rcs iolib.a $(IOLIB_OBJ)

LIBSM_C :=		index.c memccpy.c memchr.c memcmp.c memcmpu.c memcpy.c memcpyw.c \
				memset.c memsetw.c rindex.c str2lc.c str2uc.c strcat.c strccpy.c \
				strchr.c strcmp.c strcpy.c strcspn.c strfill.c strlcmp.c strlen.c \
				strltrm.c strncat.c strncmp.c strncpy.c strpbrk.c strrchr.c strrev.c \
				strrevi.c strrtrm.c strspn.c strtok.c strtol.c

LIBSM_CO :=		$(LIBSM_C:.c=.o)
LIBSM_OBJ :=	$(LIBSM_CO:%=build/%)

build/%.o:		libsm/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

libsm.a:		$(LIBSM_OBJ)
				rm -f libsm.a
				$(CROSS_AR) rcs libsm.a $(LIBSM_OBJ)

LIB700_C :=		bitrev.c ctype.c ispow2.c mangle.c micons.c tolower.c toupper.c

LIB700_S :=		aldiv.s almul.s alrem.s blkfill.s blkmove.s finalone.s jumpto.s \
				ldiv.s lmul.s lrem.s rand24.s setjmp.s uldiv.s

LIB700_CO :=	$(LIB700_C:.c=.o)
LIB700_SO :=	$(LIB700_S:.s=.o)
LIB700_OBJ :=	$(LIB700_CO:%=build/%) $(LIB700_SO:%=build/%)

build/%.o:		lib700/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		lib700/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

lib700.a:		$(LIB700_OBJ)
				rm -f lib700.a
				$(CROSS_AR) rcs lib700.a $(LIB700_OBJ)

ROM_C :=		booter.c romp.c
ROM_S :=		bios.s timeint.s

ROM_CO :=		$(ROM_C:.c=.o)
ROM_SO :=		$(ROM_S:.s=.o)
# ROM_SO goes before ROM_CO, so that bios.o is first.
ROM_OBJ :=		$(ROM_SO:%=build/%) $(ROM_CO:%=build/%)

LOWRAM_S :=		lowram.s

LOWRAM_SO :=	$(LOWRAM_S:.s=.o)
LOWRAM_OBJ :=	$(LOWRAM_SO:%=build/%)

build/%.o:		rom/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		rom/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

bios.abs:		bios.elf bios.img
				misc/mkhd.sh $(CROSS_NM) bios.elf >/tmp/bios.hdr
				ls -l bios.img
				cat /tmp/bios.hdr bios.img >bios.abs
				rm /tmp/bios.hdr

bios.img:		bios.elf
				$(CROSS_OBJC) --output-target binary bios.elf bios.img
				chmod a-x bios.img

bios.elf:		$(ROM_OBJ) \
				prolog.a libcio.a vlib.a iolib.a libsm.a lib700.a
				$(CROSS_GCC) $(FLAGS_LNK) -Wl,--script,misc/rom.ld,--entry,0x100000 \
				-o bios.elf $(ROM_OBJ) \
				prolog.a libcio.a vlib.a iolib.a libsm.a lib700.a -lgcc
				chmod a-x bios.elf
				misc/flopvbl.sh $(CROSS_OBJD)

RAM_C :=		addfpu.c adfield.c adselbx.c asgdsp.c asgvce.c barbadj.c chgsef.c \
				chksec.c cminit.c ctcpos.c curset.c dbentr.c dcopy.c dec2fr.c delnote.c \
				delpnts.c dformat.c dopatch.c enterit.c etaccn.c etadep.c etadyn.c \
				etagch.c etagpt.c etains.c etaint.c etaopt.c etaprg.c etarat.c etatab.c \
				etatun.c etavgr.c etdyn.c etiact.c eticnf.c etidin.c etimlt.c etinst.c \
				etioas.c etiosc.c etipnt.c etires.c etitim.c etival.c etivce.c etiwsn.c \
				etloc.c etmcfn.c etrel.c etres1.c etscor.c etsnbt.c etstrn.c ettpch.c \
				ettrns.c etttab.c ettval.c etvel.c etwavs.c etwhar.c etwhrv.c etwoff.c \
				etwpnt.c etwslt.c etwvce.c fcnote.c frfind.c gcurpos.c idfield.c idselbx.c \
				im700.c infield.c initi.c instdsp.c itcpos.c kbobj.c lcdlbls.c ldfield.c \
				ldselbx.c libdsp.c librw.c localkb.c m7menu.c midas.c msl.c msm.c nedacc.c \
				pix2mid.c ptdisp.c ptdkey.c ptfield.c ptread.c ptselbx.c ptwrite.c puteq.c \
				rscript.c scadv.c scfield.c scgoto.c scinit.c scope.c scordsp.c scread.c \
				scselbx.c sctrak.c scwrite.c seccpy.c sedump.c select.c sendval.c setgc.c \
				setv2gi.c setwq.c showcfg.c smscrl.c sqdisp.c sqdkey.c sqexec.c sqfield.c \
				sqread.c sqscan.c sqselbx.c sqwrite.c stcpos.c stmproc.c swinit.c tdfield.c \
				tdselbx.c ttcpos.c tundsp.c ucslice.c uslice.c vtyper.c wdfield.c wdselbx.c \
				wheel.c wscalc.c wsdsp.c

RAM_S :=		execins.s execkey.s fpuint.s procpfl.s sedisp.s seexec.s serintr.s \
				sreset.s timeint.s tofpu.s verdate.s

RAM_CO :=		$(RAM_C:.c=.o)
RAM_SO :=		$(RAM_S:.s=.o)
RAM_OBJ :=		$(RAM_CO:%=build/%) $(RAM_SO:%=build/%)

build/%.o:		ram/%.c $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_COM) -c -o $@ $<

build/%.o:		ram/%.s $(HEADERS) | build
				$(CROSS_GCC) $(FLAGS_ASM) -c -o $@ $<

midas.abs:		midas.elf midas.img
				misc/mkhd.sh $(CROSS_NM) midas.elf >/tmp/midas.hdr
				ls -l midas.img
				cat /tmp/midas.hdr midas.img >midas.abs
				rm /tmp/midas.hdr

midas.img:		midas.elf
				$(CROSS_OBJC) --output-target binary midas.elf midas.img
				chmod a-x midas.img

midas.elf:		$(LOWRAM_OBJ) prolog.a $(RAM_OBJ) \
				libcio.a vlib.a iolib.a libsm.a lib700.a
				$(CROSS_GCC) $(FLAGS_LNK) -Wl,--script,misc/ram.ld,--entry,0x10000 \
				-o midas.elf $(LOWRAM_OBJ) prolog.a $(RAM_OBJ) \
				libcio.a vlib.a iolib.a libsm.a lib700.a -lgcc
				chmod a-x midas.elf

build:
				mkdir build

hatari/c.img:	$(wildcard hatari/c/bin/*) $(wildcard hatari/c/work/*)
				rm -f hatari/c.img
				atari-hd-image 16 hatari/c.img BUCHLA hatari/c

emu:			hatari/c.img
				hatari \
				--control-socket /tmp/buchla.sock \
				--memsize 14 \
				--vdi-width 1280 --vdi-height 960 \
				--drive-a false --drive-b false \
				--acsi 0=hatari/c.img \
				--harddrive hatari/d --gemdos-drive d

rem:
				hatari/rem.py

virt:
				python3 -m venv --without-pip virt
				wget https://bootstrap.pypa.io/get-pip.py -O virt/get-pip.py
				cd virt; . bin/activate; python3 get-pip.py; pip install pycparser

clean:
				rm -rf build
				rm -f prolog.a iolib.a libcio.a libsm.a lib700.a vlib.a
				rm -f bios.elf bios.img bios.abs
				rm -f midas.elf midas.img midas.abs
				rm -f hatari/c.img
				rm -f hatari/d/out/*
