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
.globl _sd
.globl _curasg
.globl _tmpoval
.globl _curtun
.globl _se_chg
.globl _spcount
.globl _frags
.globl _se1_cnt
.globl _se2_cnt
.globl _se3_cnt
.globl _pspool
.globl _size1
.globl _size2
.globl _size3
.globl _scores
.globl _seclist
.globl _hplist
.globl _stimes
.globl _scname
.globl _curscor
.globl _cursect
.globl _scp
.globl _t_bak
.globl _t_cur
.globl _t_ctr
.globl _t_fwd
.globl _p_bak
.globl _p_cur
.globl _p_ctr
.globl _p_fwd
.globl _spool
.globl _evleft
.text
_evleft:
~~evleft:
link R14,#-4
*line 146
*line 147
move.l #$6,-(sp)
move.l _se2_cnt,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,-(sp)
move.l #$5,-(sp)
move.l _se1_cnt,-(sp)
jsr lmul
addq.l #8,sp
add.l (sp)+,R0
move.l _se3_cnt,R1
asl.l #3,R1
add.l R1,R0
add.l _spcount,R0
bra L1
L1:unlk R14
rts
.globl _scinit
.text
_scinit:
~~scinit:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~i=R7
~cp=R13
*line 165
clr.l _se1_cnt
*line 166
clr.l _size1
*line 167
clr.l _se2_cnt
*line 168
clr.l _size2
*line 169
clr.l _se3_cnt
*line 170
clr.l _size3
*line 171
move.b #1,_se_chg
*line 172
clr.l _frags
*line 174
move.l #$8000,_spcount
*line 175
move.l #_spool,_pspool
*line 176
move.l #_spool,R13
*line 178
move.l _spcount,R7
bra L5
L6:
*line 179
clr.l (R13)+
L4:L5:
*line 178
move.l R7,R0
sub.l #$1,R7
tst.l R0
bgt L6
L3:
*line 181
clr.l R7
bra L9
L10:
*line 182
move #16,(sp)
move.l #L11,-(sp)
move.l R7,R0
asl.l #4,R0
add.l #_scname,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
L8:
*line 181
add.l #$1,R7
L9:
*line 181
cmp.l #$14,R7
blt L10
L7:
*line 184
move #40,(sp)
clr -(sp)
move.l #_scores,-(sp)
jsr _memsetw
addq.l #6,sp
*line 185
move #480,(sp)
clr -(sp)
move.l #_hplist,-(sp)
jsr _memsetw
addq.l #6,sp
*line 186
move #800,(sp)
clr -(sp)
move.l #_seclist,-(sp)
jsr _memsetw
addq.l #6,sp
*line 187
move #4800,(sp)
clr -(sp)
move.l #_stimes,-(sp)
jsr _memset
addq.l #6,sp
*line 189
clr.l R0
move.l R0,_t_ctr
move.l R0,_t_cur
*line 190
move.l _t_cur,R0
add.l #$ffffff10,R0
move.l R0,_t_bak
*line 191
move.l _t_cur,R0
add.l #$102,R0
move.l R0,_t_fwd
*line 193
clr.l _p_bak
*line 194
clr.l _p_cur
*line 195
clr.l _p_ctr
*line 196
clr.l _p_fwd
*line 197
clr.l _scp
*line 199
clr _curscor
*line 200
clr _cursect
*line 202
jsr _evleft
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _e_clr
.text
_e_clr:
~~e_clr:
~e1=R13
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 219
move.l 8(R14),R13
*line 219
move.b 4(R13),R0
ext.w R0
bra L14
*line 220
L15:
*line 221
*line 222
*line 223
clr.l 24(R13)
*line 224
clr.l 28(R13)
*line 225
L16:
*line 226
*line 227
*line 228
clr.l 20(R13)
*line 229
clr.l 16(R13)
*line 230
L17:
*line 231
*line 232
*line 233
clr.l 12(R13)
*line 234
clr.l 8(R13)
*line 235
*line 236
clr.l (R13)
*line 237
clr.b 5(R13)
*line 238
clr.b 6(R13)
*line 239
clr.b 7(R13)
bra L13
L14:cmp #5,R0
beq L17
cmp #6,R0
beq L16
cmp #8,R0
beq L15
bra L13
L13:
*line 242
move.l R13,R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _e_ins
.text
_e_ins:
~~e_ins:
~e1=R13
~e2=R12
link R14,#0
movem.l R7-R7/R11-R13,-(sp)
~t1=R11
*line 261
move.l 8(R14),R13
*line 261
move.l 12(R14),R12
*line 261
move.l 12(R12),R11
*line 262
move.l R11,12(R13)
*line 263
move.l R12,8(R13)
*line 264
move.l R13,12(R12)
*line 265
move.l R13,8(R11)
*line 266
move.l R13,R0
bra L18
L18:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.globl _e_rmv
.text
_e_rmv:
~~e_rmv:
~e1=R13
link R14,#0
movem.l R7-R7/R11-R13,-(sp)
~t1=R12
~t2=R11
*line 282
move.l 8(R14),R13
*line 282
move.l 8(R13),R12
*line 283
move.l 12(R13),R11
*line 284
move.l R11,12(R12)
*line 285
move.l R12,8(R11)
*line 286
clr.l 12(R13)
*line 287
clr.l 8(R13)
*line 288
move.l R13,R0
bra L19
L19:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.globl _e_alc
.text
_e_alc:
~~e_alc:
~w=8
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~ev=R13
~ex=R12
*line 307
move.b #1,_se_chg
*line 309
move 8(R14),R0
bra L22
*line 310
L23:
*line 311
*line 312
*line 313
*line 313
cmp.l #$5,_spcount
bge L24
*line 314
*line 315
*line 315
tst.l _se1_cnt
bne L25
*line 316
*line 317
*line 317
tst.l _se3_cnt
beq L26
*line 318
*line 319
move.l _size3,R12
*line 320
move.l 12(R12),_size3
*line 321
add.l #$1,_frags
*line 322
sub.l #$1,_se3_cnt
*line 323
move.b #5,4(R12)
*line 324
clr.l 12(R12)
*line 325
move.l R12,R0
bra L20
*line 326
bra L27
L26:
*line 327
*line 328
*line 329
*line 329
tst.l _se2_cnt
beq L28
*line 330
*line 331
move.l _size2,R12
*line 332
move.l _size2,R8
move.l 12(R8),_size2
*line 333
move.b #5,4(R12)
*line 334
clr.l 12(R12)
*line 335
add.l #$1,_frags
*line 336
sub.l #$1,_se2_cnt
*line 337
move.l R12,R0
bra L20
*line 338
bra L29
L28:
*line 339
*line 340
*line 341
clr.l R0
bra L20
L29:
*line 342
L27:
*line 343
*line 344
*line 345
bra L30
L25:
*line 346
*line 347
*line 348
move.l _size1,R12
*line 349
move.l _size1,R8
move.l 12(R8),_size1
*line 350
clr.l 12(R12)
*line 351
sub.l #$1,_se1_cnt
*line 352
move.l R12,R0
bra L20
L30:
*line 353
*line 354
bra L31
L24:
*line 355
*line 356
*line 357
move.l _pspool,R12
*line 358
add.l #20,_pspool
*line 359
sub.l #$5,_spcount
*line 360
move.b #5,4(R12)
*line 361
move.l R12,R0
bra L20
L31:
*line 362
*line 363
*line 364
*line 365
*line 366
L32:
*line 367
*line 368
*line 369
*line 369
cmp.l #$6,_spcount
bge L33
*line 370
*line 371
*line 371
tst.l _se2_cnt
bne L34
*line 372
*line 373
*line 373
tst.l _se3_cnt
beq L35
*line 374
*line 375
move.l _size3,R12
*line 376
move.l _size3,R8
move.l 12(R8),_size3
*line 377
move.b #6,4(R12)
*line 378
clr.l 12(R12)
*line 379
sub.l #$1,_se3_cnt
*line 380
add.l #$1,_frags
*line 381
move.l R12,R0
bra L20
*line 382
bra L36
L35:
*line 383
*line 384
*line 385
clr.l R0
bra L20
L36:
*line 386
*line 387
bra L37
L34:
*line 388
*line 389
*line 390
move.l _size2,R12
*line 391
move.l _size2,R8
move.l 12(R8),_size2
*line 392
clr.l 12(R12)
*line 393
sub.l #$1,_se2_cnt
*line 394
move.l R12,R0
bra L20
L37:
*line 395
*line 396
bra L38
L33:
*line 397
*line 398
*line 399
move.l _pspool,R12
*line 400
add.l #24,_pspool
*line 401
sub.l #$6,_spcount
*line 402
move.b #6,4(R12)
*line 403
move.l R12,R0
bra L20
*line 404
L38:
*line 405
*line 406
*line 407
*line 408
*line 409
L39:
*line 410
*line 411
*line 412
*line 412
cmp.l #$8,_spcount
bge L40
*line 413
*line 414
*line 414
tst.l _se3_cnt
bne L41
*line 415
*line 416
clr.l R0
bra L20
*line 417
bra L42
L41:
*line 418
*line 419
*line 420
move.l _size3,R12
*line 421
move.l _size3,R8
move.l 12(R8),_size3
*line 422
clr.l 12(R12)
*line 423
sub.l #$1,_se3_cnt
*line 424
move.l R12,R0
bra L20
L42:
*line 425
*line 426
bra L43
L40:
*line 427
*line 428
*line 429
move.l _pspool,R12
*line 430
add.l #32,_pspool
*line 431
sub.l #$8,_spcount
*line 432
move.b #8,4(R12)
*line 433
move.l R12,R0
bra L20
L43:
*line 434
*line 435
L44:
*line 436
*line 437
*line 438
clr.l R0
bra L20
bra L21
L22:cmp #5,R0
beq L23
cmp #6,R0
beq L32
cmp #8,R0
beq L39
bra L44
L21:
*line 441
clr.l R0
bra L20
L20:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _e_del
.text
_e_del:
~~e_del:
~e1=R13
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 458
move.l 8(R14),R13
*line 458
move.l R13,(sp)
jsr _e_clr
*line 460
move.b 4(R13),R0
ext.w R0
bra L47
*line 461
L48:
*line 462
*line 463
*line 464
move.l _size1,12(R13)
*line 465
move.l R13,_size1
*line 466
add.l #$1,_se1_cnt
bra L46
*line 467
*line 468
L49:
*line 469
*line 470
*line 471
move.l _size2,12(R13)
*line 472
move.l R13,_size2
*line 473
add.l #$1,_se2_cnt
bra L46
*line 474
*line 475
L50:
*line 476
*line 477
*line 478
move.l _size3,12(R13)
*line 479
move.l R13,_size3
*line 480
add.l #$1,_se3_cnt
bra L46
*line 481
*line 482
L51:
*line 483
*line 484
move #1,R0
bra L45
bra L46
L47:cmp #5,R0
beq L48
cmp #6,R0
beq L49
cmp #8,R0
beq L50
bra L51
L46:
*line 487
move.b #1,_se_chg
*line 488
clr R0
bra L45
L45:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _eh_ins
.text
_eh_ins:
~~eh_ins:
~ne=R13
~et=12
link R14,#0
movem.l R7-R7/R11-R13,-(sp)
~hp=R12
~ep=R11
*line 507
move.l 8(R14),R13
*line 507
move _curscor,R0
muls #48,R0
move 12(R14),R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
move.l (R8),R12
*line 509
*line 509
move.l R12,R0
bne L53
*line 510
*line 511
move _curscor,R0
muls #48,R0
move 12(R14),R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
move.l R13,(R8)
*line 512
clr.l 20(R13)
*line 513
clr.l 16(R13)
bra L52
*line 514
*line 515
*line 516
L53:
*line 517
*line 517
move.l (R12),R0
cmp.l (R13),R0
ble L54
*line 518
*line 519
move.l R13,16(R12)
*line 520
move.l R12,20(R13)
*line 521
clr.l 16(R13)
*line 522
move _curscor,R0
muls #48,R0
move 12(R14),R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
move.l R13,(R8)
bra L52
*line 523
*line 524
*line 525
L54:
*line 526
bra L57
L56:
*line 527
*line 528
*line 528
move.l (R11),R0
cmp.l (R13),R0
ble L58
*line 529
*line 530
move.l R11,20(R13)
*line 531
move.l R12,16(R13)
*line 532
move.l R13,20(R12)
*line 533
move.l R13,16(R11)
bra L52
*line 534
*line 535
*line 536
L58:
*line 537
move.l R11,R12
L57:
*line 538
move.l 20(R12),R11
move.l R11,R0
bne L56
L55:
*line 540
move.l R13,20(R12)
*line 541
clr.l 20(R13)
*line 542
move.l R12,16(R13)
bra L52
L52:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.globl _eh_rmv
.text
_eh_rmv:
~~eh_rmv:
~ev=R13
~et=12
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 560
move.l 8(R14),R13
*line 560
*line 561
move _curscor,R0
muls #48,R0
move 12(R14),R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
cmp.l (R8),R13
bne L60
*line 561
move _curscor,R0
muls #48,R0
move 12(R14),R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
move.l 20(R13),(R8)
*line 562
L60:
*line 563
*line 564
tst.l 20(R13)
beq L61
*line 564
move.l 20(R13),R8
move.l 16(R13),16(R8)
*line 565
L61:
*line 566
*line 567
tst.l 16(R13)
beq L62
*line 567
move.l 16(R13),R8
move.l 20(R13),20(R8)
*line 568
L62:
*line 569
clr.l R0
move.l R0,16(R13)
move.l R0,20(R13)
L59:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _sc_clr
.text
_sc_clr:
~~sc_clr:
~ns=R7
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~dsp=R13
~nsp=R12
~i=R6
*line 587
move 8(R14),R7
*line 587
*line 587
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l (R8),R12
move.l R12,R0
beq L64
*line 588
*line 589
bra L67
L66:
*line 590
*line 591
move.l R12,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 592
move.l R13,R12
*line 593
L67:
*line 594
move.l 12(R12),R13
cmp.l R13,R12
bne L66
L65:
*line 595
*line 596
move.l R12,(sp)
jsr _e_del
*line 597
*line 598
L64:
*line 599
clr R6
bra L70
L71:
*line 600
move R7,R0
muls #48,R0
move R6,R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
move.l #$0,(R8)
L69:
*line 599
add #1,R6
L70:
*line 599
cmp #12,R6
blt L71
L68:
*line 602
clr R6
bra L74
L75:
*line 603
*line 604
move R7,R0
muls #80,R0
move R6,R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_seclist,R0
move.l R0,R8
move.l #$0,(R8)
*line 605
move #12,(sp)
clr -(sp)
move R7,R0
muls #240,R0
add.l #_stimes,R0
move.l R0,-(sp)
jsr _memset
addq.l #6,sp
L73:
*line 602
add #1,R6
L74:
*line 602
cmp #20,R6
blt L75
L72:
*line 608
move #16,(sp)
move.l #L76,-(sp)
move R7,R0
asl #4,R0
ext.l R0
add.l #_scname,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
*line 610
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l #$0,(R8)
L63:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.globl _selscor
.text
_selscor:
~~selscor:
~ns=R7
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~oldscor=R6
~grp=R5
~nsp=R13
~ep=R12
*line 629
move 8(R14),R7
*line 629
clr (sp)
jsr _clkset
*line 630
jsr _dsclk
*line 631
clr.l _fc_val
*line 632
clr _sd
*line 633
move _curscor,R6
*line 634
move R7,_curscor
*line 636
*line 636
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l (R8),R13
move.l R13,R0
bne L78
*line 637
*line 638
*line 638
move #5,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
bne L79
*line 639
*line 640
move R6,_curscor
*line 641
move #-1,R0
bra L77
*line 642
*line 643
L79:
*line 644
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l R13,(R8)
*line 645
move.l R13,12(R13)
*line 646
move.l R13,8(R13)
*line 647
move.b #1,5(R13)
*line 648
move.b R7,6(R13)
*line 649
clr.l (R13)
*line 650
*line 651
*line 651
move #5,(sp)
jsr _e_alc
move.l R0,R12
move.l R12,R0
bne L80
*line 652
*line 653
move R7,(sp)
jsr _sc_clr
*line 654
move R6,_curscor
*line 655
move #-1,R0
bra L77
*line 656
*line 657
L80:
*line 658
move.b #21,5(R12)
*line 659
move.b R7,6(R12)
*line 660
move.l R13,(sp)
move.l R12,-(sp)
jsr _e_ins
addq.l #4,sp
*line 661
move.l #$7fffffff,(R12)
*line 662
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_scores,R8
move.l (R8),R13
*line 663
move #16,(sp)
move.l #L81,-(sp)
move R7,R0
asl #4,R0
ext.l R0
add.l #_scname,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
*line 664
*line 665
L78:
*line 666
move.l R13,_scp
*line 667
move.l R13,_p_bak
*line 668
move.l R13,_p_cur
*line 669
move.l R13,_p_ctr
*line 670
move.l R13,_p_fwd
*line 671
clr _cursect
*line 672
clr.l (sp)
jsr _sc_goto
*line 673
clr R0
bra L77
L77:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.data
L11:.dc.b $7B,$20,$65,$6D,$70,$74,$79,$20,$73,$63,$6F,$72,$65,$20,$20,$7D,$0
L76:.dc.b $7B,$20,$65,$6D,$70,$74,$79,$20,$73,$63,$6F,$72,$65,$20,$20,$7D,$0
L81:.dc.b $25,$25,$25,$20,$55,$6E,$74,$69,$74,$6C,$65,$64,$20,$25,$25,$25,$0
