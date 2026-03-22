.globl _strfill
.text
_strfill:
~~strfill:
~s=R13
~c=R7
~n=R6
link R14,#-4
movem.l R4-R7/R13-R13,-(sp)
~i=R5
~p=-4
*line 24
move.l 8(R14),R13
*line 24
move.b 13(R14),R7
*line 24
move 14(R14),R6
*line 24
move.l R13,-4(R14)
*line 26
move R6,R5
bra L4
L5:
*line 27
move.b R7,(R13)+
L3:L4:
*line 26
clr R0
move R5,R0
sub #1,R5
tst R0
bne L5
L2:
*line 29
clr.b (R13)
*line 30
move.l -4(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.data
