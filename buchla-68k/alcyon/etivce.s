.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _instob
.globl _stccol
.globl _curvce
.globl _idbox
.globl _dspbuf
.globl _et_ivce
.text
_et_ivce:
~~et_ivce:
~n=8
link R14,#-4
*line 42
move _curvce,(sp)
add #1,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 43
move #1,_ebflag
*line 45
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_ivce
.text
_ef_ivce:
~~ef_ivce:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 63
clr.b 2+_ebuf
*line 64
clr _ebflag
*line 66
clr R6
*line 68
clr R7
bra L6
L7:
*line 69
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 68
add #1,R7
L6:
*line 68
cmp #2,R7
blt L7
L4:
*line 71
*line 72
tst R6
beq L10000
cmp #12,R6
ble L8
L10000:*line 72
move #-1,R0
bra L3
*line 73
L8:
*line 74
move R6,(sp)
sub #1,(sp)
jsr _newvce
*line 75
jsr _allwins
*line 76
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_ivce
.text
_rd_ivce:
~~rd_ivce:
~n=8
link R14,#-4
*line 94
move _curvce,(sp)
add #1,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 96
clr (sp)
jsr _vbank
*line 98
*line 99
move #14,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
add #6,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
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
*line 101
clr R0
bra L9
L9:unlk R14
rts
.globl _nd_ivce
.text
_nd_ivce:
~~nd_ivce:
~k=R7
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~ec=R6
*line 120
move 10(R14),R7
*line 120
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 121
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 122
clr.b 2+_ebuf
*line 124
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 125
clr.b 1+_dspbuf
*line 127
clr (sp)
jsr _vbank
*line 129
*line 130
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
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
*line 132
jsr _advicur
*line 134
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$64,$0
