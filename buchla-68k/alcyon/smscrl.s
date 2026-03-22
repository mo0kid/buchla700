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
.globl _ctcsw
.globl _curslin
.globl _cxrate
.globl _cxval
.globl _cyrate
.globl _cyval
.globl _ptecpos
.globl _pteset
.globl _sqdeflg
.globl _stccol
.globl _submenu
.globl _vtccol
.globl _vtcrow
.globl _vtxval
.globl _vtyval
.globl _obj10
.globl _cg3
.globl _ptdebuf
.globl _sqdebuf
.globl _ptebuf
.globl _patches
.globl _seqbuf
.globl _seqtab
.globl _TheBuf
.comm _TheBuf,66
.globl _BakLine
.comm _BakLine,4
.globl _FwdLine
.comm _FwdLine,4
.globl _PdScDnF
.comm _PdScDnF,2
.globl _PdScUpF
.comm _PdScUpF,2
.globl _CurLine
.comm _CurLine,2
.globl _CurScan
.comm _CurScan,2
.globl _DupLine
.comm _DupLine,2
.globl _ScrlObj
.comm _ScrlObj,2
.globl _LinePtr
.comm _LinePtr,4
.globl _LineAtr
.comm _LineAtr,2
.globl _LineBuf
.comm _LineBuf,4
.globl _OldLine
.comm _OldLine,4
.globl _ScObAdr
.comm _ScObAdr,4
.globl _LineCon
.data
_LineCon:
.dc.w $90
.globl _LineLen
.data
_LineLen:
.dc.w $30
.globl _SmScLim
.data
_SmScLim:
.dc.w $12
.globl _SmScNsl
.data
_SmScNsl:
.dc.w $10
.globl _SmScTop
.data
_SmScTop:
.dc.w $22
.globl _LineFwd
.text
_LineFwd:
~~LineFwd:
link R14,#0
movem.l R5-R7,-(sp)
~j=R7
~k=R6
*line 101
clr R7
bra L4
L5:
*line 102
move R7,R8
add.l #_TheBuf,R8
move.b #32,(R8)
L3:
*line 101
add #1,R7
L4:
*line 101
cmp #48,R7
blt L5
L2:
*line 104
move.b #176,_TheBuf
*line 105
clr.b 48+_TheBuf
*line 107
*line 108
tst _ptecpos
bne L6
*line 108
clr.l R0
bra L1
*line 109
L6:
*line 110
*line 111
move _ptecpos,(sp)
jsr _findnxt
move R0,R7
tst R7
bne L7
*line 111
clr.l R0
bra L1
*line 112
L7:
*line 113
move R7,_ptecpos
*line 115
move #6,(sp)
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,-(sp)
add.l #4,(sp)
move.l #4+_ptebuf,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 116
move #1,_pteset
*line 117
jsr _pte2buf
*line 119
move _ptecpos,R6
*line 121
clr R7
bra L10
L11:
*line 122
*line 123
move R6,(sp)
jsr _findnxt
move R0,R6
tst R6
bne L12
*line 123
move.l #_TheBuf,R0
bra L1
*line 124
L12:L9:
*line 121
add #1,R7
L10:
*line 121
cmp #8,R7
blt L11
L8:
*line 125
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_patches,R9
move 4(R8,R9.l),(sp)
move.l #2+_TheBuf,-(sp)
jsr _dspdfst
addq.l #4,sp
*line 126
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_patches,R9
move 6(R8,R9.l),(sp)
move.l #15+_TheBuf,-(sp)
jsr _dspdfst
addq.l #4,sp
*line 127
move R6,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,(sp)
move.l #28+_TheBuf,-(sp)
jsr _dspdest
addq.l #4,sp
*line 129
clr R7
bra L15
L16:
*line 130
*line 131
move R7,R8
add.l #_TheBuf,R8
tst.b (R8)
bne L17
*line 131
move R7,R8
add.l #_TheBuf,R8
move.b #32,(R8)
*line 132
L17:L14:
*line 129
add #1,R7
L15:
*line 129
cmp #50,R7
blt L16
L13:
*line 133
clr.b 48+_TheBuf
*line 134
move.l #_TheBuf,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _LineBak
.text
_LineBak:
~~LineBak:
link R14,#0
movem.l R5-R7,-(sp)
~j=R7
~k=R6
*line 151
clr R7
bra L21
L22:
*line 152
move R7,R8
add.l #_TheBuf,R8
move.b #32,(R8)
L20:
*line 151
add #1,R7
L21:
*line 151
cmp #48,R7
blt L22
L19:
*line 154
move.b #176,_TheBuf
*line 155
clr.b 48+_TheBuf
*line 157
*line 158
tst _ptecpos
bne L23
*line 158
clr.l R0
bra L18
*line 159
L23:
*line 160
*line 161
move _ptecpos,(sp)
jsr _findprv
move R0,R7
tst R7
bne L24
*line 161
clr.l R0
bra L18
*line 162
L24:
*line 163
move R7,_ptecpos
*line 165
move #6,(sp)
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,-(sp)
add.l #4,(sp)
move.l #4+_ptebuf,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 166
move #1,_pteset
*line 167
jsr _pte2buf
*line 169
move _ptecpos,R6
*line 171
clr R7
bra L27
L28:
*line 172
*line 173
move R6,(sp)
jsr _findprv
move R0,R6
tst R6
bne L29
*line 173
move.l #_TheBuf,R0
bra L18
*line 174
L29:L26:
*line 171
add #1,R7
L27:
*line 171
cmp #7,R7
blt L28
L25:
*line 175
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_patches,R9
move 4(R8,R9.l),(sp)
move.l #2+_TheBuf,-(sp)
jsr _dspdfst
addq.l #4,sp
*line 176
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_patches,R9
move 6(R8,R9.l),(sp)
move.l #15+_TheBuf,-(sp)
jsr _dspdfst
addq.l #4,sp
*line 177
move R6,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,(sp)
move.l #28+_TheBuf,-(sp)
jsr _dspdest
addq.l #4,sp
*line 179
clr R7
bra L32
L33:
*line 180
*line 181
move R7,R8
add.l #_TheBuf,R8
tst.b (R8)
bne L34
*line 181
move R7,R8
add.l #_TheBuf,R8
move.b #32,(R8)
*line 182
L34:L31:
*line 179
add #1,R7
L32:
*line 179
cmp #50,R7
blt L33
L30:
*line 183
clr.b 48+_TheBuf
*line 184
move.l #_TheBuf,R0
bra L18
L18:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _WrVideo
.text
_WrVideo:
~~WrVideo:
~row=R7
~col=R6
~str=R13
~atr=R5
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~chr=R4
*line 203
move 8(R14),R7
*line 203
move 10(R14),R6
*line 203
move.l 12(R14),R13
*line 203
move 16(R14),R5
*line 203
*line 204
clr R0
move 10+_v_regs,R0
and #384,R0
beq L36
*line 204
clr (sp)
jsr _vbank
*line 205
L36:
*line 206
bra L39
L38:
*line 207
*line 208
*line 209
move _LineLen,(sp)
tst R6
bne L10000
move #226,-(sp)
bra L10002
L10000:move R5,-(sp)
L10002:move.b R4,R0
ext.w R0
move R0,-(sp) 
move R6,-(sp)
move R7,-(sp)
move.l _ScObAdr,-(sp)
jsr _vputcv
adda.l #12,sp
*line 210
*line 211
add #1,R6
L39:
*line 212
move.b (R13)+,R4
bne L38
L37:L35:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _SetDTop
.text
_SetDTop:
~~SetDTop:
~row=8
~scan=10
link R14,#-4
*line 227
*line 228
clr R0
move 10+_v_regs,R0
and #384,R0
beq L41
*line 228
clr (sp)
jsr _vbank
*line 229
L41:
*line 230
move 8(R14),R0
muls _LineCon,R0
ext.l R0
add.l _ScObAdr,R0
move.l R0,_LineBuf
*line 232
*line 233
move.l _OldLine,R0
cmp.l _LineBuf,R0
beq L42
*line 233
move.l _LineBuf,R0
asr.l #1,R0
move _ScrlObj,R1
asl #3,R1
ext.l R1
add.l #_v_odtab,R1
move.l R1,R9
move R0,4(R9)
*line 234
L42:
*line 235
move.l _LineBuf,_OldLine
*line 237
move _ScrlObj,R0
asl #3,R0
ext.l R0
move.l R0,R8
move.l #_v_odtab,R9
clr R0
move 0(R8,R9.l),R0
and #4095,R0
move 10(R14),R1
move #12,R2
asl R2,R1
or R1,R0
move _ScrlObj,R1
asl #3,R1
ext.l R1
add.l #_v_odtab,R1
move.l R1,R9
move R0,(R9)
L40:unlk R14
rts
.globl _UpdVid
.text
_UpdVid:
~~UpdVid:
~row=8
~col=10
~str=12
~atr=16
link R14,#-4
*line 254
move 16(R14),(sp)
move.l 12(R14),-(sp)
move 10(R14),-(sp)
move _CurLine,-(sp)
move 8(R14),R0
add R0,(sp)
jsr _WrVideo
addq.l #8,sp
*line 256
move _CurLine,R0
add _SmScNsl,R0
add 8(R14),R0
add #2,R0
move R0,_DupLine
*line 258
*line 259
move _DupLine,R0
cmp _SmScTop,R0
bge L44
*line 259
move #18,(sp)
move.l 12(R14),-(sp)
move 10(R14),-(sp)
move _DupLine,-(sp)
jsr _WrVideo
addq.l #8,sp
*line 260
L44:
*line 261
move _CurLine,R0
sub _SmScNsl,R0
add 8(R14),R0
sub #2,R0
move R0,_DupLine
*line 263
*line 264
tst _DupLine
blt L45
*line 264
move #18,(sp)
move.l 12(R14),-(sp)
move 10(R14),-(sp)
move _DupLine,-(sp)
jsr _WrVideo
addq.l #8,sp
L45:L43:unlk R14
rts
.globl _bgncm
.text
_bgncm:
~~bgncm:
link R14,#0
movem.l R6-R7,-(sp)
~j=R7
*line 280
move #6,(sp)
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,-(sp)
add.l #4,(sp)
move.l #4+_ptebuf,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 281
move #1,_pteset
*line 282
jsr _pte2buf
*line 284
move #48,(sp)
move.l #_ptdebuf,-(sp)
move.l #_TheBuf,-(sp)
jsr _memcpy
addq.l #8,sp
*line 286
clr R7
bra L49
L50:
*line 287
*line 288
move R7,R8
add.l #_TheBuf,R8
tst.b (R8)
bne L51
*line 288
move R7,R8
add.l #_TheBuf,R8
move.b #32,(R8)
*line 289
L51:L48:
*line 286
add #1,R7
L49:
*line 286
cmp #50,R7
blt L50
L47:
*line 290
move.b #176,_TheBuf
*line 291
move.b #32,1+_TheBuf
*line 292
clr.b 48+_TheBuf
*line 294
move #18,(sp)
move.l #_TheBuf,-(sp)
clr -(sp)
move #7,-(sp)
jsr _UpdVid
addq.l #8,sp
*line 295
jsr _ctcoff
L46:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _stopcm
.text
_stopcm:
~~stopcm:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 311
*line 312
tst _PdScDnF
beq L53
*line 312
move #13,R0
move R0,_CurScan
move R0,(sp)
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
bra L54
L53:
*line 313
*line 314
tst _PdScUpF
beq L55
*line 314
move #13,R0
move R0,_CurScan
move R0,(sp)
add #1,_CurLine
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
*line 315
L55:L54:
*line 316
*line 316
tst _ctcsw
bne L56
*line 317
*line 318
*line 318
tst _ptecpos
beq L57
*line 319
*line 320
*line 321
*line 322
move #6,(sp)
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,-(sp)
add.l #4,(sp)
move.l #4+_ptebuf,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 323
move #1,_pteset
*line 324
jsr _pte2buf
*line 325
jsr _setptcv
*line 326
bra L58
L57:
*line 327
*line 328
*line 329
jsr _voidpb
L58:
*line 330
*line 331
*line 332
L56:
*line 333
jsr _ctcon
*line 335
clr _PdScDnF
*line 336
clr _PdScUpF
L52:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _stopsm
.text
_stopsm:
~~stopsm:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 352
*line 353
tst _PdScDnF
beq L60
*line 353
move #13,R0
move R0,_CurScan
move R0,(sp)
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
bra L61
L60:
*line 354
*line 355
tst _PdScUpF
beq L62
*line 355
move #13,R0
move R0,_CurScan
move R0,(sp)
add #1,_CurLine
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
*line 356
L62:L61:
*line 357
move #7,(sp)
move _curslin,R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
move.l #_seqbuf,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 358
move _curslin,(sp)
move.l #_sqdebuf,-(sp)
jsr _dsqlin
addq.l #4,sp
*line 359
move #1,_sqdeflg
*line 360
jsr _ctcon
*line 362
clr _PdScDnF
*line 363
clr _PdScUpF
L59:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _smscrl
.text
_smscrl:
~~smscrl:
link R14,#-4
*line 377
*line 377
tst _PdScUpF
beq L64
*line 378
*line 379
*line 379
cmp #13,_CurScan
bne L65
*line 380
*line 381
*line 381
move.l _FwdLine,R8
jsr (R8)
move.l R0,_LinePtr
beq L66
*line 382
*line 383
*line 383
move _CurLine,R0
cmp _SmScLim,R0
bne L67
*line 384
*line 385
*line 386
*line 387
move _LineAtr,(sp)
move.l _LinePtr,-(sp)
clr -(sp)
move _SmScNsl,-(sp)
jsr _WrVideo
addq.l #8,sp
*line 388
*line 389
*line 390
*line 391
move #13,R0
move R0,_CurScan
move R0,(sp)
clr R0
move R0,_CurLine
move R0,-(sp)
jsr _SetDTop
addq.l #2,sp
*line 392
bra L68
L67:
*line 393
*line 394
*line 395
*line 396
*line 397
move _LineAtr,(sp)
move.l _LinePtr,-(sp)
clr -(sp)
move _CurLine,-(sp)
move _SmScNsl,R0
add R0,(sp)
jsr _WrVideo
addq.l #8,sp
*line 398
*line 399
*line 400
*line 401
move _CurLine,R0
sub #2,R0
move R0,_DupLine
*line 402
*line 403
*line 404
tst _DupLine
blt L69
*line 404
move _LineAtr,(sp)
move.l _LinePtr,-(sp)
clr -(sp)
move _DupLine,-(sp)
jsr _WrVideo
addq.l #8,sp
L69:L68:
*line 405
*line 406
*line 407
*line 408
*line 409
sub #1,_CurScan
move _CurScan,(sp)
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
*line 410
*line 411
L66:bra L70
L65:
*line 412
*line 413
*line 414
*line 415
tst _CurScan
bne L71
*line 415
move #13,R0
move R0,_CurScan
move R0,(sp)
add #1,_CurLine
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
*line 416
bra L72
L71:
*line 417
sub #1,_CurScan
move _CurScan,(sp)
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
L72:L70:
*line 418
*line 419
*line 420
bra L73
L64:
*line 421
*line 421
tst _PdScDnF
beq L74
*line 422
*line 423
*line 423
cmp #13,_CurScan
bne L75
*line 424
*line 425
*line 425
move.l _BakLine,R8
jsr (R8)
move.l R0,_LinePtr
beq L76
*line 426
*line 427
*line 427
tst _CurLine
bne L77
*line 428
*line 429
*line 430
*line 431
move _LineAtr,(sp)
move.l _LinePtr,-(sp)
clr -(sp)
move _SmScLim,-(sp)
sub #1,(sp)
jsr _WrVideo
addq.l #8,sp
*line 432
*line 433
*line 434
*line 435
clr R0
move R0,_CurScan
move R0,(sp)
move _SmScLim,R0
sub #1,R0
move R0,_CurLine
move R0,-(sp)
jsr _SetDTop
addq.l #2,sp
*line 436
bra L78
L77:
*line 437
*line 438
*line 439
*line 440
*line 441
move _LineAtr,(sp)
move.l _LinePtr,-(sp)
clr -(sp)
move _CurLine,-(sp)
sub #1,(sp)
jsr _WrVideo
addq.l #8,sp
*line 442
*line 443
*line 444
*line 445
move _CurLine,R0
add _SmScNsl,R0
add #1,R0
move R0,_DupLine
*line 446
*line 447
*line 448
move _DupLine,R0
cmp _SmScTop,R0
bge L79
*line 448
move _LineAtr,(sp)
move.l _LinePtr,-(sp)
clr -(sp)
move _DupLine,-(sp)
jsr _WrVideo
addq.l #8,sp
*line 449
*line 450
*line 451
L79:
*line 452
clr R0
move R0,_CurScan
move R0,(sp)
sub #1,_CurLine
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
L78:
*line 453
*line 454
*line 455
L76:bra L80
L75:
*line 456
*line 457
*line 458
*line 459
cmp #13,_CurScan
beq L81
*line 459
add #1,_CurScan
move _CurScan,(sp)
move _CurLine,-(sp)
jsr _SetDTop
addq.l #2,sp
L81:L80:
*line 460
*line 461
L74:L73:L63:unlk R14
rts
.globl _smxupd
.text
_smxupd:
~~smxupd:
link R14,#-6
~oldcx=-2
*line 477
move _cxval,-2(R14)
*line 479
*line 479
tst _submenu
beq L83
*line 480
*line 481
move _cxrate,R0
add R0,_vtxval
move _vtxval,R0
asr #3,R0
move R0,_vtccol
*line 482
*line 483
*line 484
cmp #60,_vtccol
ble L84
*line 484
move #60,R0
move R0,_vtccol
asl #3,R0
move R0,_vtxval
bra L85
L84:
*line 485
*line 486
cmp #2,_vtccol
bge L86
*line 486
move #2,R0
move R0,_vtccol
asl #3,R0
move R0,_vtxval
*line 487
L86:L85:bra L87
L83:
*line 488
*line 489
*line 490
move _cxrate,R0
add R0,_cxval
*line 491
*line 492
*line 493
cmp #384,_cxval
ble L88
*line 493
move #384,_cxval
bra L89
L88:
*line 494
*line 495
cmp #16,_cxval
bge L90
*line 495
move #16,_cxval
*line 496
L90:L89:
*line 497
*line 498
move _cxval,R0
cmp -2(R14),R0
beq L82
*line 499
*line 500
*line 500
move _cxval,R0
asr #3,R0
cmp #47,R0
bne L91
*line 501
*line 502
*line 503
clr R0
move 10+_v_regs,R0
and #384,R0
beq L92
*line 503
clr (sp)
jsr _vbank
*line 504
L92:
*line 505
*line 506
move.l #_cg3,(sp)
move #14,-(sp)
move #14,-(sp)
move.l #L93,-(sp)
clr -(sp)
move #7,-(sp)
move #2,-(sp)
move #14,-(sp)
move #16,-(sp)
move.l _obj10,-(sp)
jsr _vvputsv
adda.l #22,sp
*line 507
*line 508
*line 509
move.l #_cg3,(sp)
move #14,-(sp)
move #14,-(sp)
move.l #L94,-(sp)
clr -(sp)
move #7,-(sp)
move #6,-(sp)
move #16,-(sp)
move.l _obj10,-(sp)
jsr _vsplot4
adda.l #20,sp
*line 510
bra L95
L91:
*line 511
*line 511
move _cxval,R0
asr #3,R0
cmp #48,R0
bne L96
*line 512
*line 513
*line 514
clr R0
move 10+_v_regs,R0
and #384,R0
beq L97
*line 514
clr (sp)
jsr _vbank
*line 515
L97:
*line 516
*line 517
move.l #_cg3,(sp)
move #14,-(sp)
move #14,-(sp)
move.l #L98,-(sp)
clr -(sp)
move #7,-(sp)
move #2,-(sp)
move #14,-(sp)
move #16,-(sp)
move.l _obj10,-(sp)
jsr _vvputsv
adda.l #22,sp
*line 518
*line 519
*line 520
move.l #_cg3,(sp)
move #14,-(sp)
move #14,-(sp)
move.l #L99,-(sp)
clr -(sp)
move #7,-(sp)
move #6,-(sp)
move #16,-(sp)
move.l _obj10,-(sp)
jsr _vsplot4
adda.l #20,sp
*line 521
*line 522
*line 523
L96:L95:bra L82
*line 524
L87:L82:unlk R14
rts
.globl _smy_up
.text
_smy_up:
~~smy_up:
~tag=8
link R14,#-4
*line 541
*line 541
tst _ptecpos
bne L101
*line 542
*line 543
jsr _dptw
bra L100
*line 544
*line 545
*line 546
L101:
*line 547
*line 548
tst _ctcsw
beq L102
*line 548
jsr _bgncm
*line 549
L102:
*line 550
*line 550
tst 8(R14)
bge L103
*line 551
*line 552
*line 553
move _ptecpos,(sp)
jsr _findnxt
tst R0
beq L100
*line 554
*line 555
move #1,_PdScUpF
*line 556
clr _PdScDnF
*line 557
jsr _smscrl
*line 558
bra L104
L103:
*line 559
*line 559
tst 8(R14)
ble L105
*line 560
*line 561
*line 562
move _ptecpos,(sp)
jsr _findprv
tst R0
beq L100
*line 563
*line 564
move #1,_PdScDnF
*line 565
clr _PdScUpF
*line 566
jsr _smscrl
*line 567
L105:L104:L100:unlk R14
rts
.globl _smyupd
.text
_smyupd:
~~smyupd:
link R14,#-4
*line 581
*line 581
tst _submenu
beq L107
*line 582
*line 583
move _cyrate,R0
add R0,_vtyval
move _vtyval,R0
ext.l R0
divs #14,R0
move R0,_vtcrow
*line 584
*line 585
*line 586
cmp #23,_vtcrow
ble L108
*line 586
move #23,R0
move R0,_vtcrow
muls #14,R0
move R0,_vtyval
bra L109
L108:
*line 587
*line 588
cmp #19,_vtcrow
bge L110
*line 588
move #19,R0
move R0,_vtcrow
muls #14,R0
move R0,_vtyval
*line 589
L110:L109:
*line 590
*line 591
*line 594
L107:L106:unlk R14
rts
.globl _sqy_up
.text
_sqy_up:
~~sqy_up:
~tag=8
link R14,#-4
*line 609
*line 610
tst _ctcsw
beq L112
*line 610
jsr _ctcoff
*line 611
L112:
*line 612
*line 612
tst 8(R14)
bge L113
*line 613
*line 614
move #1,_PdScUpF
*line 615
clr _PdScDnF
*line 616
jsr _smscrl
*line 617
bra L114
L113:
*line 618
*line 618
tst 8(R14)
ble L115
*line 619
*line 620
move #1,_PdScDnF
*line 621
clr _PdScUpF
*line 622
jsr _smscrl
*line 623
L115:L114:L111:unlk R14
rts
.globl _sqyupd
.text
_sqyupd:
~~sqyupd:
link R14,#-4
*line 637
*line 637
tst _submenu
beq L117
*line 638
*line 639
move _cyrate,R0
add R0,_vtyval
move _vtyval,R0
ext.l R0
divs #14,R0
move R0,_vtcrow
*line 640
*line 641
*line 642
cmp #23,_vtcrow
ble L118
*line 642
move #23,R0
move R0,_vtcrow
muls #14,R0
move R0,_vtyval
bra L119
L118:
*line 643
*line 644
cmp #19,_vtcrow
bge L120
*line 644
move #19,R0
move R0,_vtcrow
muls #14,R0
move R0,_vtyval
*line 645
L120:L119:
*line 646
*line 647
*line 650
L117:L116:unlk R14
rts
.data
L93:.dc.b $B0,$0
L94:.dc.b $BC,$0
L98:.dc.b $B0,$0
L99:.dc.b $BF,$0
