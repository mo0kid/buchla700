.globl _errno
.globl _chantab
.globl _Wrkbuf
.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl __thebpb
.globl __thefat
.data
L1:
*line 27
.dc.l L2
*line 28
.dc.l L3
*line 29
.dc.l L4
*line 30
.dc.l L5
*line 32
.dc.l L6
*line 33
.dc.l L7
*line 34
.dc.l L8
*line 35
.dc.l L9
*line 37
.dc.l L10
*line 38
.dc.l L11
*line 39
.dc.l L12
*line 40
.dc.l L13
*line 42
.dc.l L14
*line 43
.dc.l L15
*line 44
.dc.l L16
*line 46
.dc.l L17
.text
.data
L18:
*line 53
.dc.l L19
*line 54
.dc.l L20
*line 55
.dc.l L21
*line 56
.dc.l L22
*line 57
.dc.l L23
*line 58
.dc.l L24
*line 59
.dc.l L25
*line 61
.dc.l L26
.text
.data
L27:
*line 65
.dc.l L28
*line 66
.dc.l L29
*line 67
.dc.l L30
*line 68
.dc.l L31
*line 69
.dc.l L32
*line 70
.dc.l L33
*line 71
.dc.l L34
*line 73
.dc.l L35
.text
.text
_waitcr:
~~waitcr:
link R14,#-6
~c=-2
*line 83
move #7,(sp)
move #2,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 85
bra L40
L39:
*line 86
*line 87
cmp.b #7,-2(R14)
bne L41
*line 87
jsr _xtrap15
L41:L40:
*line 88
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$7f,R0
move.b R0,-2(R14)
cmp #13,R0
bne L39
L38:L37:unlk R14
rts
.globl _ClusMap
.text
_ClusMap:
~~ClusMap:
~fcp=8
link R14,#-20
~clus=-2
~nc=-4
~alsize=-8
~bused=-12
~bunused=-16
*line 108
*line 108
move.l 8(R14),R8
btst #4,32(R8)
bne L43
*line 109
*line 110
move #22,_errno
*line 111
move #-1,R0
bra L42
*line 112
*line 113
L43:
*line 114
clr -4(R14)
*line 115
move.l 8(R14),R8
move 26(R8),(sp)
jsr _micons
move R0,-2(R14)
*line 117
*line 117
tst -2(R14)
beq L44
*line 118
*line 119
*line 120
move -2(R14),(sp)
move.l 8(R14),-(sp)
add.l #8,(sp)
move.l 8(R14),-(sp)
move.l #L45,-(sp)
jsr _printf
adda.l #12,sp
*line 121
move #1,-4(R14)
*line 122
*line 123
bra L48
L47:
*line 124
*line 125
move -2(R14),(sp)
move.l #__thefat,-(sp)
jsr __gtcl12
addq.l #4,sp
move R0,-2(R14)
*line 126
*line 127
*line 127
cmp #4080,-2(R14)
bge L49
*line 128
*line 129
add #1,-4(R14)
*line 130
*line 131
*line 132
move -4(R14),R0
sub #1,R0
ext.l R0
divs #10,R0
swap R0
tst R0
bne L50
*line 132
move.l #L51,(sp)
jsr _printf
*line 133
L50:
*line 134
move -2(R14),(sp)
move.l #L52,-(sp)
jsr _printf
addq.l #4,sp
*line 135
L49:L48:
*line 136
cmp #4080,-2(R14)
blt L47
L46:
*line 137
*line 138
L44:
*line 139
move.l __thebpb,R8
clr R0
move 4(R8),R0
mulu -4(R14),R0
move.l R0,-8(R14)
*line 140
move.l 8(R14),R8
move.l 48(R8),-12(R14)
*line 141
move.l -8(R14),R0
sub.l -12(R14),R0
move.l R0,-16(R14)
*line 143
move.l 8(R14),R8
move.l 52(R8),(sp)
move -4(R14),-(sp)
move.l #L53,-(sp)
jsr _printf
addq.l #6,sp
*line 144
move.l -12(R14),(sp)
move.l -8(R14),-(sp)
move.l #L54,-(sp)
jsr _printf
addq.l #8,sp
*line 146
*line 147
move.l -8(R14),R0
cmp.l -12(R14),R0
blt L55
*line 147
move.l -16(R14),(sp)
move.l #L56,-(sp)
jsr _printf
addq.l #4,sp
*line 148
L55:
*line 149
move.l #L57,(sp)
jsr _printf
*line 151
*line 152
move.l -12(R14),R0
cmp.l -8(R14),R0
ble L58
*line 152
move.l #L59,(sp)
jsr _printf
*line 153
L58:
*line 154
*line 155
move.l 8(R14),R8
move.l 52(R8),R0
move -4(R14),R8
cmp.l R8,R0
beq L60
*line 156
move.l 8(R14),R8
move.l 52(R8),(sp)
move -4(R14),-(sp)
move.l #L61,-(sp)
jsr _printf
addq.l #6,sp
L60:
*line 157
clr R0
bra L42
L42:unlk R14
rts
.globl _FCBmode
.text
_FCBmode:
~~FCBmode:
~fcp=R13
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~mf=R7
~i=R6
*line 176
move.l 8(R14),R13
*line 176
move.l #L63,(sp)
jsr _printf
*line 177
move #1,R7
*line 179
clr R6
bra L66
L67:
*line 180
*line 181
*line 182
clr R0
move R7,R0
and 32(R13),R0
beq L68
*line 182
move R6,R8
add.l R8,R8
add.l R8,R8
move.l #L1,R9
move.l 0(R8,R9.l),(sp)
move.l #L69,-(sp)
jsr _printf
addq.l #4,sp
*line 183
L68:
*line 184
lsl R7
L65:
*line 179
add #1,R6
L66:
*line 179
cmp #16,R6
blt L67
L64:
*line 187
move.l #L70,(sp)
jsr _printf
*line 189
move #1,R7
*line 191
clr R6
bra L73
L74:
*line 192
*line 193
*line 194
clr R0
move R7,R0
move.b 11(R13),R1
ext.w R1
and R1,R0
beq L75
*line 194
move R6,R8
add.l R8,R8
add.l R8,R8
move.l #L18,R9
move.l 0(R8,R9.l),(sp)
move.l #L76,-(sp)
jsr _printf
addq.l #4,sp
*line 195
L75:
*line 196
lsl R7
L72:
*line 191
add #1,R6
L73:
*line 191
cmp #8,R6
blt L74
L71:
*line 199
move.l #L77,(sp)
jsr _printf
*line 200
move.l R13,R0
bra L62
L62:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _SnapFCB
.text
_SnapFCB:
~~SnapFCB:
~fcp=R13
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 217
move.l 8(R14),R13
*line 218
move.l R13,(sp)
add.l #8,(sp)
move.l R13,-(sp)
move.l R13,-(sp)
move.l #L79,-(sp)
jsr _printf
adda.l #12,sp
*line 219
move.l R13,(sp)
jsr _FCBmode
*line 221
move.b 11(R13),R0
ext.w R0
move R0,(sp) 
move.l #L80,-(sp)
jsr _printf
addq.l #4,sp
*line 222
move 32(R13),(sp)
move.l #L81,-(sp)
jsr _printf
addq.l #4,sp
*line 224
move 22(R13),(sp)
jsr _micons
move R0,(sp)
move.l #L82,-(sp)
jsr _printf
addq.l #4,sp
*line 225
move 24(R13),(sp)
jsr _micons
move R0,(sp)
move.l #L83,-(sp)
jsr _printf
addq.l #4,sp
*line 227
move.l 52(R13),(sp)
move.l #L84,-(sp)
jsr _printf
addq.l #4,sp
*line 228
move.l 28(R13),(sp)
jsr _miconl
move.l R0,(sp)
move.l #L85,-(sp)
jsr _printf
addq.l #4,sp
*line 229
move.l 48(R13),(sp)
move.l #L86,-(sp)
jsr _printf
addq.l #4,sp
*line 231
move 26(R13),(sp)
jsr _micons
move R0,(sp)
move.l #L87,-(sp)
jsr _printf
addq.l #4,sp
*line 232
move 36(R13),(sp)
move.l #L88,-(sp)
jsr _printf
addq.l #4,sp
*line 233
move 34(R13),(sp)
move.l #L89,-(sp)
jsr _printf
addq.l #4,sp
*line 235
move.l 40(R13),(sp)
move.l #L90,-(sp)
jsr _printf
addq.l #4,sp
*line 236
move.l 44(R13),(sp)
move.l #L91,-(sp)
jsr _printf
addq.l #4,sp
*line 237
move 38(R13),(sp)
move.l #L92,-(sp)
jsr _printf
addq.l #4,sp
*line 239
move.l #L93,(sp)
jsr _printf
*line 240
move.l R13,R0
bra L78
L78:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _MapFAT
.text
_MapFAT:
~~MapFAT:
~fat=R13
~ncl=12
~stops=14
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~i=R7
*line 258
move.l 8(R14),R13
*line 259
move 12(R14),(sp)
move.l R13,-(sp)
move.l #L95,-(sp)
jsr _printf
addq.l #8,sp
*line 260
move.l #L96,(sp)
jsr _printf
*line 262
move #2,R7
bra L99
L100:
*line 263
*line 264
*line 265
move R7,R0
ext.l R0
divs #10,R0
swap R0
tst R0
bne L101
*line 265
move R7,(sp)
move.l #L102,-(sp)
jsr _printf
addq.l #4,sp
*line 266
L101:
*line 267
move R7,(sp)
move.l R13,-(sp)
jsr __gtcl12
addq.l #4,sp
move R0,(sp)
move.l #L103,-(sp)
jsr _printf
addq.l #4,sp
*line 268
*line 269
*line 270
*line 271
*line 272
tst 14(R14)
beq L104
move R7,R0
ext.l R0
divs #10,R0
ext.l R0
divs #10,R0
swap R0
tst R0
bne L104
*line 272
jsr _waitcr
L104:L98:
*line 262
add #1,R7
L99:
*line 262
cmp 12(R14),R7
blt L100
L97:
*line 275
move.l #L105,(sp)
jsr _printf
L94:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _FILEfl
.text
_FILEfl:
~~FILEfl:
~fp=8
link R14,#0
movem.l R5-R7,-(sp)
~mf=R7
~i=R6
*line 294
move.l #L107,(sp)
jsr _printf
*line 295
move #1,R7
*line 297
clr R6
bra L110
L111:
*line 298
*line 299
*line 300
clr R0
move R7,R0
move.l 8(R14),R9
move.b 12(R9),R1
ext.w R1
and R1,R0
beq L112
*line 300
move R6,R8
add.l R8,R8
add.l R8,R8
move.l #L27,R9
move.l 0(R8,R9.l),(sp)
move.l #L113,-(sp)
jsr _printf
addq.l #4,sp
*line 301
L112:
*line 302
lsl R7
L109:
*line 297
add #1,R6
L110:
*line 297
cmp #8,R6
blt L111
L108:
*line 305
move.l #L114,(sp)
jsr _printf
*line 306
move.l 8(R14),R0
bra L106
L106:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _FILEpr
.text
_FILEpr:
~~FILEpr:
~fp=8
link R14,#-26
~arg=-4
~ft=-6
~ds=-10
~fsn=-14
~fse=-18
~fcp=-22
*line 325
*line 325
tst.l 8(R14)
bne L116
*line 326
*line 327
move.l #L117,(sp)
jsr _printf
bra L115
*line 328
*line 329
*line 330
*line 331
L116:
*line 332
move.l 8(R14),(sp)
move.l #L118,-(sp)
jsr _printf
addq.l #4,sp
*line 334
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
muls #12,R0
add.l #_chantab,R0
move.l R0,R8
move.l 4(R8),-4(R14)
*line 335
clr -6(R14)
*line 337
*line 337
move.l -4(R14),R0
cmp.l #__noper,R0
bne L119
*line 338
*line 339
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
muls #12,R0
move.l R0,R8
move.l #_chantab,R9
move.l 8(R8,R9.l),R8
move.l (R8),-10(R14)
*line 340
move.l -10(R14),(sp)
move.l #L120,-(sp)
jsr _printf
addq.l #4,sp
*line 341
bra L121
L119:
*line 342
*line 342
move.l -4(R14),R0
cmp.l #__filecl,R0
bne L122
*line 343
*line 344
move #1,-6(R14)
*line 345
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
muls #12,R0
add.l #_chantab,R0
move.l R0,R8
move.l 8(R8),-22(R14)
*line 346
move.l -22(R14),-14(R14)
*line 347
move.l -22(R14),R0
add.l #8,R0
move.l R0,-18(R14)
*line 348
*line 349
move.l -22(R14),(sp)
move.l -18(R14),-(sp)
move.l -14(R14),-(sp)
move.l #L123,-(sp)
jsr _printf
adda.l #12,sp
*line 350
bra L124
L122:
*line 351
*line 352
*line 353
*line 354
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
muls #12,R0
move.l R0,R8
move.l #_chantab,R9
move.l 8(R8,R9.l),(sp)
move.l -4(R14),-(sp)
move.l #L125,-(sp)
jsr _printf
addq.l #8,sp
L124:L121:
*line 357
*line 358
move.l 8(R14),R8
move 16(R8),(sp)
move.l 8(R14),R8
move.l 4(R8),-(sp)
move.l 8(R14),R8
move.l (R8),-(sp)
move.l 8(R14),R8
move.l 8(R8),-(sp)
move.l #L126,-(sp)
jsr _printf
adda.l #16,sp
*line 359
*line 360
move.l 8(R14),R8
move.b 14(R8),R0
ext.w R0
move R0,(sp) 
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
move R0,-(sp) 
move.l 8(R14),R8
move.b 12(R8),R0
ext.w R0
move R0,-(sp) 
move.l #L127,-(sp)
jsr _printf
addq.l #8,sp
*line 362
move.l 8(R14),(sp)
jsr _FILEfl
*line 364
*line 365
tst -6(R14)
beq L128
*line 365
move.l -22(R14),(sp)
jsr _SnapFCB
*line 366
bra L129
L128:
*line 367
move.l #L130,(sp)
jsr _printf
L129:L115:unlk R14
rts
.globl _fd2fcb
.text
_fd2fcb:
~~fd2fcb:
~fd=8
link R14,#-4
*line 383
*line 384
tst 8(R14)
blt L10000
cmp #11,8(R14)
ble L132
L10000:*line 384
clr.l R0
bra L131
*line 385
L132:
*line 386
move 8(R14),R0
muls #12,R0
move.l R0,R8
move.l #_chantab,R9
move.l 8(R8,R9.l),R0
bra L131
L131:unlk R14
rts
.globl _fp2fcb
.text
_fp2fcb:
~~fp2fcb:
~fp=8
link R14,#-4
*line 399
*line 400
tst.l 8(R14)
bne L134
*line 400
clr.l R0
bra L133
*line 401
L134:
*line 402
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
muls #12,R0
move.l R0,R8
move.l #_chantab,R9
move.l 8(R8,R9.l),R0
bra L133
L133:unlk R14
rts
.data
L2:.dc.b $3F,$44,$30,$0
L3:.dc.b $3F,$44,$31,$0
L4:.dc.b $3F,$44,$32,$0
L5:.dc.b $3F,$44,$33,$0
L6:.dc.b $42,$46,$20,$0
L7:.dc.b $4E,$42,$20,$0
L8:.dc.b $54,$52,$20,$0
L9:.dc.b $45,$58,$20,$0
L10:.dc.b $52,$44,$20,$0
L11:.dc.b $57,$52,$20,$0
L12:.dc.b $41,$50,$20,$0
L13:.dc.b $43,$52,$20,$0
L14:.dc.b $4F,$50,$4E,$0
L15:.dc.b $45,$52,$52,$0
L16:.dc.b $42,$41,$44,$0
L17:.dc.b $45,$4F,$46,$0
L19:.dc.b $52,$44,$4F,$4E,$4C,$59,$0
L20:.dc.b $48,$49,$44,$44,$45,$4E,$0
L21:.dc.b $53,$59,$53,$54,$45,$4D,$0
L22:.dc.b $56,$4F,$4C,$55,$4D,$45,$0
L23:.dc.b $53,$55,$42,$44,$49,$52,$0
L24:.dc.b $41,$52,$43,$48,$49,$56,$0
L25:.dc.b $3F,$3F,$44,$36,$3F,$3F,$0
L26:.dc.b $3F,$3F,$44,$37,$3F,$3F,$0
L28:.dc.b $42,$55,$53,$59,$20,$20,$0
L29:.dc.b $41,$4C,$4C,$42,$55,$46,$0
L30:.dc.b $44,$49,$52,$54,$59,$20,$0
L31:.dc.b $45,$4F,$46,$20,$20,$20,$0
L32:.dc.b $49,$4F,$45,$52,$52,$20,$0
L33:.dc.b $3F,$3F,$44,$35,$3F,$3F,$0
L34:.dc.b $3F,$3F,$44,$36,$3F,$3F,$0
L35:.dc.b $3F,$3F,$44,$37,$3F,$3F,$0
L45:.dc.b $41,$6C,$6C,$6F,$63,$61,$74,$65,$64,$20,$63,$6C,$75,$73,$74,$65,$72,$20,$63,$68,$61,$69,$6E,$20,$66,$6F,$72,$20,$5B,$25
.dc.b $2D,$38,$2E,$38,$73,$5D,$2E,$5B,$25,$2D,$33,$2E,$33,$73,$5D,$3A,$A,$25,$36,$64,$0
L51:.dc.b $A,$0
L52:.dc.b $25,$36,$64,$0
L53:.dc.b $A,$46,$41,$54,$20,$63,$6C,$75,$73,$74,$65,$72,$20,$63,$6F,$75,$6E,$74,$3D,$25,$64,$2C,$20,$61,$73,$65,$63,$74,$73,$3D
.dc.b $25,$6C,$64,$A,$0
L54:.dc.b $25,$6C,$64,$20,$62,$79,$74,$65,$73,$20,$61,$6C,$6C,$6F,$63,$61,$74,$65,$64,$2C,$20,$25,$6C,$64,$20,$62,$79,$74,$65,$73
.dc.b $20,$75,$73,$65,$64,$0
L56:.dc.b $2C,$20,$25,$6C,$64,$20,$62,$79,$74,$65,$73,$20,$75,$6E,$75,$73,$65,$64,$0
L57:.dc.b $A,$0
L59:.dc.b $45,$52,$52,$4F,$52,$3A,$20,$20,$64,$69,$72,$65,$63,$74,$6F,$72,$79,$20,$66,$69,$6C,$65,$20,$73,$69,$7A,$65,$20,$65,$78
.dc.b $63,$65,$65,$64,$73,$20,$46,$41,$54,$20,$61,$6C,$6C,$6F,$63,$61,$74,$69,$6F,$6E,$A,$0
L61:.dc.b $45,$52,$52,$4F,$52,$3A,$20,$20,$46,$41,$54,$20,$63,$6C,$75,$73,$74,$65,$72,$20,$63,$6F,$75,$6E,$74,$20,$28,$25,$64,$29
.dc.b $20,$4E,$45,$20,$46,$43,$42,$20,$63,$6C,$75,$73,$74,$65,$72,$20,$63,$6F,$75,$6E,$74,$20,$28,$25,$6C,$64,$29,$A,$0
L63:.dc.b $20,$20,$66,$6C,$61,$67,$73,$3A,$20,$20,$0
L69:.dc.b $25,$73,$20,$0
L70:.dc.b $A,$20,$20,$61,$74,$72,$69,$62,$3A,$20,$20,$0
L76:.dc.b $25,$73,$20,$0
L77:.dc.b $A,$0
L79:.dc.b $A,$46,$43,$42,$20,$61,$74,$20,$30,$78,$25,$30,$38,$6C,$78,$3A,$20,$20,$5B,$25,$2D,$38,$2E,$38,$73,$5D,$2E,$5B,$25,$2D
.dc.b $33,$2E,$33,$73,$5D,$A,$0
L80:.dc.b $20,$20,$61,$74,$72,$69,$62,$20,$20,$20,$20,$20,$20,$30,$78,$25,$30,$34,$78,$0
L81:.dc.b $20,$20,$6D,$6F,$64,$65,$66,$6C,$20,$20,$20,$20,$20,$30,$78,$25,$30,$34,$78,$A,$0
L82:.dc.b $20,$20,$63,$72,$74,$69,$6D,$65,$20,$20,$20,$20,$20,$30,$78,$25,$30,$34,$78,$0
L83:.dc.b $20,$20,$63,$72,$64,$61,$74,$65,$20,$20,$20,$20,$20,$30,$78,$25,$30,$34,$78,$A,$0
L84:.dc.b $20,$20,$61,$73,$65,$63,$74,$73,$20,$20,$20,$25,$38,$6C,$64,$0
L85:.dc.b $20,$20,$66,$6C,$65,$6E,$20,$20,$20,$20,$20,$25,$38,$6C,$64,$0
L86:.dc.b $20,$20,$63,$75,$72,$6C,$65,$6E,$20,$20,$20,$25,$38,$6C,$64,$A,$0
L87:.dc.b $20,$20,$62,$63,$6C,$75,$73,$74,$20,$20,$20,$25,$38,$64,$0
L88:.dc.b $20,$20,$63,$75,$72,$63,$6C,$73,$20,$20,$20,$25,$38,$64,$0
L89:.dc.b $20,$20,$63,$6C,$73,$65,$63,$20,$20,$20,$20,$25,$38,$64,$A,$0
L90:.dc.b $20,$20,$63,$75,$72,$6C,$73,$6E,$20,$20,$20,$25,$38,$6C,$64,$0
L91:.dc.b $20,$20,$63,$75,$72,$64,$73,$6E,$20,$20,$20,$25,$38,$6C,$64,$0
L92:.dc.b $20,$20,$6F,$66,$66,$73,$65,$74,$20,$20,$20,$25,$38,$64,$A,$0
L93:.dc.b $A,$0
L95:.dc.b $A,$43,$6C,$75,$73,$74,$65,$72,$20,$64,$75,$6D,$70,$20,$6F,$66,$20,$46,$41,$54,$20,$61,$74,$20,$30,$78,$25,$30,$38,$2E
.dc.b $38,$6C,$78,$20,$20,$28,$25,$64,$20,$65,$6E,$74,$72,$69,$65,$73,$29,$3A,$A,$0
L96:.dc.b $20,$20,$20,$30,$3A,$20,$2E,$2E,$2E,$2E,$20,$2E,$2E,$2E,$2E,$20,$0
L102:.dc.b $A,$25,$34,$2E,$34,$64,$3A,$20,$0
L103:.dc.b $25,$34,$2E,$34,$64,$20,$0
L105:.dc.b $A,$0
L107:.dc.b $20,$20,$5F,$66,$6C,$61,$67,$73,$3A,$20,$20,$0
L113:.dc.b $25,$73,$20,$0
L114:.dc.b $A,$0
L117:.dc.b $46,$49,$4C,$45,$70,$72,$28,$29,$3A,$20,$20,$45,$52,$52,$4F,$52,$20,$2D,$20,$61,$72,$67,$75,$6D,$65,$6E,$74,$20,$77,$61
.dc.b $73,$20,$4E,$55,$4C,$4C,$A,$0
L118:.dc.b $A,$46,$49,$4C,$45,$20,$61,$74,$20,$24,$25,$30,$38,$2E,$38,$6C,$58,$0
L120:.dc.b $20,$69,$73,$20,$61,$20,$64,$65,$76,$69,$63,$65,$3A,$20,$20,$5B,$25,$73,$5D,$A,$0
L123:.dc.b $20,$69,$73,$20,$61,$20,$64,$69,$73,$6B,$20,$66,$69,$6C,$65,$3A,$20,$20,$5B,$25,$38,$2E,$38,$73,$5D,$2E,$5B,$25,$33,$2E
.dc.b $33,$73,$5D,$2C,$20,$20,$66,$63,$62,$20,$61,$74,$20,$24,$25,$30,$38,$2E,$38,$6C,$58,$A,$0
L125:.dc.b $20,$69,$73,$20,$6F,$66,$20,$55,$4E,$4B,$4E,$4F,$57,$4E,$20,$74,$79,$70,$65,$3A,$20,$63,$5F,$63,$6C,$6F,$73,$65,$3D,$24
.dc.b $25,$30,$38,$2E,$38,$6C,$58,$2C,$20,$63,$5F,$61,$72,$67,$3D,$24,$25,$30,$38,$2E,$38,$6C,$58,$A,$0
L126:.dc.b $20,$20,$5F,$62,$75,$66,$66,$3D,$24,$25,$30,$38,$2E,$38,$6C,$58,$2C,$20,$5F,$62,$70,$3D,$24,$25,$30,$38,$2E,$38,$6C,$58
.dc.b $2C,$20,$5F,$62,$65,$6E,$64,$3D,$24,$25,$30,$38,$2E,$38,$6C,$58,$2C,$20,$5F,$62,$75,$66,$6C,$65,$6E,$3D,$25,$75,$A,$0
L127:.dc.b $20,$20,$5F,$66,$6C,$61,$67,$73,$3D,$24,$25,$30,$34,$2E,$34,$58,$2C,$20,$5F,$75,$6E,$69,$74,$3D,$25,$64,$2C,$20,$5F,$62
.dc.b $79,$74,$62,$75,$66,$3D,$24,$25,$30,$32,$2E,$32,$58,$A,$0
L130:.dc.b $A,$0
