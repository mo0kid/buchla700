.globl _strccpy
.text
_strccpy:
~~strccpy:
~s1=R13
~s2=R12
~c=R7
link R14,#0
movem.l R5-R7/R11-R13,-(sp)
~os1=R11
~x=R6
*line 25
move.l 8(R14),R13
*line 25
move.l 12(R14),R12
*line 25
move.b 17(R14),R7
*line 25
move.l R13,R11
*line 27
bra L4
L3:
*line 28
move.b R6,(R12)+
L4:
*line 28
move.b R7,R0
ext.w R0
move.b (R13)+,R1
ext.w R1
move.b R1,R6
cmp R1,R0
bne L3
L2:
*line 30
move.l R11,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R11-R13
unlk R14
rts
.data
