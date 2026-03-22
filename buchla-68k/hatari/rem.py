#!/usr/bin/env python3

import os
import socket
import time

mod_prolog = [
    "rom/croot.c",
    "rom/fsmain.s"
]

mod_iolib = [
    "lib/dofmt.c",
    "lib/mdump.c",
    "lib/pause.c",
    "lib/printf.c",
    "lib/rawio.c",
    "lib/sprintf.c",
    "lib/waitcr.c",
    "lib/hwdefs.s",
    "lib/rtraps.s",
    "lib/setipl.s",
    "lib/setsr.s",
    "lib/traps.s"
]

mod_libcio = [
    "lib/atoi.c",
    "lib/atol.c",
    "lib/blkrd.c",
    "lib/blkwr.c",
    "lib/close.c",
    "lib/clusmap.c",
    "lib/conin.c",
    "lib/conwr.c",
    "lib/dirfns.c",
    "lib/fgets.c",
    "lib/filesys.c",
    "lib/filname.c",
    "lib/flread.c",
    "lib/fopen.c",
    "lib/fprintf.c",
    "lib/fputs.c",
    "lib/fread.c",
    "lib/fscanf.c",
    "lib/fseek.c",
    "lib/fsinit.c",
    "lib/fsize.c",
    "lib/fstubs.c",
    "lib/ftell.c",
    "lib/fwrite.c",
    "lib/getbuff.c",
    "lib/getc.c",
    "lib/getl.c",
    "lib/getw.c",
    "lib/lseek.c",
    "lib/open.c",
    "lib/posit.c",
    "lib/putc.c",
    "lib/putl.c",
    "lib/putw.c",
    "lib/read.c",
    "lib/readrn.c",
    "lib/rename.c",
    "lib/scan.c",
    "lib/setbuf.c",
    "lib/ungetc.c",
    "lib/unlink.c",
    "lib/write.c",
    "lib/writern.c",
    "lib/ptcl12.s"
]

mod_libsm = [
    "lib/index.c",
    "lib/memccpy.c",
    "lib/memchr.c",
    "lib/memcmp.c",
    "lib/memcmpu.c",
    "lib/memcpy.c",
    "lib/memcpyw.c",
    "lib/memset.c",
    "lib/memsetw.c",
    "lib/rindex.c",
    "lib/str2lc.c",
    "lib/str2uc.c",
    "lib/strcat.c",
    "lib/strccpy.c",
    "lib/strchr.c",
    "lib/strcmp.c",
    "lib/strcpy.c",
    "lib/strcspn.c",
    "lib/strfill.c",
    "lib/strlcmp.c",
    "lib/strlen.c",
    "lib/strltrm.c",
    "lib/strncat.c",
    "lib/strncmp.c",
    "lib/strncpy.c",
    "lib/strpbrk.c",
    "lib/strrchr.c",
    "lib/strrev.c",
    "lib/strrevi.c",
    "lib/strrtrm.c",
    "lib/strspn.c",
    "lib/strtok.c",
    "lib/strtol.c"
]

mod_lib700 = [
    "lib/bitrev.c",
    "lib/ctype.c",
    "lib/ispow2.c",
    "lib/mangle.c",
    "lib/micons.c",
    "lib/tolower.c",
    "lib/toupper.c",
    "lib/aldiv.s",
    "lib/almul.s",
    "lib/alrem.s",
    "lib/blkfill.s",
    "lib/blkmove.s",
    "lib/finalone.s",
    "lib/jumpto.s",
    "lib/ldiv.s",
    "lib/lmul.s",
    "lib/lrem.s",
    "lib/rand24.s",
    "lib/setjmp.s",
    "lib/uldiv.s"
]

mod_vlib = [
    "lib/cg2.c",
    "lib/cg3.c",
    "lib/glcinit.c",
    "lib/lseg.c",
    "lib/vbfill4.c",
    "lib/vclrs.c",
    "lib/vhinit.c",
    "lib/vmput.c",
    "lib/vobjfns.c",
    "lib/vputs.c",
    "lib/vputsv.c",
    "lib/vsetpal.c",
    "lib/vsinit.c",
    "lib/vspray4.c",
    "lib/vtext.c",
    "lib/vwputm.c",
    "lib/acctrl.s",
    "lib/glcplot.s",
    "lib/tsplot4.s",
    "lib/vbank.s",
    "lib/vclrav.s",
    "lib/vcputs.s",
    "lib/vcputsv.s",
    "lib/viint.s",
    "lib/vputa.s",
    "lib/vputc.s",
    "lib/vputcv.s",
    "lib/vputp.s",
    "lib/vsetav.s",
    "lib/vsetcv.s",
    "lib/vsplot4.s",
    "lib/vvputsv.s",
    "lib/vwputp.s",
    "lib/vwputs.s"
]

mod_rom = [
    "rom/booter.c",
    "rom/romp.c",
    "rom/bios.s",
    "rom/lowram.s",
    "rom/timeint.s"
]

mod_ram = [
    "ram/addfpu.c",
    "ram/adfield.c",
    "ram/adselbx.c",
    "ram/asgdsp.c",
    "ram/asgvce.c",
    "ram/barbadj.c",
    "ram/chgsef.c",
    "ram/chksec.c",
    "ram/cminit.c",
    "ram/ctcpos.c",
    "ram/curset.c",
    "ram/dbentr.c",
    "ram/dcopy.c",
    "ram/dec2fr.c",
    "ram/delnote.c",
    "ram/delpnts.c",
    "ram/dformat.c",
    "ram/dopatch.c",
    "ram/enterit.c",
    "ram/etaccn.c",
    "ram/etadep.c",
    "ram/etadyn.c",
    "ram/etagch.c",
    "ram/etagpt.c",
    "ram/etains.c",
    "ram/etaint.c",
    "ram/etaopt.c",
    "ram/etaprg.c",
    "ram/etarat.c",
    "ram/etatab.c",
    "ram/etatun.c",
    "ram/etavgr.c",
    "ram/etdyn.c",
    "ram/etiact.c",
    "ram/eticnf.c",
    "ram/etidin.c",
    "ram/etimlt.c",
    "ram/etinst.c",
    "ram/etioas.c",
    "ram/etiosc.c",
    "ram/etipnt.c",
    "ram/etires.c",
    "ram/etitim.c",
    "ram/etival.c",
    "ram/etivce.c",
    "ram/etiwsn.c",
    "ram/etloc.c",
    "ram/etmcfn.c",
    "ram/etrel.c",
    "ram/etres1.c",
    "ram/etscor.c",
    "ram/etsnbt.c",
    "ram/etstrn.c",
    "ram/ettpch.c",
    "ram/ettrns.c",
    "ram/etttab.c",
    "ram/ettval.c",
    "ram/etvel.c",
    "ram/etwavs.c",
    "ram/etwhar.c",
    "ram/etwhrv.c",
    "ram/etwoff.c",
    "ram/etwpnt.c",
    "ram/etwslt.c",
    "ram/etwvce.c",
    "ram/fcnote.c",
    "ram/frfind.c",
    "ram/gcurpos.c",
    "ram/idfield.c",
    "ram/idselbx.c",
    "ram/im700.c",
    "ram/infield.c",
    "ram/initi.c",
    "ram/instdsp.c",
    "ram/itcpos.c",
    "ram/kbobj.c",
    "ram/lcdlbls.c",
    "ram/ldfield.c",
    "ram/ldselbx.c",
    "ram/libdsp.c",
    "ram/librw.c",
    "ram/localkb.c",
    "ram/m7menu.c",
    "ram/midas.c",
    "ram/msl.c",
    "ram/msm.c",
    "ram/nedacc.c",
    "ram/pix2mid.c",
    "ram/ptdisp.c",
    "ram/ptdkey.c",
    "ram/ptfield.c",
    "ram/ptread.c",
    "ram/ptselbx.c",
    "ram/ptwrite.c",
    "ram/puteq.c",
    "ram/rscript.c",
    "ram/scadv.c",
    "ram/scfield.c",
    "ram/scgoto.c",
    "ram/scinit.c",
    "ram/scope.c",
    "ram/scordsp.c",
    "ram/scread.c",
    "ram/scselbx.c",
    "ram/sctrak.c",
    "ram/scwrite.c",
    "ram/seccpy.c",
    "ram/sedump.c",
    "ram/select.c",
    "ram/sendval.c",
    "ram/setgc.c",
    "ram/setv2gi.c",
    "ram/setwq.c",
    "ram/showcfg.c",
    "ram/smscrl.c",
    "ram/sqdisp.c",
    "ram/sqdkey.c",
    "ram/sqexec.c",
    "ram/sqfield.c",
    "ram/sqread.c",
    "ram/sqscan.c",
    "ram/sqselbx.c",
    "ram/sqwrite.c",
    "ram/stcpos.c",
    "ram/stmproc.c",
    "ram/swinit.c",
    "ram/tdfield.c",
    "ram/tdselbx.c",
    "ram/ttcpos.c",
    "ram/tundsp.c",
    "ram/ucslice.c",
    "ram/uslice.c",
    "ram/vtyper.c",
    "ram/wdfield.c",
    "ram/wdselbx.c",
    "ram/wheel.c",
    "ram/wscalc.c",
    "ram/wsdsp.c",
    "ram/execins.s",
    "ram/execkey.s",
    "ram/fpuint.s",
    "ram/procpfl.s",
    "ram/sedisp.s",
    "ram/seexec.s",
    "ram/serintr.s",
    "ram/sreset.s",
    "ram/timeint.s",
    "ram/tofpu.s",
    "ram/verdate.s"
]

codes = {
    "-":  12,
    "=":  13,
    "\b": 14,
    "\t": 15,
    "`":  41,
    "[":  26,
    "]":  27,
    "\n": 28,
    ";":  39,
    "'":  40,
    "\\": 43,
    ",":  51,
    ".":  52,
    "/":  53,
    " ":  57
}

codes_shifted = {
    "!":   2,
    "@":   3,
    "#":   4,
    "$":   5,
    "%":   6,
    "^":   7,
    "&":   8,
    "*":   9,
    "(":  10,
    ")":  11,
    "_":  12,
    "+":  13,
    "~":  41,
    "{":  26,
    "}":  27,
    ":":  39,
    "\"": 40,
    "|":  43,
    "<":  51,
    ">":  52,
    "?":  53
}

sig_path = "hatari/d/signal"
lis_path = "/tmp/buchla.sock"
con = None

def hatari_connect():
    lis = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

    if os.path.exists(lis_path):
        os.unlink(lis_path)

    lis.bind(lis_path)
    lis.listen(1)

    global con
    (con, _) = lis.accept()

def hatari_send(command):
    global con
    con.sendall((command + "\n").encode("ascii"))

def send_alnum(c):
    hatari_send("hatari-event keypress {}".format(c))

def send_code(code):
    hatari_send("hatari-event keypress {}".format(code))

def send_code_shifted(code):
    hatari_send("hatari-event keydown 42")
    send_code(code)
    hatari_send("hatari-event keyup 42")

def send_line(line):
    line += "\n"

    for c in line:
        if c in codes:
            send_code(codes[c])
        elif c in codes_shifted:
            send_code_shifted(codes_shifted[c])
        else:
            send_alnum(c)

        time.sleep(0.075)

def run_command(command):
    if os.path.exists(sig_path):
        os.unlink(sig_path)

    print("Executing {}".format(command))
    send_line(command + "; touch d:\\signal")

    print("Waiting for completion")
    while not os.path.exists(sig_path):
        time.sleep(0.25)

    os.unlink(sig_path)

def assemble(dir, base):
    print("Assembling {}.s in {}".format(base, dir))
    run_command("cp d:\\{}\\{}.s code.s".format(dir, base))
    run_command("as code")
    run_command("cp code.o d:\\out\\{}.o".format(base))
    run_command("rm code.o")
    run_command("rm code.s")
    send_line("")

def compile(dir, base):
    print("Compiling {}.c in {}".format(base, dir))
    run_command("cp d:\\{}\\{}.c code.c".format(dir, base))
    run_command("cc code")
    run_command("as code")
    run_command("cp code.s d:\\out\\{}.s".format(base))
    run_command("cp code.o d:\\out\\{}.o".format(base))
    run_command("rm code.o")
    run_command("rm code.s")
    run_command("rm code.c")
    send_line("")

def store_file(file):
    run_command("cp {} d:\\out\\{}".format(file, file))

def fetch_file(file):
    run_command("cp d:\\out\\{} {}".format(file, file))

def remove_file(file):
    run_command("rm {}".format(file))

def store_archive(a_base):
    store_file("{}.a".format(a_base))
    store_file("{}.ndx".format(a_base))
    send_line("")

def fetch_archive(a_base):
    fetch_file("{}.a".format(a_base))
    fetch_file("{}.ndx".format(a_base))
    send_line("")

def remove_archive(a_base):
    remove_file("{}.a".format(a_base))
    remove_file("{}.ndx".format(a_base))
    send_line("")

def archive_one(a_base, base):
    print("Adding {}.o to {}.a".format(base, a_base))
    fetch_file("{}.o".format(base))
    run_command("ar68 r {}.a {}.o".format(a_base, base))
    remove_file("{}.o".format(base))
    send_line("")

def archive(a_base, mod):
    print("Creating {}.a".format(a_base))

    for path in mod:
        (dir, file) = path.split("/")
        (base, ext) = file.split(".")
        archive_one(a_base, base)

    run_command("doindex -w {}.a".format(a_base))
    send_line("")

    store_archive(a_base)
    remove_archive(a_base)

def link(com_file):
    fetch_archive("prolog")
    fetch_archive("libcio")
    fetch_archive("vlib")
    fetch_archive("iolib")
    fetch_archive("libsm")
    fetch_archive("lib700")

    run_command("aln -w -l -c {}".format(com_file))
    send_line("")

    remove_archive("prolog")
    remove_archive("libcio")
    remove_archive("vlib")
    remove_archive("iolib")
    remove_archive("libsm")
    remove_archive("lib700")

def link_rom():
    print("Linking ROM")

    fetch_file("bios.o")
    fetch_file("romp.o")
    fetch_file("booter.o")
    fetch_file("timeint.o")
    send_line("")

    link("rom.lnk")

    remove_file("bios.o")
    remove_file("romp.o")
    remove_file("booter.o")
    remove_file("timeint.o")
    send_line("")

    store_file("bios.abs")
    remove_file("bios.abs")
    send_line("")

def link_ram():
    print("Linking RAM")

    for path in mod_ram:
        (dir, file) = path.split("/")
        (base, ext) = file.split(".")
        fetch_file("{}.o".format(base))

    fetch_file("lowram.o")
    send_line("")

    link("ram.lnk")

    for path in mod_ram:
        (dir, file) = path.split("/")
        (base, ext) = file.split(".")
        remove_file("{}.o".format(base))

    remove_file("lowram.o")
    send_line("")

    store_file("midas.abs")
    remove_file("midas.abs")
    send_line("")

print("Waiting for Hatari to connect to {}.".format(lis_path))
hatari_connect()

print("Hatari connected.")
input("Please start C:\\BIN\\SH.TTP manually, then press enter.")

send_line("PATH=\\bin")
send_line("cd \\work")
send_line("")

start_at = None

for mod in [mod_prolog, mod_iolib, mod_libcio, mod_libsm, mod_lib700, mod_vlib,
            mod_rom, mod_ram]:
    for path in mod:
        if start_at != None:
            if start_at != path:
                continue
            else:
                start_at = None

        (dir, file) = path.split("/")
        (base, ext) = file.split(".")

        if ext == "s":
            assemble(dir, base)
        elif ext == "c":
            compile(dir, base)
        else:
            raise Exception("file {} with invalid extension {}".format(file, ext))

archive("prolog", mod_prolog)
archive("iolib", mod_iolib)
archive("libcio", mod_libcio)
archive("libsm", mod_libsm)
archive("lib700", mod_lib700)
archive("vlib", mod_vlib)

link_rom()
link_ram()
