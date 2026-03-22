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
.globl _ancmsw
.globl _grptran
.globl _grpmode
.globl _grpstat
.globl _grptmap
.globl _varmode
.globl _cmslens
.data
_cmslens:
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $6
.dc.w $5
.dc.w $5
.dc.w $5
.dc.w $5
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $6
.dc.w $5
.dc.w $5
.dc.w $5
.dc.w $0
.dc.w $5
.dc.w $5
.dc.w $5
.globl _cmgtags
.data
_cmgtags:
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.dc.b $1
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
.dc.b $0
.dc.b $1
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.dc.b $0
.dc.b $0
.even
.globl _cmgtype
.data
_cmgtype:
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.dc.b $1
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
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $0
.dc.b $1
.dc.b $0
.dc.b $0
.even
.globl _ehdlist
.data
_ehdlist:
.dc.w $FFFF
.dc.w $FFFF
.dc.w $A
.dc.w $B
.dc.w $0
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.dc.w $6
.dc.w $7
.dc.w $8
.dc.w $1
.dc.w $2
.dc.w $3
.dc.w $FFFF
.dc.w $4
.dc.w $9
.dc.w $5
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.globl _oktocm
.text
_oktocm:
~~oktocm:
~ep=R13
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~et=R7
~grp=R6
~mode=R5
*line 171
move.l 8(R14),R13
*line 171
move.b 5(R13),R7
ext.w R7
and #127,R7
*line 173
*line 174
move R7,R8
add.l R8,R8
add.l #_cmslens,R8
tst (R8)
bne L2
*line 174
clr R0
bra L1
*line 175
L2:
*line 176
*line 177
move.l #_cmgtags,R8
tst.b 0(R8,R7)
bne L3
*line 177
move #1,R0
bra L1
*line 178
*line 179
*line 180
L3:
*line 181
move.l #_cmgtype,R8
tst.b 0(R8,R7)
beq L10000
move.b 7(R13),R0
ext.w R0
bra L10002
L10000:move.b 6(R13),R0
ext.w R0
L10002:move R0,R6
and #15,R6
*line 183
*line 184
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
bne L4
*line 184
clr R0
bra L1
*line 185
L4:
*line 186
*line 187
cmp #15,R7
beq L10003
cmp #14,R7
bne L5
L10003:*line 188
*line 189
tst _ancmsw
beq L10004
move.b 6(R13),R0
ext.w R0
asr #4,R0
and #7,R0
asl #5,R0
ext.l R0
move R6,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_varmode,R9
move 0(R8,R9.l),R0
bra L10006
L10004:move R6,R8
add.l R8,R8
add.l #_grptmap,R8
cmp #-1,(R8)
bne L10007
clr R0
bra L10009
L10007:move #2,R0
L10009:L10006:move R0,R5
bra L6
L5:
*line 190
*line 191
move R6,R8
add.l R8,R8
add.l #_grptmap,R8
cmp #-1,(R8)
bne L10010
clr R0
bra L10012
L10010:move #2,R0
L10012:move R0,R5
L6:
*line 195
cmp #2,R5
bne L10013
move #1,R0
bra L10015
L10013:clr R0
L10015:bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _oktode
.text
_oktode:
~~oktode:
~ep=R13
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~et=R7
~grp=R6
~mode=R5
*line 218
move.l 8(R14),R13
*line 218
move.b 5(R13),R7
ext.w R7
and #127,R7
*line 220
*line 221
cmp #5,R7
beq L10016
cmp #6,R7
bne L8
L10016:*line 221
clr R0
bra L7
*line 222
L8:
*line 223
*line 224
move.l #_cmgtags,R8
tst.b 0(R8,R7)
bne L9
*line 224
move #1,R0
bra L7
*line 225
*line 226
*line 227
L9:
*line 228
move.l #_cmgtype,R8
tst.b 0(R8,R7)
beq L10017
move.b 7(R13),R0
ext.w R0
bra L10019
L10017:move.b 6(R13),R0
ext.w R0
L10019:move R0,R6
and #15,R6
*line 230
*line 231
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
bne L10
*line 231
clr R0
bra L7
*line 232
L10:
*line 233
*line 234
cmp #15,R7
beq L10020
cmp #14,R7
bne L11
L10020:*line 235
tst _ancmsw
beq L10021
move.b 6(R13),R0
ext.w R0
asr #4,R0
and #7,R0
asl #5,R0
ext.l R0
move R6,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_varmode,R9
move 0(R8,R9.l),R0
bra L10023
L10021:move R6,R8
add.l R8,R8
move.l #_grpmode,R9
move 0(R8,R9.l),R0
L10023:move R0,R5
bra L12
L11:
*line 236
*line 237
move R6,R8
add.l R8,R8
add.l #_grpmode,R8
move (R8),R5
L12:
*line 241
cmp #2,R5
bne L10024
move #1,R0
bra L10026
L10024:clr R0
L10026:bra L7
L7:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _oktodg
.text
_oktodg:
~~oktodg:
~ep=R13
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~et=R7
~grp=R6
*line 264
move.l 8(R14),R13
*line 264
move.b 5(R13),R7
ext.w R7
and #127,R7
*line 266
*line 267
*line 268
cmp #5,R7
beq L14
cmp #6,R7
beq L14
*line 268
clr R0
bra L13
*line 269
L14:
*line 270
move.b 7(R13),R6
ext.w R6
*line 272
*line 273
*line 274
move R6,R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L15
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L15
*line 274
move #1,R0
bra L13
*line 275
bra L16
L15:
*line 276
clr R0
bra L13
L16:L13:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _chksec
.text
_chksec:
~~chksec:
~ns=R7
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ep=R13
*line 301
move 8(R14),R7
*line 305
*line 305
move _curscor,R0
muls #80,R0
move R7,R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_seclist,R0
move.l R0,R8
move.l (R8),_p_sbgn
bne L18
*line 306
*line 307
clr _secopok
*line 308
clr.l _p_send
*line 309
*line 310
move #1,R0
bra L17
*line 311
*line 312
L18:
*line 313
move.l _p_sbgn,R8
move.l (R8),_t_sbgn
*line 319
move _curscor,R0
muls #48,R0
add.l #_hplist,R0
move.l R0,R8
move.l 44(R8),R13
*line 321
bra L21
L20:
*line 322
*line 323
*line 324
*line 325
move.b 5(R13),R0
ext.w R0
and #127,R0
cmp #3,R0
bne L10027
move.b 6(R13),R0
ext.w R0
cmp R0,R7
beq L19
L10027:*line 326
*line 327
move.l 20(R13),R13
L21:
*line 328
move.l R13,R0
bne L20
L19:
*line 330
*line 330
move.l R13,_p_send
bne L22
*line 331
*line 332
clr _secopok
*line 333
*line 334
move #2,R0
bra L17
*line 335
*line 336
*line 337
*line 338
L22:
*line 339
*line 339
move.l (R13),R0
move.l R0,_t_send
cmp.l _t_sbgn,R0
bgt L23
*line 340
*line 341
clr _secopok
*line 342
*line 343
move #3,R0
bra L17
*line 344
*line 345
L23:
*line 346
move.l _t_send,R0
add.l #$1,R0
sub.l _t_sbgn,R0
move.l R0,_t_sect
*line 349
clr R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _sizesec
.text
_sizesec:
~~sizesec:
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~ec=R7
~et=R6
~sbp=R13
~sep=R12
*line 375
clr.l R7
*line 376
move.l _p_sbgn,R8
move.l 12(R8),R13
*line 377
move.l _p_send,R12
*line 379
bra L27
L26:
*line 380
*line 381
move.b 5(R13),R6
ext.w R6
and #127,R6
*line 382
*line 383
*line 384
move.l R13,(sp)
jsr _oktocm
tst R0
beq L28
*line 384
move R6,R8
add.l R8,R8
move.l #_cmslens,R9
move 0(R8,R9.l),R0
ext.l R0
add.l R0,R7
*line 385
L28:
*line 386
move.l 12(R13),R13
L27:
*line 387
cmp.l R12,R13
bne L26
L25:
*line 397
move.l R7,R0
bra L24
L24:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.globl _edelta
.text
_edelta:
~~edelta:
~ep=R13
~btime=R7
~delta=R6
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
*line 417
move.l 8(R14),R13
*line 417
move.l 12(R14),R7
*line 417
move.l 16(R14),R6
*line 419
bra L32
L31:
*line 420
*line 421
*line 422
cmp.l (R13),R7
bge L33
*line 422
add.l R6,(R13)
*line 423
L33:
*line 424
move.l 12(R13),R13
L32:
*line 425
move.b 5(R13),R0
ext.w R0
and #127,R0
cmp #21,R0
bne L31
L30:L29:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _madjsec
.text
_madjsec:
~~madjsec:
~sbp=R13
~btime=R7
link R14,#-8
movem.l R2-R7/R11-R13,-(sp)
~ns=-2
~nv=-4
~grp=R6
~es=R5
~et=R4
~ep=R12
~np=R11
~cp=-8
~sat=R3
*line 460
move.l 8(R14),R13
*line 460
move.l 12(R14),R7
*line 462
clr.l R0
move.l R0,-8(R14)
move.l R0,R12
move.l R12,R11
*line 463
move.b 6(R13),R0
ext.w R0
move R0,-2(R14)
*line 464
move.l (R13),R3
sub.l R7,R3
*line 465
move.l 12(R13),R13
*line 472
bra L37
L36:
*line 473
*line 474
move.b 5(R13),R4
ext.w R4
and #127,R4
*line 475
*line 476
*line 477
*line 478
*line 479
cmp #3,R4
bne L10028
move.b 6(R13),R0
ext.w R0
cmp -2(R14),R0
beq L35
L10028:*line 480
*line 481
*line 481
move.l R13,(sp)
jsr _oktocm
tst R0
beq L38
*line 482
*line 483
move.b 4(R13),R5
ext.w R5
*line 484
move R5,(sp)
jsr _e_alc
move.l R0,R11
*line 485
move R5,R0
asl #1,R0
move R0,(sp)
move.l R13,-(sp)
move.l R11,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 486
*line 487
*line 487
move.l #_cmgtags,R8
tst.b 0(R8,R4)
beq L39
*line 488
*line 489
*line 490
move.l #_cmgtype,R8
tst.b 0(R8,R4)
beq L10029
move.b 7(R11),R0
ext.w R0
bra L10031
L10029:move.b 6(R11),R0
ext.w R0
L10031:move R0,R6
and #15,R6
*line 491
*line 492
*line 492
cmp #5,R4
beq L10032
cmp #6,R4
bne L40
L10032:*line 493
*line 494
*line 495
*line 496
*line 497
move.b 7(R11),R0
ext.w R0
and #240,R0
move R6,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,7(R11)
*line 498
*line 499
*line 500
*line 501
move.b 6(R11),R0
ext.w R0
add _grptran,R0
move R0,-4(R14)
*line 502
*line 503
*line 504
cmp #127,-4(R14)
ble L41
*line 504
move #127,-4(R14)
bra L42
L41:
*line 505
*line 506
tst -4(R14)
bge L43
*line 506
clr -4(R14)
*line 507
L43:L42:
*line 508
move -4(R14),R0
move.b R0,6(R11)
*line 509
bra L44
L40:
*line 510
*line 510
cmp #15,R4
beq L10033
cmp #14,R4
bne L45
L10033:*line 511
*line 512
*line 513
*line 514
*line 515
move.b 6(R11),R0
ext.w R0
and #15,R0
move R6,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
asl #4,R1
or R1,R0
move.b R0,6(R11)
*line 516
bra L46
L45:
*line 517
*line 518
*line 519
*line 520
*line 521
*line 522
move.l #_cmgtype,R8
tst.b 0(R8,R4)
beq L47
*line 523
move.b 7(R11),R0
ext.w R0
and #240,R0
move R6,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,7(R11)
*line 524
bra L48
L47:
*line 525
*line 526
move.b 6(R11),R0
ext.w R0
and #240,R0
move R6,R9
add.l R9,R9
add.l #_grptmap,R9
move (R9),R1
or R1,R0
move.b R0,6(R11)
L48:L46:L44:
*line 527
*line 528
*line 529
*line 530
*line 531
L39:
*line 532
*line 532
move.l R12,R0
beq L49
*line 533
*line 534
move.l R11,12(R12)
*line 535
bra L50
L49:
*line 536
*line 537
*line 538
*line 539
move.l R11,-8(R14)
L50:
*line 540
*line 541
*line 542
move.l R12,8(R11)
*line 543
clr.l 12(R11)
*line 544
sub.l R3,(R11)
*line 545
move.l R11,R12
*line 546
*line 547
L38:
*line 548
move.l 12(R13),R13
L37:
*line 549
bra L36
L35:
*line 551
move.l -8(R14),_p_cbgn
*line 552
move.l R11,_p_cend
*line 554
*line 554
tst.l -8(R14)
beq L51
*line 555
*line 556
*line 557
move.l -8(R14),R8
move.l (R8),_t_cbgn
*line 558
move.l (R11),_t_cend
*line 559
*line 560
L51:
*line 562
move.l -8(R14),R0
bra L34
L34:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _ehfix
.text
_ehfix:
~~ehfix:
~cbp=R13
~cep=R12
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~et=R7
*line 582
move.l 8(R14),R13
*line 582
move.l 12(R14),R12
L55:
*line 583
*line 584
move.b 5(R13),R7
ext.w R7
and #127,R7
*line 585
*line 586
*line 587
*line 588
*line 589
move R7,R8
add.l R8,R8
add.l #_ehdlist,R8
cmp #-1,(R8)
beq L56
*line 589
move R7,R8
add.l R8,R8
move.l #_ehdlist,R9
move 0(R8,R9.l),(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 590
L56:
*line 591
*line 592
cmp.l R12,R13
beq L52
*line 593
*line 594
move.l 12(R13),R13
L54:bra L55
L53:L52:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
