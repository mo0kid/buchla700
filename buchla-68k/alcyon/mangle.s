.globl _mangle
.text
_mangle:
~~mangle:
~bitmap=R13
~nb=R7
~ib=R6
link R14,#0
movem.l R2-R7/R13-R13,-(sp)
~bm=R5
~rv=R4
~bn=R3
*line 32
move.l 8(R14),R13
*line 32
move 12(R14),R7
*line 32
move.l 14(R14),R6
*line 32
move.l #$1,R5
*line 33
clr.l R4
*line 35
clr R3
bra L4
L5:
*line 36
*line 37
*line 38
move.l R6,R0
and.l R5,R0
beq L6
*line 38
move.l R13,R8
move R3,R9
add.l R9,R9
add.l R9,R9
add.l R9,R8
move.l (R8),R0
or.l R0,R4
*line 39
L6:
*line 40
asl.l #$1,R5
L3:
*line 35
add #1,R3
L4:
*line 35
cmp R7,R3
blt L5
L2:
*line 43
move.l R4,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R3-R7/R13-R13
unlk R14
rts
.data
