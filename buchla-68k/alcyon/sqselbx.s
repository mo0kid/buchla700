.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _stmptr
.globl _defptr
.globl _patches
.globl _defents
.globl _seqtab
.globl _seqflag
.globl _seqline
.globl _seqstim
.globl _seqtime
.globl _sregval
.globl _trstate
.globl _cmtype
.globl _curslin
.globl _stccol
.globl _stcrow
.globl _submenu
.globl _vtccol
.globl _vtcrow
.globl _actlft
.globl _sqatype
.globl _obj11
.globl _seqtab
.globl _action
.comm _action,2
.globl _sqdeflg
.comm _sqdeflg,2
.globl _sqmenu
.comm _sqmenu,2
.globl _sqdebuf
.comm _sqdebuf,50
.globl _seqbuf
.comm _seqbuf,14
.globl _sqhilit
.data
_sqhilit:
.dc.b $2
.dc.b $D
.dc.b $5
.dc.b $5
.dc.b $5
.dc.b $1
.dc.b $0
.dc.b $0
.dc.b $11
.dc.b $B
.dc.b $5
.dc.b $5
.dc.b $5
.dc.b $1
.dc.b $0
.dc.b $0
.dc.b $1E
.dc.b $B
.dc.b $5
.dc.b $5
.dc.b $0
.dc.b $1
.dc.b $0
.dc.b $0
.dc.b $2B
.dc.b $8
.dc.b $5
.dc.b $5
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $0
.dc.b $35
.dc.b $8
.dc.b $2
.dc.b $2
.dc.b $2
.dc.b $2
.dc.b $0
.dc.b $0
.globl _sqboxes
.data
_sqboxes:
.dc.w $8
.dc.w $7E
.dc.w $17F
.dc.w $8B
.dc.w $0
*line 70
.dc.l _sqfnbox
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.l $0
.globl _sqopreq
.data
_sqopreq:
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.even
.globl _nextact
.data
_nextact:
.dc.b $18
.dc.b $24
.dc.b $6
.even
.globl _sqidata
.data
_sqidata:
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $100
.dc.w $100
.dc.w $100
.dc.w $100
.dc.w $100
.globl _actcol
.data
_actcol:
.dc.b $0
.dc.b $3
.dc.b $3
.dc.b $3
.dc.b $3
.dc.b $9
.dc.b $9
.dc.b $9
.dc.b $9
.dc.b $5
.dc.b $5
.dc.b $5
.dc.b $5
.dc.b $A
.dc.b $8
.dc.b $3
.dc.b $5
.even
.globl _sqvcol
.data
_sqvcol:
.dc.b $9
.dc.b $8
.dc.b $9
.dc.b $9
.globl _seqvcol
.data
_seqvcol:
.dc.b $8
.dc.b $8
.dc.b $9
.dc.b $9
.dc.b $9
.even
.globl _sqndata
.data
_sqndata:
.dc.w $100
.dc.w $0
.dc.w $200
.dc.w $300
.globl _hilitsq
.text
_hilitsq:
~~hilitsq:
~n=R7
link R14,#0
movem.l R2-R7,-(sp)
~chr=R6
~h=R5
~v=R4
~w=R3
*line 138
move.b 9(R14),R7
*line 138
move.b R7,R0
ext.w R0
move R0,_sqmenu
*line 140
clr R5
bra L4
L5:
*line 141
*line 142
clr R4
bra L8
L9:
*line 143
*line 144
move R5,R0
asl #3,R0
ext.l R0
move.l R0,R8
move.l #_sqhilit,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R6
*line 145
*line 146
move R5,R0
asl #3,R0
ext.l R0
move.l R0,R8
move.l #_sqhilit,R9
move.b 1(R8,R9.l),R0
ext.w R0
move R0,R3
bra L12
L13:
*line 147
*line 148
*line 149
move #64,(sp)
move.b R7,R0
ext.w R0
move R4,R9
move R5,R2
asl #3,R2
ext.l R2
add.l R2,R9
add.l #_sqhilit,R9
move.b 2(R9),R1
ext.w R1
and R1,R0
beq L10000
move #18,-(sp)
bra L10002
L10000:move #146,-(sp)
L10002:move R6,-(sp)
move R4,-(sp)
add #1,(sp)
move.l _obj11,-(sp)
jsr _vsetcv
adda.l #10,sp
add #1,R6
L11:L12:
*line 146
move R3,R0
sub #1,R3
tst R0
bgt L13
L10:
*line 149
L7:
*line 142
add #1,R4
L8:
*line 142
cmp #5,R4
blt L9
L6:
*line 150
L3:
*line 140
add #1,R5
L4:
*line 140
cmp #5,R5
blt L5
L2:L1:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _postcm
.text
_postcm:
~~postcm:
link R14,#-4
*line 165
*line 165
cmp #12,_stccol
blt L15
cmp #22,_stccol
bgt L15
*line 166
*line 167
*line 168
cmp #12,_stccol
blt L16
cmp #13,_stccol
bgt L16
*line 168
move #1,(sp)
jsr _hilitsq
bra L17
L16:
*line 169
*line 170
clr R0
move 2+_seqbuf,R0
and #255,R0
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L18
cmp #19,_stccol
bne L18
*line 170
move #2,(sp)
jsr _hilitsq
*line 171
bra L19
L18:
*line 172
clr (sp)
jsr _hilitsq
L19:L17:
*line 173
bra L14
*line 174
*line 175
bra L20
L15:
*line 176
*line 176
cmp #24,_stccol
blt L21
cmp #34,_stccol
bgt L21
*line 177
*line 178
*line 179
cmp #24,_stccol
blt L22
cmp #25,_stccol
bgt L22
*line 179
move #1,(sp)
jsr _hilitsq
bra L23
L22:
*line 180
*line 181
clr R0
move 6+_seqbuf,R0
and #255,R0
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L24
cmp #31,_stccol
bne L24
*line 181
move #2,(sp)
jsr _hilitsq
*line 182
bra L25
L24:
*line 183
clr (sp)
jsr _hilitsq
L25:L23:
*line 184
bra L14
*line 185
*line 186
bra L26
L21:
*line 187
*line 187
cmp #36,_stccol
blt L27
cmp #46,_stccol
bgt L27
*line 188
*line 189
*line 190
cmp #36,_stccol
blt L28
cmp #37,_stccol
bgt L28
*line 190
move #4,(sp)
jsr _hilitsq
bra L29
L28:
*line 191
*line 192
clr R0
move 10+_seqbuf,R0
and #255,R0
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L30
cmp #43,_stccol
bne L30
*line 192
move #2,(sp)
jsr _hilitsq
*line 193
bra L31
L30:
*line 194
clr (sp)
jsr _hilitsq
L31:L29:
*line 195
bra L14
*line 196
*line 197
bra L32
L27:
*line 198
*line 199
*line 200
clr (sp)
jsr _hilitsq
bra L14
*line 201
L32:L26:L20:L14:unlk R14
rts
.globl _movestc
.text
_movestc:
~~movestc:
~r=8
~c=10
link R14,#-4
*line 217
move 10(R14),(sp)
move 8(R14),-(sp)
jsr _ctcpos
addq.l #2,sp
*line 218
jsr _postcm
L33:unlk R14
rts
.globl _endssm
.text
_endssm:
~~endssm:
~row=8
~col=10
link R14,#-4
*line 230
clr _submenu
*line 231
move #4,_cmtype
*line 233
jsr _mtcoff
*line 234
jsr _ctcon
*line 235
move 10(R14),(sp)
move 8(R14),-(sp)
jsr _movestc
addq.l #2,sp
L34:unlk R14
rts
.globl _setsqm
.text
_setsqm:
~~setsqm:
~r=8
~c=10
link R14,#-4
*line 250
move #1,_submenu
*line 251
move #5,_cmtype
*line 252
move 10(R14),(sp)
move 8(R14),-(sp)
jsr _mtcpos
addq.l #2,sp
L35:unlk R14
rts
.globl _sqenter
.text
_sqenter:
~~sqenter:
link R14,#-14
movem.l R4-R7/R12-R13,-(sp)
~i=R7
~lcol=R6
~ltemp=R5
~ap=R13
~dp=R12
~theact=-2
~port=-4
~chan=-6
~key=-8
~val=-10
~obj=-12
~dtype=-14
*line 272
move _action,R0
bra L38
*line 273
L39:
*line 274
*line 275
*line 276
move.l #2+_seqbuf,R13
*line 277
move.l #4+_seqbuf,R12
bra L37
*line 278
*line 279
L40:
*line 280
*line 281
*line 282
move.l #6+_seqbuf,R13
*line 283
move.l #8+_seqbuf,R12
bra L37
*line 284
*line 285
L41:
*line 286
*line 287
*line 288
move.l #10+_seqbuf,R13
*line 289
move.l #12+_seqbuf,R12
bra L37
*line 290
*line 291
L42:
*line 292
*line 293
*line 294
clr _action
*line 295
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 296
move #-1,R0
bra L36
bra L37
L38:tst R0
beq L39
cmp #1,R0
beq L40
cmp #2,R0
beq L41
bra L42
L37:
*line 301
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R6
*line 302
clr R0
move (R13),R0
and #255,R0
move R0,-2(R14)
*line 304
clr R0
move -2(R14),R0
bra L44
*line 305
L45:
*line 306
L46:
*line 307
L47:
*line 308
L48:
*line 309
*line 310
*line 311
clr.l R5
*line 312
*line 313
move R6,R7
add #3,R7
bra L51
L52:
*line 314
move.l #$a,-(sp)
move.l R5,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R5
move.l #_sqdebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R5
L50:
*line 313
add #1,R7
L51:
*line 313
move R6,R0
add #6,R0
cmp R0,R7
blt L52
L49:
*line 314
*line 315
*line 316
*line 316
cmp.l #$1,R5
blt L10003
cmp.l #$80,R5
ble L53
L10003:*line 317
*line 318
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #3,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 319
move #-1,R0
bra L36
*line 320
*line 321
L53:
*line 322
move.l R5,R0
sub.l #$1,R0
move R0,-8(R14)
*line 323
*line 324
*line 325
move.l #_sqdebuf,R8
move.b 7(R8,R6),R0
ext.w R0
move R0,R7
*line 326
*line 327
*line 327
cmp #49,R7
beq L10004
cmp #50,R7
bne L54
L10004:*line 328
*line 329
move R7,R0
add #-49,R0
move R0,-4(R14)
*line 330
bra L55
L54:
*line 331
*line 331
cmp #76,R7
bne L56
*line 332
*line 333
move #2,-4(R14)
*line 334
bra L57
L56:
*line 335
*line 336
*line 337
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #7,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 338
move #-1,R0
bra L36
L57:L55:
*line 339
*line 340
*line 341
*line 342
move.l #_sqdebuf,R8
move.b 9(R8,R6),R0
ext.w R0
add #-48,R0
muls #10,R0
move.l #_sqdebuf,R9
move.b 10(R9,R6),R1
ext.w R1
add R1,R0
add #-48,R0
ext.l R0
move.l R0,R5
*line 343
*line 344
*line 344
cmp.l #$1,R5
blt L10005
cmp.l #$10,R5
ble L58
L10005:*line 345
*line 346
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #9,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 347
move #-1,R0
bra L36
*line 348
*line 349
L58:
*line 350
move.l R5,R0
sub.l #$1,R0
move R0,-6(R14)
*line 351
clr R0
move -4(R14),R0
move #11,R1
lsl R1,R0
clr R1
move -6(R14),R1
lsl #7,R1
or R1,R0
or -8(R14),R0
move R0,(R12)
*line 352
bra L43
*line 353
*line 354
*line 355
L59:
*line 356
L60:
*line 357
L61:
*line 358
*line 359
*line 360
*line 361
move.l #_sqdebuf,R8
move.b 9(R8,R6),R0
ext.w R0
add #-48,R0
muls #10,R0
move.l #_sqdebuf,R9
move.b 10(R9,R6),R1
ext.w R1
add R1,R0
add #-48,R0
ext.l R0
move.l R0,R5
*line 362
*line 363
*line 363
cmp.l #$1,R5
blt L10006
cmp.l #$10,R5
ble L62
L10006:*line 364
*line 365
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #9,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 366
move #-1,R0
bra L36
*line 367
*line 368
L62:
*line 369
move.l R5,R0
sub.l #$1,R0
move R0,(R12)
*line 370
bra L43
*line 371
*line 372
L63:
*line 373
L64:
*line 374
L65:
*line 375
L66:
*line 376
*line 377
bra L43
*line 378
*line 379
L67:
*line 380
*line 381
*line 382
clr.l R5
*line 383
*line 384
move R6,R7
add #8,R7
bra L70
L71:
*line 385
move.l #$a,-(sp)
move.l R5,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R5
move.l #_sqdebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R5
L69:
*line 384
add #1,R7
L70:
*line 384
move R6,R0
add #11,R0
cmp R0,R7
blt L71
L68:
*line 385
*line 386
*line 387
move R5,(R12)
*line 388
bra L43
*line 389
*line 390
*line 391
L72:
*line 392
L73:
*line 393
L74:
*line 394
L75:
*line 395
L76:
*line 396
*line 397
*line 398
clr R0
move (R12),R0
and #3840,R0
move R0,-14(R14)
*line 399
*line 400
*line 401
move.l #_sqdebuf,R8
move.b 5(R8,R6),R0
ext.w R0
add #-48,R0
muls #10,R0
move.l #_sqdebuf,R9
move.b 6(R9,R6),R1
ext.w R1
add R1,R0
add #-48,R0
ext.l R0
move.l R0,R5
*line 402
*line 403
*line 403
cmp.l #$1,R5
blt L10007
cmp.l #$10,R5
ble L77
L10007:*line 404
*line 405
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #5,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 406
move #-1,R0
bra L36
*line 407
*line 408
L77:
*line 409
move.l R5,R0
sub.l #$1,R0
move R0,-12(R14)
*line 410
*line 411
clr R0
move -14(R14),R0
bra L79
*line 412
L80:
*line 413
*line 414
*line 415
*line 416
move.l #_sqdebuf,R8
move.b 9(R8,R6),R0
ext.w R0
add #-48,R0
muls #10,R0
move.l #_sqdebuf,R9
move.b 10(R9,R6),R1
ext.w R1
add R1,R0
add #-48,R0
ext.l R0
move.l R0,R5
*line 417
*line 418
*line 418
cmp.l #$1,R5
blt L10008
cmp.l #$10,R5
ble L81
L10008:*line 419
*line 420
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #9,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 421
move #-1,R0
bra L36
*line 422
*line 423
L81:
*line 424
move.l R5,R0
sub.l #$1,R0
move R0,-10(R14)
bra L78
*line 425
*line 426
L82:
*line 427
*line 428
*line 429
*line 430
move.l #_sqdebuf,R8
move.b 8(R8,R6),R0
ext.w R0
add #-48,R0
muls #10,R0
move.l #_sqdebuf,R9
move.b 9(R9,R6),R1
ext.w R1
add R1,R0
add #-48,R0
move R0,-10(R14)
*line 431
bra L78
*line 432
*line 433
*line 434
L83:
*line 435
*line 436
*line 437
move.l #_sqdebuf,R8
move.b 9(R8,R6),R0
ext.w R0
add #-49,R0
move R0,-10(R14)
bra L78
*line 438
*line 439
L84:
*line 440
*line 441
*line 442
move.l #_sqdebuf,R8
move.b 9(R8,R6),R0
ext.w R0
add #-48,R0
move R0,-10(R14)
bra L78
*line 443
*line 444
L85:
*line 445
*line 446
*line 447
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
add #8,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 448
move #-1,R0
bra L36
bra L78
L79:tst R0
beq L80
cmp #256,R0
beq L82
cmp #512,R0
beq L83
cmp #768,R0
beq L84
bra L85
L78:
*line 449
*line 450
*line 451
*line 452
*line 453
clr R0
move (R13),R0
and #255,R0
cmp #16,R0
bne L86
move R6,R8
add.l #_sqdebuf,R8
cmp.b #45,7(R8)
bne L86
*line 453
or #4096,-10(R14)
*line 454
L86:
*line 455
clr R0
move (R13),R0
and #255,R0
clr R1
move -12(R14),R1
lsl #8,R1
or R1,R0
move R0,(R13)
*line 456
clr R0
move (R12),R0
and #3840,R0
or -10(R14),R0
move R0,(R12)
*line 457
bra L43
*line 458
*line 459
L87:
*line 460
*line 461
*line 462
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 463
move #-1,R0
bra L36
bra L43
L44:cmp #16,R0
bhi L87
asl #2,R0
move R0,R8
add.l #L88,R8
move.l (R8),R8
jmp (R8)
.data
L88:.dc.l L63
.dc.l L46
.dc.l L47
.dc.l L45
.dc.l L48
.dc.l L59
.dc.l L60
.dc.l L61
.dc.l L64
.dc.l L72
.dc.l L74
.dc.l L75
.dc.l L76
.dc.l L66
.dc.l L67
.dc.l L65
.dc.l L73
.text
L43:
*line 467
move #7,(sp)
move.l #_seqbuf,-(sp)
move _curslin,R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 468
move _curslin,(sp)
move.l #_sqdebuf,-(sp)
jsr _dsqlin
addq.l #4,sp
*line 469
move #1,_sqdeflg
*line 470
jsr _dcursq
*line 471
move _action,R8
move.l #_nextact,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 472
clr R0
bra L36
L36:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _sqfnbox
.text
_sqfnbox:
~~sqfnbox:
~n=8
link R14,#-4
movem.l R4-R7,-(sp)
~act=-2
~vtype=-4
~box=R7
~i=R6
~ltemp=R5
*line 493
*line 493
tst _submenu
bne L90
*line 494
*line 495
*line 495
cmp #2,_stccol
blt L91
cmp #4,_stccol
bgt L91
*line 496
*line 497
clr.l R5
*line 498
*line 499
move #2,R6
bra L94
L95:
*line 500
move.l #$a,-(sp)
move.l R5,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R5
move.l #_sqdebuf,R8
move.b 0(R8,R6),R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R5
L93:
*line 499
add #1,R6
L94:
*line 499
cmp #5,R6
blt L95
L92:
*line 500
*line 501
*line 502
move R5,_curslin
*line 503
clr _sqdeflg
*line 504
jsr _dstw
*line 505
move #2,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 506
clr R0
bra L89
*line 507
bra L96
L91:
*line 508
*line 508
cmp #6,_stccol
blt L97
cmp #10,_stccol
bgt L97
*line 509
*line 510
clr.l R5
*line 511
*line 512
move #6,R6
bra L100
L101:
*line 513
move.l #$a,-(sp)
move.l R5,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R5
move.l #_sqdebuf,R8
move.b 0(R8,R6),R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R5
L99:
*line 512
add #1,R6
L100:
*line 512
cmp #8,R6
blt L101
L98:
*line 513
*line 514
*line 515
move #9,R6
bra L104
L105:
*line 516
move.l #$a,-(sp)
move.l R5,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R5
move.l #_sqdebuf,R8
move.b 0(R8,R6),R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R5
L103:
*line 515
add #1,R6
L104:
*line 515
cmp #11,R6
blt L105
L102:
*line 516
*line 517
*line 518
move.l R5,R0
move _curslin,R1
muls #14,R1
add.l #_seqtab,R1
move.l R1,R9
move R0,(R9)
*line 519
move R5,_seqbuf
*line 520
move _curslin,(sp)
move.l #_sqdebuf,-(sp)
jsr _dsqlin
addq.l #4,sp
*line 521
move #1,_sqdeflg
*line 522
jsr _dcursq
*line 523
move #12,(sp)
move #9,-(sp)
jsr _movestc
addq.l #2,sp
*line 524
clr R0
bra L89
*line 525
*line 526
bra L106
L97:
*line 527
*line 527
cmp #12,_stccol
blt L107
cmp #22,_stccol
bgt L107
*line 528
*line 529
clr _action
*line 530
*line 531
*line 531
cmp #12,_stccol
blt L108
cmp #13,_stccol
bgt L108
*line 532
*line 533
move #2,(sp)
move #19,-(sp)
jsr _setsqm
addq.l #2,sp
*line 534
clr R0
bra L89
*line 535
bra L109
L108:
*line 536
*line 537
clr R0
move 2+_seqbuf,R0
and #255,R0
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L110
cmp #19,_stccol
bne L110
*line 538
*line 539
move #53,(sp)
move #19,-(sp)
jsr _setsqm
addq.l #2,sp
*line 540
clr R0
bra L89
*line 541
bra L111
L110:
*line 542
*line 543
*line 544
jsr _sqenter
bra L89
L111:L109:
*line 545
*line 546
bra L112
L107:
*line 547
*line 547
cmp #24,_stccol
blt L113
cmp #34,_stccol
bgt L113
*line 548
*line 549
move #1,_action
*line 550
*line 551
*line 551
cmp #24,_stccol
blt L114
cmp #25,_stccol
bgt L114
*line 552
*line 553
move #2,(sp)
move #19,-(sp)
jsr _setsqm
addq.l #2,sp
*line 554
clr R0
bra L89
*line 555
bra L115
L114:
*line 556
*line 557
clr R0
move 6+_seqbuf,R0
and #255,R0
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L116
cmp #31,_stccol
bne L116
*line 558
*line 559
move #53,(sp)
move #19,-(sp)
jsr _setsqm
addq.l #2,sp
*line 560
clr R0
bra L89
*line 561
bra L117
L116:
*line 562
*line 563
*line 564
jsr _sqenter
bra L89
L117:L115:
*line 565
*line 566
*line 567
bra L118
L113:
*line 568
*line 568
cmp #36,_stccol
blt L119
cmp #46,_stccol
bgt L119
*line 569
*line 570
move #2,_action
*line 571
*line 572
*line 572
cmp #36,_stccol
blt L120
cmp #37,_stccol
bgt L120
*line 573
*line 574
move #2,(sp)
move #19,-(sp)
jsr _setsqm
addq.l #2,sp
*line 575
clr R0
bra L89
*line 576
bra L121
L120:
*line 577
*line 578
clr R0
move 10+_seqbuf,R0
and #255,R0
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L122
cmp #43,_stccol
bne L122
*line 579
*line 580
move #53,(sp)
move #19,-(sp)
jsr _setsqm
addq.l #2,sp
*line 581
clr R0
bra L89
*line 582
bra L123
L122:
*line 583
*line 584
*line 585
jsr _sqenter
bra L89
L123:L121:
*line 586
*line 587
*line 588
bra L124
L119:
*line 589
move #-1,R0
bra L89
L124:L118:L112:L106:L96:
*line 590
*line 591
bra L125
L90:
*line 592
*line 593
*line 594
*line 595
*line 596
*line 597
cmp #2,_vtccol
blt L126
cmp #14,_vtccol
bgt L126
*line 597
move _vtcrow,R7
add #-18,R7
bra L127
L126:
*line 598
*line 599
cmp #17,_vtccol
blt L128
cmp #27,_vtccol
bgt L128
*line 599
move _vtcrow,R7
add #-14,R7
bra L129
L128:
*line 600
*line 601
cmp #30,_vtccol
blt L130
cmp #40,_vtccol
bgt L130
*line 601
move _vtcrow,R7
add #-10,R7
bra L131
L130:
*line 602
*line 603
cmp #43,_vtccol
blt L132
cmp #50,_vtccol
bgt L132
*line 603
move _vtcrow,R7
sub #6,R7
bra L133
L132:
*line 604
*line 605
cmp #53,_vtccol
blt L134
cmp #60,_vtccol
bgt L134
*line 605
move _vtcrow,R7
sub #1,R7
*line 606
bra L135
L134:
*line 607
move #-1,R0
bra L89
L135:L133:L131:L129:L127:
*line 608
*line 609
*line 610
move _sqmenu,R0
bra L137
*line 611
L138:
*line 612
L139:
*line 613
*line 614
*line 615
*line 616
cmp #18,R7
blt L140
cmp #21,R7
bgt L140
*line 616
move #-1,R0
bra L89
*line 617
L140:
*line 618
move _action,R0
bra L142
*line 619
L143:
*line 620
*line 621
*line 622
move R7,R8
add.l R8,R8
move.l #_sqatype,R9
move 0(R8,R9.l),R0
move R0,2+_seqbuf
and #255,R0
move R0,-2(R14)
*line 623
move R7,R8
add.l R8,R8
move.l #_sqidata,R9
move 0(R8,R9.l),R0
move R0,4+_seqbuf
lsr #8,R0
and #15,R0
move R0,-4(R14)
bra L141
*line 624
*line 625
L144:
*line 626
*line 627
*line 628
move R7,R8
add.l R8,R8
move.l #_sqatype,R9
move 0(R8,R9.l),R0
move R0,6+_seqbuf
and #255,R0
move R0,-2(R14)
*line 629
move R7,R8
add.l R8,R8
move.l #_sqidata,R9
move 0(R8,R9.l),R0
move R0,8+_seqbuf
lsr #8,R0
and #15,R0
move R0,-4(R14)
bra L141
*line 630
*line 631
L145:
*line 632
*line 633
*line 634
*line 635
*line 636
cmp #4,R7
beq L10009
cmp #8,R7
beq L10009
cmp #12,R7
beq L10009
cmp #15,R7
blt L146
cmp #17,R7
bgt L146
L10009:*line 636
move #-1,R0
bra L89
*line 637
L146:
*line 638
move R7,R8
add.l R8,R8
move.l #_sqatype,R9
move 0(R8,R9.l),R0
move R0,10+_seqbuf
and #255,R0
move R0,-2(R14)
*line 639
move R7,R8
add.l R8,R8
move.l #_sqidata,R9
move 0(R8,R9.l),R0
move R0,12+_seqbuf
lsr #8,R0
and #15,R0
move R0,-4(R14)
bra L141
*line 640
bra L141
L142:tst R0
beq L143
cmp #1,R0
beq L144
cmp #2,R0
beq L145
bra L141
L141:
*line 641
*line 642
*line 643
move #7,(sp)
move.l #_seqbuf,-(sp)
move _curslin,R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 644
move _curslin,(sp)
move.l #_sqdebuf,-(sp)
jsr _dsqlin
addq.l #4,sp
*line 645
move #1,_sqdeflg
*line 646
jsr _dcursq
*line 647
*line 648
*line 649
move -2(R14),R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
beq L147
*line 649
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move -4(R14),R8
move.l #_sqvcol,R9
move.b 0(R8,R9.l),R0
ext.w R0
add R0,(sp)
move _stcrow,-(sp)
jsr _endssm
addq.l #2,sp
bra L148
L147:
*line 650
*line 651
cmp #13,-2(R14)
beq L10010
cmp #15,-2(R14)
bne L149
L10010:*line 651
move _action,R8
move.l #_nextact,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move _stcrow,-(sp)
jsr _endssm
addq.l #2,sp
*line 652
bra L150
L149:
*line 653
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move -2(R14),R8
move.l #_actcol,R9
move.b 0(R8,R9.l),R0
ext.w R0
add R0,(sp)
move _stcrow,-(sp)
jsr _endssm
addq.l #2,sp
L150:L148:
*line 654
*line 655
clr R0
bra L89
*line 656
*line 657
L151:
*line 658
*line 659
*line 660
*line 661
cmp #18,R7
blt L10011
cmp #21,R7
ble L152
L10011:*line 661
move #-1,R0
bra L89
*line 662
L152:
*line 663
move _action,R0
bra L154
*line 664
L155:
*line 665
*line 666
*line 667
*line 668
clr R0
move 2+_seqbuf,R0
and #255,R0
move R0,-2(R14)
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
bne L156
*line 668
move #-1,R0
bra L89
*line 669
L156:
*line 670
clr R0
move 4+_seqbuf,R0
and #-4096,R0
move R7,R9
add #-18,R9
add.l R9,R9
add.l #_sqndata,R9
move (R9),R1
or R1,R0
move R0,4+_seqbuf
bra L153
*line 671
*line 672
L157:
*line 673
*line 674
*line 675
*line 676
clr R0
move 6+_seqbuf,R0
and #255,R0
move R0,-2(R14)
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
bne L158
*line 676
move #-1,R0
bra L89
*line 677
L158:
*line 678
clr R0
move 8+_seqbuf,R0
and #-4096,R0
move R7,R9
add #-18,R9
add.l R9,R9
add.l #_sqndata,R9
move (R9),R1
or R1,R0
move R0,8+_seqbuf
bra L153
*line 679
*line 680
L159:
*line 681
*line 682
*line 683
*line 684
clr R0
move 10+_seqbuf,R0
and #255,R0
move R0,-2(R14)
move R0,R8
move.l #_sqopreq,R9
tst.b 0(R8,R9.l)
bne L160
*line 684
move #-1,R0
bra L89
*line 685
L160:
*line 686
clr R0
move 12+_seqbuf,R0
and #-4096,R0
move R7,R9
add #-18,R9
add.l R9,R9
add.l #_sqndata,R9
move (R9),R1
or R1,R0
move R0,12+_seqbuf
bra L153
*line 687
bra L153
L154:tst R0
beq L155
cmp #1,R0
beq L157
cmp #2,R0
beq L159
bra L153
L153:
*line 688
*line 689
bra L136
*line 690
*line 691
L161:
*line 692
*line 693
*line 694
move _stccol,(sp)
move _stcrow,-(sp)
jsr _endssm
addq.l #2,sp
*line 695
move #-1,R0
bra L89
bra L136
L137:cmp #1,R0
beq L138
cmp #2,R0
beq L151
cmp #4,R0
beq L139
bra L161
L136:
*line 696
*line 697
*line 698
move #7,(sp)
move.l #_seqbuf,-(sp)
move _curslin,R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 699
move _curslin,(sp)
move.l #_sqdebuf,-(sp)
jsr _dsqlin
addq.l #4,sp
*line 700
move #1,_sqdeflg
*line 701
jsr _dcursq
*line 702
move _action,R8
move.l #_actlft,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move.l #_seqvcol,R8
move.b -18(R8,R7),R0
ext.w R0
add R0,(sp)
move _stcrow,-(sp)
jsr _endssm
addq.l #2,sp
*line 703
clr R0
bra L89
L125:
*line 706
move #-1,R0
bra L89
L89:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
