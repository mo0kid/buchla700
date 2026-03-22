.globl _vwputm
.text
_vwputm:
~~vwputm:
~ml=-4
~obase=8
~nw=12
~fg=14
~bg=16
~row=18
~col=20
~ml=22
link R14,#-4
*line 33
bra L4
L3:
*line 34
*line 35
move.l 22(R14),R8
move.l (R8),(sp)
move 20(R14),-(sp)
move 18(R14),-(sp)
move 16(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _vwputs
adda.l #14,sp
add.l #4,22(R14)
add #1,18(R14)
L4:
*line 36
move.l 22(R14),R8
tst.l (R8)
bne L3
L2:L1:unlk R14
rts
.data
