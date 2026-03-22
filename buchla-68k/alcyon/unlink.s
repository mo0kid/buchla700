.globl _unlink
.text
_unlink:
~~unlink:
~name=8
link R14,#-60
~delfcb=-56
*line 33
*line 34
move.l R14,(sp)
add.l #-56,(sp)
move.l 8(R14),-(sp)
jsr _fcbinit
addq.l #4,sp
tst R0
beq L2
*line 34
move #-1,R0
bra L1
*line 35
*line 43
L2:
*line 44
move.l R14,(sp)
add.l #-56,(sp)
jsr _DelFile
bra L1
L1:unlk R14
rts
.data
