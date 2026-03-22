.globl _strcspn
.text
_strcspn:
~~strcspn:
~charset=R13
~string=8
link R14,#0
movem.l R6-R7/R11-R13,-(sp)
~p=R12
~q=R11
~n=R7
*line 17
clr R7
*line 19
move.l 12(R14),R13
*line 19
move.l 8(R14),R11
bra L4
L5:
*line 20
*line 21
move.l R13,R12
bra L8
L9:L7:
*line 21
add.l #1,R12
L8:
*line 21
tst.b (R12)
beq L10000
move.b (R12),R0
ext.w R0
cmp.b (R11),R0
bne L9
L10000:L6:
*line 22
*line 23
*line 24
*line 25
tst.b (R12)
bne L2
L3:
*line 19
add.l #1,R11
add #1,R7
L4:
*line 19
tst.b (R11)
bne L5
L2:
*line 28
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.data
