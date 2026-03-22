.globl _strltrm
.text
_strltrm:
~~strltrm:
~s=R13
link R14,#0
movem.l R6-R7/R11-R13,-(sp)
~c=R7
~lp=R12
~rp=R11
*line 19
move.l 8(R14),R13
*line 19
*line 20
cmp.b #32,(R13)
beq L2
*line 20
move.l R13,R0
bra L1
*line 21
L2:
*line 22
move.l R13,R12
*line 23
move.l R13,R11
*line 25
bra L5
L4:
*line 26
add.l #1,R11
L5:
*line 26
cmp.b #32,(R11)
beq L4
L3:
*line 28
bra L8
L7:
*line 29
move.b R7,(R12)+
L8:
*line 29
move.b (R11)+,R7
bne L7
L6:
*line 31
clr.b (R12)
*line 33
move.l R13,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.data
