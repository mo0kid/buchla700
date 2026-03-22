.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _instob
.globl _stccol
.globl _subj
.globl _curvce
.globl _curfunc
.globl _curpnt
.globl _idbox
.globl _dspbuf
.globl _vbufs
.globl _pntptr
.globl _et_ipnt
.text
_et_ipnt:
~~et_ipnt:
~n=8
link R14,#-4
*line 46
move _subj,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 47
move #1,_ebflag
*line 49
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_ipnt
.text
_ef_ipnt:
~~ef_ipnt:
~n=8
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~i=R7
~tmpval=R6
~endpnt=R5
~basept=R4
~fp=R13
~ip=R12
*line 69
move _curvce,R0
muls #3938,R0
move.l R0,R12
add.l #_vbufs,R12
*line 70
move.l R12,R13
move _curfunc,R0
muls #12,R0
add.l R0,R13
add.l #86,R13
*line 72
clr.b 2+_ebuf
*line 73
clr _ebflag
*line 75
clr R6
*line 77
clr R7
bra L6
L7:
*line 78
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 77
add #1,R7
L6:
*line 77
cmp #2,R7
blt L7
L4:
*line 80
move.b 6(R13),R4
ext.w R4
*line 81
move.b 6(R13),R5
ext.w R5
move.b 5(R13),R0
ext.w R0
add R0,R5
sub #1,R5
*line 86
*line 86
move.b 5(R13),R0
ext.w R0
cmp R0,R6
blt L8
*line 87
*line 88
*line 88
cmp.b #100,5(R13)
bne L9
*line 89
*line 90
move #1,(sp)
jsr _showpt
*line 91
move #-1,R0
bra L3
*line 92
*line 95
L9:
*line 96
*line 96
move R5,(sp)
move _curfunc,-(sp)
move.l R12,-(sp)
jsr _inspnt
addq.l #6,sp
tst R0
bne L10
*line 99
*line 100
move #1,(sp)
jsr _showpt
*line 101
move #-1,R0
bra L3
*line 102
bra L11
L10:
*line 103
*line 104
*line 105
move.b 5(R13),R0
ext.w R0
sub #1,R0
move R0,_subj
*line 106
jsr _pntsel
*line 107
move #12,(sp)
clr -(sp)
move.l _pntptr,-(sp)
jsr _memset
addq.l #6,sp
*line 108
move.l _pntptr,R8
move.l _pntptr,R9
move -10(R9),2(R8)
*line 109
move _subj,(sp)
sub #1,(sp)
move _curfunc,-(sp)
jsr _timeto
addq.l #2,sp
move R0,(sp)
add #1,(sp)
move _subj,-(sp)
jsr _setseg
addq.l #2,sp
*line 110
move #1,(sp)
jsr _showpt
*line 114
*line 115
jsr _modinst
*line 116
clr R0
bra L3
L11:
*line 117
*line 118
bra L12
L8:
*line 119
*line 122
*line 123
*line 124
move R6,R0
add R4,R0
cmp R0,R5
bge L13
*line 124
move #-1,R0
bra L3
*line 125
L13:
*line 126
move R6,_subj
*line 127
jsr _pntsel
*line 128
move #1,(sp)
jsr _showpt
*line 132
*line 133
clr R0
bra L3
L12:L3:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _rd_ipnt
.text
_rd_ipnt:
~~rd_ipnt:
~n=8
link R14,#-4
*line 150
move _subj,(sp)
move.l #L15,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 152
clr (sp)
jsr _vbank
*line 154
*line 155
move #14,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 157
clr R0
bra L14
L14:unlk R14
rts
.globl _nd_ipnt
.text
_nd_ipnt:
~~nd_ipnt:
~k=R7
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~ec=R6
*line 176
move 10(R14),R7
*line 176
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 177
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 178
clr.b 2+_ebuf
*line 180
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 181
clr.b 1+_dspbuf
*line 183
clr (sp)
jsr _vbank
*line 185
*line 186
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 188
jsr _advicur
*line 190
clr R0
bra L16
L16:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L15:.dc.b $25,$30,$32,$64,$0
