.globl _strrchr
.text
_strrchr:
~~strrchr:
~sp=R13
~c=R7
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~r=R12
*line 19
move.l 8(R14),R13
*line 19
move.b 13(R14),R7
*line 19
clr.l R12
*line 21
L4:
*line 22
*line 23
*line 24
cmp.b (R13),R7
bne L5
*line 24
move.l R13,R12
*line 25
L5:L3:
*line 26
tst.b (R13)+
bne L4
L2:
*line 28
move.l R12,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
