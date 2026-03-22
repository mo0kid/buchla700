.data
L1:.dc.w $F
.dc.w $FF
.dc.w $FFF
.dc.w $FFFF
.dc.w $F0
.dc.w $FF0
.dc.w $FFF0
.dc.w $F00
.dc.w $FF00
.dc.w $F000
.text
.globl _vbfill4
.text
_vbfill4:
~~vbfill4:
~color=R7
~obj=8
~obwidth=12
~xmin=14
~ymin=16
~xmax=18
~ymax=20
link R14,#-6
movem.l R2-R7/R12-R13,-(sp)
~mw=-2
~nl=-4
~width=-6
~fwp=R13
~wp=R12
~lmask=R6
~rmask=R5
~i=R4
~j=R3
*line 42
move 22(R14),R7
*line 42
move 12(R14),R8
move.l R8,-(sp)
move 16(R14),R8
move.l R8,-(sp)
jsr lmul
addq.l #8,sp
asl.l #1,R0
move.l R0,R13
move 14(R14),R0
asr #2,R0
ext.l R0
asl.l #1,R0
add.l R0,R13
add.l 8(R14),R13
*line 43
move 18(R14),R0
sub 14(R14),R0
add #1,R0
move R0,-6(R14)
*line 44
move 20(R14),R0
sub 16(R14),R0
add #1,R0
move R0,-4(R14)
*line 45
clr R5
move R5,R6
*line 49
move 14(R14),R0
and #3,R0
bra L4
*line 50
L5:
*line 51
*line 52
*line 53
*line 53
cmp #4,-6(R14)
ble L6
*line 54
*line 55
sub #5,-6(R14)
*line 56
move 6+L1,R6
*line 57
move -6(R14),R0
asr #2,R0
move R0,-2(R14)
*line 58
*line 59
*line 59
tst -2(R14)
beq L7
*line 60
*line 61
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 62
*line 63
clr R4
bra L10
L11:
*line 64
*line 65
move.l R13,R12
*line 66
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 67
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 68
*line 69
clr R3
bra L14
L15:
*line 70
move R7,(R12)+
L13:
*line 69
add #1,R3
L14:
*line 69
cmp -2(R14),R3
blt L15
L12:
*line 70
*line 71
*line 72
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L9:
*line 63
add #1,R4
L10:
*line 63
cmp -4(R14),R4
blt L11
L8:
*line 73
*line 74
bra L16
L7:
*line 75
*line 76
*line 77
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 78
*line 79
clr R4
bra L19
L20:
*line 80
*line 81
move.l R13,R12
*line 82
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 83
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 84
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L18:
*line 79
add #1,R4
L19:
*line 79
cmp -4(R14),R4
blt L20
L17:
*line 85
L16:
*line 86
*line 87
bra L21
L6:
*line 88
*line 89
*line 90
move -6(R14),R8
sub #1,R8
add.l R8,R8
add.l #L1,R8
move (R8),R6
*line 91
*line 92
clr R4
bra L24
L25:
*line 93
*line 94
move.l R13,R12
*line 95
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 96
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)
L23:
*line 92
add #1,R4
L24:
*line 92
cmp -4(R14),R4
blt L25
L22:
*line 97
L21:
*line 98
*line 99
bra L2
*line 100
*line 101
*line 102
*line 103
L26:
*line 104
*line 105
*line 106
*line 106
cmp #3,-6(R14)
ble L27
*line 107
*line 108
sub #4,-6(R14)
*line 109
move 12+L1,R6
*line 110
move -6(R14),R0
asr #2,R0
move R0,-2(R14)
*line 111
*line 112
*line 112
tst -2(R14)
beq L28
*line 113
*line 114
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 115
*line 116
clr R4
bra L31
L32:
*line 117
*line 118
move.l R13,R12
*line 119
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 120
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 121
*line 122
clr R3
bra L35
L36:
*line 123
move R7,(R12)+
L34:
*line 122
add #1,R3
L35:
*line 122
cmp -2(R14),R3
blt L36
L33:
*line 123
*line 124
*line 125
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L30:
*line 116
add #1,R4
L31:
*line 116
cmp -4(R14),R4
blt L32
L29:
*line 126
*line 127
bra L37
L28:
*line 128
*line 129
*line 130
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 131
*line 132
clr R4
bra L40
L41:
*line 133
*line 134
move.l R13,R12
*line 135
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 136
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 137
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L39:
*line 132
add #1,R4
L40:
*line 132
cmp -4(R14),R4
blt L41
L38:
*line 138
L37:
*line 139
*line 140
bra L42
L27:
*line 141
*line 142
*line 143
move -6(R14),R8
add #3,R8
add.l R8,R8
add.l #L1,R8
move (R8),R6
*line 144
*line 145
clr R4
bra L45
L46:
*line 146
*line 147
move.l R13,R12
*line 148
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 149
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)
L44:
*line 145
add #1,R4
L45:
*line 145
cmp -4(R14),R4
blt L46
L43:
*line 150
L42:
*line 151
*line 152
bra L2
*line 153
*line 154
*line 155
*line 156
L47:
*line 157
*line 158
*line 159
*line 159
cmp #2,-6(R14)
ble L48
*line 160
*line 161
sub #3,-6(R14)
*line 162
move 16+L1,R6
*line 163
move -6(R14),R0
asr #2,R0
move R0,-2(R14)
*line 164
*line 165
*line 165
tst -2(R14)
beq L49
*line 166
*line 167
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 168
*line 169
clr R4
bra L52
L53:
*line 170
*line 171
move.l R13,R12
*line 172
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 173
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 174
*line 175
clr R3
bra L56
L57:
*line 176
move R7,(R12)+
L55:
*line 175
add #1,R3
L56:
*line 175
cmp -2(R14),R3
blt L57
L54:
*line 176
*line 177
*line 178
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L51:
*line 169
add #1,R4
L52:
*line 169
cmp -4(R14),R4
blt L53
L50:
*line 179
*line 180
bra L58
L49:
*line 181
*line 182
*line 183
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 184
*line 185
clr R4
bra L61
L62:
*line 186
*line 187
move.l R13,R12
*line 188
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 189
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 190
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L60:
*line 185
add #1,R4
L61:
*line 185
cmp -4(R14),R4
blt L62
L59:
*line 191
L58:
*line 192
*line 193
bra L63
L48:
*line 194
*line 195
*line 196
move -6(R14),R8
add #6,R8
add.l R8,R8
add.l #L1,R8
move (R8),R6
*line 197
*line 198
clr R4
bra L66
L67:
*line 199
*line 200
move.l R13,R12
*line 201
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 202
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)
L65:
*line 198
add #1,R4
L66:
*line 198
cmp -4(R14),R4
blt L67
L64:
*line 203
L63:
*line 204
*line 205
bra L2
*line 206
*line 207
*line 208
*line 209
L68:
*line 210
*line 211
*line 212
*line 212
cmp #1,-6(R14)
ble L69
*line 213
*line 214
sub #2,-6(R14)
*line 215
move 18+L1,R6
*line 216
move -6(R14),R0
asr #2,R0
move R0,-2(R14)
*line 217
*line 218
*line 218
tst -2(R14)
beq L70
*line 219
*line 220
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 221
*line 222
clr R4
bra L73
L74:
*line 223
*line 224
move.l R13,R12
*line 225
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 226
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 227
*line 228
clr R3
bra L77
L78:
*line 229
move R7,(R12)+
L76:
*line 228
add #1,R3
L77:
*line 228
cmp -2(R14),R3
blt L78
L75:
*line 229
*line 230
*line 231
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L72:
*line 222
add #1,R4
L73:
*line 222
cmp -4(R14),R4
blt L74
L71:
*line 232
*line 233
bra L79
L70:
*line 234
*line 235
*line 236
move -6(R14),R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #L1,R8
move (R8),R5
*line 237
*line 238
clr R4
bra L82
L83:
*line 239
*line 240
move.l R13,R12
*line 241
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 242
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)+
*line 243
clr R0
move R5,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R5,R1
or R1,R0
move R0,(R12)
L81:
*line 238
add #1,R4
L82:
*line 238
cmp -4(R14),R4
blt L83
L80:
*line 244
L79:
*line 245
*line 246
bra L84
L69:
*line 247
*line 248
*line 249
move 18+L1,R6
*line 250
*line 251
clr R4
bra L87
L88:
*line 252
*line 253
move.l R13,R12
*line 254
move 12(R14),R0
asl #1,R0
ext.l R0
add.l R0,R13
*line 255
clr R0
move R6,R0
not R0
and (R12),R0
clr R1
move R7,R1
and R6,R1
or R1,R0
move R0,(R12)
L86:
*line 251
add #1,R4
L87:
*line 251
cmp -4(R14),R4
blt L88
L85:
*line 256
L84:
*line 257
*line 258
bra L2
*line 259
bra L3
L4:tst R0
beq L5
cmp #1,R0
beq L26
cmp #2,R0
beq L47
cmp #3,R0
beq L68
bra L3
L3:L2:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.data
