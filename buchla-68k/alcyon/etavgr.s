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
.globl _vce2grp
.globl _ins2grp
.globl _et_avgr
.text
_et_avgr:
~~et_avgr:
~nn=8
link R14,#-4
movem.l R6-R7,-(sp)
~grp=R7
~buf=-4
*line 52
move 8(R14),R7
asr #8,R7
and #255,R7
*line 54
move R7,R8
add.l R8,R8
move.l #_vce2grp,R9
move 0(R8,R9.l),(sp)
move.l R14,-(sp)
sub.l #4,(sp)
jsr _numblk
addq.l #4,sp
move.l R0,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 55
move #1,_ebflag
*line 62
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ef_avgr
.text
_ef_avgr:
~~ef_avgr:
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~tmpval=R7
~vce=R6
~i=R5
*line 80
move 8(R14),R6
asr #8,R6
and #255,R6
*line 82
clr.b 2+_ebuf
*line 83
clr _ebflag
*line 84
clr R7
*line 91
*line 91
cmp.b #32,_ebuf
bne L4
cmp.b #32,1+_ebuf
bne L4
*line 92
*line 93
move #-1,R7
*line 94
bra L5
L4:
*line 95
*line 96
*line 97
clr R5
bra L8
L9:
*line 98
*line 99
*line 100
move R5,R8
add.l #_ebuf,R8
cmp.b #32,(R8)
bne L10
*line 100
move R5,R8
add.l #_ebuf,R8
move.b #48,(R8)
*line 101
L10:
*line 102
muls #10,R7
move.l #_ebuf,R8
move.b 0(R8,R5),R0
ext.w R0
add R0,R7
add #-48,R7
L7:
*line 97
add #1,R5
L8:
*line 97
cmp #2,R5
blt L9
L6:
*line 103
*line 104
*line 105
*line 106
tst R7
beq L10000
cmp #12,R7
ble L11
L10000:*line 106
move #-1,R0
bra L3
L11:L5:
*line 109
move R6,R8
add.l R8,R8
add.l #_vce2grp,R8
move R7,(R8)
*line 111
*line 112
tst R7
ble L12
*line 112
move #1,(sp)
move R7,R8
sub #1,R8
add.l R8,R8
move.l #_ins2grp,R9
move 0(R8,R9.l),-(sp)
and #255,(sp)
move R6,-(sp)
jsr _execinst
addq.l #4,sp
*line 113
L12:
*line 114
jsr _modasg
*line 115
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _rd_avgr
.text
_rd_avgr:
~~rd_avgr:
~nn=8
link R14,#-4
movem.l R5-R7,-(sp)
~n=R7
~grp=R6
~buf=-4
*line 134
move 8(R14),R7
and #255,R7
*line 135
move 8(R14),R6
asr #8,R6
and #255,R6
*line 137
clr (sp)
jsr _vbank
*line 138
*line 139
move #14,(sp)
move R6,R8
add.l R8,R8
move.l #_vce2grp,R9
move 0(R8,R9.l),-(sp)
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
*line 141
clr R0
bra L13
L13:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_avgr
.text
_nd_avgr:
~~nd_avgr:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~n=R6
~col=R5
*line 160
move 10(R14),R7
*line 160
move 8(R14),R6
and #255,R6
*line 161
move _stccol,R5
move.l _cfetp,R8
move 2(R8),R0
sub R0,R5
*line 163
move R7,R0
add #48,R0
move R5,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 164
clr.b 2+_ebuf
*line 172
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 173
clr.b 1+_dspbuf
*line 175
clr (sp)
jsr _vbank
*line 176
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
*line 178
jsr _advacur
*line 179
clr R0
bra L14
L14:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$73,$0
