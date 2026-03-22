.globl _strlcmp
.text
_strlcmp:
~~strlcmp:
~s=8
~l=12
link R14,#-6
~rc=-2
*line 23
clr -2(R14)
*line 25
bra L4
L3:
*line 26
*line 27
*line 28
move.l 12(R14),R8
move -2(R14),R9
add.l R9,R9
add.l R9,R9
move.l 0(R8,R9.l),(sp)
move.l 8(R14),-(sp)
jsr _strcmp
addq.l #4,sp
tst R0
bne L5
*line 28
add #1,-2(R14)
move -2(R14),R0
bra L1
*line 29
L5:
*line 30
add #1,-2(R14)
L4:
*line 31
move.l 12(R14),R8
move -2(R14),R9
add.l R9,R9
add.l R9,R9
tst.l 0(R8,R9.l)
bne L3
L2:
*line 33
clr R0
bra L1
L1:unlk R14
rts
.data
