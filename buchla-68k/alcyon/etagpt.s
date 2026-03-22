.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _stcrow
.globl _stccol
.globl _dspbuf
.globl _gprep
.globl _key2grp
.globl _adbox
.globl _grp2prt
.globl _et_agpt
.text
_et_agpt:
~~et_agpt:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~grp=R7
*line 48
move 8(R14),R7
asr #8,R7
and #255,R7
*line 50
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_grp2prt,R9
move 0(R8,R9.l),R0
move.b R0,_ebuf
*line 51
clr.b 1+_ebuf
*line 53
move #1,_ebflag
*line 55
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ef_agpt
.text
_ef_agpt:
~~ef_agpt:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~tmpval=R7
~grp=R6
~i=R5
*line 70
move 8(R14),R6
asr #8,R6
and #255,R6
*line 72
clr.b 1+_ebuf
*line 73
clr _ebflag
*line 75
move.b _ebuf,R0
ext.w R0
move R6,R9
add.l R9,R9
add.l R9,R9
add.l #_grp2prt,R9
move R0,(R9)
*line 77
*line 78
move R6,R8
add.l R8,R8
add.l R8,R8
add.l #_grp2prt,R8
cmp #1,(R8)
beq L3
*line 78
clr R5
bra L6
L7:
*line 79
move #1,R0
move R6,R1
asl R1,R0
not R0
move R5,R9
add.l R9,R9
add.l #_key2grp,R9
and R0,(R9)
L5:
*line 78
add #1,R5
L6:
*line 78
cmp #88,R5
blt L7
L4:
*line 79
*line 80
L3:
*line 81
move R6,(sp)
jsr _drawk2g
*line 83
jsr _modasg
*line 84
clr R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _rd_agpt
.text
_rd_agpt:
~~rd_agpt:
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R7
~grp=R6
*line 102
move 8(R14),R7
and #255,R7
*line 103
move 8(R14),R6
asr #8,R6
and #255,R6
*line 105
clr (sp)
jsr _vbank
*line 106
*line 107
move #14,(sp)
move R6,R8
add.l R8,R8
add.l R8,R8
move.l #_grp2prt,R9
move 0(R8,R9.l),R8
add.l R8,R8
add.l R8,R8
move.l #_gprep,R9
move.l 0(R8,R9.l),-(sp)
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
*line 109
clr R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_agpt
.text
_nd_agpt:
~~nd_agpt:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 125
move 10(R14),R7
*line 125
move 8(R14),R6
and #255,R6
*line 127
*line 127
cmp #8,R7
bne L10
*line 128
*line 129
*line 130
sub.b #1,_ebuf
bge L11
*line 130
move.b #3,_ebuf
*line 131
L11:bra L12
L10:
*line 132
*line 132
cmp #9,R7
bne L13
*line 133
*line 134
*line 135
move.b _ebuf,R0
ext.w R0
add #1,R0
move.b R0,_ebuf
cmp #3,R0
ble L14
*line 135
clr.b _ebuf
*line 136
L14:bra L15
L13:
*line 137
*line 138
*line 139
move #-1,R0
bra L9
L15:L12:
*line 142
move.b _ebuf,R0
ext.w R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_gprep,R9
move.l 0(R8,R9.l),R8
move.b (R8),_dspbuf
*line 143
clr.b 1+_dspbuf
*line 145
clr (sp)
jsr _vbank
*line 146
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
*line 148
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
