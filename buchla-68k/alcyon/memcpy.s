.globl _memcpy
.text
_memcpy:
~~memcpy:
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
move.b (R12)+,(R13)+
L4:
*line 19
sub #1,R7
bge L3
L2:
*line 20
move.l R11,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.data
