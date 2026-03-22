.globl _memset
.text
_memset:
~~memset:
~sp=R13
~c=R7
~n=R6
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~sp0=R12
*line 16
move.l R13,R12
*line 18
move.l 8(R14),R13
*line 18
move.b 13(R14),R7
*line 18
move 14(R14),R6
*line 18
bra L4
L3:
*line 19
move.b R7,(R13)+
L4:
*line 19
sub #1,R6
bge L3
L2:
*line 21
move.l R12,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.data
