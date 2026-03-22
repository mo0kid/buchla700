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
.globl _seqtab
.globl _seqflag
.globl _seqline
.globl _seqstim
.globl _seqtime
.globl _sregval
.globl _trstate
.globl _ptegood
.globl _ptedfok
.globl _ptestok
.globl _ptedsok
.globl _ptedtok
.globl _ptedef
.globl _ptestm
.globl _ptespec
.globl _ptesuba
.globl _ptedat1
.globl _pteset
.globl _ptecpos
.globl _ptepred
.globl _ptesucc
.globl _ptebuf
.globl _ptdebuf
.globl _dtfree
.comm _dtfree,2
.globl _ptfree
.comm _ptfree,2
.globl _dpepred
.comm _dpepred,2
.globl _dpecpos
.comm _dpecpos,2
.globl _dpesucc
.comm _dpesucc,2
.globl _ptdsbuf
.comm _ptdsbuf,50
.globl _defptr
.comm _defptr,5120
.globl _stmptr
.comm _stmptr,5120
.globl _defents
.comm _defents,2560
.globl _patches
.comm _patches,4096
.globl _ptefifo
.comm _ptefifo,16
.globl _ptewrds
.comm _ptewrds,512
.globl _dmatch
.data
_dmatch:
.dc.b $0
.dc.b $0
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
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.dc.b $1
.even
.globl _initpt
.text
_initpt:
~~initpt:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 107
move #64,(sp)
move #192,-(sp)
move #256,-(sp)
move.l #_ptewrds,-(sp)
move.l #_ptefifo,-(sp)
jsr _setwq
adda.l #12,sp
*line 111
move #5120,(sp)
clr -(sp)
move.l #_defptr,-(sp)
jsr _memset
addq.l #6,sp
*line 112
move #5120,(sp)
clr -(sp)
move.l #_stmptr,-(sp)
jsr _memset
addq.l #6,sp
*line 116
move #4096,(sp)
clr -(sp)
move.l #_patches,-(sp)
jsr _memset
addq.l #6,sp
*line 118
move #1,R7
bra L4
L5:
*line 119
clr R0
move R7,R0
add #1,R0
clr R1
move R7,R1
lsl #4,R1
swap R1
clr R1
swap R1
add.l #_patches,R1
move.l R1,R9
move R0,(R9)
L3:
*line 118
add #1,R7
L4:
*line 118
cmp #255,R7
blo L5
L2:
*line 121
move #1,_ptfree
*line 125
move #2560,(sp)
clr -(sp)
move.l #_defents,-(sp)
jsr _memset
addq.l #6,sp
*line 127
move #1,R7
bra L8
L9:
*line 128
clr R0
move R7,R0
add #1,R0
clr R1
move R7,R1
mulu #10,R1
add.l #_defents,R1
move.l R1,R9
move R0,(R9)
L7:
*line 127
add #1,R7
L8:
*line 127
cmp #255,R7
blo L9
L6:
*line 130
move #1,_dtfree
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _pt_alc
.text
_pt_alc:
~~pt_alc:
link R14,#0
movem.l R6-R7,-(sp)
~pe=R7
*line 147
*line 148
move _ptfree,R7
tst R7
beq L11
*line 148
clr R0
move R7,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
move.l R0,R8
move (R8),_ptfree
*line 149
L11:
*line 150
clr R0
move R7,R0
bra L10
L10:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _pt_del
.text
_pt_del:
~~pt_del:
~pe=R7
link R14,#0
movem.l R6-R7,-(sp)
*line 162
move 8(R14),R7
*line 162
clr R0
move R7,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
move.l R0,R8
move _ptfree,(R8)
*line 163
move R7,_ptfree
L12:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _dt_alc
.text
_dt_alc:
~~dt_alc:
link R14,#0
movem.l R6-R7,-(sp)
~de=R7
*line 180
*line 181
move _dtfree,R7
tst R7
beq L14
*line 181
clr R0
move R7,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move (R8),_dtfree
*line 182
L14:
*line 183
clr R0
move R7,R0
bra L13
L13:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _dt_del
.text
_dt_del:
~~dt_del:
~de=R7
link R14,#0
movem.l R6-R7,-(sp)
*line 195
move 8(R14),R7
*line 195
clr R0
move R7,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _dtfree,(R8)
*line 196
move R7,_dtfree
L15:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _cprdpe
.text
_cprdpe:
~~cprdpe:
~np=8
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~ca=R7
~cb=R6
~ct=R5
~pp=R13
*line 220
clr R0
move 8(R14),R0
mulu #10,R0
move.l R0,R13
add.l #_defents,R13
*line 222
*line 223
move _ptestm,R6
clr R0
move R6,R0
move 2(R13),R5
clr R1
move R5,R1
cmp R1,R0
bcc L17
*line 223
move #-1,R0
bra L16
*line 224
L17:
*line 225
*line 226
cmp R5,R6
bls L18
*line 226
move #1,R0
bra L16
*line 227
L18:
*line 228
*line 229
move _ptespec,R7
and #255,R7
clr R0
move R7,R0
move 4(R13),R5
and #255,R5
clr R1
move R5,R1
cmp R1,R0
bcc L19
*line 229
move #-1,R0
bra L16
*line 230
L19:
*line 231
*line 232
cmp R5,R7
bls L20
*line 232
move #1,R0
bra L16
*line 233
L20:
*line 234
*line 235
move _ptesuba,R6
clr R0
move R6,R0
move 6(R13),R5
clr R1
move R5,R1
cmp R1,R0
bcc L21
*line 235
move #-1,R0
bra L16
*line 236
L21:
*line 237
*line 238
cmp R5,R6
bls L22
*line 238
move #1,R0
bra L16
*line 239
*line 240
*line 241
*line 242
L22:
*line 243
*line 243
move.l #_dmatch,R8
tst.b 0(R8,R7)
beq L23
*line 244
*line 245
*line 246
move _ptedat1,R6
clr R0
move R6,R0
move 8(R13),R5
clr R1
move R5,R1
cmp R1,R0
bcc L24
*line 246
move #-1,R0
bra L16
*line 247
L24:
*line 248
*line 249
cmp R5,R6
bls L25
*line 249
move #1,R0
bra L16
*line 250
bra L26
L25:
*line 251
clr R0
bra L16
L26:
*line 252
bra L27
L23:
*line 253
*line 254
*line 255
clr R0
bra L16
L27:L16:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _finddpe
.text
_finddpe:
~~finddpe:
link R14,#0
movem.l R5-R7,-(sp)
~c=R7
~idef=R6
*line 281
clr _dpepred
*line 282
clr _dpecpos
*line 283
clr _dpesucc
*line 298
*line 298
clr R0
move 4+_ptebuf,R0
and #8191,R0
move R0,R8
move.l #_defptr,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R6
tst R6
bne L29
*line 299
*line 307
*line 308
*line 309
move #1,R0
bra L28
*line 310
*line 311
*line 312
*line 313
*line 314
L29:
*line 315
bra L32
L31:
*line 316
*line 317
*line 318
*line 319
*line 319
move R6,(sp)
jsr _cprdpe
move R0,R7
cmp #1,R7
beq L33
*line 320
*line 321
*line 321
tst R7
bne L34
*line 322
*line 323
move R6,_dpecpos
*line 324
clr R0
move R6,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move (R8),_dpesucc
*line 325
*line 326
*line 327
*line 337
L34:
*line 338
clr R0
move R7,R0
bra L28
*line 339
*line 340
L33:
*line 341
move R6,_dpepred
*line 342
clr R0
move R6,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move (R8),R6
L32:
*line 343
tst R6
bne L31
L30:
*line 354
move #-1,R0
bra L28
L28:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _cprpte
.text
_cprpte:
~~cprpte:
~np=8
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~ca=R7
~cb=R6
~ct=R5
~pb=R13
~pp=R12
*line 378
move.l #_ptebuf,R13
*line 379
clr R0
move 8(R14),R0
lsl #4,R0
swap R0
clr R0
swap R0
move.l R0,R12
add.l #_patches,R12
*line 381
*line 382
move 6(R13),R6
clr R0
move R6,R0
move 6(R12),R5
clr R1
move R5,R1
cmp R1,R0
bcc L36
*line 382
move #-1,R0
bra L35
*line 383
L36:
*line 384
*line 385
cmp R5,R6
bls L37
*line 385
move #1,R0
bra L35
*line 386
L37:
*line 387
*line 388
move 4(R13),R6
clr R0
move R6,R0
move 4(R12),R5
clr R1
move R5,R1
cmp R1,R0
bcc L38
*line 388
move #-1,R0
bra L35
*line 389
L38:
*line 390
*line 391
cmp R5,R6
bls L39
*line 391
move #1,R0
bra L35
*line 392
L39:
*line 393
*line 394
move 8(R13),R7
and #255,R7
clr R0
move R7,R0
move 8(R12),R5
and #255,R5
clr R1
move R5,R1
cmp R1,R0
bcc L40
*line 394
move #-1,R0
bra L35
*line 395
L40:
*line 396
*line 397
cmp R5,R7
bls L41
*line 397
move #1,R0
bra L35
*line 398
L41:
*line 399
*line 400
move 10(R13),R6
clr R0
move R6,R0
move 10(R12),R5
clr R1
move R5,R1
cmp R1,R0
bcc L42
*line 400
move #-1,R0
bra L35
*line 401
L42:
*line 402
*line 403
cmp R5,R6
bls L43
*line 403
move #1,R0
bra L35
*line 404
*line 405
*line 406
*line 407
L43:
*line 408
*line 408
move.l #_dmatch,R8
tst.b 0(R8,R7)
beq L44
*line 409
*line 410
*line 411
move 12(R13),R6
clr R0
move R6,R0
move 12(R12),R5
clr R1
move R5,R1
cmp R1,R0
bcc L45
*line 411
move #-1,R0
bra L35
*line 412
L45:
*line 413
*line 414
cmp R5,R6
bls L46
*line 414
move #1,R0
bra L35
*line 415
bra L47
L46:
*line 416
clr R0
bra L35
L47:
*line 417
bra L48
L44:
*line 418
*line 419
*line 420
clr R0
bra L35
L48:L35:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _findpte
.text
_findpte:
~~findpte:
link R14,#0
movem.l R5-R7,-(sp)
~c=R7
~istim=R6
*line 446
clr _ptepred
*line 447
clr _ptecpos
*line 448
clr _ptesucc
*line 463
*line 463
clr R0
move 6+_ptebuf,R0
and #8191,R0
move R0,R8
move.l #_stmptr,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R6
tst R6
bne L50
*line 464
*line 472
*line 473
*line 474
move #1,R0
bra L49
*line 475
*line 476
*line 477
*line 478
*line 479
L50:
*line 480
bra L53
L52:
*line 481
*line 482
*line 483
*line 484
*line 484
move R6,(sp)
jsr _cprpte
move R0,R7
cmp #1,R7
beq L54
*line 485
*line 486
*line 486
tst R7
bne L55
*line 487
*line 488
move R6,_ptecpos
*line 489
clr R0
move R6,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
move.l R0,R8
move (R8),_ptesucc
*line 490
*line 491
*line 492
*line 502
L55:
*line 503
clr R0
move R7,R0
bra L49
*line 504
*line 505
L54:
*line 506
move R6,_ptepred
*line 507
clr R0
move R6,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
move.l R0,R8
move (R8),R6
L53:
*line 508
tst R6
bne L52
L51:
*line 519
move #-1,R0
bra L49
L49:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _entrpte
.text
_entrpte:
~~entrpte:
link R14,#0
movem.l R4-R7,-(sp)
~c=R7
~np=R6
~stim=R5
*line 536
tst _ptedfok
beq L10001
tst _ptestok
beq L10001
tst _ptedsok
beq L10001
tst _ptedtok
bne L10000
L10001:clr R0
bra L10002
L10000:move #1,R0
L10002:move R0,_ptegood
*line 538
*line 538
tst _ptegood
beq L57
*line 539
*line 540
jsr _buf2pte
*line 541
*line 542
jsr _findpte
move R0,R7
*line 543
*line 544
*line 544
tst R7
bne L58
*line 545
*line 546
move #6,(sp)
move.l #4+_ptebuf,-(sp)
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,-(sp)
add.l #4,(sp)
jsr _memcpyw
addq.l #8,sp
*line 547
*line 548
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
or #-32768,8(R8)
*line 549
*line 558
*line 559
bra L56
*line 560
*line 561
*line 562
*line 563
*line 564
*line 565
L58:
*line 566
*line 566
jsr _pt_alc
move R0,_ptecpos
bne L59
*line 567
*line 571
bra L56
*line 572
*line 573
*line 574
L59:
*line 575
move #6,(sp)
move.l #4+_ptebuf,-(sp)
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,-(sp)
add.l #4,(sp)
jsr _memcpyw
addq.l #8,sp
*line 576
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
or #-32768,8(R8)
*line 577
move 6+_ptebuf,R5
and #8191,R5
*line 578
*line 579
*line 579
cmp #1,R7
bne L60
*line 580
*line 581
clr _ptepred
*line 582
move _ptecpos,R0
clr R9
move R5,R9
add.l #_stmptr,R9
move.b R0,(R9)
*line 583
*line 584
*line 585
*line 586
*line 587
L60:
*line 588
*line 588
tst _ptepred
beq L61
*line 589
*line 590
move _ptepred,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move (R8),_ptesucc
*line 591
*line 592
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move _ptesucc,(R8)
*line 593
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move _ptepred,2(R8)
*line 594
*line 595
move _ptepred,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move _ptecpos,(R8)
*line 596
*line 597
*line 598
tst _ptesucc
beq L62
*line 598
move _ptesucc,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move _ptecpos,2(R8)
*line 599
L62:bra L63
L61:
*line 600
*line 601
*line 602
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
clr 2(R8)
*line 603
*line 604
*line 604
cmp #-1,R7
bne L64
*line 605
*line 606
move.l #_stmptr,R8
move.b 0(R8,R5),R0
ext.w R0
move R0,_ptesucc
*line 607
*line 608
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move _ptesucc,(R8)
*line 609
*line 610
move _ptesucc,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move _ptecpos,2(R8)
*line 611
*line 612
move _ptecpos,R0
clr R9
move R5,R9
add.l #_stmptr,R9
move.b R0,(R9)
*line 613
bra L65
L64:
*line 614
*line 615
*line 616
move _ptecpos,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
clr (R8)
L65:
*line 617
L63:
*line 618
*line 619
*line 620
*line 621
*line 622
*line 623
*line 623
jsr _finddpe
move R0,R7
tst R7
bne L66
*line 624
*line 628
bra L56
*line 629
*line 630
*line 631
L66:
*line 632
*line 632
jsr _dt_alc
move R0,_dpecpos
bne L67
*line 633
*line 637
bra L56
*line 638
*line 639
*line 640
L67:
*line 641
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
clr (R8)
*line 642
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _ptestm,2(R8)
*line 643
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _ptespec,4(R8)
*line 644
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _ptesuba,6(R8)
*line 645
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _ptedat1,8(R8)
*line 646
*line 647
move 4+_ptebuf,R6
and #8191,R6
*line 648
*line 649
*line 649
cmp #1,R7
bne L68
*line 650
*line 651
clr _dpepred
*line 652
clr R0
move _dpecpos,R0
clr R9
move R6,R9
add.l #_defptr,R9
move.b R0,(R9)
*line 653
*line 654
L68:
*line 655
*line 655
tst _dpepred
beq L69
*line 656
*line 657
clr R0
move _dpepred,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move (R8),_dpesucc
*line 658
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _dpesucc,(R8)
*line 659
clr R0
move _dpepred,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _dpecpos,(R8)
*line 660
bra L70
L69:
*line 661
*line 662
*line 663
*line 663
cmp #-1,R7
bne L71
*line 664
*line 665
move.l #_defptr,R8
move.b 0(R8,R6),R0
ext.w R0
move R0,_dpesucc
*line 666
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
move _dpesucc,(R8)
*line 667
clr R0
move _dpecpos,R0
clr R9
move R6,R9
add.l #_defptr,R9
move.b R0,(R9)
*line 668
bra L72
L71:
*line 669
*line 670
*line 671
clr R0
move _dpecpos,R0
mulu #10,R0
add.l #_defents,R0
move.l R0,R8
clr (R8)
L72:
*line 672
L70:
*line 673
*line 674
*line 683
bra L56
*line 684
*line 685
*line 686
*line 695
L57:L56:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _find1st
.text
_find1st:
~~find1st:
link R14,#0
movem.l R5-R7,-(sp)
~cp=R7
~pp=R6
*line 712
clr R7
bra L76
L77:
*line 713
*line 714
move.l #_stmptr,R8
move.b 0(R8,R7),R0
ext.w R0
move R0,R6
and #255,R6
tst R6
beq L78
*line 714
move R6,R0
bra L73
*line 715
L78:L75:
*line 712
add #1,R7
L76:
*line 712
cmp #5120,R7
blt L77
L74:
*line 716
clr R0
bra L73
L73:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _findnxt
.text
_findnxt:
~~findnxt:
~cp=8
link R14,#0
movem.l R5-R7,-(sp)
~np=R7
~stim=R6
*line 731
*line 732
move 8(R14),R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move (R8),R7
tst R7
beq L80
*line 732
move R7,R0
bra L79
*line 733
L80:
*line 734
move 8(R14),R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move 6(R8),R6
and #8191,R6
*line 736
bra L83
L82:
*line 737
*line 738
move.l #_stmptr,R8
move.b 0(R8,R6),R0
ext.w R0
move R0,R7
and #255,R7
tst R7
beq L84
*line 738
move R7,R0
bra L79
*line 739
L84:L83:
*line 740
add #1,R6
move R6,R0
cmp #5120,R0
blt L82
L81:
*line 740
clr R0
bra L79
L79:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _findprv
.text
_findprv:
~~findprv:
~cp=8
link R14,#0
movem.l R4-R7,-(sp)
~np=R7
~pp=R6
~stim=R5
*line 758
*line 759
move 8(R14),R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move 2(R8),R7
tst R7
beq L86
*line 759
move R7,R0
bra L85
*line 760
L86:
*line 761
move 8(R14),R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move 6(R8),R5
and #8191,R5
*line 763
bra L89
L88:
*line 764
*line 765
*line 765
move.l #_stmptr,R8
move.b 0(R8,R5),R0
ext.w R0
move R0,R7
and #255,R7
tst R7
beq L90
*line 766
*line 767
*line 768
*line 769
bra L93
L92:
*line 770
move R6,R7
L93:
*line 770
move R7,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,R8
move (R8),R6
bne L92
L91:
*line 771
*line 772
move R7,R0
bra L85
*line 773
L90:L89:
*line 774
sub #1,R5
bge L88
L87:
*line 776
clr R0
bra L85
L85:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _dpte
.text
_dpte:
~~dpte:
~pe=R7
~row=R6
~atr=R5
link R14,#0
movem.l R3-R7,-(sp)
~i=R4
*line 793
move 8(R14),R7
*line 793
move 10(R14),R6
*line 793
move 12(R14),R5
*line 793
move #50,(sp)
move #32,-(sp)
move.l #_ptdsbuf,-(sp)
jsr _memset
addq.l #6,sp
*line 795
*line 795
tst R7
beq L95
*line 796
*line 797
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_patches,R9
move 4(R8,R9.l),(sp)
move.l #2+_ptdsbuf,-(sp)
jsr _dspdfst
addq.l #4,sp
*line 798
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_patches,R9
move 6(R8,R9.l),(sp)
move.l #15+_ptdsbuf,-(sp)
jsr _dspdfst
addq.l #4,sp
*line 799
move R7,R0
asl #4,R0
ext.l R0
add.l #_patches,R0
move.l R0,(sp)
move.l #28+_ptdsbuf,-(sp)
jsr _dspdest
addq.l #4,sp
*line 800
*line 801
clr R4
bra L98
L99:
*line 802
*line 803
move R4,R8
add.l #_ptdsbuf,R8
tst.b (R8)
bne L100
*line 803
move R4,R8
add.l #_ptdsbuf,R8
move.b #32,(R8)
*line 804
L100:L97:
*line 801
add #1,R4
L98:
*line 801
cmp #50,R4
blt L99
L96:
*line 805
clr.b 48+_ptdsbuf
*line 806
*line 807
L95:
*line 808
move #226,(sp)
move.l #L101,-(sp)
clr -(sp)
move R6,-(sp)
jsr _UpdVid
addq.l #8,sp
*line 809
move R5,(sp)
move.l #1+_ptdsbuf,-(sp)
move #1,-(sp)
move R6,-(sp)
jsr _UpdVid
addq.l #8,sp
L94:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _dptw
.text
_dptw:
~~dptw:
link R14,#0
movem.l R3-R7,-(sp)
~cp=R7
~r=R6
~row=R5
~pp=R4
*line 830
*line 830
tst _ptecpos
beq L103
*line 831
*line 832
*line 833
*line 834
move #7,R5
*line 835
move _ptecpos,R4
*line 836
*line 837
bra L106
L105:
*line 838
*line 839
move R7,R4
*line 840
*line 841
*line 842
sub #1,R5
beq L104
L106:
*line 843
move R4,(sp)
jsr _findprv
move R0,R7
tst R7
bne L105
L104:
*line 844
*line 848
*line 849
*line 850
*line 850
tst R5
beq L107
*line 851
*line 852
clr R6
bra L110
L111:
*line 853
move #18,(sp)
move R6,-(sp)
clr -(sp)
jsr _dpte
addq.l #4,sp
L109:
*line 852
add #1,R6
L110:
*line 852
cmp R5,R6
blt L111
L108:
*line 853
*line 854
*line 855
L107:
*line 856
bra L114
L113:
*line 857
*line 858
move #18,(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
*line 859
move R4,(sp)
jsr _findnxt
move R0,R4
L114:
*line 860
cmp #7,R5
blt L113
L112:
*line 861
*line 862
*line 863
*line 864
*line 869
*line 870
*line 871
move #18,(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
*line 872
*line 873
*line 874
*line 875
bra L117
L116:
*line 876
*line 877
move #18,(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
*line 878
*line 879
*line 880
cmp #15,R5
bgt L115
L117:
*line 881
move R4,(sp)
jsr _findnxt
move R0,R4
tst R4
bne L116
L115:
*line 882
*line 883
*line 884
bra L120
L119:
*line 885
move #18,(sp)
move R5,-(sp)
clr -(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
L120:
*line 885
cmp #16,R5
blt L119
L118:
*line 886
*line 887
bra L121
L103:
*line 888
*line 889
*line 890
*line 890
jsr _find1st
move R0,_ptecpos
beq L122
*line 891
*line 895
*line 896
*line 897
*line 898
*line 899
clr R5
bra L125
L126:
*line 900
move #18,(sp)
move R5,-(sp)
clr -(sp)
jsr _dpte
addq.l #4,sp
L124:
*line 899
add #1,R5
L125:
*line 899
cmp #7,R5
blt L126
L123:
*line 900
*line 901
*line 902
*line 903
*line 904
move #18,(sp)
move R5,-(sp)
move _ptecpos,R4
move R4,-(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
*line 905
*line 906
*line 907
*line 908
bra L129
L128:
*line 909
*line 910
move #18,(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
*line 911
*line 912
*line 913
cmp #15,R5
bgt L127
L129:
*line 914
move R4,(sp)
jsr _findnxt
move R0,R4
tst R4
bne L128
L127:
*line 915
*line 916
*line 917
*line 918
bra L132
L131:
*line 919
move #18,(sp)
move R5,-(sp)
clr -(sp)
jsr _dpte
addq.l #4,sp
add #1,R5
L132:
*line 919
cmp #16,R5
blt L131
L130:
*line 920
*line 921
bra L133
L122:
*line 922
*line 923
*line 927
*line 928
*line 929
*line 930
*line 931
clr R5
bra L136
L137:
*line 932
cmp #7,R5
bne L10003
move #18,(sp)
bra L10005
L10003:move #18,(sp)
L10005:move R5,-(sp)
clr -(sp)
jsr _dpte
addq.l #4,sp
L135:
*line 931
add #1,R5
L136:
*line 931
cmp #16,R5
blt L137
L134:
*line 932
L133:
*line 933
L121:
*line 936
*line 936
tst _ptecpos
beq L138
*line 937
*line 938
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
*line 939
move #1,_pteset
*line 940
jsr _pte2buf
*line 941
*line 946
*line 947
bra L139
L138:
*line 948
*line 949
*line 950
clr _pteset
*line 951
jsr _voidpb
*line 952
*line 957
*line 958
*line 959
L139:L102:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _srdspte
.text
_srdspte:
~~srdspte:
link R14,#-10
~oldcpos=-2
~oldpred=-4
~oldsucc=-6
*line 980
tst _ptedfok
beq L10007
tst _ptestok
beq L10007
tst _ptedsok
beq L10007
tst _ptedtok
bne L10006
L10007:clr R0
bra L10008
L10006:move #1,R0
L10008:move R0,_ptegood
*line 1002
*line 1002
tst _ptegood
beq L141
*line 1003
*line 1004
move _ptecpos,-2(R14)
*line 1005
move _ptepred,-4(R14)
*line 1006
move _ptesucc,-6(R14)
*line 1007
*line 1008
jsr _buf2pte
*line 1009
*line 1010
*line 1010
jsr _findpte
tst R0
bne L142
*line 1011
*line 1015
*line 1016
*line 1017
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
*line 1018
move #1,_pteset
*line 1019
jsr _pte2buf
*line 1020
jsr _dptw
*line 1021
bra L143
L142:
*line 1022
*line 1023
*line 1024
move -2(R14),_ptecpos
*line 1025
move -4(R14),_ptepred
*line 1026
move -6(R14),_ptesucc
*line 1027
*line 1037
*line 1038
L143:
*line 1039
*line 1040
*line 1041
*line 1045
*line 1046
L141:L140:unlk R14
rts
.globl _stmproc
.text
_stmproc:
~~stmproc:
~trg=R7
link R14,#-4
movem.l R2-R7/R12-R13,-(sp)
~nextdef=R13
~nextpch=R12
~adspec=R6
~adsuba=R5
~np=R4
~stim=R3
~addat1=-2
~adrtag=-4
*line 1068
move 8(R14),R7
*line 1068
clr R0
move R7,R0
and #8191,R0
move R0,R8
move.l #_defptr,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R4
and #255,R4
*line 1069
tst R4
beq L10009
clr R0
move R4,R0
mulu #10,R0
add.l #_defents,R0
bra L10011
L10009:clr.l R0
L10011:move.l R0,R13
*line 1073
bra L147
L146:
*line 1074
*line 1075
*line 1076
*line 1077
move 4(R13),R6
*line 1078
move 6(R13),R5
*line 1079
move 8(R13),-2(R14)
*line 1080
move 2(R13),R3
*line 1081
move.l #_dmatch,R8
move.b 0(R8,R6),R0
ext.w R0
move R0,-4(R14)
*line 1082
*line 1083
*line 1084
*line 1085
clr R0
move R3,R0
and #8191,R0
move R0,R8
move.l #_stmptr,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R4
and #255,R4
*line 1086
tst R4
beq L10012
clr R0
move R4,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
bra L10014
L10012:clr.l R0
L10014:move.l R0,R12
*line 1087
*line 1088
bra L150
L149:
*line 1089
*line 1090
*line 1091
*line 1092
*line 1093
*line 1094
cmp 6(R12),R3
bne L151
clr R0
move 8(R12),R0
and #255,R0
cmp R0,R6
bne L151
cmp 10(R12),R5
bne L151
*line 1095
*line 1096
*line 1097
tst -4(R14)
beq L10015
tst -4(R14)
beq L152
clr R0
move 12(R12),R0
cmp -2(R14),R0
bne L152
L10015:*line 1098
*line 1099
*line 1100
cmp 4(R12),R7
bne L153
*line 1100
or #-32768,8(R12)
*line 1101
bra L154
L153:
*line 1102
and #32767,8(R12)
L154:
*line 1103
L152:
*line 1104
*line 1105
*line 1106
*line 1107
L151:
*line 1108
move (R12),R4
*line 1109
tst R4
beq L10016
clr R0
move R4,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
bra L10018
L10016:clr.l R0
L10018:move.l R0,R12
L150:
*line 1110
move.l R12,R0
bne L149
L148:
*line 1111
*line 1112
*line 1113
*line 1114
move (R13),R4
*line 1115
tst R4
beq L10019
clr R0
move R4,R0
mulu #10,R0
add.l #_defents,R0
bra L10021
L10019:clr.l R0
L10021:move.l R0,R13
L147:
*line 1116
move.l R13,R0
bne L146
L145:
*line 1124
clr R0
move R7,R0
and #8191,R0
move R0,R8
move.l #_stmptr,R9
move.b 0(R8,R9.l),R0
ext.w R0
move R0,R4
and #255,R4
*line 1125
tst R4
beq L10022
clr R0
move R4,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
bra L10024
L10022:clr.l R0
L10024:move.l R0,R12
*line 1129
bra L157
L156:
*line 1130
*line 1131
*line 1132
*line 1133
clr R0
move 8(R12),R0
and #-32768,R0
beq L158
cmp 6(R12),R7
bne L158
*line 1133
move.l R12,(sp)
jsr _dopatch
*line 1134
*line 1135
*line 1136
L158:
*line 1137
move (R12),R4
*line 1138
tst R4
beq L10025
clr R0
move R4,R0
lsl #4,R0
swap R0
clr R0
swap R0
add.l #_patches,R0
bra L10027
L10025:clr.l R0
L10027:move.l R0,R12
L157:
*line 1139
move.l R12,R0
bne L156
L155:L144:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.data
L101:.dc.b $B0,$20,$0
