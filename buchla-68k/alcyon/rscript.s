.globl _endflg
.globl _script0
.data
_script0:
*line 14
.dc.l L1
.dc.l $0
.globl _rscript
.text
_rscript:
~~rscript:
~p=-4
~p=8
link R14,#-6
~rc=-2
*line 34
jsr _sqinit
*line 35
clr -2(R14)
*line 37
bra L5
L4:
*line 38
*line 39
*line 39
move.l 8(R14),R8
move.l (R8),(sp)
jsr _sqscan
add.l #4,8(R14)
tst R0
bne L6
*line 40
*line 41
move #-1,-2(R14)
bra L3
*line 42
*line 43
*line 44
L6:
*line 45
*line 45
tst _endflg
beq L7
*line 46
*line 47
move #1,-2(R14)
bra L3
*line 48
*line 49
L7:L5:
*line 50
move.l 8(R14),R8
tst.l (R8)
bne L4
L3:
*line 52
move -2(R14),R0
bra L2
L2:unlk R14
rts
.data
L1:.dc.b $21,$71,$75,$69,$65,$74,$20,$21,$6E,$6F,$72,$6D,$61,$6C,$20,$21,$73,$63,$6F,$72,$65,$3D,$30,$20,$21,$77,$65,$69,$67,$68
.dc.b $74,$3D,$36,$30,$20,$21,$65,$6E,$64,$0
