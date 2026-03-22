.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
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
.globl _obj8
.globl _curintp
.globl _ctrsw
.globl _curasg
.globl _curtun
.globl _tmpoval
.globl _recsw
.globl _stccol
.globl _dspbuf
.globl _gdstbc
.globl _et_ioas
.text
_et_ioas:
~~et_ioas:
~n=8
link R14,#-4
*line 56
move _curasg,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 57
move #1,_ebflag
*line 59
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_ioas
.text
_ef_ioas:
~~ef_ioas:
~n=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ival=R7
~ep=R13
*line 77
clr.b 2+_ebuf
*line 78
move.b _ebuf,R7
ext.w R7
add #-48,R7
muls #10,R7
move.b 1+_ebuf,R0
ext.w R0
add R0,R7
add #-48,R7
*line 80
clr _ebflag
*line 82
*line 83
cmp #100,R7
blt L4
*line 83
move #-1,R0
bra L3
*line 84
L4:
*line 85
move R7,R0
move R0,_curasg
move R0,(sp)
jsr _getasg
*line 86
jsr _mpcupd
*line 88
*line 88
tst _recsw
beq L5
*line 89
*line 90
*line 90
move #-1,(sp)
move #-1,-(sp)
move #16,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L6
*line 91
*line 92
move.b R7,6(R13)
*line 93
bra L7
L6:
*line 94
*line 94
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L8
*line 95
*line 96
move.b #16,5(R13)
*line 97
move.b R7,6(R13)
*line 98
move.l _t_cur,(R13)
*line 99
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
move.l R0,R8
move.l 12(R8),_p_cur
*line 100
move #9,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 101
move #1,_ctrsw
*line 102
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 103
jsr _scupd
*line 104
L8:L7:
*line 105
*line 106
L5:
*line 107
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _rd_ioas
.text
_rd_ioas:
~~rd_ioas:
~n=8
link R14,#-4
*line 123
move _curasg,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 125
*line 126
clr R0
move 10+_v_regs,R0
and #384,R0
beq L11
*line 126
clr (sp)
jsr _vbank
*line 127
L11:
*line 128
move #19,(sp)
move.l #_dspbuf,-(sp)
move #11,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 129
clr R0
bra L9
L9:unlk R14
rts
.globl _nd_ioas
.text
_nd_ioas:
~~nd_ioas:
~n=8
~k=10
link R14,#0
movem.l R6-R7,-(sp)
~ec=R7
*line 144
move _stccol,R7
move.l _cfetp,R8
move 2(R8),R0
sub R0,R7
*line 145
move 10(R14),R0
add #48,R0
move R7,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 147
*line 148
clr R0
move 10+_v_regs,R0
and #384,R0
beq L13
*line 148
clr (sp)
jsr _vbank
*line 149
L13:
*line 150
move #99,(sp)
move 10(R14),-(sp)
add #48,(sp)
move _stccol,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 151
jsr _advscur
*line 152
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _et_tune
.text
_et_tune:
~~et_tune:
~n=8
link R14,#-4
*line 174
move _curtun,R0
add #48,R0
move.b R0,_ebuf
*line 175
clr.b 1+_ebuf
*line 176
move #1,_ebflag
*line 177
clr R0
bra L14
L14:unlk R14
rts
.globl _ef_tune
.text
_ef_tune:
~~ef_tune:
~n=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ival=R7
~ep=R13
*line 196
clr.b 1+_ebuf
*line 197
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 198
clr _ebflag
*line 199
move R7,(sp)
jsr _gettun
*line 201
*line 201
tst _recsw
beq L16
*line 202
*line 203
*line 203
move #-1,(sp)
move #-1,-(sp)
move #10,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L17
*line 204
*line 205
move.b R7,6(R13)
*line 206
bra L18
L17:
*line 207
*line 207
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L19
*line 208
*line 209
move.b #10,5(R13)
*line 210
move.b R7,6(R13)
*line 211
move.l _t_cur,(R13)
*line 212
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
move.l R0,R8
move.l 12(R8),_p_cur
*line 213
move #8,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 214
move #1,_ctrsw
*line 215
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 216
jsr _scupd
*line 217
L19:L18:
*line 218
*line 219
L16:
*line 220
clr R0
bra L15
L15:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _rd_tune
.text
_rd_tune:
~~rd_tune:
~n=8
link R14,#-4
*line 236
*line 237
clr R0
move 10+_v_regs,R0
and #384,R0
beq L21
*line 237
clr (sp)
jsr _vbank
*line 238
L21:
*line 239
move #20,(sp)
move _curtun,-(sp)
add #48,(sp)
move #19,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 241
clr R0
bra L20
L20:unlk R14
rts
.globl _nd_tune
.text
_nd_tune:
~~nd_tune:
~n=8
~k=10
link R14,#0
movem.l R6-R7,-(sp)
~ec=R7
*line 256
move 10(R14),R0
add #48,R0
move.b R0,_ebuf
*line 258
*line 259
clr R0
move 10+_v_regs,R0
and #384,R0
beq L23
*line 259
clr (sp)
jsr _vbank
*line 260
L23:
*line 261
move #100,(sp)
move 10(R14),-(sp)
add #48,(sp)
move _stccol,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 263
clr R0
bra L22
L22:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _et_tmpo
.text
_et_tmpo:
~~et_tmpo:
~n=8
link R14,#-4
*line 285
move _tmpoval,(sp)
move.l #L25,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 286
move #1,_ebflag
*line 288
clr R0
bra L24
L24:unlk R14
rts
.globl _ef_tmpo
.text
_ef_tmpo:
~~ef_tmpo:
~n=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ival=R7
~ep=R13
*line 307
clr.b 3+_ebuf
*line 308
*line 309
move.b _ebuf,R7
ext.w R7
add #-48,R7
muls #100,R7
move.b 1+_ebuf,R0
ext.w R0
add #-48,R0
muls #10,R0
add R0,R7
move.b 2+_ebuf,R0
ext.w R0
add R0,R7
add #-48,R7
*line 311
clr _ebflag
*line 313
*line 314
cmp #240,R7
bgt L10000
cmp #4,R7
bge L27
L10000:*line 314
move #-1,R0
bra L26
*line 315
L27:
*line 316
move R7,(sp)
jsr _settmpo
*line 318
*line 318
tst _recsw
beq L28
*line 319
*line 320
*line 320
move #-1,(sp)
move #-1,-(sp)
move #9,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L29
*line 321
*line 322
move.b R7,6(R13)
*line 323
bra L30
L29:
*line 324
*line 324
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L31
*line 325
*line 326
move.b #9,5(R13)
*line 327
move.b R7,6(R13)
*line 328
move.l _t_cur,(R13)
*line 329
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
move.l R0,R8
move.l 12(R8),_p_cur
*line 330
move #7,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 331
move #1,_ctrsw
*line 332
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 333
jsr _scupd
*line 334
L31:L30:
*line 335
*line 336
L28:
*line 337
clr R0
bra L26
L26:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _rd_tmpo
.text
_rd_tmpo:
~~rd_tmpo:
~n=8
link R14,#-4
*line 353
move _tmpoval,(sp)
move.l #L33,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 355
*line 356
clr R0
move 10+_v_regs,R0
and #384,R0
beq L34
*line 356
clr (sp)
jsr _vbank
*line 357
L34:
*line 358
move #19,(sp)
move.l #_dspbuf,-(sp)
move #27,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 360
clr R0
bra L32
L32:unlk R14
rts
.globl _nd_tmpo
.text
_nd_tmpo:
~~nd_tmpo:
~n=R7
~k=R6
link R14,#0
movem.l R4-R7,-(sp)
~ec=R5
*line 375
move 8(R14),R7
*line 375
move 10(R14),R6
*line 375
move _stccol,R5
move.l _cfetp,R8
move 2(R8),R0
sub R0,R5
*line 376
move R6,R0
add #48,R0
move R5,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 378
*line 379
clr R0
move 10+_v_regs,R0
and #384,R0
beq L36
*line 379
clr (sp)
jsr _vbank
*line 380
L36:
*line 381
move #99,(sp)
move R6,-(sp)
add #48,(sp)
move _stccol,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 382
jsr _advscur
*line 384
clr R0
bra L35
L35:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _et_intp
.text
_et_intp:
~~et_intp:
~n=8
link R14,#0
movem.l R2-R7,-(sp)
~th=R7
~tl=R6
~tt=R5
~sc=R4
~sf=R3
*line 409
move.l #$3e8,R4
*line 410
move.l #$64,R3
*line 411
move _curintp,(sp)
jsr _fromfpu
swap R0
clr R0
swap R0
move.l R0,R5
*line 412
move.l R4,-(sp)
move.l R5,-(sp)
jsr ldiv
addq.l #8,sp
move R0,R7
*line 413
move.l R3,-(sp)
move R7,R0
ext.l R0
move.l R0,-(sp)
move.l R4,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,-(sp)
move.l R5,R0
sub.l (sp)+,R0
move.l R0,-(sp)
jsr ldiv
addq.l #8,sp
move R0,R6
*line 415
move R6,(sp)
move R7,-(sp)
move.l #L38,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 416
move #1,_ebflag
*line 418
clr R0
bra L37
L37:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _ef_intp
.text
_ef_intp:
~~ef_intp:
~n=8
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~i=R7
~tmpval=R6
~ep=R13
*line 435
move.b #46,2+_ebuf
*line 436
clr.b 4+_ebuf
*line 437
clr _ebflag
*line 438
clr R6
*line 440
clr R7
bra L42
L43:
*line 441
mulu #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L41:
*line 440
add #1,R7
L42:
*line 440
cmp #2,R7
blt L43
L40:
*line 443
mulu #10,R6
move.b 3+_ebuf,R0
ext.w R0
add R0,R6
add #-48,R6
mulu #100,R6
*line 445
*line 446
cmp #-636,R6
bls L44
*line 446
move #-1,R0
bra L39
*line 447
L44:
*line 448
*line 449
tst R6
bne L45
*line 449
move #1,R6
*line 450
L45:
*line 451
move R6,(sp)
jsr _tofpu
move R0,_curintp
*line 453
*line 453
tst _recsw
beq L46
*line 454
*line 455
*line 455
move #-1,(sp)
move #-1,-(sp)
move #8,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L47
*line 456
*line 457
clr R0
move _curintp,R0
lsr #8,R0
move.b R0,6(R13)
*line 458
clr R0
move _curintp,R0
and #255,R0
move.b R0,7(R13)
*line 459
bra L48
L47:
*line 460
*line 460
move #8,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L49
*line 461
*line 462
move.b #8,5(R13)
*line 463
move.l _t_cur,(R13)
*line 464
clr R0
move _curintp,R0
lsr #8,R0
move.b R0,6(R13)
*line 465
clr R0
move _curintp,R0
and #255,R0
move.b R0,7(R13)
*line 466
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
move.l R0,R8
move.l 12(R8),_p_cur
*line 467
move #6,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 468
move #1,_ctrsw
*line 469
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 470
jsr _scupd
*line 471
L49:L48:
*line 472
*line 473
L46:
*line 474
clr R0
bra L39
L39:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _rd_intp
.text
_rd_intp:
~~rd_intp:
~n=8
link R14,#0
movem.l R2-R7,-(sp)
~th=R7
~tl=R6
~tt=R5
~sc=R4
~sf=R3
*line 493
move.l #$3e8,R4
*line 494
move.l #$64,R3
*line 495
move _curintp,(sp)
jsr _fromfpu
swap R0
clr R0
swap R0
move.l R0,R5
*line 496
move.l R4,-(sp)
move.l R5,-(sp)
jsr ldiv
addq.l #8,sp
move R0,R7
*line 497
move.l R3,-(sp)
move R7,R0
ext.l R0
move.l R0,-(sp)
move.l R4,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,-(sp)
move.l R5,R0
sub.l (sp)+,R0
move.l R0,-(sp)
jsr ldiv
addq.l #8,sp
move R0,R6
*line 499
move R6,(sp)
move R7,-(sp)
move.l #L51,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 501
clr (sp)
jsr _vbank
*line 503
move #20,(sp)
move.l #_dspbuf,-(sp)
move #35,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 505
clr R0
bra L50
L50:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _nd_intp
.text
_nd_intp:
~~nd_intp:
~n=8
~k=10
link R14,#0
movem.l R6-R7,-(sp)
~ec=R7
*line 520
move _stccol,R7
move.l _cfetp,R8
move 2(R8),R0
sub R0,R7
*line 522
*line 523
cmp #2,R7
bne L53
*line 523
move #-1,R0
bra L52
*line 524
L53:
*line 525
*line 526
tst R7
bne L54
cmp #6,10(R14)
ble L54
*line 526
move #-1,R0
bra L52
*line 527
L54:
*line 528
*line 529
cmp #1,R7
bne L55
cmp.b #54,_ebuf
bne L55
cmp #4,10(R14)
ble L55
*line 529
move #-1,R0
bra L52
*line 530
L55:
*line 531
move 10(R14),R0
add #48,R0
move R7,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 532
move.b #46,2+_ebuf
*line 533
clr.b 4+_ebuf
*line 535
move 10(R14),R0
add #48,R0
move.b R0,_dspbuf
*line 536
clr.b 1+_dspbuf
*line 538
clr (sp)
jsr _vbank
*line 540
move #100,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move #1,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 542
jsr _advscur
*line 544
*line 545
cmp #37,_stccol
bne L56
*line 545
jsr _advscur
*line 546
L56:
*line 547
clr R0
bra L52
L52:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$2E,$32,$64,$0
L10:.dc.b $25,$30,$32,$2E,$32,$64,$0
L25:.dc.b $25,$30,$33,$2E,$33,$64,$0
L33:.dc.b $25,$30,$33,$2E,$33,$64,$0
L38:.dc.b $25,$30,$32,$64,$2E,$25,$64,$0
L51:.dc.b $25,$30,$32,$64,$2E,$25,$64,$0
