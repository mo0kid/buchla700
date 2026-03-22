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
.globl _mctlnum
.globl _et_accn
.text
_et_accn:
~~et_accn:
~n=8
link R14,#-4
movem.l R6-R7,-(sp)
~ctl=R7
~buf=-4
*line 46
move 8(R14),R7
asr #8,R7
and #255,R7
*line 48
move R7,R8
add.l R8,R8
move.l #_mctlnum,R9
move 0(R8,R9.l),(sp)
and #255,(sp)
move.l #_ebuf,-(sp)
jsr _numblk
addq.l #4,sp
*line 49
move #1,_ebflag
*line 51
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ef_accn
.text
_ef_accn:
~~ef_accn:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~tmpval=R7
~ctl=R6
~i=R5
*line 66
move 8(R14),R6
asr #8,R6
and #255,R6
*line 68
clr.b 2+_ebuf
*line 69
clr _ebflag
*line 70
clr R7
*line 72
*line 72
cmp.b #32,_ebuf
bne L3
cmp.b #32,1+_ebuf
bne L3
*line 73
*line 74
move #-1,R7
*line 75
bra L4
L3:
*line 76
*line 77
*line 78
clr R5
bra L7
L8:
*line 79
*line 80
*line 81
move R5,R8
add.l #_ebuf,R8
cmp.b #32,(R8)
bne L9
*line 81
move R5,R8
add.l #_ebuf,R8
move.b #48,(R8)
*line 82
L9:
*line 83
muls #10,R7
move.l #_ebuf,R8
move.b 0(R8,R5),R0
ext.w R0
add R0,R7
add #-48,R7
L6:
*line 78
add #1,R5
L7:
*line 78
cmp #2,R5
blt L8
L5:
*line 84
L4:
*line 87
*line 88
move R6,R8
add.l R8,R8
add.l #_mctlnum,R8
cmp #-1,(R8)
bne L10
*line 88
move R6,R8
add.l R8,R8
add.l #_mctlnum,R8
move R7,(R8)
*line 89
bra L11
L10:
*line 90
move R7,R0
move R6,R9
add.l R9,R9
add.l #_mctlnum,R9
move (R9),R1
and #-256,R1
or R1,R0
move R6,R9
add.l R9,R9
add.l #_mctlnum,R9
move R0,(R9)
L11:
*line 92
jsr _modasg
*line 93
clr R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _rd_accn
.text
_rd_accn:
~~rd_accn:
~nn=8
link R14,#-4
movem.l R5-R7,-(sp)
~n=R7
~ctl=R6
~buf=-4
*line 112
move 8(R14),R7
and #255,R7
*line 113
move 8(R14),R6
asr #8,R6
and #255,R6
*line 115
clr (sp)
jsr _vbank
*line 116
*line 117
*line 118
move #14,(sp)
move R6,R8
add.l R8,R8
move.l #_mctlnum,R9
move 0(R8,R9.l),-(sp)
and #255,(sp)
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
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_accn
.text
_nd_accn:
~~nd_accn:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 139
move 10(R14),R7
*line 139
move 8(R14),R6
and #255,R6
*line 140
move R7,R0
add #48,R0
move _stccol,R9
move.l _cfetp,R10
move 2(R10),R10
sub R10,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 141
clr.b 2+_ebuf
*line 143
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 144
clr.b 1+_dspbuf
*line 146
clr (sp)
jsr _vbank
*line 147
*line 148
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
*line 150
jsr _advacur
*line 151
clr R0
bra L13
L13:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
