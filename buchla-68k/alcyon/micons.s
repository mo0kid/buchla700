.globl _micons
.text
_micons:
~~micons:
~wi=8
link R14,#-4
*line 40
move 8(R14),R0
asl #8,R0
and #-256,R0
move 8(R14),R1
asr #8,R1
and #255,R1
or R1,R0
bra L1
L1:unlk R14
rts
.globl _miconi
.text
_miconi:
~~miconi:
~wi=8
link R14,#-4
*line 53
*line 54
bra L3
*line 55
move 8(R14),R0
move #24,R1
asl R1,R0
clr R0
move 8(R14),R1
asl #8,R1
clr R1
or R1,R0
move 8(R14),R1
asr #8,R1
and #-256,R1
or R1,R0
move 8(R14),R1
move #24,R2
asr R2,R1
and #255,R1
or R1,R0
bra L2
*line 56
bra L4
L3:
*line 57
move 8(R14),R0
asl #8,R0
and #-256,R0
move 8(R14),R1
asr #8,R1
and #255,R1
or R1,R0
bra L2
L4:L2:unlk R14
rts
.globl _miconl
.text
_miconl:
~~miconl:
~wi=8
link R14,#-4
*line 70
*line 71
move.l 8(R14),R0
move.l #$18,R1
asl.l R1,R0
and.l #$ff000000,R0
move.l 8(R14),R1
asl.l #$8,R1
and.l #$ff0000,R1
or.l R1,R0
move.l 8(R14),R1
asr.l #$8,R1
and.l #$ff00,R1
or.l R1,R0
move.l 8(R14),R1
move.l #$18,R2
asr.l R2,R1
and.l #$ff,R1
or.l R1,R0
bra L5
L5:unlk R14
rts
.data
