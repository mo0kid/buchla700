.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _stcrow
.globl _stccol
.globl _adbox
.globl _dspbuf
.globl _grp2prt
.globl _et_agch
.text
_et_agch:
~~et_agch:
~n=8
link R14,#-4
movem.l R6-R7,-(sp)
~grp=R7
~buf=-4
*line 47
move 8(R14),R7
asr #8,R7
and #255,R7
*line 49
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_grp2prt,R9
move 2(R8,R9.l),(sp)
move.l #_ebuf,-(sp)
jsr _numblk
addq.l #4,sp
*line 50
move #1,_ebflag
*line 52
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ef_agch
.text
_ef_agch:
~~ef_agch:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~tmpval=R7
~grp=R6
~i=R5
*line 67
move 8(R14),R6
asr #8,R6
and #255,R6
*line 69
clr.b 2+_ebuf
*line 70
clr _ebflag
*line 71
clr R7
*line 73
*line 73
cmp.b #32,_ebuf
bne L3
cmp.b #32,1+_ebuf
bne L3
*line 74
*line 75
move #-1,R7
*line 76
bra L4
L3:
*line 77
*line 78
*line 79
clr R5
bra L7
L8:
*line 80
*line 81
*line 82
move R5,R8
add.l #_ebuf,R8
cmp.b #32,(R8)
bne L9
*line 82
move R5,R8
add.l #_ebuf,R8
move.b #48,(R8)
*line 83
L9:
*line 84
muls #10,R7
move.l #_ebuf,R8
move.b 0(R8,R5),R0
ext.w R0
add R0,R7
add #-48,R7
L6:
*line 79
add #1,R5
L7:
*line 79
cmp #2,R5
blt L8
L5:
*line 85
*line 86
*line 87
*line 88
tst R7
beq L10000
cmp #16,R7
ble L10
L10000:*line 88
move #-1,R0
bra L2
L10:L4:
*line 91
move R6,R8
add.l R8,R8
add.l R8,R8
add.l #_grp2prt,R8
move R7,2(R8)
*line 93
jsr _modasg
*line 94
clr R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _rd_agch
.text
_rd_agch:
~~rd_agch:
~nn=8
link R14,#-4
movem.l R5-R7,-(sp)
~n=R7
~grp=R6
~buf=-4
*line 113
move 8(R14),R7
and #255,R7
*line 114
move 8(R14),R6
asr #8,R6
and #255,R6
*line 116
clr (sp)
jsr _vbank
*line 117
*line 118
move #14,(sp)
move R6,R8
add.l R8,R8
add.l R8,R8
move.l #_grp2prt,R9
move 2(R8,R9.l),-(sp)
move.l R14,-(sp)
sub.l #4,(sp)
jsr _numblk
addq.l #6,sp
move.l R0,-(sp)
move.l _cfetp,R8
move 2(R8),-(sp)
move.l _cfetp,R8
move (R8),-(sp)
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
*line 120
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_agch
.text
_nd_agch:
~~nd_agch:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 136
move 10(R14),R7
*line 136
move 8(R14),R6
and #255,R6
*line 137
move R7,R0
add #48,R0
move _stccol,R9
move.l _cfetp,R10
move 2(R10),R10
sub R10,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 138
clr.b 2+_ebuf
*line 140
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 141
clr.b 1+_dspbuf
*line 143
clr (sp)
jsr _vbank
*line 144
*line 145
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
*line 147
jsr _advacur
*line 148
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
