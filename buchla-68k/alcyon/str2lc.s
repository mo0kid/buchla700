.globl _str2lc
.text
_str2lc:
~~str2lc:
~s=R13
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~c=R7
~r=R12
*line 13
move.l R13,R12
*line 15
move.l 8(R14),R13
*line 15
bra L4
L3:
*line 16
move.b R7,R0
ext.w R0
move R0,(sp) 
jsr _tolower
move.b R0,(R13)+
L4:
*line 16
move.b (R13),R7
bne L3
L2:
*line 18
move.l R12,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
