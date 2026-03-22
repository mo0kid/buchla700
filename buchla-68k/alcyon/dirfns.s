.data
L1:.dc.b $41,$44,$56,$53,$48,$52,$0
.even
.text
.globl _atrstr
.text
_atrstr:
~~atrstr:
~atr=R7
~s=-2
~s=10
link R14,#0
movem.l R4-R7,-(sp)
~i=R6
~j=R5
*line 28
move 8(R14),R7
*line 28
move #32,R6
*line 30
clr R5
bra L6
L7:
*line 31
*line 32
*line 33
move R7,R0
and R6,R0
beq L8
*line 33
move R5,R8
add.l 10(R14),R8
move R5,R9
add.l #L1,R9
move.b (R9),(R8)
*line 34
bra L9
L8:
*line 35
move R5,R8
add.l 10(R14),R8
move.b #45,(R8)
L9:
*line 36
*line 37
asr R6
L5:
*line 30
add #1,R5
L6:
*line 30
cmp #6,R5
blt L7
L4:
*line 40
move R5,R8
add.l 10(R14),R8
clr.b (R8)
*line 41
move.l 10(R14),R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L10:
*line 48
.dc.l L11
*line 49
.dc.l L12
*line 50
.dc.l L13
*line 51
.dc.l L14
*line 52
.dc.l L15
*line 53
.dc.l L16
*line 54
.dc.l L17
*line 55
.dc.l L18
*line 56
.dc.l L19
*line 57
.dc.l L20
*line 58
.dc.l L21
*line 59
.dc.l L22
*line 61
.dc.l L23
.text
.globl _mname
.text
_mname:
~~mname:
~n=8
link R14,#-4
*line 73
cmp #1,8(R14)
blt L10001
cmp #12,8(R14)
ble L10000
L10001:move.l L10,R0
bra L10003
L10000:move 8(R14),R8
add.l R8,R8
add.l R8,R8
move.l #L10,R9
move.l 0(R8,R9.l),R0
L10003:bra L24
L24:unlk R14
rts
.globl _dtunpk
.text
_dtunpk:
~~dtunpk:
~din=8
~tin=10
~s=12
~fmt=16
link R14,#0
movem.l R5-R7,-(sp)
~ftm=R7
~fdt=R6
*line 93
move 10(R14),R7
asl #8,R7
and #-256,R7
move 10(R14),R0
asr #8,R0
and #255,R0
or R0,R7
*line 94
move 8(R14),R6
asl #8,R6
and #-256,R6
move 8(R14),R0
asr #8,R0
and #255,R0
or R0,R6
*line 96
move 16(R14),R0
bra L27
*line 97
L28:
*line 98
*line 99
*line 100
*line 101
*line 102
*line 103
*line 104
*line 105
*line 106
move R7,R0
asr #5,R0
move R0,(sp)
and #63,(sp)
move R7,R0
move #11,R1
asr R1,R0
move R0,-(sp)
and #31,(sp)
move R6,-(sp)
and #31,(sp)
move R6,R0
asr #5,R0
move R0,-(sp)
and #15,(sp)
move R6,R0
move #9,R1
asr R1,R0
move R0,-(sp)
and #127,(sp)
add #1980,(sp)
move.l #L29,-(sp)
move.l 12(R14),-(sp)
jsr _sprintf
adda.l #16,sp
*line 107
*line 108
move.l 12(R14),R8
clr.b 16(R8)
bra L26
*line 109
*line 110
L30:
*line 111
L31:
*line 112
*line 113
*line 114
*line 115
*line 116
*line 117
*line 118
*line 119
*line 120
move R7,R0
asr #5,R0
move R0,(sp)
and #63,(sp)
move R7,R0
move #11,R1
asr R1,R0
move R0,-(sp)
and #31,(sp)
move R6,-(sp)
and #31,(sp)
move R6,R0
asr #5,R0
move R0,-(sp)
and #15,(sp)
jsr _mname
addq.l #2,sp
move.l R0,-(sp)
move R6,R0
move #9,R1
asr R1,R0
move R0,-(sp)
and #127,(sp)
add #1980,(sp)
move.l #L32,-(sp)
move.l 12(R14),-(sp)
jsr _sprintf
adda.l #18,sp
*line 121
*line 122
move.l 12(R14),R8
clr.b 17(R8)
bra L26
*line 123
*line 124
*line 125
*line 126
L33:
*line 127
*line 128
*line 129
*line 130
*line 131
*line 132
*line 133
*line 134
*line 135
move R7,R0
asr #5,R0
move R0,(sp)
and #63,(sp)
move R7,R0
move #11,R1
asr R1,R0
move R0,-(sp)
and #31,(sp)
move R6,R0
move #9,R1
asr R1,R0
move R0,-(sp)
and #127,(sp)
add #1980,(sp)
move R6,-(sp)
and #31,(sp)
move R6,R0
asr #5,R0
move R0,-(sp)
and #15,(sp)
jsr _mname
addq.l #2,sp
move.l R0,-(sp)
move.l #L34,-(sp)
move.l 12(R14),-(sp)
jsr _sprintf
adda.l #18,sp
*line 136
*line 137
move.l 12(R14),R8
clr.b 17(R8)
bra L26
*line 138
bra L26
L27:tst R0
beq L28
cmp #1,R0
beq L30
cmp #2,R0
beq L33
bra L31
L26:
*line 141
move.l 12(R14),R0
bra L25
L25:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L11:.dc.b $3F,$3F,$3F,$0
L12:.dc.b $4A,$61,$6E,$0
L13:.dc.b $46,$65,$62,$0
L14:.dc.b $4D,$61,$72,$0
L15:.dc.b $41,$70,$72,$0
L16:.dc.b $4D,$61,$79,$0
L17:.dc.b $4A,$75,$6E,$0
L18:.dc.b $4A,$75,$6C,$0
L19:.dc.b $41,$75,$67,$0
L20:.dc.b $53,$65,$70,$0
L21:.dc.b $4F,$63,$74,$0
L22:.dc.b $4E,$6F,$76,$0
L23:.dc.b $44,$65,$63,$0
L29:.dc.b $25,$30,$34,$64,$2D,$25,$30,$32,$64,$2D,$25,$30,$32,$64,$20,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$0
L32:.dc.b $25,$30,$34,$64,$20,$25,$73,$20,$25,$2D,$32,$64,$20,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$0
L34:.dc.b $25,$73,$20,$25,$32,$64,$20,$25,$30,$34,$64,$20,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$0
