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
.globl _pecase
.globl _npts
.globl _temin
.globl _temax
.globl _pntsv
.globl _idbox
.globl _dspbuf
.globl _vbufs
.globl _pntptr
.globl _et_itim
.text
_et_itim:
~~et_itim:
~n=8
link R14,#0
movem.l R3-R7,-(sp)
~th=R7
~tl=R6
~tt=R5
~sc=R4
*line 50
jsr _pntsel
*line 52
move.l #$3e8,R4
*line 53
move _subj,(sp)
move _curfunc,-(sp)
jsr _timeto
addq.l #2,sp
ext.l R0
move.l R0,R5
*line 54
move.l R4,-(sp)
move.l R5,-(sp)
jsr ldiv
addq.l #8,sp
move R0,R7
*line 55
move R7,R0
ext.l R0
move.l R0,-(sp)
move.l R4,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,-(sp)
move.l R5,R0
sub.l (sp)+,R0
move R0,R6
*line 57
move R6,(sp)
move R7,-(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 58
move #1,_ebflag
*line 65
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _ef_itim
.text
_ef_itim:
~~ef_itim:
~n=8
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~i=R7
~endpnt=R6
~basept=R5
~tmpval=R4
~fp=R13
~ip=R12
*line 86
move _curvce,R0
muls #3938,R0
move.l R0,R12
add.l #_vbufs,R12
*line 87
move.l R12,R13
move _curfunc,R0
muls #12,R0
add.l R0,R13
add.l #86,R13
*line 89
move.b #46,2+_ebuf
*line 90
clr.b 6+_ebuf
*line 91
clr _ebflag
*line 96
clr R4
*line 98
clr R7
bra L6
L7:
*line 99
mulu #10,R4
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R4
add #-48,R4
L5:
*line 98
add #1,R7
L6:
*line 98
cmp #2,R7
blt L7
L4:
*line 101
move #3,R7
bra L10
L11:
*line 102
mulu #10,R4
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R4
add #-48,R4
L9:
*line 101
add #1,R7
L10:
*line 101
cmp #6,R7
blt L11
L8:
*line 107
*line 108
cmp _temax,R4
bls L12
*line 108
move #-1,R0
bra L3
*line 109
L12:
*line 110
*line 111
cmp _temin,R4
bcc L13
*line 111
move #-1,R0
bra L3
*line 112
L13:
*line 113
move R4,(sp)
move _subj,-(sp)
jsr _setseg
addq.l #2,sp
*line 115
*line 116
cmp #2,_pecase
bne L14
*line 116
move _temax,(sp)
move _subj,-(sp)
add #1,(sp)
jsr _setseg
addq.l #2,sp
*line 120
L14:
*line 121
jsr _modinst
*line 122
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _rd_itim
.text
_rd_itim:
~~rd_itim:
~n=8
link R14,#0
movem.l R3-R7,-(sp)
~th=R7
~tl=R6
~tt=R5
~sc=R4
*line 141
move.l #$3e8,R4
*line 142
move _subj,(sp)
move _curfunc,-(sp)
jsr _timeto
addq.l #2,sp
ext.l R0
move.l R0,R5
*line 143
move.l R4,-(sp)
move.l R5,-(sp)
jsr ldiv
addq.l #8,sp
move R0,R7
*line 144
move R7,R0
ext.l R0
move.l R0,-(sp)
move.l R4,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,-(sp)
move.l R5,R0
sub.l (sp)+,R0
move R0,R6
*line 146
move R6,(sp)
move R7,-(sp)
move.l #L16,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 148
clr (sp)
jsr _vbank
*line 150
*line 151
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
*line 153
move _curfunc,(sp)
jsr _edfunc
*line 154
clr R0
bra L15
L15:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _nd_itim
.text
_nd_itim:
~~nd_itim:
~k=R7
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~ec=R6
*line 173
move 10(R14),R7
*line 173
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 175
*line 176
cmp #2,R6
bne L18
*line 176
move #-1,R0
bra L17
*line 177
L18:
*line 178
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 179
move.b #46,2+_ebuf
*line 180
clr.b 6+_ebuf
*line 182
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 183
clr.b 1+_dspbuf
*line 185
clr (sp)
jsr _vbank
*line 187
*line 188
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
*line 190
jsr _advicur
*line 192
*line 193
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #2,R0
cmp _stccol,R0
bne L19
*line 193
jsr _advicur
*line 194
L19:
*line 195
clr R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$2E,$25,$30,$33,$64,$0
L16:.dc.b $25,$30,$32,$64,$2E,$25,$30,$33,$64,$0
