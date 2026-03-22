.globl _strncat
.text
_strncat:
~~strncat:
~s1=R13
~s2=R12
~n=R7
link R14,#0
movem.l R6-R7/R11-R13,-(sp)
~os1=R11
*line 19
move.l 8(R14),R13
*line 19
move.l 12(R14),R12
*line 19
move 16(R14),R7
*line 19
move.l R13,R11
*line 21
bra L4
L3:L4:
*line 22
tst.b (R13)+
bne L3
L2:
*line 24
sub.l #1,R13
*line 26
bra L7
L6:
*line 27
*line 27
sub #1,R7
bge L8
*line 28
*line 29
clr.b -(R13)
bra L5
*line 30
*line 31
*line 32
L8:L7:
*line 33
move.b (R12)+,(R13)+
bne L6
L5:
*line 33
move.l R11,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.data
