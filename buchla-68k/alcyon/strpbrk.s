.globl _strpbrk
.text
_strpbrk:
~~strpbrk:
~string=R13
~brkset=R12
link R14,#0
movem.l R7-R7/R11-R13,-(sp)
~p=R11
*line 17
move.l 8(R14),R13
*line 17
move.l 12(R14),R12
*line 17
L4:
*line 18
*line 19
move.l R12,R11
bra L7
L8:L6:
*line 19
add.l #1,R11
L7:
*line 19
tst.b (R11)
beq L10000
move.b (R11),R0
ext.w R0
cmp.b (R13),R0
bne L8
L10000:L5:
*line 20
*line 21
*line 22
*line 23
tst.b (R11)
beq L9
*line 23
move.l R13,R0
bra L1
L9:L3:
*line 24
*line 25
*line 26
tst.b (R13)+
bne L4
L2:
*line 29
clr.l R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.data
