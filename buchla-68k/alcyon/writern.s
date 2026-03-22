.globl _errno
.globl __berrno
.globl _WriteRN
.text
_WriteRN:
~~WriteRN:
~fcp=8
~buf=12
link R14,#-10
~sv=-2
~brc=-6
*line 53
*line 53
move.l 8(R14),(sp)
jsr __seek
move R0,-2(R14)
beq L2
*line 54
*line 55
*line 55
tst -2(R14)
bge L3
*line 56
*line 61
*line 62
*line 63
move #5,_errno
*line 64
move #-1,R0
bra L1
*line 65
bra L4
L3:
*line 66
*line 66
cmp #2,-2(R14)
bne L5
*line 67
*line 68
*line 68
move.l 8(R14),(sp)
jsr __alcnew
tst R0
beq L6
*line 69
*line 70
move #5,_errno
*line 71
move #-1,R0
bra L1
*line 72
*line 77
*line 78
L6:
*line 79
L5:L4:
*line 80
*line 81
*line 86
*line 87
*line 88
*line 89
L2:
*line 90
*line 90
clr (sp)
move.l 8(R14),R8
move.l 44(R8),R0
move R0,-(sp)
move #1,-(sp)
move.l 12(R14),-(sp)
move #1,-(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
move.l R0,-6(R14)
beq L7
*line 91
*line 95
*line 96
*line 97
move.l -6(R14),__berrno
*line 98
move #5,_errno
*line 99
move #-1,R0
bra L1
*line 100
*line 101
*line 102
L7:
*line 103
move.l 8(R14),R8
move.l 44(R8),R0
move R0,(sp)
move.l 12(R14),-(sp)
jsr __secwr
addq.l #4,sp
*line 106
clr R0
bra L1
L1:unlk R14
rts
.data
