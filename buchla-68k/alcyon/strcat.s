.globl _strcat
.text
_strcat:
~~strcat:
~s1=R13
~s2=R12
link R14,#0
movem.l R7-R7/R11-R13,-(sp)
~os1=R11
*line 17
move.l 8(R14),R13
*line 17
move.l 12(R14),R12
*line 17
move.l R13,R11
*line 19
bra L4
L3:L4:
*line 20
tst.b (R13)+
bne L3
L2:
*line 22
sub.l #1,R13
*line 24
bra L7
L6:L7:
*line 25
move.b (R12)+,(R13)+
bne L6
L5:
*line 27
move.l R11,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.data
