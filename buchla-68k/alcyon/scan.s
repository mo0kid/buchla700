.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl ___atab
.bss
L1:.ds.b 2
.text
.bss
L2:.ds.b 4
.text
.bss
L3:.ds.b 4
.text
.bss
L4:.ds.b 2
.text
.text
_getnum:
~~getnum:
~list=8
~values=12
~base=16
link R14,#-4
movem.l R6-R7/R13-R13,-(sp)
~val=R7
~cp=R13
~c=-2
~sign=-4
*line 35
*line 36
tst L1
bgt L7
*line 36
clr.l R0
bra L6
*line 37
L7:
*line 38
clr R0
move R0,-4(R14)
ext.l R0
move.l R0,R7
*line 40
*line 40
clr -(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
move R0,-2(R14)
cmp #45,R0
bne L8
*line 41
*line 42
move #1,-4(R14)
*line 43
sub #1,L1
*line 44
bra L9
L8:
*line 45
*line 46
cmp #43,-2(R14)
bne L10
*line 46
sub #1,L1
*line 47
bra L11
L10:
*line 48
move #1,-(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
L11:L9:
*line 50
bra L14
L13:
*line 51
*line 52
*line 52
clr -(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
move R0,(sp)
move.l 8(R14),-(sp)
jsr _index
addq.l #4,sp
move.l R0,R13
move.l R13,R0
bne L15
*line 53
*line 54
move #1,-(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
bra L12
*line 55
*line 56
*line 57
L15:
*line 58
move 16(R14),R0
ext.l R0
move.l R0,-(sp)
move.l R7,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R7
*line 59
move.l 12(R14),R8
move.l R13,R9
sub.l 8(R14),R9
move.b 0(R8,R9.l),R0
ext.w R0
ext.l R0
add.l R0,R7
L14:
*line 60
move L1,R0
sub #1,L1
tst R0
bne L13
L12:
*line 62
*line 63
tst -4(R14)
beq L16
*line 63
move.l R7,R0
neg.l R0
move.l R0,R7
*line 64
L16:
*line 65
move.l R7,R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.text
_skipblk:
~~skipblk:
link R14,#-4
*line 74
bra L21
L20:L21:
*line 75
clr -(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #5,(R8)
bne L20
L19:
*line 77
*line 78
move #1,-(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
cmp #-1,R0
bne L22
*line 78
move #-1,R0
bra L18
*line 79
L22:
*line 80
clr R0
bra L18
L18:unlk R14
rts
.text
_sgetc:
~~sgetc:
~what=8
link R14,#-4
*line 86
*line 86
tst 8(R14)
bne L25
*line 87
*line 88
*line 89
move.l L3,R8
tst.b (R8)
beq L26
*line 89
move.l L3,R8
move.b (R8),R0
ext.w R0
and #255,R0
add.l #1,L3
bra L24
*line 90
L26:
*line 91
move.b #1,L4
*line 92
bra L27
L25:
*line 93
*line 94
*line 95
*line 96
tst.b L4
bne L28
*line 96
sub.l #1,L3
move.l L3,R8
move.b (R8),R0
ext.w R0
and #255,R0
bra L24
L28:L27:
*line 99
move #-1,R0
bra L24
L24:unlk R14
rts
.globl _scanfmt
.text
_scanfmt:
~~scanfmt:
~fmt=R13
~getsub=8
~args=16
link R14,#-148
movem.l R7-R7/R13-R13,-(sp)
~lv=-4
~c=-6
~count=-8
~dontdo=-10
~lflag=-12
~base=-14
~cp=-18
~tlist=-148
~list=L30
.data
L30:.dc.b $41,$42,$43,$44,$45,$46,$61,$62,$63,$64,$65,$66,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30,$0
.even
.text
~vals=L32
.data
L32:.dc.b $A
.dc.b $B
.dc.b $C
.dc.b $D
.dc.b $E
.dc.b $F
.dc.b $A
.dc.b $B
.dc.b $C
.dc.b $D
.dc.b $E
.dc.b $F
.dc.b $9
.dc.b $8
.dc.b $7
.dc.b $6
.dc.b $5
.dc.b $4
.dc.b $3
.dc.b $2
.dc.b $1
.dc.b $0
.text
*line 129
move.l 12(R14),R13
*line 129
clr -8(R14)
*line 130
move.l 8(R14),L2
*line 132
bra L35
L34:
*line 133
*line 134
*line 134
cmp #37,-6(R14)
bne L36
*line 135
*line 136
clr R0
move R0,-10(R14)
move R0,-12(R14)
*line 137
move #127,L1
*line 138
*line 139
*line 139
cmp.b #42,(R13)
bne L37
*line 140
add.l #1,R13
*line 141
move #1,-10(R14)
*line 142
*line 143
L37:
*line 144
*line 144
move.b (R13),R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #2,(R8)
beq L38
*line 145
*line 146
clr L1
*line 147
*line 148
L41:
*line 149
*line 150
move L1,R0
muls #10,R0
move.b (R13),R1
ext.w R1
add R1,R0
add #-48,R0
move R0,L1
*line 151
L40:
*line 152
add.l #1,R13
move.b (R13),R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #2,(R8)
bne L41
L39:
*line 153
*line 154
L38:
*line 155
*line 155
cmp.b #108,(R13)
bne L42
*line 156
*line 157
move #1,-12(R14)
*line 158
add.l #1,R13
*line 159
*line 160
*line 161
*line 162
L42:
*line 163
move.b (R13)+,R0
ext.w R0
bra L44
*line 164
L45:
*line 165
*line 166
move #37,-6(R14)
bra L46
*line 167
*line 168
L47:
*line 169
*line 170
clr -12(R14)
bra L48
*line 171
*line 172
L49:
*line 173
*line 174
move #1,-12(R14)
*line 175
L50:
*line 176
L48:
*line 177
*line 178
move #12,-6(R14)
*line 179
move #10,-14(R14)
bra L51
*line 180
*line 181
L52:
*line 182
*line 183
move #1,-12(R14)
*line 184
L53:
*line 185
*line 186
clr -6(R14)
*line 187
move #16,-14(R14)
bra L51
*line 188
*line 189
L54:
*line 190
*line 191
move #1,-12(R14)
*line 192
L55:
*line 193
*line 194
move #14,-6(R14)
*line 195
move #8,-14(R14)
L51:
*line 196
*line 197
*line 198
jsr _skipblk
tst R0
bne L56
*line 199
*line 200
move -14(R14),(sp)
move.l #L32,R0
move -6(R14),R1
ext.l R1
add.l R1,R0
move.l R0,-(sp)
move.l #L30,R0
move -6(R14),R1
ext.l R1
add.l R1,R0
move.l R0,-(sp)
jsr _getnum
addq.l #8,sp
move.l R0,-4(R14)
*line 201
*line 202
*line 202
tst -10(R14)
bne L57
*line 203
*line 204
*line 205
tst -12(R14)
beq L58
*line 205
move.l 16(R14),R8
move.l (R8),R8
move.l -4(R14),(R8)
add.l #4,16(R14)
*line 206
bra L59
L58:
*line 207
move.l -4(R14),R0
move.l 16(R14),R9
move.l (R9),R9
move R0,(R9)
add.l #4,16(R14)
L59:
*line 208
add #1,-8(R14)
*line 209
*line 210
L57:bra L43
*line 211
*line 212
*line 213
*line 214
*line 237
*line 238
*line 239
*line 240
*line 241
L60:
*line 242
*line 243
clr -12(R14)
*line 244
*line 245
*line 245
cmp.b #94,(R13)
beq L10000
cmp.b #126,(R13)
bne L61
L10000:*line 246
*line 247
add.l #1,R13
*line 248
move #1,-12(R14)
*line 249
*line 250
L61:
*line 251
lea -148(R14),R8
move.l R8,-18(R14)
bra L64
L65:
*line 252
move -6(R14),R0
move.l -18(R14),R9
move.b R0,(R9)
add.l #1,-18(R14)
L63:L64:
*line 251
move.b (R13)+,R0
ext.w R0
move R0,-6(R14)
cmp #93,R0
bne L65
L62:
*line 252
*line 253
*line 254
move.l -18(R14),R8
clr.b (R8)
bra L66
*line 255
*line 256
L67:
*line 257
*line 258
move #1,-12(R14)
*line 259
move.b #32,-148(R14)
*line 260
move.b #9,-147(R14)
*line 261
move.b #10,-146(R14)
*line 262
clr.b -145(R14)
L66:
*line 263
*line 264
*line 265
jsr _skipblk
tst R0
bne L56
*line 266
*line 267
*line 268
tst -10(R14)
bne L68
*line 268
move.l 16(R14),R8
move.l (R8),-18(R14)
add.l #4,16(R14)
*line 269
L68:
*line 270
bra L71
L70:
*line 271
*line 272
*line 273
clr -(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
move R0,-6(R14)
cmp #-1,R0
beq L69
*line 274
*line 275
*line 276
*line 277
tst -12(R14)
beq L10001
move -6(R14),(sp)
move.l R14,-(sp)
add.l #-148,(sp)
jsr _index
addq.l #4,sp
tst.l R0
bne L10002
clr R0
bra L10003
L10002:move #1,R0
L10003:bra L10005
L10001:move -6(R14),(sp)
move.l R14,-(sp)
add.l #-148,(sp)
jsr _index
addq.l #4,sp
tst.l R0
beq L10006
clr R0
bra L10007
L10006:move #1,R0
L10007:L10005:tst R0
beq L72
*line 278
*line 279
move #1,-(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
bra L69
*line 280
*line 281
*line 282
L72:
*line 283
*line 284
tst -10(R14)
bne L73
*line 284
move -6(R14),R0
move.l -18(R14),R9
move.b R0,(R9)
add.l #1,-18(R14)
L73:L71:
*line 285
move L1,R0
sub #1,L1
tst R0
bne L70
L69:
*line 286
*line 287
*line 287
tst -10(R14)
bne L74
*line 288
*line 289
move.l -18(R14),R8
clr.b (R8)
*line 290
add #1,-8(R14)
*line 291
*line 292
L74:bra L43
*line 293
*line 294
*line 295
L75:
*line 296
*line 297
*line 298
clr -(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
move R0,-6(R14)
cmp #-1,R0
beq L56
*line 299
*line 300
*line 300
tst -10(R14)
bne L76
*line 301
*line 302
move -6(R14),R0
move.l 16(R14),R9
move.l (R9),R9
move.b R0,(R9)
add.l #4,16(R14)
*line 303
add #1,-8(R14)
*line 304
*line 305
L76:bra L43
*line 306
bra L43
L44:ext.l R0
move.l #L77,R8
move #11,R1
L78:cmp.l (R8)+,R0
dbeq R1,L78
move.l 44(R8),R8
jmp (R8)
.data
L77:.dc.l 37
.dc.l 68
.dc.l 79
.dc.l 88
.dc.l 91
.dc.l 99
.dc.l 100
.dc.l 104
.dc.l 111
.dc.l 115
.dc.l 120
.dc.l 0
.dc.l L45
.dc.l L49
.dc.l L54
.dc.l L52
.dc.l L60
.dc.l L75
.dc.l L50
.dc.l L47
.dc.l L55
.dc.l L67
.dc.l L53
.dc.l L43
.text
L43:
*line 307
*line 308
bra L79
L36:
*line 309
*line 309
move.l #___atab,R8
move -6(R14),R9
add.l R9,R8
btst #5,(R8)
beq L80
*line 310
*line 311
*line 311
jsr _skipblk
tst R0
beq L81
L56:
*line 312
*line 313
*line 314
tst -8(R14)
bne L82
*line 314
move #-1,R0
bra L29
*line 315
L82:
*line 316
move -8(R14),R0
bra L29
*line 317
*line 318
L81:bra L83
L80:
*line 319
*line 320
L46:
*line 321
*line 322
*line 323
jsr _skipblk
tst R0
bne L56
*line 324
*line 325
*line 326
clr -(sp)
move.l L2,R8
jsr (R8)
addq.l #2,sp
cmp -6(R14),R0
beq L84
*line 326
move -8(R14),R0
bra L29
L84:L83:L79:
*line 327
L35:
*line 328
move.b (R13)+,R0
ext.w R0
move R0,-6(R14)
bne L34
L33:
*line 330
move -8(R14),R0
bra L29
L29:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _sscanf
.text
_sscanf:
~~sscanf:
~string=8
~fmt=12
~args=16
link R14,#-4
*line 385
move.l 8(R14),L3
*line 386
clr.b L4
*line 387
move.l R14,(sp)
add.l #16,(sp)
move.l 12(R14),-(sp)
move.l #_sgetc,-(sp)
jsr _scanfmt
addq.l #8,sp
bra L85
L85:unlk R14
rts
.data
