.globl _strcmp
.text
_strcmp:
~~strcmp:
~s1=R13
~s2=R12
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
*line 14
move.l 8(R14),R13
*line 14
move.l 12(R14),R12
*line 14
*line 15
cmp.l R12,R13
bne L2
*line 15
clr R0
bra L1
*line 16
L2:
*line 17
bra L5
L4:
*line 18
*line 19
tst.b (R13)+
bne L6
*line 19
clr R0
bra L1
*line 20
L6:L5:
*line 21
move.b (R13),R0
ext.w R0
cmp.b (R12)+,R0
beq L4
L3:
*line 21
move.b (R13),R0
ext.w R0
move.b -(R12),R1
ext.w R1
sub R1,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.data
