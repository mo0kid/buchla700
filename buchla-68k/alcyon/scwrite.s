.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _io_time
.globl _io_lcd
.globl _io_ser
.globl _io_midi
.globl _io_disk
.globl _io_tone
.globl _io_leds
.globl _io_kbrd
.globl _lcd_a0
.globl _lcd_a1
.globl _io_vreg
.globl _io_vraw
.globl _io_vram
.globl _io_fpu
.globl _v_regs
.globl _v_odtab
.globl _v_actab
.globl _v_ct0
.globl _v_gt1
.globl _v_score
.globl _v_cgtab
.globl _v_curs0
.globl _v_curs1
.globl _v_curs2
.globl _v_curs3
.globl _v_curs4
.globl _v_curs5
.globl _v_curs6
.globl _v_curs7
.globl _v_tcur
.globl _v_kbobj
.globl _v_lnobj
.globl _v_win0
.globl _v_cur
.globl _fc_sw
.globl _fc_val
.globl _ac_code
.globl _scname
.globl _se_chg
.globl _curscor
.globl _cursect
.globl _se1_cnt
.globl _se2_cnt
.globl _se3_cnt
.globl _spool
.globl _pspool
.globl _spcount
.globl _frags
.globl _t_bak
.globl _t_cur
.globl _t_ctr
.globl _t_fwd
.globl _size1
.globl _size2
.globl _size3
.globl _scores
.globl _scp
.globl _seclist
.globl _hplist
.globl _p_bak
.globl _p_cur
.globl _p_ctr
.globl _p_fwd
.globl _filecat
.globl _schksum
.globl _snbreq
.globl _snlreq
.globl _sntbreq
.globl _sntlreq
.globl _nlpersc
.globl _scsums
.globl _stimes
.globl _m1con
.data
_m1con:
.dc.l $FFFFFFFF
.globl _scsizes
.data
_scsizes:
.dc.w $14
.dc.w $0
.dc.w $14
.dc.w $6
.dc.w $18
.dc.w $6
.dc.w $18
.dc.w $6
.dc.w $18
.dc.w $7
.dc.w $14
.dc.w $9
.dc.w $14
.dc.w $9
.dc.w $14
.dc.w $5
.dc.w $14
.dc.w $7
.dc.w $18
.dc.w $6
.dc.w $18
.dc.w $6
.dc.w $18
.dc.w $7
.dc.w $18
.dc.w $7
.dc.w $18
.dc.w $7
.dc.w $18
.dc.w $8
.dc.w $18
.dc.w $7
.dc.w $18
.dc.w $6
.dc.w $20
.dc.w $8
.dc.w $14
.dc.w $6
.dc.w $14
.dc.w $6
.dc.w $14
.dc.w $7
.dc.w $14
.dc.w $6
.dc.w $14
.dc.w $7
.dc.w $14
.dc.w $5
.dc.w $14
.dc.w $5
.globl _scsize
.text
_scsize:
~~scsize:
~sn=8
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~nb=R7
~nl=R6
~sc=R5
~ep=R13
~go=R4
*line 91
clr.l R7
move.l R7,_snbreq
*line 92
clr.l R6
move.l R6,_snlreq
*line 93
clr.l R5
move.l R5,_schksum
*line 95
move 8(R14),R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l (R8),R13
*line 97
*line 97
move.l R13,R0
bne L2
*line 98
*line 102
*line 103
clr.l R0
bra L1
*line 104
*line 105
L2:
*line 106
move #1,R4
*line 110
L5:
*line 111
and.b #127,5(R13)
*line 112
*line 113
move.b 5(R13),R0
ext.w R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_scsizes,R9
move 0(R8,R9.l),R0
ext.l R0
add.l R0,R6
*line 114
move.b 5(R13),R0
ext.w R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_scsizes,R9
move 2(R8,R9.l),R0
ext.l R0
add.l R0,R7
*line 115
*line 116
move.b 5(R13),R0
ext.w R0
bra L7
*line 117
L8:
*line 118
L9:
*line 119
L10:
*line 120
*line 121
*line 122
move.b 5(R13),R0
ext.w R0
ext.l R0
add.l (R13),R0
add.l R0,R5
bra L6
*line 123
*line 124
L11:
*line 125
L12:
*line 126
L13:
*line 127
L14:
*line 128
L15:
*line 129
L16:
*line 130
L17:
*line 131
L18:
*line 132
*line 133
*line 134
move.b 5(R13),R0
ext.w R0
ext.l R0
move.b 6(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
add.l (R13),R0
add.l R0,R5
bra L6
*line 135
*line 136
L19:
*line 137
L20:
*line 138
*line 139
*line 140
*line 141
move.l #18,-(sp)
move.b 5(R13),R0
ext.w R0
ext.l R0
move.b 6(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
move.b 7(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
add.l (R13),R0
move.l R0,-(sp)
jsr lmul
addq.l #8,sp
move 16(R13),R1
ext.l R1
add.l R1,R0
add.l R0,R5
*line 142
bra L6
*line 143
*line 144
*line 145
L21:
*line 146
L22:
*line 147
L23:
*line 148
L24:
*line 149
L25:
*line 150
L26:
*line 151
L27:
*line 152
L28:
*line 153
*line 154
*line 155
*line 156
move.b 5(R13),R0
ext.w R0
ext.l R0
move.b 6(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
move.b 7(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
add.l (R13),R0
add.l R0,R5
*line 157
bra L6
*line 158
*line 159
L29:
*line 160
*line 161
*line 162
*line 163
move.b 5(R13),R0
ext.w R0
ext.l R0
move.b 6(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
add.l 24(R13),R0
add.l (R13),R0
add.l R0,R5
*line 164
bra L6
*line 165
*line 166
L30:
*line 167
*line 168
*line 169
*line 170
move.b 5(R13),R0
ext.w R0
ext.l R0
move.b 6(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
move.l 16(R13),R1
move.l #$10,R2
asr.l R2,R1
and.l #$ffff,R1
add.l R1,R0
add.l (R13),R0
add.l R0,R5
*line 171
bra L6
*line 172
*line 173
L31:
*line 174
*line 175
*line 176
move.b 5(R13),R0
ext.w R0
ext.l R0
move.b 6(R13),R1
ext.w R1
ext.l R1
add.l R1,R0
add.l (R13),R0
add.l R0,R5
*line 177
clr R4
bra L6
*line 178
bra L6
L7:sub #1,R0
cmp #23,R0
bhi L6
asl #2,R0
move R0,R8
add.l #L32,R8
move.l (R8),R8
jmp (R8)
.data
L32:.dc.l L11
.dc.l L12
.dc.l L13
.dc.l L21
.dc.l L19
.dc.l L20
.dc.l L9
.dc.l L22
.dc.l L14
.dc.l L15
.dc.l L23
.dc.l L24
.dc.l L25
.dc.l L30
.dc.l L28
.dc.l L16
.dc.l L29
.dc.l L17
.dc.l L18
.dc.l L26
.dc.l L31
.dc.l L27
.dc.l L8
.dc.l L10
.text
L6:
*line 179
*line 180
*line 181
move.l 12(R13),R13
*line 182
L4:
*line 183
tst R4
bne L5
L3:
*line 185
move.l R5,_schksum
*line 186
move.l R7,_snbreq
*line 187
move.l R6,R0
add.l #$3,R0
asr.l #$2,R0
move.l R0,_snlreq
*line 194
move.l R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _scsizer
.text
_scsizer:
~~scsizer:
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~nb=R6
*line 212
clr.l _sntlreq
*line 213
clr.l R6
*line 215
clr R7
bra L36
L37:
*line 216
*line 217
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_nlpersc,R8
move.l #$0,(R8)
*line 218
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scsums,R8
move.l #$0,(R8)
*line 219
*line 220
add.l #$4,R6
*line 221
*line 222
*line 222
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
tst.l (R8)
beq L38
*line 223
*line 224
*line 225
*line 226
*line 227
move R7,(sp)
jsr _scsize
add.l #$100,R0
add.l R0,R6
*line 228
*line 229
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_nlpersc,R8
move.l _snlreq,(R8)
*line 230
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scsums,R8
move.l _schksum,(R8)
*line 231
move.l _snlreq,R0
add.l R0,_sntlreq
*line 232
L38:L35:
*line 215
add #1,R7
L36:
*line 215
cmp #20,R7
blt L37
L34:
*line 235
add.l #$4,R6
*line 242
move.l R6,_sntbreq
*line 244
move.l R6,R0
bra L33
L33:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _scwrite
.text
_scwrite:
~~scwrite:
~fp=R13
~sn=8
link R14,#-48
movem.l R6-R7/R12-R13,-(sp)
~ep=R12
~go=R7
~scid=-48
*line 265
move.l 10(R14),R13
*line 265
move 8(R14),R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l (R8),R12
*line 272
*line 272
move.l R12,R0
bne L40
*line 273
*line 274
move 8(R14),(sp)
add #1,(sp)
move.l #L41,-(sp)
move.l R14,-(sp)
add.l #-48,(sp)
jsr _sprintf
addq.l #8,sp
*line 275
*line 276
move #9,(sp)
move #12,-(sp)
clr.l -(sp)
move.l R14,-(sp)
add.l #-48,(sp)
clr.l -(sp)
jsr _ldwmsg
adda.l #14,sp
*line 277
*line 278
*line 279
move.l #$4,(sp)
move.l #_m1con,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L42
*line 279
move #-1,R0
bra L39
*line 280
bra L43
L42:
*line 281
clr R0
bra L39
L43:
*line 282
*line 283
L40:
*line 284
move 8(R14),(sp)
add #1,(sp)
move.l #L44,-(sp)
move.l R14,-(sp)
add.l #-48,(sp)
jsr _sprintf
addq.l #8,sp
*line 286
*line 287
move #9,(sp)
move #12,-(sp)
move.l R14,-(sp)
add.l #-48,(sp)
clr.l -(sp)
move.l #L45,-(sp)
jsr _ldwmsg
adda.l #14,sp
*line 289
*line 290
move.l #$4,(sp)
move 8(R14),R0
asl #2,R0
ext.l R0
add.l #_nlpersc,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L46
*line 290
move #-1,R0
bra L39
*line 291
L46:
*line 292
*line 293
move.l #$10,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
add.l #_scname,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L47
*line 293
move #-1,R0
bra L39
*line 294
L47:
*line 295
*line 296
move.l #$f0,(sp)
move 8(R14),R0
muls #240,R0
add.l #_stimes,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L48
*line 296
move #-1,R0
bra L39
*line 297
L48:
*line 298
move #1,R7
*line 300
L51:
*line 301
*line 302
move.b 5(R12),R0
ext.w R0
bra L53
*line 303
L54:
*line 304
L55:
*line 305
L56:
*line 306
*line 307
*line 308
*line 309
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L57
*line 309
move #-1,R0
bra L39
*line 310
L57:
*line 311
*line 312
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L58
*line 312
move #-1,R0
bra L39
*line 313
L58:bra L52
*line 314
*line 315
L59:
*line 316
L60:
*line 317
L61:
*line 318
L62:
*line 319
L63:
*line 320
L64:
*line 321
L65:
*line 322
L66:
*line 323
*line 324
*line 325
*line 326
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L67
*line 326
move #-1,R0
bra L39
*line 327
L67:
*line 328
*line 329
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L68
*line 329
move #-1,R0
bra L39
*line 330
L68:
*line 331
*line 332
move.l #$1,(sp)
move.l R12,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L69
*line 332
move #-1,R0
bra L39
*line 333
L69:bra L52
*line 334
*line 335
*line 336
L70:
*line 337
L71:
*line 338
L72:
*line 339
L73:
*line 340
L74:
*line 341
L75:
*line 342
L76:
*line 343
L77:
*line 344
*line 345
*line 346
*line 347
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L78
*line 347
move #-1,R0
bra L39
*line 348
L78:
*line 349
*line 350
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L79
*line 350
move #-1,R0
bra L39
*line 351
L79:
*line 352
*line 353
move.l #$1,(sp)
move.l R12,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L80
*line 353
move #-1,R0
bra L39
*line 354
L80:
*line 355
*line 356
move.l #$1,(sp)
move.l R12,-(sp)
add.l #7,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L81
*line 356
move #-1,R0
bra L39
*line 357
L81:bra L52
*line 358
*line 359
*line 360
L82:
*line 361
L83:
*line 362
*line 363
*line 364
*line 365
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L84
*line 365
move #-1,R0
bra L39
*line 366
L84:
*line 367
*line 368
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L85
*line 368
move #-1,R0
bra L39
*line 369
L85:
*line 370
*line 371
move.l #$1,(sp)
move.l R12,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L86
*line 371
move #-1,R0
bra L39
*line 372
L86:
*line 373
*line 374
move.l #$1,(sp)
move.l R12,-(sp)
add.l #7,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L87
*line 374
move #-1,R0
bra L39
*line 375
L87:
*line 376
*line 377
move.l #$2,(sp)
move.l R12,-(sp)
add.l #16,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L88
*line 377
move #-1,R0
bra L39
*line 378
L88:bra L52
*line 379
*line 380
L89:
*line 381
*line 382
*line 383
*line 384
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L90
*line 384
move #-1,R0
bra L39
*line 385
L90:
*line 386
*line 387
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L91
*line 387
move #-1,R0
bra L39
*line 388
L91:
*line 389
*line 390
move.l #$1,(sp)
move.l R12,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L92
*line 390
move #-1,R0
bra L39
*line 391
L92:
*line 392
*line 393
move.l #$2,(sp)
move.l R12,-(sp)
add.l #24,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L93
*line 393
move #-1,R0
bra L39
*line 394
L93:bra L52
*line 395
*line 396
*line 397
L94:
*line 398
*line 399
*line 400
*line 401
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L95
*line 401
move #-1,R0
bra L39
*line 402
L95:
*line 403
*line 404
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L96
*line 404
move #-1,R0
bra L39
*line 405
L96:
*line 406
*line 407
move.l #$1,(sp)
move.l R12,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L97
*line 407
move #-1,R0
bra L39
*line 408
L97:
*line 409
*line 410
move.l #$2,(sp)
move.l R12,-(sp)
add.l #16,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L98
*line 410
move #-1,R0
bra L39
*line 411
L98:bra L52
*line 412
*line 413
L99:
*line 414
*line 415
*line 416
*line 417
move.l #$1,(sp)
move.l R12,-(sp)
add.l #5,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L100
*line 417
move #-1,R0
bra L39
*line 418
L100:
*line 419
*line 420
move.l #$4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L101
*line 420
clr R0
bra L39
*line 421
L101:
*line 422
*line 423
move.l #$1,(sp)
move.l R12,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L102
*line 423
move #-1,R0
bra L39
*line 424
L102:
*line 425
clr R7
*line 426
*line 430
bra L52
*line 431
*line 432
bra L52
L53:sub #1,R0
cmp #23,R0
bhi L52
asl #2,R0
move R0,R8
add.l #L103,R8
move.l (R8),R8
jmp (R8)
.data
L103:.dc.l L59
.dc.l L60
.dc.l L61
.dc.l L70
.dc.l L82
.dc.l L83
.dc.l L55
.dc.l L71
.dc.l L62
.dc.l L63
.dc.l L72
.dc.l L73
.dc.l L74
.dc.l L94
.dc.l L77
.dc.l L64
.dc.l L89
.dc.l L65
.dc.l L66
.dc.l L75
.dc.l L99
.dc.l L76
.dc.l L54
.dc.l L56
.text
L52:
*line 433
*line 434
*line 435
move.l 12(R12),R12
*line 436
L50:
*line 437
tst R7
bne L51
L49:
*line 444
clr R0
bra L39
L39:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
L41:.dc.b $73,$63,$6F,$72,$65,$20,$25,$64,$20,$77,$61,$73,$20,$65,$6D,$70,$74,$79,$0
L44:.dc.b $20,$20,$77,$72,$69,$74,$69,$6E,$67,$20,$73,$63,$6F,$72,$65,$20,$25,$64,$0
L45:.dc.b $42,$75,$73,$79,$20,$2D,$2D,$20,$50,$6C,$65,$61,$73,$65,$20,$73,$74,$61,$6E,$64,$20,$62,$79,$0
