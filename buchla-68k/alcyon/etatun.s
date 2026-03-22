.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _stcrow
.globl _stccol
.globl _curtun
.globl _adbox
.globl _dspbuf
.globl _et_atun
.text
_et_atun:
~~et_atun:
~n=8
link R14,#-4
*line 39
move _curtun,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 40
move #1,_ebflag
*line 42
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_atun
.text
_ef_atun:
~~ef_atun:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~tmpval=R7
*line 57
clr.b 1+_ebuf
*line 58
clr _ebflag
*line 60
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 62
move R7,(sp)
jsr _gettun
*line 64
jsr _modasg
*line 65
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_atun
.text
_rd_atun:
~~rd_atun:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 83
move 8(R14),R7
and #255,R7
*line 84
move _curtun,(sp)
move.l #L5,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 86
clr (sp)
jsr _vbank
*line 87
*line 88
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 12(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 10(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _asgob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 90
clr R0
bra L4
L4:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_atun
.text
_nd_atun:
~~nd_atun:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 106
move 10(R14),R7
*line 106
move 8(R14),R6
and #255,R6
*line 107
move R7,R0
add #48,R0
move.b R0,_ebuf
*line 108
clr.b 1+_ebuf
*line 110
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 111
clr.b 1+_dspbuf
*line 113
clr (sp)
jsr _vbank
*line 114
*line 115
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 10(R8,R9.l),-(sp)
move #12,-(sp)
move #64,-(sp)
move.l _asgob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 117
clr R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$31,$2E,$31,$64,$0
L5:.dc.b $54,$75,$6E,$20,$25,$30,$31,$2E,$31,$64,$0
