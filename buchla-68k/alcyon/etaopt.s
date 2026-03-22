.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _stcrow
.globl _stccol
.globl _curmop
.globl _adbox
.globl _dspbuf
.globl _gprep
.globl _et_aopt
.text
_et_aopt:
~~et_aopt:
~n=8
link R14,#-4
*line 41
move _curmop,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 42
move #1,_ebflag
*line 44
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_aopt
.text
_ef_aopt:
~~ef_aopt:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~tmpval=R7
*line 59
clr.b 1+_ebuf
*line 60
clr _ebflag
*line 62
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 64
*line 65
cmp #3,R7
ble L4
*line 65
move #-1,R0
bra L3
*line 66
L4:
*line 67
move R7,_curmop
*line 68
jsr _modasg
*line 69
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_aopt
.text
_rd_aopt:
~~rd_aopt:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 87
move 8(R14),R7
and #255,R7
*line 89
clr (sp)
jsr _vbank
*line 90
*line 91
move #14,(sp)
move _curmop,R8
add.l R8,R8
add.l R8,R8
move.l #_gprep,R9
move.l 0(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 14(R8,R9.l),-(sp)
add #9,(sp)
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
*line 93
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_aopt
.text
_nd_aopt:
~~nd_aopt:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 109
move 10(R14),R7
*line 109
*line 110
cmp #1,R7
blt L10000
cmp #2,R7
ble L7
L10000:*line 110
move #-1,R0
bra L6
*line 111
L7:
*line 112
move 8(R14),R6
and #255,R6
*line 113
move R7,R0
add #48,R0
move.b R0,_ebuf
*line 114
clr.b 1+_ebuf
*line 116
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 117
clr.b 1+_dspbuf
*line 119
clr (sp)
jsr _vbank
*line 120
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
*line 122
clr R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$31,$2E,$31,$64,$0
