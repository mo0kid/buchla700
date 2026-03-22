.globl _vclrs
.text
_vclrs:
~~vclrs:
~obase=-2
~nc=R7
~obase=8
~row=12
~col=14
~ch=18
~atr=20
link R14,#0
movem.l R6-R7,-(sp)
*line 32
move 16(R14),R7
*line 32
bra L4
L3:
*line 33
move 20(R14),(sp)
move 18(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _vputc
adda.l #10,sp
add #1,14(R14)
L4:
*line 33
move R7,R0
sub #1,R7
tst R0
bne L3
L2:L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
