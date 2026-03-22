.globl _strncpy
.text
_strncpy:
~~strncpy:
~s1=R13
~s2=R12
~n=R7
link R14,#0
movem.l R6-R7/R11-R13,-(sp)
~os1=R11
*line 16
move.l R13,R11
*line 18
move.l 8(R14),R13
*line 18
move.l 12(R14),R12
*line 18
move 16(R14),R7
*line 18
bra L4
L3:
*line 19
*line 20
move.b (R12)+,(R13)+
bne L5
*line 20
bra L8
L7:
*line 21
clr.b (R13)+
L8:
*line 21
sub #1,R7
bge L7
L6:
*line 22
L5:L4:
*line 23
sub #1,R7
bge L3
L2:
*line 23
move.l R11,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.data
