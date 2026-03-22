.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _stcrow
.globl _stccol
.globl _curvce
.globl _curpnt
.globl _curfunc
.globl _debugsw
.globl _idbox
.globl _instob
.globl _dspbuf
.globl _vbufs
.globl _aform
.globl _et_iact
.text
_et_iact:
~~et_iact:
~nn=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~pp=R13
*line 56
move _curvce,R0
muls #3938,R0
move.l R0,R13
move _curpnt,R0
muls #12,R0
add.l R0,R13
add.l #_vbufs,R13
add.l #242,R13
*line 58
move.b 7(R13),R0
ext.w R0
move R0,_aform
*line 60
move _aform,R0
bra L3
*line 61
L4:
*line 62
L5:
*line 63
L6:
*line 64
L7:
*line 65
*line 66
*line 67
clr.b _ebuf
bra L2
*line 68
*line 69
L8:
*line 70
L9:
*line 71
L10:
*line 72
*line 73
*line 74
move.b 8(R13),R0
ext.w R0
move R0,(sp) 
move.l #L11,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
bra L2
*line 75
*line 76
L12:
*line 77
*line 78
*line 79
move.b 9(R13),R0
ext.w R0
move R0,(sp) 
move.b 8(R13),R0
ext.w R0
move R0,-(sp) 
move.l #L13,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
bra L2
*line 80
bra L2
L3:cmp #7,R0
bhi L2
asl #2,R0
move R0,R8
add.l #L14,R8
move.l (R8),R8
jmp (R8)
.data
L14:.dc.l L4
.dc.l L5
.dc.l L6
.dc.l L8
.dc.l L12
.dc.l L9
.dc.l L10
.dc.l L7
.text
L2:
*line 88
move #1,_ebflag
*line 89
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _ef_iact
.text
_ef_iact:
~~ef_iact:
~nn=8
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~i=R7
~tmp1=R6
~tmp2=R5
~pp=R13
~fp=R12
*line 109
move _curvce,R0
muls #3938,R0
move.l R0,R12
move _curfunc,R0
muls #12,R0
add.l R0,R12
add.l #_vbufs,R12
add.l #86,R12
*line 110
move _curvce,R0
muls #3938,R0
move.l R0,R13
move _curpnt,R0
muls #12,R0
add.l R0,R13
add.l #_vbufs,R13
add.l #242,R13
*line 111
clr _ebflag
*line 119
move _aform,R0
bra L17
*line 120
L18:
*line 121
L19:
*line 122
*line 123
*line 124
clr _aform
*line 125
L20:
*line 126
L21:
*line 127
*line 128
*line 129
move _aform,R0
move.b R0,7(R13)
*line 130
*line 135
*line 136
*line 137
jsr _modinst
*line 138
clr R0
bra L15
*line 139
L22:
*line 140
L23:
*line 141
L24:
*line 142
*line 143
*line 144
clr R6
*line 145
*line 146
clr R7
bra L27
L28:
*line 147
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L26:
*line 146
add #1,R7
L27:
*line 146
cmp #2,R7
blt L28
L25:
*line 147
*line 148
*line 149
*line 150
move.b 5(R12),R0
ext.w R0
cmp R0,R6
blt L29
*line 150
move #-1,R0
bra L15
*line 151
L29:
*line 152
move _aform,R0
move.b R0,7(R13)
*line 153
move.b R6,8(R13)
*line 154
clr.b 9(R13)
*line 155
clr.b 10(R13)
*line 156
*line 161
*line 162
*line 163
jsr _modinst
*line 164
clr R0
bra L15
*line 165
*line 166
L30:
*line 167
*line 168
*line 169
clr R6
*line 170
*line 171
clr R7
bra L33
L34:
*line 172
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L32:
*line 171
add #1,R7
L33:
*line 171
cmp #2,R7
blt L34
L31:
*line 172
*line 173
*line 174
*line 175
move.b 5(R12),R0
ext.w R0
cmp R0,R6
blt L35
*line 175
move #-1,R0
bra L15
*line 176
L35:
*line 177
clr R5
*line 178
*line 179
move #3,R7
bra L38
L39:
*line 180
muls #10,R5
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R5
add #-48,R5
L37:
*line 179
add #1,R7
L38:
*line 179
cmp #5,R7
blt L39
L36:
*line 180
*line 181
*line 182
move _aform,R0
move.b R0,7(R13)
*line 183
move.b R6,8(R13)
*line 184
move.b R5,9(R13)
*line 185
clr.b 10(R13)
*line 186
*line 191
*line 192
*line 193
jsr _modinst
*line 194
clr R0
bra L15
bra L16
L17:cmp #7,R0
bhi L16
asl #2,R0
move R0,R8
add.l #L40,R8
move.l (R8),R8
jmp (R8)
.data
L40:.dc.l L18
.dc.l L20
.dc.l L21
.dc.l L22
.dc.l L30
.dc.l L23
.dc.l L24
.dc.l L19
.text
L16:L15:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _rd_iact
.text
_rd_iact:
~~rd_iact:
~nn=8
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~pnt=R7
~par=R6
~n=R5
~pp=R13
~s1=R12
*line 215
move 8(R14),R5
and #255,R5
*line 216
move _curvce,R0
muls #3938,R0
move.l R0,R13
move _curpnt,R0
muls #12,R0
add.l R0,R13
add.l #_vbufs,R13
add.l #242,R13
*line 217
move.b 8(R13),R7
ext.w R7
*line 218
move.b 9(R13),R6
ext.w R6
*line 219
move.b 7(R13),R0
ext.w R0
move R0,_aform
*line 227
move _aform,R0
bra L43
*line 228
L44:
*line 229
*line 230
*line 231
move.l #L45,R12
bra L42
*line 232
*line 233
L46:
*line 234
*line 235
*line 236
move #170,(sp)
move.l #L47,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 237
move.l #_dspbuf,R12
bra L42
*line 238
*line 239
L48:
*line 240
*line 241
*line 242
move #171,(sp)
move.l #L49,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 243
move.l #_dspbuf,R12
bra L42
*line 244
*line 245
L50:
*line 246
*line 247
*line 248
move R7,(sp)
move.l #L51,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 249
move.l #_dspbuf,R12
bra L42
*line 250
*line 251
*line 252
*line 253
L52:
*line 254
*line 255
*line 256
move R6,(sp)
move R7,-(sp)
move.l #L53,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 257
*line 258
*line 259
cmp.b #57,8+_dspbuf
bne L54
*line 259
move.b #82,8+_dspbuf
*line 260
L54:
*line 261
move.l #_dspbuf,R12
bra L42
*line 262
*line 263
L55:
*line 264
*line 265
*line 266
move #171,(sp)
move R7,-(sp)
move.l #L56,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 267
move.l #_dspbuf,R12
bra L42
*line 268
*line 269
L57:
*line 270
*line 271
*line 272
move #170,(sp)
move R7,-(sp)
move.l #L58,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 273
move.l #_dspbuf,R12
bra L42
*line 274
*line 275
L59:
*line 276
*line 277
*line 278
move.l #L60,R12
bra L42
*line 279
bra L42
L43:cmp #6,R0
bhi L59
asl #2,R0
move R0,R8
add.l #L61,R8
move.l (R8),R8
jmp (R8)
.data
L61:.dc.l L44
.dc.l L46
.dc.l L48
.dc.l L50
.dc.l L52
.dc.l L55
.dc.l L57
.text
L42:
*line 282
clr (sp)
jsr _vbank
*line 283
*line 284
move #14,(sp)
move.l R12,-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
L41:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _setactb
.text
_setactb:
~~setactb:
~n=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~s1=R13
*line 301
move _aform,R0
bra L64
*line 302
L65:
*line 303
*line 304
*line 305
move.l #L66,R13
*line 306
clr.b _ebuf
bra L63
*line 307
*line 308
L67:
*line 309
*line 310
*line 311
move #170,(sp)
move.l #L68,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 312
move.l #_dspbuf,R13
*line 313
clr.b _ebuf
bra L63
*line 314
*line 315
L69:
*line 316
*line 317
*line 318
move #171,(sp)
move.l #L70,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 319
move.l #_dspbuf,R13
*line 320
clr.b _ebuf
bra L63
*line 321
*line 322
L71:
*line 323
*line 324
*line 325
move.l #L72,R13
*line 326
move.b #48,_ebuf
*line 327
move.b #48,1+_ebuf
*line 328
clr.b 2+_ebuf
bra L63
*line 329
*line 330
*line 331
*line 332
L73:
*line 333
*line 334
*line 335
move.l #L74,R13
*line 336
move.b #48,_ebuf
*line 337
move.b #48,1+_ebuf
*line 338
move.b #32,2+_ebuf
*line 339
move.b #48,3+_ebuf
*line 340
move.b #48,4+_ebuf
*line 341
clr.b 5+_ebuf
bra L63
*line 342
*line 343
L75:
*line 344
*line 345
*line 346
move #171,(sp)
move.l #L76,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 347
move.l #_dspbuf,R13
*line 348
move.b #48,_ebuf
*line 349
move.b #48,1+_ebuf
*line 350
clr.b 2+_ebuf
bra L63
*line 351
*line 352
L77:
*line 353
*line 354
*line 355
move #170,(sp)
move.l #L78,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 356
move.l #_dspbuf,R13
*line 357
move.b #48,_ebuf
*line 358
move.b #48,1+_ebuf
*line 359
clr.b 2+_ebuf
bra L63
*line 360
*line 361
L79:
*line 362
*line 363
*line 364
move.l #L80,R13
*line 365
clr.b _ebuf
bra L63
*line 366
bra L63
L64:cmp #6,R0
bhi L79
asl #2,R0
move R0,R8
add.l #L81,R8
move.l (R8),R8
jmp (R8)
.data
L81:.dc.l L65
.dc.l L67
.dc.l L69
.dc.l L71
.dc.l L73
.dc.l L75
.dc.l L77
.text
L63:
*line 369
clr (sp)
jsr _vbank
*line 370
*line 371
move #14,(sp)
move.l R13,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
L62:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _nd_iact
.text
_nd_iact:
~~nd_iact:
~nn=8
~k=10
link R14,#0
movem.l R5-R7,-(sp)
~n=R7
~ec=R6
*line 389
move 8(R14),R7
and #255,R7
*line 391
*line 391
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #5,R0
cmp _stccol,R0
ble L83
*line 392
*line 393
*line 393
cmp #8,10(R14)
bne L84
*line 394
*line 395
*line 396
sub #1,_aform
bge L85
*line 396
move #6,_aform
*line 397
L85:
*line 398
move R7,(sp)
jsr _setactb
*line 399
clr R0
bra L82
*line 400
bra L86
L84:
*line 401
*line 401
cmp #9,10(R14)
bne L87
*line 402
*line 403
*line 404
add #1,_aform
move _aform,R0
cmp #6,R0
ble L88
*line 404
clr _aform
*line 405
L88:
*line 406
move R7,(sp)
jsr _setactb
*line 407
clr R0
bra L82
*line 408
*line 409
L87:L86:
*line 410
move #-1,R0
bra L82
*line 411
*line 412
*line 413
bra L89
L83:
*line 414
*line 415
*line 416
move _aform,R0
bra L91
*line 417
L92:
*line 418
L93:
*line 419
L94:
*line 420
L95:
*line 421
*line 422
*line 423
move #-1,R0
bra L82
*line 424
L96:
*line 425
L97:
*line 426
L98:
*line 427
*line 428
*line 429
*line 430
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #5,R0
cmp _stccol,R0
beq L10000
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #6,R0
cmp _stccol,R0
bne L99
L10000:*line 431
*line 432
move 10(R14),R0
add #48,R0
move _stccol,R9
move R7,R2
asl #4,R2
ext.l R2
add.l #_idbox,R2
move.l R2,R10
move 14(R10),R10
add #5,R10
sub R10,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 433
move 10(R14),R0
add #48,R0
move.b R0,_dspbuf
*line 434
clr.b 1+_dspbuf
*line 435
*line 436
clr (sp)
jsr _vbank
*line 437
*line 438
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 439
*line 440
jsr _advicur
*line 441
clr R0
bra L82
*line 442
bra L100
L99:
*line 443
*line 444
*line 445
move #-1,R0
bra L82
L100:
*line 446
*line 447
*line 448
L101:
*line 449
*line 450
*line 451
*line 452
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #5,R0
cmp _stccol,R0
bgt L102
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #9,R0
cmp _stccol,R0
blt L102
*line 453
*line 454
move _stccol,R6
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),R0
add #5,R0
sub R0,R6
*line 455
*line 456
*line 457
cmp #2,R6
bne L103
*line 457
move #-1,R0
bra L82
*line 458
L103:
*line 459
move 10(R14),R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 460
move 10(R14),R0
add #48,R0
move.b R0,_dspbuf
*line 461
clr.b 1+_dspbuf
*line 462
*line 463
*line 464
cmp #3,R6
bne L104
cmp #9,10(R14)
bne L104
*line 464
move.b #82,_dspbuf
*line 465
L104:
*line 466
clr (sp)
jsr _vbank
*line 467
*line 468
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 469
*line 470
jsr _advicur
*line 471
*line 472
*line 473
cmp #1,R6
bne L105
*line 473
jsr _advicur
*line 474
L105:
*line 475
clr R0
bra L82
*line 476
bra L106
L102:
*line 477
*line 478
*line 479
move #-1,R0
bra L82
L106:
*line 480
bra L90
L91:cmp #7,R0
bhi L90
asl #2,R0
move R0,R8
add.l #L107,R8
move.l (R8),R8
jmp (R8)
.data
L107:.dc.l L92
.dc.l L95
.dc.l L94
.dc.l L98
.dc.l L101
.dc.l L96
.dc.l L97
.dc.l L93
.text
L90:
*line 481
L89:L82:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L11:.dc.b $25,$30,$32,$64,$0
L13:.dc.b $25,$30,$32,$64,$20,$25,$30,$32,$64,$0
L45:.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0
L47:.dc.b $50,$61,$75,$73,$65,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$20,$20,$0
L49:.dc.b $53,$74,$6F,$70,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$20,$20,$20,$0
L51:.dc.b $47,$6F,$54,$6F,$20,$25,$30,$32,$64,$20,$66,$6F,$72,$65,$76,$65,$72,$20,$0
L53:.dc.b $47,$6F,$54,$6F,$20,$25,$30,$32,$64,$20,$25,$30,$32,$64,$20,$74,$69,$6D,$65,$73,$0
L56:.dc.b $47,$6F,$54,$6F,$20,$25,$30,$32,$64,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$0
L58:.dc.b $47,$6F,$54,$6F,$20,$25,$30,$32,$64,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$0
L60:.dc.b $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$0
L66:.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0
L68:.dc.b $50,$61,$75,$73,$65,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$20,$20,$0
L70:.dc.b $53,$74,$6F,$70,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$20,$20,$20,$0
L72:.dc.b $47,$6F,$54,$6F,$20,$30,$30,$20,$66,$6F,$72,$65,$76,$65,$72,$20,$0
L74:.dc.b $47,$6F,$54,$6F,$20,$30,$30,$20,$30,$30,$20,$74,$69,$6D,$65,$73,$0
L76:.dc.b $47,$6F,$54,$6F,$20,$30,$30,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$0
L78:.dc.b $47,$6F,$54,$6F,$20,$30,$30,$20,$69,$66,$20,$6B,$65,$79,$20,$25,$63,$0
L80:.dc.b $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$0
