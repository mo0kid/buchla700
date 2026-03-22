.globl ___atab
.globl _uldivr
.globl _dofmt_
.text
_dofmt_:
~~dofmt_:
~putsub=R13
~format=R12
~args=16
link R14,#-64
movem.l R6-R7/R11-R13,-(sp)
~fcode=R7
~k=-4
~n=-8
~lzero=-12
~count=-16
~hradix=-18
~lowbit=-20
~length=-22
~fplus=-24
~fminus=-26
~fblank=-28
~fsharp=-30
~flzero=-32
~width=-34
~prec=-36
~bp=R11
~p=-40
~prefix=-44
~tab=-48
~buf=-60
~val=-64
*line 78
move.l 8(R14),R13
*line 78
move.l 12(R14),R12
*line 78
clr.l -16(R14)
L4:
*line 80
*line 81
*line 82
move.l R12,R11
bra L7
L8:
*line 83
*line 84
L6:
*line 83
add.l #1,R12
L7:
*line 83
move.b (R12),R7
ext.w R7
tst R7
beq L10000
cmp #37,R7
bne L8
L10000:L5:
*line 85
*line 86
*line 87
*line 87
move.l R12,R0
sub.l R11,R0
move.l R0,-8(R14)
beq L9
*line 88
*line 89
move.l -8(R14),R0
add.l R0,-16(R14)
*line 90
*line 91
bra L12
L11:
*line 92
move.b (R11)+,R0
ext.w R0
move R0,(sp) 
jsr (R13)
L12:
*line 92
move.l -8(R14),R0
sub.l #$1,-8(R14)
tst.l R0
bne L11
L10:
*line 93
*line 94
L9:
*line 95
*line 96
tst R7
bne L13
*line 96
move.l -16(R14),R0
bra L1
*line 97
L13:
*line 98
clr R0
move R0,-32(R14)
move R0,-30(R14)
move R0,-28(R14)
move R0,-26(R14)
move R0,-24(R14)
*line 99
L16:
*line 100
*line 101
*line 102
add.l #1,R12
move.b (R12),R7
ext.w R7
move R7,R0
bra L18
*line 103
L19:
*line 104
*line 105
add #1,-24(R14)
bra L15
*line 106
*line 107
L20:
*line 108
*line 109
add #1,-26(R14)
bra L15
*line 110
*line 111
L21:
*line 112
*line 113
add #1,-28(R14)
bra L15
*line 114
*line 115
L22:
*line 116
*line 117
add #1,-30(R14)
bra L15
*line 118
bra L17
L18:cmp #32,R0
beq L21
cmp #35,R0
beq L22
cmp #43,R0
beq L19
cmp #45,R0
beq L20
bra L17
L17:
*line 119
*line 120
bra L14
*line 121
L15:bra L16
L14:
*line 122
*line 123
*line 124
*line 125
*line 126
*line 127
*line 127
cmp #42,R7
bne L23
*line 128
*line 129
add.l #2,16(R14)
move.l 16(R14),R8
move -2(R8),-34(R14)
*line 130
*line 131
*line 131
tst -34(R14)
bge L24
*line 132
*line 133
move -34(R14),R0
neg R0
move R0,-34(R14)
*line 134
add #1,-26(R14)
*line 135
*line 136
L24:
*line 137
add.l #1,R12
*line 138
bra L25
L23:
*line 139
*line 140
*line 141
*line 142
cmp #48,R7
bne L26
*line 142
add #1,-32(R14)
*line 143
L26:
*line 144
clr -34(R14)
bra L29
L30:
*line 145
move R7,R0
move -34(R14),R1
muls #10,R1
add R1,R0
add #-48,R0
move R0,-34(R14)
L28:
*line 144
add.l #1,R12
L29:
*line 144
move.b (R12),R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #2,(R8)
bne L30
L27:
*line 145
L25:
*line 146
*line 147
*line 148
*line 149
cmp.b #46,(R12)
beq L31
*line 149
move #-1,-36(R14)
bra L32
L31:
*line 150
*line 150
add.l #1,R12
move.l R12,R8
cmp.b #42,(R8)
bne L33
*line 151
*line 152
add.l #2,16(R14)
move.l 16(R14),R8
move -2(R8),-36(R14)
*line 153
add.l #1,R12
*line 154
bra L34
L33:
*line 155
clr -36(R14)
bra L37
L38:
*line 156
move R7,R0
move -36(R14),R1
muls #10,R1
add R1,R0
add #-48,R0
move R0,-36(R14)
L36:
*line 155
add.l #1,R12
L37:
*line 155
move.b (R12),R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #2,(R8)
bne L38
L35:L34:L32:
*line 156
*line 157
*line 158
clr -22(R14)
*line 159
*line 160
*line 160
cmp.b #108,(R12)
bne L39
*line 161
*line 162
add #1,-22(R14)
*line 163
add.l #1,R12
*line 164
*line 165
L39:
*line 166
move.l #L40,-44(R14)
*line 167
clr.l -12(R14)
*line 168
*line 169
*line 170
*line 171
move.b (R12)+,R7
ext.w R7
move R7,R0
bra L42
*line 172
L43:
*line 173
L44:
*line 174
*line 175
move #5,-18(R14)
bra L45
*line 176
*line 177
L46:
*line 178
*line 179
move #4,-18(R14)
bra L45
*line 180
*line 181
L47:
*line 182
L48:
*line 183
*line 184
move #8,-18(R14)
*line 185
L45:
*line 186
*line 187
*line 188
*line 189
tst -36(R14)
bge L49
*line 189
*line 190
tst -32(R14)
beq L50
tst -34(R14)
ble L50
*line 190
move -34(R14),-36(R14)
*line 191
bra L51
L50:
*line 192
move #1,-36(R14)
L51:
*line 193
L49:
*line 194
*line 195
tst -22(R14)
beq L52
*line 195
add.l #4,16(R14)
move.l 16(R14),R8
move.l -4(R8),-64(R14)
bra L53
L52:
*line 196
*line 197
cmp #100,R7
bne L54
*line 197
add.l #2,16(R14)
move.l 16(R14),R8
move -2(R8),R0
ext.l R0
move.l R0,-64(R14)
*line 198
bra L55
L54:
*line 199
add.l #2,16(R14)
move.l 16(R14),R8
clr R0
move -2(R8),R0
swap R0
clr R0
swap R0
move.l R0,-64(R14)
L55:L53:
*line 200
*line 201
*line 201
cmp #100,R7
bne L56
*line 202
*line 203
*line 203
tst.l -64(R14)
bge L57
*line 204
*line 205
move.l #L58,-44(R14)
*line 206
*line 207
*line 208
move.l -64(R14),R0
cmp.l #$80000000,R0
beq L59
*line 208
move.l -64(R14),R0
neg.l R0
move.l R0,-64(R14)
*line 209
L59:bra L60
L57:
*line 210
*line 211
tst -24(R14)
beq L61
*line 211
move.l #L62,-44(R14)
bra L63
L61:
*line 212
*line 213
tst -28(R14)
beq L64
*line 213
move.l #L65,-44(R14)
L64:L63:L60:
*line 214
*line 215
L56:
*line 216
*line 217
cmp #88,R7
bne L10001
move.l #L66,R0
bra L10003
L10001:move.l #L67,R0
L10003:move.l R0,-48(R14)
*line 218
*line 219
lea -49(R14),R11
move.l R11,R0
move.l R0,-40(R14)
*line 220
*line 221
*line 222
*line 223
move -18(R14),R0
bra L69
*line 224
L70:
*line 225
*line 226
*line 227
bra L73
L72:
*line 228
*line 229
move.l -64(R14),R0
and.l #$7,R0
add.l -48(R14),R0
move.l R0,R8
move.b (R8),-(R11)
*line 230
move.l -64(R14),R0
asr.l #$3,R0
and.l #$1fffffff,R0
move.l R0,-64(R14)
L73:
*line 231
tst.l -64(R14)
bne L72
L71:
*line 232
bra L68
*line 233
*line 234
L74:
*line 235
*line 236
*line 237
bra L77
L76:
*line 238
*line 239
*line 240
*line 241
*line 242
*line 243
move.l #$a,(sp)
move.l -64(R14),-(sp)
jsr _uldiv
addq.l #4,sp
move.l R0,-64(R14)
*line 244
move.l -48(R14),R8
add.l _uldivr,R8
move.b (R8),-(R11)
*line 252
L77:
*line 253
tst.l -64(R14)
bne L76
L75:
*line 254
bra L68
*line 255
*line 256
L78:
*line 257
*line 258
*line 259
bra L81
L80:
*line 260
*line 261
move.l -64(R14),R0
and.l #$f,R0
add.l -48(R14),R0
move.l R0,R8
move.b (R8),-(R11)
*line 262
move.l -64(R14),R0
asr.l #$4,R0
and.l #$fffffff,R0
move.l R0,-64(R14)
L81:
*line 263
tst.l -64(R14)
bne L80
L79:bra L68
L69:cmp #4,R0
beq L70
cmp #5,R0
beq L74
cmp #8,R0
beq L78
bra L68
L68:
*line 264
*line 265
*line 266
move.l R11,R0
sub.l -40(R14),R0
move -36(R14),R1
ext.l R1
add.l R1,R0
move.l R0,-12(R14)
*line 267
*line 268
*line 269
tst -30(R14)
beq L82
cmp.l -40(R14),R11
beq L82
*line 269
move R7,R0
bra L84
*line 270
L85:
*line 271
*line 272
*line 273
cmp.l #$1,-12(R14)
bge L86
*line 273
move.l #$1,-12(R14)
L86:bra L83
*line 274
*line 275
L87:
*line 276
L88:
*line 277
*line 278
move.l #L89,-44(R14)
bra L83
*line 279
bra L83
L84:cmp #88,R0
beq L88
cmp #111,R0
beq L85
cmp #120,R0
beq L87
bra L83
L83:
*line 280
*line 281
L82:bra L41
*line 282
*line 283
*line 284
*line 285
L90:
*line 286
*line 287
move.b R7,-60(R14)
bra L91
*line 288
*line 289
L92:
*line 290
*line 291
add.l #2,16(R14)
move.l 16(R14),R8
move -2(R8),R0
move.b R0,-60(R14)
*line 292
L91:
*line 293
*line 294
*line 295
lea -60(R14),R11
move.l R11,R0
add.l #1,R0
move.l R0,-40(R14)
bra L41
*line 296
*line 297
L93:
*line 298
*line 299
add.l #4,16(R14)
move.l 16(R14),R8
move.l -4(R8),R11
move.l R11,-40(R14)
*line 300
*line 301
*line 302
tst -36(R14)
bge L94
*line 302
move.l R11,(sp)
jsr _strlen
ext.l R0
add.l R0,-40(R14)
bra L95
L94:
*line 303
*line 304
bra L98
L97:L98:
*line 305
move.l -40(R14),R8
move.b (R8),R0
ext.w R0
add.l #1,-40(R14)
tst.b R0
beq L10004
sub #1,-36(R14)
bge L97
L10004:L96:
*line 306
sub.l #1,-40(R14)
L95:
*line 307
*line 308
bra L41
*line 309
*line 310
L99:
*line 311
*line 312
move.l #$ffffffff,R0
bra L1
*line 313
bra L41
L42:ext.l R0
move.l #L100,R8
move #8,R1
L101:cmp.l (R8)+,R0
dbeq R1,L101
move.l 32(R8),R8
jmp (R8)
.data
L100:.dc.l 0
.dc.l 88
.dc.l 99
.dc.l 100
.dc.l 111
.dc.l 115
.dc.l 117
.dc.l 120
.dc.l 0
.dc.l L99
.dc.l L47
.dc.l L92
.dc.l L43
.dc.l L46
.dc.l L93
.dc.l L44
.dc.l L48
.dc.l L90
.text
L41:
*line 314
*line 315
*line 316
*line 317
*line 318
*line 319
tst.l -12(R14)
bge L102
*line 319
clr.l -12(R14)
*line 320
L102:
*line 321
*line 322
move.l -40(R14),R0
sub.l R11,R0
move.l R0,-8(R14)
move.l -44(R14),R9
tst.b (R9)
bne L10005
clr R1
bra L10007
L10005:move.l -44(R14),R9
tst.b 1(R9)
bne L10008
move #1,R1
bra L10010
L10008:move #2,R1
L10010:L10007:ext.l R1
add.l R1,R0
add.l -12(R14),R0
move.l R0,-4(R14)
*line 323
*line 324
move -34(R14),R0
ext.l R0
move.l -4(R14),R1
cmp.l R1,R0
ble L10011
move -34(R14),R0
ext.l R0
bra L10013
L10011:move.l -4(R14),R0
L10013:add.l R0,-16(R14)
*line 325
*line 326
*line 327
tst -26(R14)
bne L103
*line 327
bra L106
L105:
*line 328
move #32,(sp)
jsr (R13)
L106:
*line 328
sub #1,-34(R14)
move -34(R14),R0
ext.l R0
move.l -4(R14),R1
cmp.l R1,R0
bge L105
L104:
*line 329
L103:
*line 330
bra L109
L108:
*line 331
move.l -44(R14),R8
move.b (R8),R0
ext.w R0
move R0,(sp)
jsr (R13)
add.l #1,-44(R14)
L109:
*line 331
move.l -44(R14),R8
tst.b (R8)
bne L108
L107:
*line 332
*line 333
bra L112
L111:
*line 334
move #48,(sp)
jsr (R13)
L112:
*line 334
sub.l #$1,-12(R14)
bge L111
L110:
*line 335
*line 336
*line 337
tst.l -8(R14)
ble L113
*line 337
bra L116
L115:
*line 338
move.b (R11)+,R0
ext.w R0
move R0,(sp) 
jsr (R13)
L116:
*line 338
move.l -8(R14),R0
sub.l #$1,-8(R14)
tst.l R0
bne L115
L114:
*line 339
L113:
*line 340
bra L119
L118:
*line 341
move #32,(sp)
jsr (R13)
L119:
*line 341
sub #1,-34(R14)
move -34(R14),R0
ext.l R0
move.l -4(R14),R1
cmp.l R1,R0
bge L118
L117:L3:bra L4
L2:L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.data
L40:.dc.b $0
L58:.dc.b $2D,$0
L62:.dc.b $2B,$0
L65:.dc.b $20,$0
L66:.dc.b $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$41,$42,$43,$44,$45,$46,$0
L67:.dc.b $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$61,$62,$63,$64,$65,$66,$0
L89:.dc.b $30,$78,$0
