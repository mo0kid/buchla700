.data
L1:.dc.l $0
.dc.l $19A0
.dc.l $3336
.dc.l $4CD0
.dc.l $6668
.dc.l $8000
.dc.l $99A0
.dc.l $B336
.dc.l $CCCE
.dc.l $E668
.dc.l $0
.dc.l $290
.dc.l $520
.dc.l $7B0
.dc.l $A40
.dc.l $CD0
.dc.l $F60
.dc.l $11F0
.dc.l $1480
.dc.l $1710
.text
.data
L2:.dc.l $C350
.dc.l $61A8
.dc.l $30D4
.dc.l $186A
.dc.l $C35
.dc.l $61A
.dc.l $30D
.dc.l $186
.dc.l $C3
.dc.l $61
.dc.l $30
.dc.l $18
.dc.l $C
.dc.l $6
.dc.l $3
.dc.l $1
.text
.globl _dec2fr
.text
_dec2fr:
~~dec2fr:
~s=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~i=R7
*line 49
move.l 8(R14),R13
*line 49
*line 49
cmp.b #49,(R13)
bne L4
*line 50
*line 51
*line 51
cmp.b #48,1(R13)
bne L5
*line 52
*line 53
*line 53
cmp.b #48,2(R13)
bne L6
*line 54
*line 55
*line 56
cmp.b #45,3(R13)
bne L7
*line 56
move #-32768,R0
bra L3
*line 57
bra L8
L7:
*line 58
move #32767,R0
bra L3
L8:
*line 59
bra L9
L6:
*line 60
*line 61
*line 62
move #-1,R0
bra L3
L9:
*line 63
*line 64
bra L10
L5:
*line 65
*line 66
*line 67
move #-1,R0
bra L3
*line 68
L10:
*line 69
*line 70
*line 71
*line 72
*line 73
bra L11
L4:
*line 74
*line 74
cmp.b #48,(R13)
bne L12
*line 75
*line 76
move.b 1(R13),R0
ext.w R0
add #-48,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #L1,R9
move.l 0(R8,R9.l),R0
move.b 2(R13),R1
ext.w R1
add #-48,R1
move R1,R9
add.l R9,R9
add.l R9,R9
add.l #L1,R9
move.l 40(R9),R1
add.l R1,R0
asr.l #$1,R0
move R0,R7
*line 77
*line 78
*line 78
cmp.b #45,3(R13)
bne L13
*line 79
*line 80
*line 81
tst R7
beq L14
*line 81
move R7,R0
not R0
bra L3
*line 82
bra L15
L14:
*line 83
clr R0
bra L3
L15:
*line 84
bra L16
L13:
*line 85
*line 86
*line 87
move R7,R0
bra L3
L16:
*line 88
*line 89
*line 90
L12:L11:
*line 91
move #-1,R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _fr2dec
.text
_fr2dec:
~~fr2dec:
~v=R7
~s=R13
link R14,#0
movem.l R2-R7/R13-R13,-(sp)
~acc=R6
~sc=R5
~i=R4
~p=R3
*line 114
move 8(R14),R7
*line 114
move.l 10(R14),R13
*line 114
*line 114
cmp #32767,R7
bne L18
*line 115
*line 116
move.l #L19,(sp)
move.l R13,-(sp)
jsr _sprintf
addq.l #4,sp
*line 117
move.l R13,R0
bra L17
*line 118
*line 119
L18:
*line 120
*line 120
cmp #-32768,R7
bne L20
*line 121
*line 122
move.l #L21,(sp)
move.l R13,-(sp)
jsr _sprintf
addq.l #4,sp
*line 123
move.l R13,R0
bra L17
*line 124
*line 125
L20:
*line 126
*line 126
move R7,R0
and #-32768,R0
beq L22
*line 127
*line 128
move R7,R0
not R0
move R0,R7
*line 129
move #45,R3
*line 130
bra L23
L22:
*line 131
*line 132
*line 133
move #43,R3
L23:
*line 136
clr.l R6
*line 138
clr R4
bra L26
L27:
*line 139
*line 140
move R7,R0
move #1,R1
move #14,R2
sub R4,R2
asl R2,R1
and R1,R0
beq L28
*line 140
move R4,R8
add.l R8,R8
add.l R8,R8
add.l #L2,R8
move.l (R8),R0
add.l R0,R6
*line 141
L28:L25:
*line 138
add #1,R4
L26:
*line 138
cmp #15,R4
blt L27
L24:
*line 142
move.l #$3e8,R5
*line 143
move.l R5,-(sp)
move.l R6,-(sp)
jsr ldiv
addq.l #8,sp
move.l R0,R6
*line 144
move R3,(sp)
move.l R6,R0
move R0,-(sp)
move.l #L29,-(sp)
move.l R13,-(sp)
jsr _sprintf
adda.l #10,sp
*line 145
move.l R13,R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R3-R7/R13-R13
unlk R14
rts
.data
L19:.dc.b $31,$30,$30,$2B,$0
L21:.dc.b $31,$30,$30,$2D,$0
L29:.dc.b $25,$30,$33,$64,$25,$63,$0
