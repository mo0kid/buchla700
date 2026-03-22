.globl ___atab
.globl _toupper
.text
_toupper:
~~toupper:
~c=8
link R14,#-6
~x=-2
*line 22
*line 22
move 8(R14),R0
and #-128,R0
bne L2
*line 23
*line 24
*line 25
move.l #___atab,R8
move 8(R14),R9
add.l R9,R8
btst #4,(R8)
beq L3
*line 25
move 8(R14),R0
add #-32,R0
move R0,-2(R14)
*line 26
bra L4
L3:
*line 27
move 8(R14),-2(R14)
L4:bra L5
L2:
*line 28
*line 29
*line 30
move 8(R14),-2(R14)
L5:
*line 33
move -2(R14),R0
bra L1
L1:unlk R14
rts
.data
