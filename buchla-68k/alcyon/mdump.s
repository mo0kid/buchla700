.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl ___atab
.text
_pipc:
~~pipc:
~chars=8
~length=12
link R14,#-6
~i=-2
*line 47
clr -2(R14)
bra L5
L6:
*line 48
*line 49
move.l 8(R14),R8
move -2(R14),R9
add.l R9,R8
btst #7,(R8)
bne L7
move -2(R14),R8
move.l 8(R14),R9
move.b 0(R8,R9.l),R0
ext.w R0
and #255,R0
move R0,R8
move.l #___atab,R9
move.b 0(R8,R9.l),R0
ext.w R0
and #94,R0
beq L7
*line 49
move -2(R14),R8
move.l 8(R14),R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move.l #L8,-(sp)
jsr _printf
addq.l #4,sp
*line 50
bra L9
L7:
*line 51
move.l #L10,(sp)
jsr _printf
L9:L4:
*line 47
add #1,-2(R14)
L5:
*line 47
move -2(R14),R0
cmp 12(R14),R0
blt L6
L3:L2:unlk R14
rts
.globl _mdump
.text
_mdump:
~~mdump:
~begin=8
~end=12
~start=16
link R14,#-36
~i=-4
~ii=-8
~j=-10
~jj=-12
~k=-14
~c=-16
~chars=-32
*line 71
clr.l -4(R14)
*line 72
move.l 16(R14),-8(R14)
*line 73
clr -10(R14)
*line 75
*line 76
move.l 8(R14),R0
cmp.l 12(R14),R0
bhi L11
*line 77
*line 78
bra L14
L13:
*line 79
*line 80
move.l 8(R14),R8
move.b (R8),-16(R14)
add.l #1,8(R14)
*line 81
*line 82
*line 82
move.l #$10,-(sp)
move.l -4(R14),-(sp)
jsr lrem
addq.l #8,sp
tst.l R0
bne L15
*line 83
*line 84
*line 84
tst.l -4(R14)
beq L16
*line 85
*line 86
clr -10(R14)
*line 87
move.l #L17,(sp)
jsr _printf
*line 88
move #16,(sp)
move.l R14,-(sp)
add.l #-32,(sp)
jsr _pipc
addq.l #4,sp
*line 89
*line 90
L16:
*line 91
move.l -8(R14),(sp)
move.l #L18,-(sp)
jsr _printf
addq.l #4,sp
*line 92
*line 93
L15:
*line 94
add.l #$1,-8(R14)
*line 95
add.l #$1,-4(R14)
*line 96
*line 97
move.b -16(R14),R0
ext.w R0
move R0,(sp) 
and #255,(sp)
move.l #L19,-(sp)
jsr _printf
addq.l #4,sp
*line 98
move.l R14,R8
move -10(R14),R9
add.l R9,R8
move.b -16(R14),-32(R8)
add #1,-10(R14)
L14:
*line 99
move.l 8(R14),R0
cmp.l 12(R14),R0
bls L13
L12:
*line 101
*line 101
move.l #$10,-(sp)
move.l -4(R14),-(sp)
jsr lrem
addq.l #8,sp
move R0,-14(R14)
beq L20
*line 102
*line 103
move #16,R0
sub -14(R14),R0
move R0,-14(R14)
*line 104
*line 105
clr -12(R14)
bra L23
L24:
*line 106
move.l #L25,(sp)
jsr _printf
L22:
*line 105
add #1,-12(R14)
L23:
*line 105
move -14(R14),R0
muls #3,R0
cmp -12(R14),R0
bgt L24
L21:
*line 106
*line 107
*line 108
L20:
*line 109
move.l #L26,(sp)
jsr _printf
*line 110
move #16,(sp)
move.l R14,-(sp)
add.l #-32,(sp)
jsr _pipc
addq.l #4,sp
*line 111
move.l #L27,(sp)
jsr _printf
L11:unlk R14
rts
.data
L8:.dc.b $25,$63,$0
L10:.dc.b $2E,$0
L17:.dc.b $20,$20,$0
L18:.dc.b $A,$25,$30,$38,$6C,$58,$3A,$0
L19:.dc.b $20,$25,$30,$32,$2E,$32,$58,$0
L25:.dc.b $20,$0
L26:.dc.b $20,$20,$0
L27:.dc.b $A,$0
