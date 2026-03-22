.globl _strchr
.text
_strchr:
~~strchr:
~sp=R13
~c=R7
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
*line 16
move.l 8(R14),R13
*line 16
move.b 13(R14),R7
*line 16
L4:
*line 17
*line 18
cmp.b (R13),R7
bne L5
*line 18
move.l R13,R0
bra L1
L5:L3:
*line 19
tst.b (R13)+
bne L4
L2:
*line 21
clr.l R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
