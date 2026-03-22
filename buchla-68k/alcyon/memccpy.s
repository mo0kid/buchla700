.globl _memccpy
.text
_memccpy:
~~memccpy:
~s1=R13
~s2=R12
~c=R7
~n=R6
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
*line 19
move.l 8(R14),R13
*line 19
move.l 12(R14),R12
*line 19
move.b 17(R14),R7
*line 19
move 18(R14),R6
*line 19
bra L4
L3:
*line 20
*line 21
move.b R7,R0
ext.w R0
move.b (R12)+,R1
ext.w R1
move.b R1,(R13)+
cmp R1,R0
bne L5
*line 21
move.l R13,R0
bra L1
L5:L4:
*line 22
sub #1,R6
bge L3
L2:
*line 22
clr.l R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.data
