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
.globl _noteop
.globl _notesel
.globl _t_note
.globl _p_nbeg
.globl _p_nend
.globl _cflag
.globl _cnote
.globl _cyval
.globl _cxval
.globl _recsw
.globl _scmctl
.globl _grpmode
.globl _grpstat
.globl _ctime
.globl _accnote
.text
_accnote:
~~accnote:
link R14,#0
movem.l R6-R7,-(sp)
~rc=R7
*line 78
move #-1,R7
*line 80
*line 80
cmp.b #4,_ac_code
bne L2
tst _cflag
beq L2
*line 81
*line 82
*line 83
move _cnote,R7
add #1,R7
*line 84
bra L3
L2:
*line 85
*line 85
cmp.b #1,_ac_code
bne L4
tst _cflag
beq L4
*line 86
*line 87
*line 88
move _cnote,R7
sub #1,R7
*line 89
bra L5
L4:
*line 90
*line 91
*line 92
L5:L3:
*line 101
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ned_acc
.text
_ned_acc:
~~ned_acc:
~grp=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~nn=R7
~ep=R13
*line 122
*line 122
jsr _accnote
move R0,R7
cmp #-1,R7
bne L7
*line 123
*line 124
*line 125
move #-1,R0
bra L6
*line 126
*line 127
L7:
*line 128
*line 128
move #5,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L8
*line 129
*line 134
*line 135
*line 136
move.l _ctime,(R13)
*line 137
move.b #5,5(R13)
*line 138
move.b R7,6(R13)
*line 139
move 8(R14),R0
move.b R0,7(R13)
*line 140
move #16128,16(R13)
*line 141
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
*line 142
move #3,_noteop
*line 143
*line 144
clr R0
bra L6
*line 145
*line 146
L8:
*line 147
clr _noteop
*line 149
move #-1,R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _ned_nat
.text
_ned_nat:
~~ned_nat:
~grp=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~ep=R13
*line 169
*line 169
move #5,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L10
*line 170
*line 175
*line 176
*line 177
move.l _ctime,(R13)
*line 178
move.b #5,5(R13)
*line 179
move _cnote,R0
move.b R0,6(R13)
*line 180
move 8(R14),R0
move.b R0,7(R13)
*line 181
move #16128,16(R13)
*line 182
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
*line 183
move #3,_noteop
*line 184
*line 185
clr R0
bra L9
*line 186
*line 187
L10:
*line 188
clr _noteop
*line 190
move #-1,R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _nedesub
.text
_nedesub:
~~nedesub:
~grp=R7
~note=R6
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~ep=R13
~np=R12
~et=R5
*line 215
move 8(R14),R7
*line 215
move 10(R14),R6
*line 217
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R13
L14:
*line 229
*line 230
*line 231
move.b 5(R13),R5
ext.w R5
and #127,R5
*line 232
*line 233
move R5,R0
bra L16
*line 234
L17:
*line 235
*line 236
*line 237
*line 238
move.b 6(R13),R0
ext.w R0
cmp R0,R6
bne L18
move.b 7(R13),R0
ext.w R0
cmp R0,R7
bne L18
*line 239
*line 240
*line 241
move #1,R0
bra L11
*line 242
bra L19
L18:bra L15
L19:
*line 243
*line 244
L20:
*line 245
*line 246
*line 247
*line 248
move #1,R0
bra L11
*line 249
L21:
*line 250
*line 251
*line 252
*line 253
move.b 6(R13),R0
ext.w R0
cmp R0,R6
bne L22
move.b 7(R13),R0
ext.w R0
cmp R0,R7
bne L22
*line 254
*line 255
move.l 12(R13),R13
*line 256
*line 257
*line 258
L25:
*line 259
*line 260
*line 261
move.b 5(R13),R5
ext.w R5
and #127,R5
*line 262
*line 263
move R5,R0
bra L27
*line 264
L28:
*line 265
*line 266
*line 267
*line 268
move.b 6(R13),R0
ext.w R0
cmp R0,R6
bne L29
move.b 7(R13),R0
ext.w R0
cmp R0,R7
bne L29
*line 269
*line 270
*line 271
move #1,R0
bra L11
*line 272
*line 273
bra L30
L29:bra L26
L30:
*line 274
*line 275
*line 276
L31:
*line 277
*line 278
*line 279
*line 280
move.b 6(R13),R0
ext.w R0
cmp R0,R6
bne L32
move.b 7(R13),R0
ext.w R0
cmp R0,R7
bne L32
*line 281
L33:
*line 282
*line 283
*line 284
*line 285
*line 286
*line 286
move #5,(sp)
jsr _e_alc
move.l R0,R12
move.l R12,R0
beq L34
*line 287
*line 292
*line 293
*line 294
move.l _ctime,(R12)
*line 295
move.b #6,5(R12)
*line 296
move.b R6,6(R12)
*line 297
move.b R7,7(R12)
*line 298
move #16128,16(R12)
*line 299
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R12,-(sp)
jsr _e_ins
addq.l #4,sp
*line 300
*line 301
clr R0
bra L11
*line 302
bra L35
L34:
*line 303
*line 304
*line 305
*line 306
move #-1,R0
bra L11
L35:
*line 307
*line 308
*line 309
*line 310
L32:bra L26
L27:cmp #5,R0
beq L31
cmp #6,R0
beq L28
cmp #21,R0
beq L33
bra L26
L26:
*line 311
*line 312
*line 313
move.l 12(R13),R13
*line 314
L24:bra L25
L23:
*line 315
*line 316
*line 317
*line 318
L22:bra L15
L16:cmp #1,R0
beq L20
cmp #5,R0
beq L21
cmp #6,R0
beq L17
bra L15
L15:
*line 319
*line 320
*line 321
move.l 8(R13),R13
*line 322
L13:bra L14
L12:L11:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _ned_end
.text
_ned_end:
~~ned_end:
~grp=8
link R14,#0
movem.l R6-R7,-(sp)
~rc=R7
*line 350
*line 350
move _cnote,(sp)
move 8(R14),-(sp)
jsr _nedesub
addq.l #2,sp
move R0,R7
cmp #-1,R7
bne L37
*line 351
*line 352
clr _noteop
*line 353
*line 354
move #-1,R0
bra L36
*line 355
bra L38
L37:
*line 356
*line 356
tst R7
bne L39
*line 357
*line 358
clr _noteop
*line 359
*line 360
clr R0
bra L36
*line 361
bra L40
L39:
*line 362
*line 362
cmp #1,R7
beq L41
*line 363
*line 368
*line 369
*line 370
clr _noteop
*line 371
*line 372
move #-1,R0
bra L36
*line 373
*line 374
*line 375
*line 380
*line 381
L41:L40:L38:
*line 384
*line 384
move _cnote,(sp)
add #1,(sp)
move 8(R14),-(sp)
jsr _nedesub
addq.l #2,sp
move R0,R7
cmp #-1,R7
bne L42
*line 385
*line 386
clr _noteop
*line 387
*line 388
move #-1,R0
bra L36
*line 389
bra L43
L42:
*line 390
*line 390
cmp #1,R7
bne L44
*line 391
*line 392
clr _noteop
*line 393
*line 394
move #-1,R0
bra L36
*line 395
bra L45
L44:
*line 396
*line 396
tst R7
beq L46
*line 397
*line 402
*line 403
*line 404
clr _noteop
*line 405
*line 406
move #-1,R0
bra L36
*line 407
*line 408
L46:L45:L43:
*line 409
clr _noteop
*line 411
clr R0
bra L36
L36:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ned_mvn
.text
_ned_mvn:
~~ned_mvn:
~grp=8
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~bp=R13
~ep=R12
~note=R7
*line 432
*line 432
tst _notesel
beq L48
*line 433
*line 434
move.l _p_nbeg,R13
*line 435
move.l _p_nend,R12
*line 436
*line 437
*line 438
*line 439
*line 440
*line 441
*line 442
cmp.l _p_bak,R13
bne L49
*line 442
move.l 12(R13),_p_bak
*line 443
L49:
*line 444
*line 445
cmp.l _p_ctr,R13
bne L50
*line 445
move.l 12(R13),_p_ctr
*line 446
L50:
*line 447
*line 448
cmp.l _p_cur,R13
bne L51
*line 448
move.l 12(R13),_p_cur
*line 449
L51:
*line 450
*line 451
cmp.l _p_fwd,R13
bne L52
*line 451
move.l 12(R13),_p_fwd
*line 452
L52:
*line 453
move.l R13,(sp)
jsr _e_rmv
*line 454
*line 455
*line 456
*line 457
*line 458
*line 459
*line 460
*line 461
cmp.l _p_bak,R12
bne L53
*line 461
move.l 12(R12),_p_bak
*line 462
L53:
*line 463
*line 464
cmp.l _p_ctr,R12
bne L54
*line 464
move.l 12(R12),_p_ctr
*line 465
L54:
*line 466
*line 467
cmp.l _p_cur,R12
bne L55
*line 467
move.l 12(R12),_p_cur
*line 468
L55:
*line 469
*line 470
cmp.l _p_fwd,R12
bne L56
*line 470
move.l 12(R12),_p_fwd
*line 471
L56:
*line 472
move.l R12,(sp)
jsr _e_rmv
*line 473
*line 474
move.l _ctime,(R13)
*line 475
move.l _ctime,R0
add.l _t_note,R0
move.l R0,(R12)
*line 476
*line 477
*line 478
*line 479
*line 480
*line 481
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
*line 482
move.l _ctime,R0
add.l _t_note,R0
move.l R0,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R12,-(sp)
jsr _e_ins
addq.l #4,sp
*line 483
*line 484
clr _notesel
*line 485
clr _noteop
*line 486
*line 487
clr R0
bra L47
*line 488
bra L57
L48:
*line 489
*line 490
*line 491
*line 491
move _cnote,(sp)
move 8(R14),-(sp)
jsr _fcnote
addq.l #2,sp
tst.l R0
beq L58
*line 492
*line 493
move #1,_notesel
*line 494
*line 495
move #-1,R0
bra L47
*line 496
bra L59
L58:
*line 497
*line 497
jsr _accnote
move R0,R7
cmp #-1,R7
beq L60
*line 498
*line 499
*line 499
move R7,(sp)
move 8(R14),-(sp)
jsr _fcnote
addq.l #2,sp
move.l R0,R13
move.l R13,R0
beq L61
*line 500
*line 501
move #1,_notesel
*line 502
*line 503
move #-1,R0
bra L47
*line 504
L61:
*line 505
*line 506
L60:L59:
*line 507
clr _notesel
*line 508
clr _noteop
*line 509
*line 510
move #-1,R0
bra L47
L57:L47:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _ned_mvb
.text
_ned_mvb:
~~ned_mvb:
~grp=8
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~bp=R13
~ep=R12
~note=R7
*line 532
*line 532
tst _notesel
beq L63
*line 533
*line 534
move.l _p_nbeg,R13
*line 535
move.l _p_nend,R12
*line 536
*line 537
*line 537
move.l (R12),R0
cmp.l _ctime,R0
bgt L64
*line 538
*line 539
clr _noteop
*line 540
clr _notesel
*line 541
*line 542
move #-1,R0
bra L62
*line 543
*line 544
*line 545
*line 546
L64:
*line 547
*line 548
*line 549
*line 550
cmp.l _p_bak,R13
bne L65
*line 550
move.l 12(R13),_p_bak
*line 551
L65:
*line 552
*line 553
cmp.l _p_ctr,R13
bne L66
*line 553
move.l 12(R13),_p_ctr
*line 554
L66:
*line 555
*line 556
cmp.l _p_cur,R13
bne L67
*line 556
move.l 12(R13),_p_cur
*line 557
L67:
*line 558
*line 559
cmp.l _p_fwd,R13
bne L68
*line 559
move.l 12(R13),_p_fwd
*line 560
L68:
*line 561
move.l R13,(sp)
jsr _e_rmv
*line 562
*line 563
move.l _ctime,(R13)
*line 564
*line 565
*line 566
*line 567
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
*line 568
*line 569
clr _noteop
*line 570
clr _notesel
*line 571
*line 572
clr R0
bra L62
*line 573
*line 574
bra L69
L63:
*line 575
*line 576
*line 577
*line 577
move _cnote,(sp)
move 8(R14),-(sp)
jsr _fcnote
addq.l #2,sp
tst.l R0
beq L70
*line 578
*line 579
move #1,_notesel
*line 580
*line 581
move #-1,R0
bra L62
*line 582
bra L71
L70:
*line 583
*line 583
jsr _accnote
move R0,R7
cmp #-1,R7
beq L72
*line 584
*line 585
*line 585
move R7,(sp)
move 8(R14),-(sp)
jsr _fcnote
addq.l #2,sp
move.l R0,R13
move.l R13,R0
beq L73
*line 586
*line 587
move #1,_notesel
*line 588
*line 589
move #-1,R0
bra L62
*line 590
L73:
*line 591
*line 592
L72:L71:
*line 593
clr _notesel
*line 594
clr _noteop
*line 595
*line 596
move #-1,R0
bra L62
L69:L62:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _ned_mve
.text
_ned_mve:
~~ned_mve:
~grp=8
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~bp=R13
~ep=R12
~note=R7
*line 618
*line 618
tst _notesel
beq L75
*line 619
*line 620
move.l _p_nbeg,R13
*line 621
move.l _p_nend,R12
*line 622
*line 623
*line 623
move.l (R13),R0
cmp.l _ctime,R0
blt L76
*line 624
*line 625
clr _noteop
*line 626
clr _notesel
*line 627
*line 628
move #-1,R0
bra L74
*line 629
*line 630
*line 631
*line 632
L76:
*line 633
*line 634
*line 635
*line 636
cmp.l _p_bak,R12
bne L77
*line 636
move.l 12(R12),_p_bak
*line 637
L77:
*line 638
*line 639
cmp.l _p_ctr,R12
bne L78
*line 639
move.l 12(R12),_p_ctr
*line 640
L78:
*line 641
*line 642
cmp.l _p_cur,R12
bne L79
*line 642
move.l 12(R12),_p_cur
*line 643
L79:
*line 644
*line 645
cmp.l _p_fwd,R12
bne L80
*line 645
move.l 12(R12),_p_fwd
*line 646
L80:
*line 647
move.l R12,(sp)
jsr _e_rmv
*line 648
*line 649
move.l _ctime,(R12)
*line 650
*line 651
*line 652
*line 653
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R12,-(sp)
jsr _e_ins
addq.l #4,sp
*line 654
*line 655
clr _noteop
*line 656
clr _notesel
*line 657
*line 658
clr R0
bra L74
*line 659
bra L81
L75:
*line 660
*line 661
*line 662
*line 662
move _cnote,(sp)
move 8(R14),-(sp)
jsr _fcnote
addq.l #2,sp
tst.l R0
beq L82
*line 663
*line 664
move #1,_notesel
*line 665
*line 666
move #-1,R0
bra L74
*line 667
bra L83
L82:
*line 668
*line 668
jsr _accnote
move R0,R7
cmp #-1,R7
beq L84
*line 669
*line 670
*line 670
move R7,(sp)
move 8(R14),-(sp)
jsr _fcnote
addq.l #2,sp
move.l R0,R13
move.l R13,R0
beq L85
*line 671
*line 672
move #1,_notesel
*line 673
*line 674
move #-1,R0
bra L74
*line 675
L85:
*line 676
*line 677
L84:L83:
*line 678
clr _notesel
*line 679
clr _noteop
*line 680
*line 681
move #-1,R0
bra L74
L81:L74:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _donote
.text
_donote:
~~donote:
link R14,#0
movem.l R4-R7,-(sp)
~grp=R7
~i=R6
~gs=R5
*line 700
*line 700
cmp #-1,_scmctl
beq L87
*line 701
*line 702
bra L86
*line 703
*line 704
*line 705
L87:
*line 706
*line 706
tst _recsw
bne L88
*line 707
*line 708
bra L86
*line 709
*line 710
*line 711
*line 712
*line 713
L88:
*line 714
clr R5
*line 715
move #-1,R7
*line 717
clr R6
bra L91
L92:
*line 718
*line 719
*line 719
move R6,R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L93
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L93
*line 720
*line 721
move R6,R7
*line 722
add #1,R5
*line 726
*line 727
L93:L90:
*line 717
add #1,R6
L91:
*line 717
cmp #12,R6
blt L92
L89:
*line 737
*line 737
cmp #1,R5
beq L94
*line 738
*line 739
bra L86
*line 740
*line 741
*line 742
L94:
*line 743
*line 743
move _cyval,(sp)
move _cxval,-(sp)
jsr _pix2mid
addq.l #2,sp
tst R0
beq L95
*line 744
*line 749
*line 750
bra L86
*line 751
*line 752
*line 753
*line 754
*line 759
*line 760
L95:
*line 763
move _noteop,R0
bra L97
*line 764
L98:
*line 765
*line 766
*line 767
*line 768
move R7,(sp)
jsr _ned_acc
tst R0
bne L96
*line 769
*line 770
move.l _fc_val,(sp)
jsr _sc_refr
bra L96
*line 771
*line 772
L99:
*line 773
*line 774
*line 775
*line 776
move R7,(sp)
jsr _ned_nat
tst R0
bne L96
*line 777
*line 778
move.l _fc_val,(sp)
jsr _sc_refr
bra L96
*line 779
*line 780
L100:
*line 781
*line 782
*line 783
*line 784
move R7,(sp)
jsr _ned_end
tst R0
bne L96
*line 785
*line 786
move.l _fc_val,(sp)
jsr _sc_refr
bra L96
*line 787
*line 788
*line 789
L101:
*line 790
*line 791
*line 792
*line 793
move R7,(sp)
jsr _ned_mvn
tst R0
bne L96
*line 794
*line 795
move.l _fc_val,(sp)
jsr _sc_refr
bra L96
*line 796
*line 797
L102:
*line 798
*line 799
*line 800
*line 801
move R7,(sp)
jsr _ned_mvb
tst R0
bne L96
*line 802
*line 803
move.l _fc_val,(sp)
jsr _sc_refr
bra L96
*line 804
*line 805
L103:
*line 806
*line 807
*line 808
*line 809
move R7,(sp)
jsr _ned_mve
tst R0
bne L96
*line 810
*line 811
move.l _fc_val,(sp)
jsr _sc_refr
bra L96
*line 812
*line 813
L104:
*line 814
*line 815
*line 816
*line 817
clr _noteop
bra L96
L97:sub #1,R0
cmp #5,R0
bhi L104
asl #2,R0
move R0,R8
add.l #L105,R8
move.l (R8),R8
jmp (R8)
.data
L105:.dc.l L98
.dc.l L99
.dc.l L100
.dc.l L101
.dc.l L102
.dc.l L103
.text
L96:
*line 820
jsr _dnedmod
bra L86
L86:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
