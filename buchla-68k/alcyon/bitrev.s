.data
L1:.dc.w $1
.dc.w $2
.dc.w $4
.dc.w $8
.dc.w $10
.dc.w $20
.dc.w $40
.dc.w $80
.dc.w $100
.dc.w $200
.dc.w $400
.dc.w $800
.dc.w $1000
.dc.w $2000
.dc.w $4000
.dc.w $8000
.text
.globl _bitrev
.text
_bitrev:
~~bitrev:
~bitsin=8
~nbits=10
link R14,#-8
~m=-2
~n=-4
*line 30
clr -4(R14)
*line 32
clr -2(R14)
bra L5
L6:
*line 33
*line 34
move -2(R14),R8
add.l R8,R8
move.l #L1,R9
move 0(R8,R9.l),R0
and 8(R14),R0
beq L7
*line 34
move 10(R14),R8
sub #1,R8
sub -2(R14),R8
add.l R8,R8
add.l #L1,R8
move (R8),R0
or R0,-4(R14)
*line 35
L7:L4:
*line 32
add #1,-2(R14)
L5:
*line 32
move -2(R14),R0
cmp 10(R14),R0
blt L6
L3:
*line 36
move -4(R14),R0
bra L2
L2:unlk R14
rts
.data
