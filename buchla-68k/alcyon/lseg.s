.globl _point
.comm _point,4
.globl _lseg
.text
_lseg:
~~lseg:
~x1=8
~y1=10
~x2=12
~y2=14
~t=16
link R14,#-6
movem.l R2-R7,-(sp)
~dx=R7
~dy=R6
~ptx=R5
~pty=R4
~p=R3
~i=-2
~px=-4
~py=-6
*line 48
move 8(R14),R5
move 12(R14),R3
sub R5,R3
*line 49
tst R3
bge L10000
move #-1,R0
bra L10002
L10000:tst R3
beq L10003
move #1,R0
bra L10005
L10003:clr R0
L10005:L10002:move R0,R7
*line 50
tst R3
bge L10006
move R3,R0
neg R0
bra L10008
L10006:move R3,R0
L10008:move R0,-6(R14)
*line 52
move 10(R14),R4
move 14(R14),R3
sub R4,R3
*line 53
tst R3
bge L10009
move #-1,R0
bra L10011
L10009:tst R3
beq L10012
move #1,R0
bra L10014
L10012:clr R0
L10014:L10011:move R0,R6
*line 54
tst R3
bge L10015
move R3,R0
neg R0
bra L10017
L10015:move R3,R0
L10017:move R0,-4(R14)
*line 56
move 16(R14),-(sp)
move R4,-(sp)
move R5,-(sp)
move.l _point,R8
jsr (R8)
addq.l #6,sp
*line 58
*line 58
move -6(R14),R0
cmp -4(R14),R0
ble L2
*line 59
*line 60
move -6(R14),R3
asr R3
*line 61
*line 62
move #1,-2(R14)
bra L5
L6:
*line 63
*line 64
add R7,R5
*line 65
*line 66
*line 66
sub -4(R14),R3
bge L7
*line 67
*line 68
add R6,R4
*line 69
add -6(R14),R3
*line 70
*line 71
L7:
*line 72
move 16(R14),-(sp)
move R4,-(sp)
move R5,-(sp)
move.l _point,R8
jsr (R8)
addq.l #6,sp
L4:
*line 62
add #1,-2(R14)
L5:
*line 62
move -2(R14),R0
cmp -6(R14),R0
blt L6
L3:
*line 73
*line 74
bra L8
L2:
*line 75
*line 76
*line 77
move -4(R14),R3
asr R3
*line 78
*line 79
move #1,-2(R14)
bra L11
L12:
*line 80
*line 81
add R6,R4
*line 82
*line 83
*line 83
sub -6(R14),R3
bge L13
*line 84
*line 85
add R7,R5
*line 86
add -4(R14),R3
*line 87
*line 88
L13:
*line 89
move 16(R14),-(sp)
move R4,-(sp)
move R5,-(sp)
move.l _point,R8
jsr (R8)
addq.l #6,sp
L10:
*line 79
add #1,-2(R14)
L11:
*line 79
move -2(R14),R0
cmp -4(R14),R0
ble L12
L9:
*line 90
L8:L1:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.data
