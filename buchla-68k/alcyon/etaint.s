.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _stcrow
.globl _stccol
.globl _ps_intn
.globl _adbox
.globl _dspbuf
.globl _et_aint
.text
_et_aint:
~~et_aint:
~n=8
link R14,#-4
*line 39
move _ps_intn,(sp)
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
.globl _ef_aint
.text
_ef_aint:
~~ef_aint:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 57
clr.b 2+_ebuf
*line 58
clr _ebflag
*line 59
clr R6
*line 61
clr R7
bra L6
L7:
*line 62
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 61
add #1,R7
L6:
*line 61
cmp #2,R7
blt L7
L4:
*line 64
move R6,_ps_intn
*line 65
move _ps_intn,R0
muls #10,R0
asl #5,R0
move R0,(sp)
clr -(sp)
move #1,-(sp)
jsr _sendval
addq.l #4,sp
*line 66
jsr _modasg
*line 67
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_aint
.text
_rd_aint:
~~rd_aint:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 85
move 8(R14),R7
and #255,R7
*line 86
move _ps_intn,(sp)
move.l #L9,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 88
clr (sp)
jsr _vbank
*line 89
*line 90
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 14(R8,R9.l),-(sp)
add #8,(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
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
*line 92
clr R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_aint
.text
_nd_aint:
~~nd_aint:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 108
move 10(R14),R7
*line 108
move 8(R14),R5
and #255,R5
*line 110
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 112
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 113
clr.b 2+_ebuf
*line 115
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 116
clr.b 1+_dspbuf
*line 118
clr (sp)
jsr _vbank
*line 119
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R5,R0
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
*line 121
jsr _advacur
*line 122
clr R0
bra L10
L10:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L9:.dc.b $25,$30,$32,$2E,$32,$64,$0
