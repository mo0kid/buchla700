.globl ___atab
.globl _QQsw
.comm _QQsw,2
.globl _QQanch
.comm _QQanch,2
.globl _QQin
.comm _QQin,4
.globl _QQip
.comm _QQip,4
.globl _QQop
.comm _QQop,4
.globl _QQnum
.comm _QQnum,4
.globl _QQlnum
.comm _QQlnum,2
.globl _QQdig
.comm _QQdig,2
.globl _QQchr
.comm _QQchr,2
.globl _QQstr
.comm _QQstr,258
.globl _CMinit
.text
_CMinit:
~~CMinit:
~ip=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~i=R7
~t=R13
*line 48
move.l 8(R14),_QQip
*line 49
move.l 8(R14),_QQin
*line 50
move #1,_QQsw
*line 51
clr _QQanch
*line 52
move.b #63,_QQdig
*line 53
move.b #63,_QQchr
*line 54
clr.l _QQnum
*line 55
move.l #_QQstr,_QQop
*line 56
move.l #_QQstr,R13
*line 58
clr R7
bra L4
L5:
*line 59
clr.b (R13)+
L3:
*line 58
add #1,R7
L4:
*line 58
cmp #257,R7
blt L5
L2:L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _CMchr
.text
_CMchr:
~~CMchr:
~c=9
link R14,#-4
*line 75
*line 75
tst _QQanch
bne L7
*line 75
bra L10
L9:
*line 75
add.l #1,_QQip
L10:
*line 75
move.l _QQip,R8
cmp.b #32,(R8)
beq L9
L8:
*line 76
L7:
*line 77
*line 78
move.l _QQip,R8
move.b (R8),R0
ext.w R0
cmp.b 9(R14),R0
beq L11
*line 78
clr R0
move R0,_QQsw
bra L6
*line 79
L11:
*line 80
move.l _QQip,R8
move.b (R8),_QQchr
add.l #1,_QQip
*line 81
move #1,R0
move R0,_QQsw
bra L6
L6:unlk R14
rts
.globl _CMuchr
.text
_CMuchr:
~~CMuchr:
~c=R7
link R14,#0
movem.l R5-R7,-(sp)
~t=R6
*line 99
move.b 9(R14),R7
*line 99
*line 99
tst _QQanch
bne L13
*line 99
bra L16
L15:
*line 99
add.l #1,_QQip
L16:
*line 99
move.l _QQip,R8
cmp.b #32,(R8)
beq L15
L14:
*line 100
L13:
*line 101
move.l _QQip,R8
move.b (R8),R6
*line 103
*line 104
move.b R7,R0
ext.w R0
and #-128,R0
bne L17
*line 104
*line 105
move.b R7,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #3,(R8)
beq L18
*line 105
add.b #32,R7
*line 106
L18:L17:
*line 107
*line 108
move.b R6,R0
ext.w R0
and #-128,R0
bne L19
*line 108
*line 109
move.b R6,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #3,(R8)
beq L20
*line 109
add.b #32,R6
*line 110
L20:L19:
*line 111
*line 112
cmp.b R6,R7
beq L21
*line 112
clr R0
move R0,_QQsw
bra L12
*line 113
L21:
*line 114
move.l _QQip,R8
move.b (R8),_QQchr
add.l #1,_QQip
*line 115
move #1,R0
move R0,_QQsw
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _CMstr
.text
_CMstr:
~~CMstr:
~s=8
link R14,#-4
movem.l R7-R7/R13-R13,-(sp)
~t=R13
~q=-4
*line 134
*line 134
tst _QQanch
bne L23
*line 134
bra L26
L25:
*line 134
add.l #1,_QQip
L26:
*line 134
move.l _QQip,R8
cmp.b #32,(R8)
beq L25
L24:
*line 135
L23:
*line 136
move.l _QQip,R13
*line 137
move.l 8(R14),-4(R14)
*line 139
bra L29
L28:
*line 140
*line 141
*line 142
move.l 8(R14),R8
move.b (R8),R0
ext.w R0
cmp.b (R13)+,R0
move sr,R0
add.l #1,8(R14)
move R0,ccr
beq L30
*line 142
clr R0
move R0,_QQsw
bra L22
L30:L29:
*line 143
move.l 8(R14),R8
tst.b (R8)
bne L28
L27:
*line 145
move.l #_QQstr,_QQop
*line 147
bra L33
L32:L33:
*line 147
move.l -4(R14),R8
move.b (R8),R0
ext.w R0
move.l _QQop,R9
move.b R0,(R9)
add.l #1,-4(R14)
add.l #1,_QQop
tst R0
bne L32
L31:
*line 149
move.l R13,_QQip
*line 150
move #1,R0
move R0,_QQsw
bra L22
L22:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _CMustr
.text
_CMustr:
~~CMustr:
~s=R13
link R14,#-4
movem.l R5-R7/R12-R13,-(sp)
~t=R12
~t1=R7
~t2=R6
~q=-4
*line 169
move.l 8(R14),R13
*line 169
*line 169
tst _QQanch
bne L35
*line 169
bra L38
L37:
*line 169
add.l #1,_QQip
L38:
*line 169
move.l _QQip,R8
cmp.b #32,(R8)
beq L37
L36:
*line 170
L35:
*line 171
move.l _QQip,R12
*line 172
move.l R13,-4(R14)
*line 174
bra L41
L40:
*line 175
*line 176
move.b (R12)+,R7
*line 177
move.b (R13)+,R6
*line 178
*line 179
*line 180
move.b R7,R0
ext.w R0
and #-128,R0
bne L42
*line 180
*line 181
move.b R7,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #3,(R8)
beq L43
*line 181
add.b #32,R7
*line 182
L43:L42:
*line 183
*line 184
move.b R6,R0
ext.w R0
and #-128,R0
bne L44
*line 184
*line 185
move.b R6,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #3,(R8)
beq L45
*line 185
add.b #32,R6
*line 186
L45:L44:
*line 187
*line 188
cmp.b R6,R7
beq L46
*line 188
clr R0
move R0,_QQsw
bra L34
L46:L41:
*line 189
tst.b (R13)
bne L40
L39:
*line 191
move.l #_QQstr,_QQop
*line 193
bra L49
L48:L49:
*line 193
move.l -4(R14),R8
move.b (R8),R0
ext.w R0
move.l _QQop,R9
move.b R0,(R9)
add.l #1,-4(R14)
add.l #1,_QQop
tst R0
bne L48
L47:
*line 195
move.l R12,_QQip
*line 196
move #1,R0
move R0,_QQsw
bra L34
L34:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.globl _CMlong
.text
_CMlong:
~~CMlong:
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~p=R13
~n=R7
~c=R6
*line 215
*line 215
tst _QQanch
bne L51
*line 215
bra L54
L53:
*line 215
add.l #1,_QQip
L54:
*line 215
move.l _QQip,R8
cmp.b #32,(R8)
beq L53
L52:
*line 216
L51:
*line 217
move.l _QQip,R13
*line 218
clr.l R7
*line 219
move.b (R13)+,R6
*line 221
*line 222
move.b R6,R0
ext.w R0
and #-128,R0
beq L55
*line 222
clr R0
move R0,_QQsw
bra L50
*line 223
L55:
*line 224
*line 225
move.b R6,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #2,(R8)
bne L56
*line 225
clr R0
move R0,_QQsw
bra L50
*line 226
L56:
*line 227
move.b R6,R0
ext.w R0
add #-48,R0
ext.l R0
move.l R0,R7
*line 229
bra L59
L58:
*line 230
*line 231
*line 232
move.b R6,R0
ext.w R0
and #-128,R0
bne L57
*line 233
*line 234
*line 235
move.b R6,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #2,(R8)
beq L57
*line 236
*line 237
move.l #$a,-(sp)
move.l R7,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R7
move.b R6,R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R7
*line 238
add.l #1,R13
L59:
*line 239
move.b (R13),R6
bne L58
L57:
*line 241
move.l R13,_QQip
*line 242
move.l R7,_QQnum
*line 243
move #1,R0
move R0,_QQsw
bra L50
L50:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _CMdig
.text
_CMdig:
~~CMdig:
link R14,#0
movem.l R6-R7,-(sp)
~c=R7
*line 260
*line 260
tst _QQanch
bne L61
*line 260
bra L64
L63:
*line 260
add.l #1,_QQip
L64:
*line 260
move.l _QQip,R8
cmp.b #32,(R8)
beq L63
L62:
*line 261
L61:
*line 262
move.l _QQip,R8
move.b (R8),R7
*line 264
*line 265
move.b R7,R0
ext.w R0
and #-128,R0
beq L65
*line 265
clr R0
move R0,_QQsw
bra L60
*line 266
L65:
*line 267
*line 268
move.b R7,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #2,(R8)
bne L66
*line 268
clr R0
move R0,_QQsw
bra L60
*line 269
L66:
*line 270
move.b R7,_QQdig
*line 271
add.l #1,_QQip
*line 272
move #1,R0
move R0,_QQsw
bra L60
L60:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _CMlist
.text
_CMlist:
~~CMlist:
~l=-4
~l=8
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~n=R7
~p=R13
~q=R12
*line 291
*line 291
tst _QQanch
bne L68
*line 291
bra L71
L70:
*line 291
add.l #1,_QQip
L71:
*line 291
move.l _QQip,R8
cmp.b #32,(R8)
beq L70
L69:
*line 292
L68:
*line 293
clr R7
*line 295
bra L74
L73:
*line 296
*line 297
move.l R13,R12
*line 298
*line 299
*line 299
move.l R13,(sp)
jsr _CMstr
tst R0
beq L75
*line 300
*line 301
move.l #_QQstr,_QQop
*line 302
*line 303
bra L78
L77:L78:
*line 303
move.b (R12)+,R0
ext.w R0
move.l _QQop,R9
move.b R0,(R9)
add.l #1,_QQop
tst R0
bne L77
L76:
*line 304
*line 305
move R7,_QQlnum
*line 306
move #1,R0
move R0,_QQsw
bra L67
*line 307
*line 308
L75:
*line 309
add #1,R7
L74:
*line 310
move.l 8(R14),R8
move.l (R8),R13
move.l R13,R0
add.l #4,8(R14)
tst.l R0
bne L73
L72:
*line 312
clr R0
move R0,_QQsw
bra L67
L67:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _CMulist
.text
_CMulist:
~~CMulist:
~l=-4
~l=8
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~n=R7
~p=R13
~q=R12
*line 332
*line 332
tst _QQanch
bne L80
*line 332
bra L83
L82:
*line 332
add.l #1,_QQip
L83:
*line 332
move.l _QQip,R8
cmp.b #32,(R8)
beq L82
L81:
*line 333
L80:
*line 334
clr R7
*line 336
bra L86
L85:
*line 337
*line 338
move.l R13,R12
*line 339
*line 340
*line 340
move.l R13,(sp)
jsr _CMustr
tst R0
beq L87
*line 341
*line 342
move.l #_QQstr,_QQop
*line 343
*line 344
bra L90
L89:L90:
*line 344
move.b (R12)+,R0
ext.w R0
move.l _QQop,R9
move.b R0,(R9)
add.l #1,_QQop
tst R0
bne L89
L88:
*line 345
*line 346
move R7,_QQlnum
*line 347
move #1,R0
move R0,_QQsw
bra L79
*line 348
*line 349
L87:
*line 350
add #1,R7
L86:
*line 351
move.l 8(R14),R8
move.l (R8),R13
move.l R13,R0
add.l #4,8(R14)
tst.l R0
bne L85
L84:
*line 353
clr R0
move R0,_QQsw
bra L79
L79:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _CMstat
.text
_CMstat:
~~CMstat:
~msg=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~tp=R13
*line 371
move.l _QQin,R13
*line 372
move.l 8(R14),(sp)
move.l #L92,-(sp)
jsr _printf
addq.l #4,sp
*line 373
*line 374
*line 375
*line 376
move.b _QQdig,R0
ext.w R0
move R0,(sp) 
move.b _QQchr,R0
ext.w R0
and #-128,R0
bne L10000
move.b _QQchr,R0
ext.w R0
move R0,R8
move.l #___atab,R9
move.b 0(R8,R9.l),R0
ext.w R0
and #94,R0
beq L10001
move.b _QQchr,R0
ext.w R0
move R0,-(sp) 
bra L10003
L10001:move #32,-(sp)
L10003:bra L10005
L10000:move #32,-(sp)
L10005:move.b _QQchr,R0
ext.w R0
move R0,-(sp) 
tst _QQanch
beq L10006
move.l #L96,-(sp)
bra L10008
L10006:move.l #L97,-(sp)
L10008:tst _QQsw
beq L10009
move.l #L94,-(sp)
bra L10011
L10009:move.l #L95,-(sp)
L10011:move.l #L93,-(sp)
jsr _printf
adda.l #16,sp
*line 377
move _QQlnum,(sp)
move.l _QQnum,-(sp)
move.l #L98,-(sp)
jsr _printf
addq.l #8,sp
*line 378
move.l #_QQstr,(sp)
move.l #L99,-(sp)
jsr _printf
addq.l #4,sp
*line 379
move.l _QQin,(sp)
move.l #L100,-(sp)
jsr _printf
addq.l #4,sp
*line 380
move.l #L101,(sp)
jsr _printf
*line 382
bra L104
L103:
*line 383
move.l #L105,(sp)
jsr _printf
L104:
*line 383
cmp.l _QQip,R13
move sr,R0
add.l #1,R13
move R0,ccr
bne L103
L102:
*line 385
move.l #L106,(sp)
jsr _printf
*line 386
move _QQsw,R0
bra L91
L91:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
L92:.dc.b $25,$73,$D,$A,$0
L93:.dc.b $20,$20,$51,$51,$73,$77,$3A,$20,$25,$73,$2C,$20,$51,$51,$61,$6E,$63,$68,$3A,$20,$25,$73,$2C,$20,$51,$51,$63,$68,$72,$3A
.dc.b $20,$30,$78,$25,$30,$32,$78,$20,$3C,$25,$63,$3E,$2C,$20,$51,$51,$64,$69,$67,$3A,$20,$25,$63,$D,$A,$0
L94:.dc.b $4F,$4B,$0
L95:.dc.b $4E,$4F,$47,$4F,$0
L96:.dc.b $61,$6E,$63,$68,$6F,$72,$65,$64,$0
L97:.dc.b $64,$65,$62,$6C,$61,$6E,$6B,$65,$64,$0
L98:.dc.b $20,$20,$51,$51,$6E,$75,$6D,$3A,$20,$25,$6C,$64,$2C,$20,$51,$51,$6C,$6E,$75,$6D,$3A,$20,$25,$64,$D,$A,$0
L99:.dc.b $20,$20,$51,$51,$73,$74,$72,$3A,$20,$25,$73,$D,$A,$0
L100:.dc.b $20,$20,$7B,$25,$73,$7D,$D,$A,$0
L101:.dc.b $20,$20,$20,$0
L105:.dc.b $20,$0
L106:.dc.b $5E,$D,$A,$0
