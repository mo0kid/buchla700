.globl _memchr
.text
_memchr:
~~memchr:
~sp=R13
~c=R7
~n=R6
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
*line 16
move.l 8(R14),R13
*line 16
move.b 13(R14),R7
*line 16
move 14(R14),R6
*line 16
bra L4
L3:
*line 17
*line 18
cmp.b (R13)+,R7
bne L5
*line 18
sub.l #1,R13
move.l R13,R0
bra L1
L5:L4:
*line 19
sub #1,R6
bge L3
L2:
*line 19
clr.l R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.data
