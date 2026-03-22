.globl _rindex
.text
_rindex:
~~rindex:
~str=R13
~c=13
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~cp=R12
*line 15
move.l 8(R14),R13
*line 15
move.l R13,R12
bra L4
L5:L3:L4:
*line 15
tst.b (R12)+
bne L5
L2:
*line 18
bra L8
L7:
*line 19
*line 20
move.b -(R12),R0
ext.w R0
cmp.b 13(R14),R0
bne L9
*line 20
move.l R12,R0
bra L1
*line 21
L9:L8:
*line 22
cmp.l R13,R12
bhi L7
L6:
*line 22
clr.l R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.data
