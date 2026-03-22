.globl _memcmp
.text
_memcmp:
~~memcmp:
~s1=R13
~s2=R12
~n=R7
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~diff=R6
*line 17
move.l 8(R14),R13
*line 17
move.l 12(R14),R12
*line 17
move 16(R14),R7
*line 17
*line 18
cmp.l R12,R13
beq L2
*line 18
bra L5
L4:
*line 19
*line 20
move.b (R13)+,R6
ext.w R6
move.b (R12)+,R0
ext.w R0
sub R0,R6
beq L6
*line 20
move R6,R0
bra L1
L6:L5:
*line 21
sub #1,R7
bge L4
L3:L2:
*line 21
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.data
