.globl _strncmp
.text
_strncmp:
~~strncmp:
~s1=R13
~s2=R12
~n=R7
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
*line 16
move.l 8(R14),R13
*line 16
move.l 12(R14),R12
*line 16
move 16(R14),R7
*line 16
*line 17
cmp.l R12,R13
bne L2
*line 17
clr R0
bra L1
*line 18
L2:
*line 19
bra L5
L4:
*line 20
*line 21
tst.b (R13)+
bne L6
*line 21
clr R0
bra L1
*line 22
L6:L5:
*line 23
sub #1,R7
blt L10000
move.b (R13),R0
ext.w R0
cmp.b (R12)+,R0
beq L4
L10000:L3:
*line 23
tst R7
bge L10001
clr R0
bra L10003
L10001:move.b (R13),R0
ext.w R0
move.b -(R12),R1
ext.w R1
sub R1,R0
L10003:bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
