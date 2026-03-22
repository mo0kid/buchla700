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
.globl _secopok
.globl _t_sbgn
.globl _t_send
.globl _t_sect
.globl _t_sec1
.globl _t_sec2
.globl _t_cbgn
.globl _t_cend
.globl _p_sbgn
.globl _p_send
.globl _p_sec1
.globl _p_sec2
.globl _p_cbgn
.globl _p_cend
.globl _grptran
.globl _cmgtags
.globl _cmgtype
.globl _ehdlist
.globl _grptmap
.globl _sec_cpy
.text
_sec_cpy:
~~sec_cpy:
~ns=R7
link R14,#0
movem.l R5-R7/R11-R13,-(sp)
~cp=R13
~lp=R12
~rp=R11
~newet=R6
*line 66
move 8(R14),R7
*line 68
move #1,_secopok
*line 70
*line 70
move R7,(sp)
jsr _chksec
tst R0
beq L2
*line 71
*line 72
*line 73
move #-1,R0
bra L1
*line 74
*line 75
*line 76
*line 77
L2:
*line 78
*line 78
jsr _evleft
move.l R0,-(sp)
jsr _sizesec
cmp.l (sp)+,R0
ble L3
*line 79
*line 80
*line 81
move #-1,R0
bra L1
*line 82
*line 83
*line 84
*line 85
L3:
*line 86
move.l _scp,R8
move.l 8(R8),R8
move.l 8(R8),R8
move.l (R8),R6
add.l _t_sect,R6
*line 88
*line 88
tst.l R6
blt L10000
cmp.l #$ffffff,R6
blt L4
L10000:*line 89
*line 90
*line 91
move #-1,R0
bra L1
*line 92
*line 93
*line 94
*line 95
*line 96
*line 97
L4:
*line 98
*line 98
move.l _t_cur,(sp)
move.l _p_sbgn,-(sp)
jsr _madjsec
addq.l #4,sp
move.l R0,R13
move.l R13,R0
bne L5
*line 99
*line 100
*line 101
move #-1,R0
bra L1
*line 102
*line 103
*line 104
*line 105
L5:
*line 106
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R12
*line 107
move.l 12(R12),R11
*line 111
move.l _t_sect,(sp)
move.l _t_cur,-(sp)
move.l R12,-(sp)
jsr _edelta
addq.l #8,sp
*line 115
move.l _p_cbgn,12(R12)
*line 116
move.l _p_cbgn,R8
move.l R12,8(R8)
*line 118
move.l _p_cend,8(R11)
*line 119
move.l _p_cend,R8
move.l R11,12(R8)
*line 123
move.l _p_cend,(sp)
move.l _p_cbgn,-(sp)
jsr _ehfix
addq.l #4,sp
*line 126
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R11-R13
unlk R14
rts
.globl _sec_mrg
.text
_sec_mrg:
~~sec_mrg:
~ns=R7
link R14,#0
movem.l R4-R7/R11-R13,-(sp)
~cp=R13
~lp=R12
~rp=R11
~newet=R6
~et=R5
*line 150
move 8(R14),R7
*line 152
move #1,_secopok
*line 154
*line 154
move R7,(sp)
jsr _chksec
tst R0
beq L7
*line 155
*line 156
*line 157
move #-1,R0
bra L6
*line 158
*line 159
*line 160
*line 161
L7:
*line 162
*line 162
jsr _evleft
move.l R0,-(sp)
jsr _sizesec
cmp.l (sp)+,R0
ble L8
*line 163
*line 164
*line 165
move #-1,R0
bra L6
*line 166
*line 167
*line 168
*line 169
L8:
*line 170
move.l _scp,R8
move.l 8(R8),R8
move.l 8(R8),R8
move.l (R8),R6
add.l _t_sect,R6
*line 172
*line 172
tst.l R6
blt L10001
cmp.l #$ffffff,R6
blt L9
L10001:*line 173
*line 174
*line 175
move #-1,R0
bra L6
*line 176
*line 177
*line 178
*line 179
*line 180
*line 181
L9:
*line 182
*line 182
move.l _t_cur,(sp)
move.l _p_sbgn,-(sp)
jsr _madjsec
addq.l #4,sp
move.l R0,R13
move.l R13,R0
bne L10
*line 183
*line 184
*line 185
move #-1,R0
bra L6
*line 186
*line 187
L10:
*line 190
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R12
*line 192
bra L13
L12:
*line 193
*line 194
move.l 12(R13),R11
*line 195
move.l (R13),(sp)
clr -(sp)
move.l R12,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R12
*line 196
move.l R12,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
move.l R0,R12
*line 197
move.b 5(R13),R5
ext.w R5
and #127,R5
*line 198
*line 199
*line 200
move R5,R8
add.l R8,R8
add.l #_ehdlist,R8
cmp #-1,(R8)
beq L14
*line 200
move R5,R8
add.l R8,R8
move.l #_ehdlist,R9
move 0(R8,R9.l),(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 201
L14:
*line 202
move.l R11,R13
L13:
*line 203
move.l R13,R0
bne L12
L11:
*line 206
clr R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R5-R7/R11-R13
unlk R14
rts
.globl _sec_grp
.text
_sec_grp:
~~sec_grp:
~ns=R7
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~cp=R13
~rp=R12
~et=R6
~nv=R5
~grp=R4
*line 229
move 8(R14),R7
*line 231
move #1,_secopok
*line 233
*line 233
move R7,(sp)
jsr _chksec
tst R0
beq L16
*line 234
*line 235
*line 236
move #-1,R0
bra L15
*line 237
*line 238
L16:
*line 239
move.l _p_sbgn,R13
*line 241
bra L19
L18:
*line 242
*line 243
move.l 12(R13),R12
*line 244
move.b 5(R13),R6
ext.w R6
and #127,R6
*line 245
*line 246
*line 246
move.l #_cmgtags,R8
tst.b 0(R8,R6)
beq L20
*line 247
*line 248
*line 249
move.l #_cmgtype,R8
tst.b 0(R8,R6)
beq L10002
move.b 7(R13),R0
ext.w R0
bra L10004
L10002:move.b 6(R13),R0
ext.w R0
L10004:move R0,R4
and #15,R4
*line 250
*line 251
*line 251
cmp #5,R6
beq L10005
cmp #6,R6
bne L21
L10005:*line 252
*line 253
*line 254
*line 255
*line 256
move.b 7(R13),R0
ext.w R0
and #240,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,7(R13)
*line 257
*line 258
*line 259
*line 260
move.b 6(R13),R5
ext.w R5
add _grptran,R5
*line 261
*line 262
*line 263
cmp #127,R5
ble L22
*line 263
move #127,R5
bra L23
L22:
*line 264
*line 265
tst R5
bge L24
*line 265
clr R5
*line 266
L24:L23:
*line 267
move.b R5,6(R13)
*line 268
bra L25
L21:
*line 269
*line 269
cmp #15,R6
beq L10006
cmp #14,R6
bne L26
L10006:*line 270
*line 271
*line 272
*line 273
*line 274
move.b 6(R13),R0
ext.w R0
and #15,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
asl #4,R1
or R1,R0
move.b R0,6(R13)
*line 275
bra L27
L26:
*line 276
*line 277
*line 278
*line 279
*line 280
*line 281
move.l #_cmgtype,R8
tst.b 0(R8,R6)
beq L28
*line 282
move.b 7(R13),R0
ext.w R0
and #240,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,7(R13)
*line 283
bra L29
L28:
*line 284
*line 285
move.b 6(R13),R0
ext.w R0
and #240,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,6(R13)
L29:L27:L25:
*line 286
*line 287
*line 288
L20:
*line 289
move.l R12,R13
L19:
*line 290
cmp.l _p_send,R13
bne L18
L17:
*line 293
clr R0
bra L15
L15:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _sec_mov
.text
_sec_mov:
~~sec_mov:
~ns=R7
link R14,#0
movem.l R2-R7/R11-R13,-(sp)
~cp=R13
~lp=R12
~rp=R11
~newet=R6
~et=R5
~grp=R4
~nv=R3
*line 317
move 8(R14),R7
*line 319
move #1,_secopok
*line 321
*line 321
move R7,(sp)
jsr _chksec
tst R0
beq L31
*line 322
*line 323
*line 324
move #-1,R0
bra L30
*line 325
*line 326
*line 336
*line 337
*line 338
*line 339
L31:
*line 340
*line 340
move.l _t_cur,R0
cmp.l _t_sbgn,R0
blt L32
move.l _t_cur,R0
cmp.l _t_send,R0
bgt L32
*line 341
*line 342
*line 343
move #-1,R0
bra L30
*line 344
*line 345
*line 346
*line 347
L32:
*line 348
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R12
*line 349
move.l _p_send,R8
move.l 12(R8),R13
*line 358
move.l _p_sbgn,R8
move.l 8(R8),R8
move.l _p_send,R9
move.l 12(R9),12(R8)
*line 359
move.l _p_send,R8
move.l 12(R8),R8
move.l _p_sbgn,R9
move.l 8(R9),8(R8)
*line 360
move.l _p_sbgn,R8
move.l #$0,8(R8)
*line 361
move.l _p_send,R8
move.l #$0,12(R8)
*line 365
*line 366
move.l _t_cur,R0
cmp.l _t_send,R0
blt L33
*line 366
move.l _t_sect,R0
sub.l R0,_t_cur
*line 367
*line 371
*line 372
L33:
*line 373
bra L36
L35:
*line 374
*line 375
move.l _t_sect,R0
sub.l R0,(R13)
*line 376
move.l 12(R13),R13
L36:
*line 377
move.b 5(R13),R5
ext.w R5
and #127,R5
cmp #21,R5
bne L35
L34:
*line 389
move.l _p_sbgn,R11
*line 390
move.l _p_sbgn,R8
move.l (R8),R6
*line 392
bra L39
L38:
*line 393
*line 394
sub.l R6,(R11)
*line 395
move.b 5(R11),R5
ext.w R5
and #127,R5
*line 396
*line 397
*line 397
move.l #_cmgtags,R8
tst.b 0(R8,R5)
beq L40
*line 398
*line 399
*line 400
move.l #_cmgtype,R8
tst.b 0(R8,R5)
beq L10007
move.b 7(R11),R0
ext.w R0
bra L10009
L10007:move.b 6(R11),R0
ext.w R0
L10009:move R0,R4
and #15,R4
*line 401
*line 402
*line 402
cmp #5,R5
beq L10010
cmp #6,R5
bne L41
L10010:*line 403
*line 404
*line 405
*line 406
*line 407
move.b 7(R11),R0
ext.w R0
and #240,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,7(R11)
*line 408
*line 409
*line 410
*line 411
move.b 6(R11),R3
ext.w R3
add _grptran,R3
*line 412
*line 413
*line 414
cmp #127,R3
ble L42
*line 414
move #127,R3
bra L43
L42:
*line 415
*line 416
tst R3
bge L44
*line 416
clr R3
*line 417
L44:L43:
*line 418
move.b R3,6(R11)
*line 419
bra L45
L41:
*line 420
*line 420
cmp #15,R5
beq L10011
cmp #14,R5
bne L46
L10011:*line 421
*line 422
*line 423
*line 424
*line 425
move.b 6(R11),R0
ext.w R0
and #15,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
asl #4,R1
or R1,R0
move.b R0,6(R11)
*line 426
bra L47
L46:
*line 427
*line 428
*line 429
*line 430
*line 431
*line 432
move.l #_cmgtype,R8
tst.b 0(R8,R5)
beq L48
*line 433
move.b 7(R11),R0
ext.w R0
and #240,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,7(R11)
*line 434
bra L49
L48:
*line 435
*line 436
move.b 6(R11),R0
ext.w R0
and #240,R0
move R4,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,6(R11)
L49:L47:L45:
*line 437
*line 438
*line 439
L40:
*line 440
*line 441
move R5,R8
add.l R8,R8
add.l #_ehdlist,R8
cmp #-1,(R8)
beq L50
*line 441
move R5,R8
add.l R8,R8
move.l #_ehdlist,R9
move 0(R8,R9.l),(sp)
move.l R11,-(sp)
jsr _eh_rmv
addq.l #4,sp
*line 442
L50:
*line 443
move.l 12(R11),R11
L39:
*line 444
move.l R11,R0
bne L38
L37:
*line 446
move.l 12(R12),R11
*line 450
move.l _p_sbgn,R8
move.l R12,8(R8)
*line 451
move.l _p_send,R8
move.l R11,12(R8)
*line 452
move.l _p_sbgn,12(R12)
*line 453
move.l _p_send,8(R11)
*line 459
move.l _p_sbgn,R13
*line 460
move.l _t_cur,R6
*line 468
bra L53
L52:
*line 469
*line 470
move.b 5(R13),R5
ext.w R5
and #127,R5
*line 471
add.l R6,(R13)
*line 472
*line 473
*line 474
move R5,R8
add.l R8,R8
add.l #_ehdlist,R8
cmp #-1,(R8)
beq L54
*line 474
move R5,R8
add.l R8,R8
move.l #_ehdlist,R9
move 0(R8,R9.l),(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 475
L54:
*line 476
move.l 12(R13),R13
L53:
*line 477
cmp.l R11,R13
bne L52
L51:
*line 487
bra L57
L56:
*line 488
*line 489
move.l _t_sect,R0
add.l R0,(R13)
*line 490
move.l 12(R13),R13
L57:
*line 491
move.b 5(R13),R5
ext.w R5
and #127,R5
cmp #21,R5
bne L56
L55:
*line 494
clr R0
bra L30
L30:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _sec_rmv
.text
_sec_rmv:
~~sec_rmv:
~ns=R7
link R14,#-4
movem.l R5-R7/R11-R13,-(sp)
~cp=R13
~lp=R12
~rp=R11
~et=R6
~pp=-4
*line 518
move 8(R14),R7
*line 520
move #1,_secopok
*line 522
*line 522
move R7,(sp)
jsr _chksec
tst R0
beq L59
*line 523
*line 524
*line 525
move #-1,R0
bra L58
*line 526
*line 527
L59:
*line 528
move.l _p_send,R8
move.l 12(R8),R13
move.l R13,-4(R14)
*line 547
move.l _p_sbgn,R8
move.l 8(R8),R8
move.l _p_send,R9
move.l 12(R9),12(R8)
*line 548
move.l _p_send,R8
move.l 12(R8),R8
move.l _p_sbgn,R9
move.l 8(R9),8(R8)
*line 549
move.l _p_sbgn,R8
move.l #$0,8(R8)
*line 550
move.l _p_send,R8
move.l #$0,12(R8)
*line 554
*line 555
move.l _t_cur,R0
cmp.l _t_send,R0
blt L60
*line 555
move.l _t_sect,R0
sub.l R0,_t_cur
*line 556
*line 560
*line 561
L60:
*line 562
bra L63
L62:
*line 563
*line 564
move.l _t_sect,R0
sub.l R0,(R13)
*line 565
move.l 12(R13),R13
L63:
*line 566
move.b 5(R13),R6
ext.w R6
and #127,R6
cmp #21,R6
bne L62
L61:
*line 576
move.l _p_sbgn,R11
*line 578
bra L66
L65:
*line 579
*line 580
move.l 12(R11),R12
*line 581
move.b 5(R11),R6
ext.w R6
and #127,R6
*line 582
*line 583
*line 584
cmp.l _p_bak,R11
bne L67
*line 584
move.l -4(R14),_p_bak
*line 585
L67:
*line 586
*line 587
cmp.l _p_cur,R11
bne L68
*line 587
move.l -4(R14),_p_cur
*line 588
L68:
*line 589
*line 590
cmp.l _p_ctr,R11
bne L69
*line 590
move.l -4(R14),_p_ctr
*line 591
L69:
*line 592
*line 593
cmp.l _p_fwd,R11
bne L70
*line 593
move.l -4(R14),_p_fwd
*line 594
L70:
*line 595
*line 596
move R6,R8
add.l R8,R8
add.l #_ehdlist,R8
cmp #-1,(R8)
beq L71
*line 596
move R6,R8
add.l R8,R8
move.l #_ehdlist,R9
move 0(R8,R9.l),(sp)
move.l R11,-(sp)
jsr _eh_rmv
addq.l #4,sp
*line 597
L71:
*line 598
move.l R11,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 599
move.l R12,R11
L66:
*line 600
move.l R11,R0
bne L65
L64:
*line 602
move _curscor,R0
muls #80,R0
move R7,R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_seclist,R0
move.l R0,R8
move.l #$0,(R8)
*line 604
clr R0
bra L58
L58:tst.l (sp)+
movem.l (sp)+,R6-R7/R11-R13
unlk R14
rts
.globl _sec_dgr
.text
_sec_dgr:
~~sec_dgr:
~ns=R7
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~lp=R13
~rp=R12
*line 626
move 8(R14),R7
*line 628
move #1,_secopok
*line 630
*line 630
move R7,(sp)
jsr _chksec
tst R0
beq L73
*line 631
*line 632
*line 633
move #-1,R0
bra L72
*line 634
*line 635
*line 645
*line 646
*line 647
*line 648
*line 649
*line 650
L73:
*line 653
move.l _p_sbgn,R8
move.l 12(R8),R12
*line 655
bra L76
L75:
*line 656
*line 657
move.l 12(R12),R13
*line 658
*line 659
*line 659
move.l R12,(sp)
jsr _oktodg
tst R0
beq L77
*line 660
*line 661
*line 662
cmp.l _p_bak,R12
bne L78
*line 662
move.l R13,_p_bak
*line 663
L78:
*line 664
*line 665
cmp.l _p_cur,R12
bne L79
*line 665
move.l R13,_p_cur
*line 666
L79:
*line 667
*line 668
cmp.l _p_ctr,R12
bne L80
*line 668
move.l R13,_p_ctr
*line 669
L80:
*line 670
*line 671
cmp.l _p_fwd,R12
bne L81
*line 671
move.l R13,_p_fwd
*line 672
L81:
*line 673
move.l R12,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 674
*line 675
L77:
*line 676
move.l R13,R12
L76:
*line 677
cmp.l _p_send,R12
bne L75
L74:
*line 680
clr R0
bra L72
L72:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _sec_dev
.text
_sec_dev:
~~sec_dev:
~ns=R7
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~lp=R13
~rp=R12
*line 702
move 8(R14),R7
*line 704
move #1,_secopok
*line 706
*line 706
move R7,(sp)
jsr _chksec
tst R0
beq L83
*line 707
*line 708
*line 709
move #-1,R0
bra L82
*line 710
*line 711
*line 721
*line 722
*line 723
*line 724
*line 725
*line 726
L83:
*line 729
move.l _p_sbgn,R8
move.l 12(R8),R12
*line 731
bra L86
L85:
*line 732
*line 733
move.l 12(R12),R13
*line 734
*line 735
*line 735
move.l R12,(sp)
jsr _oktode
tst R0
beq L87
*line 736
*line 737
*line 738
cmp.l _p_bak,R12
bne L88
*line 738
move.l R13,_p_bak
*line 739
L88:
*line 740
*line 741
cmp.l _p_cur,R12
bne L89
*line 741
move.l R13,_p_cur
*line 742
L89:
*line 743
*line 744
cmp.l _p_ctr,R12
bne L90
*line 744
move.l R13,_p_ctr
*line 745
L90:
*line 746
*line 747
cmp.l _p_fwd,R12
bne L91
*line 747
move.l R13,_p_fwd
*line 748
L91:
*line 749
move.l R12,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 750
*line 751
L87:
*line 752
move.l R13,R12
L86:
*line 753
cmp.l _p_send,R12
bne L85
L84:
*line 756
clr R0
bra L82
L82:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
