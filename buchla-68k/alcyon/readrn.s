.globl _errno
.globl __berrno
.globl _ReadRN
.text
_ReadRN:
~~ReadRN:
~fcp=8
~buf=12
link R14,#-10
~sv=-2
~brc=-6
*line 53
*line 54
move.l 8(R14),(sp)
jsr __seek
move R0,-2(R14)
beq L2
*line 54
*line 54
tst -2(R14)
bge L3
*line 55
*line 56
move #5,_errno
*line 57
move #-1,R0
bra L1
*line 58
bra L4
L3:
*line 59
*line 60
*line 61
move #22,_errno
*line 62
move #1,R0
bra L1
L4:
*line 63
*line 64
*line 69
*line 70
*line 71
L2:
*line 72
*line 72
move.l 8(R14),R8
move.l 44(R8),R0
move R0,(sp)
move.l 12(R14),-(sp)
jsr __secrd
addq.l #4,sp
move.l R0,-6(R14)
beq L5
*line 75
*line 76
*line 77
move.l -6(R14),__berrno
*line 78
move #5,_errno
*line 79
move #-1,R0
bra L1
*line 80
*line 81
L5:
*line 82
clr R0
bra L1
L1:unlk R14
rts
.data
