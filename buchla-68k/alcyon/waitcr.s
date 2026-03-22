.globl _waitcr
.text
_waitcr:
~~waitcr:
link R14,#-6
~c=-2
*line 28
move #7,(sp)
move #2,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 32
bra L4
L3:
*line 33
*line 34
cmp #7,-2(R14)
bne L5
*line 34
jsr _xtrap15
*line 35
L5:L4:
*line 36
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and #127,R0
move R0,-2(R14)
cmp #13,R0
bne L3
L2:
*line 36
move -2(R14),R0
bra L1
L1:unlk R14
rts
.data
