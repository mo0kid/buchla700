.globl _strlen
.text
_strlen:
~~strlen:
~s=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~n=R7
*line 15
clr R7
*line 17
move.l 8(R14),R13
*line 17
bra L4
L3:
*line 18
add #1,R7
L4:
*line 18
tst.b (R13)+
bne L3
L2:
*line 20
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
