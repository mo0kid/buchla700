.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _errno
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
.globl _v_obtab
.globl _v_curob
.globl _v_nobj
.globl _v_obpri
.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _filecat
.globl _point
.globl _errno
.globl __bpbin
.globl _chtime
.globl _cmtype
.globl _cvtime
.globl _cxval
.globl _cyval
.globl _sgcsw
.globl _stccol
.globl _stcrow
.globl _submenu
.globl _thcwval
.globl _tvcwval
.globl _obj0
.globl _obj2
.globl _ldbxlb0
.globl _vtlin1
.globl _vtlin2
.globl _vtlin3
.globl _ldbox
.globl _idefs
.globl __thebpb
.globl _librob
.globl _catin
.globl _lrasw
.globl _lorchl
.globl _ldrow
.globl _ldslot
.globl _lselsw
.globl _ldkind
.globl _lstrsw
.globl _lasgsw
.globl _lksel
.globl _lorchsw
.globl _lorclsw
.globl _lpatsw
.globl _lscrsw
.globl _lseqsw
.globl _ltunsw
.globl _lwavsw
.globl _ldelsw
.globl _lderrsw
.globl _ldidsiz
.globl _lmwtype
.globl _ltagged
.globl _ndisp
.globl _lcsum
.globl _ndbytes
.globl _lmln22
.globl _lmln23
.globl _lmln24
.globl _ldfile
.globl _ldcmnt
.globl _ldmsg1
.globl _ldmsg2
.globl _ldmsg3
.globl _errbuf
.globl _ldoct
.globl _ldhead
.globl _ftypes
.data
_ftypes:
*line 142
.dc.l L1
*line 142
.dc.l L2
*line 142
.dc.l L3
*line 143
.dc.l L4
*line 143
.dc.l L5
*line 143
.dc.l L6
*line 144
.dc.l L7
*line 144
.dc.l L8
*line 144
.dc.l L9
*line 145
.dc.l L10
*line 145
.dc.l L11
*line 145
.dc.l L12
*line 146
.dc.l L13
*line 146
.dc.l L14
*line 146
.dc.l L15
*line 147
.dc.l L16
*line 147
.dc.l L17
*line 147
.dc.l L18
*line 148
.dc.l L19
*line 148
.dc.l L20
*line 148
.dc.l L21
*line 149
.dc.l L22
*line 149
.dc.l L23
*line 149
.dc.l L24
*line 150
.dc.l L25
*line 150
.dc.l L26
*line 150
.dc.l L27
.globl _ld_em1
.data
_ld_em1:
.dc.b $4E,$6F,$20,$66,$69,$6C,$65,$73,$20,$73,$74,$6F,$72,$65,$64,$20,$6F,$6E,$20,$64,$69,$73,$6B,$0
.globl _ld_em2
.data
_ld_em2:
.dc.b $20,$62,$79,$20,$74,$68,$69,$73,$20,$6F,$70,$65,$72,$61,$74,$69,$6F,$6E,$0
.even
.globl _lbrpal
.data
_lbrpal:
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $2
.dc.w $1
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $2
.dc.w $1
.dc.w $0
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $2
.dc.w $2
.dc.w $2
.dc.w $2
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $0
.dc.w $3
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.globl _ftkind
.text
_ftkind:
~~ftkind:
~ns=8
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 194
clr R7
bra L33
L34:
*line 195
*line 196
move #3,(sp)
move R7,R0
muls #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 0(R8,R9.l),-(sp)
move 8(R14),R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #13,(sp)
jsr _memcmpu
addq.l #8,sp
tst R0
bne L35
*line 196
add #1,R7
move R7,R0
bra L30
*line 197
L35:L32:
*line 194
add #1,R7
L33:
*line 194
cmp #9,R7
blt L34
L31:
*line 198
move #-1,R0
bra L30
L30:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _fctstr
.text
_fctstr:
~~fctstr:
~ns=8
~just=10
link R14,#0
movem.l R6-R7,-(sp)
~fcbad=L37
.bss
L37:.ds.b 12
.text
~i=R7
*line 217
clr R7
bra L40
L41:
*line 218
*line 219
move #3,(sp)
move R7,R0
muls #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 0(R8,R9.l),-(sp)
move 8(R14),R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #13,(sp)
jsr _memcmpu
addq.l #8,sp
tst R0
bne L42
*line 219
move R7,R0
muls #12,R0
tst 10(R14)
beq L10000
move #2,R1
bra L10002
L10000:move #1,R1
L10002:asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 0(R8,R9.l),R0
bra L36
*line 220
L42:L39:
*line 217
add #1,R7
L40:
*line 217
cmp #9,R7
blt L41
L38:
*line 221
move 8(R14),R0
muls #56,R0
add.l #_filecat,R0
move.l R0,(sp)
add.l #13,(sp)
move.l #L43,-(sp)
move.l #L37,-(sp)
jsr _sprintf
addq.l #8,sp
*line 222
move.l #L37,R0
bra L36
L36:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ocslot
.text
_ocslot:
~~ocslot:
~slot=8
link R14,#-4
*line 238
*line 239
*line 240
move #3,(sp)
move.l #L45,-(sp)
move 8(R14),R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
jsr _memcmp
addq.l #8,sp
tst R0
beq L46
move 8(R14),R0
muls #56,R0
add.l #_filecat,R0
move.l R0,R8
tst.b (R8)
beq L46
*line 240
move #1,R0
bra L44
*line 241
bra L47
L46:
*line 242
clr R0
bra L44
L47:L44:unlk R14
rts
.globl _ldline
.text
_ldline:
~~ldline:
~cy=8
link R14,#-4
*line 255
*line 256
cmp #292,8(R14)
ble L49
*line 256
clr R0
bra L48
*line 257
L49:
*line 258
*line 259
cmp #14,8(R14)
bge L50
*line 259
clr R0
bra L48
*line 260
L50:
*line 261
move 8(R14),R0
ext.l R0
divs #14,R0
bra L48
L48:unlk R14
rts
.globl _lin2slt
.text
_lin2slt:
~~lin2slt:
~line=8
link R14,#0
movem.l R5-R7,-(sp)
~slot=R7
~row=R6
*line 281
clr R6
*line 283
clr R7
bra L54
L55:
*line 284
*line 285
move R7,(sp)
jsr _ocslot
tst R0
beq L56
*line 285
*line 286
add #1,R6
move R6,R0
cmp 8(R14),R0
bne L57
*line 286
move R7,R0
bra L51
*line 287
L57:L56:L53:
*line 283
add #1,R7
L54:
*line 283
cmp #20,R7
blt L55
L52:
*line 288
move #-1,R0
bra L51
L51:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _exp_c
.text
_exp_c:
~~exp_c:
~cx=R7
link R14,#0
movem.l R6-R7,-(sp)
*line 301
move 8(R14),R7
*line 301
and #15,R7
*line 302
clr R0
move R7,R0
lsl #4,R0
or R0,R7
*line 303
clr R0
move R7,R0
lsl #8,R0
or R0,R7
*line 305
clr R0
move R7,R0
bra L58
L58:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ldwmsg
.text
_ldwmsg:
~~ldwmsg:
~line1=8
~line2=12
~line3=16
~fgcolor=20
~bgcolor=22
link R14,#-4
*line 321
clr _lderrsw
*line 322
move #2,_lmwtype
*line 323
clr _submenu
*line 325
*line 326
tst _ndisp
bne L59
*line 327
*line 328
move 22(R14),(sp)
jsr _exp_c
move R0,22(R14)
*line 329
move 20(R14),(sp)
jsr _exp_c
move R0,20(R14)
*line 331
*line 332
clr R0
move 10+_v_regs,R0
and #384,R0
beq L60
*line 332
clr (sp)
jsr _vbank
*line 333
*line 334
*line 335
L60:
*line 336
*line 337
move 22(R14),(sp)
move 166+_ldbox,-(sp)
move 164+_ldbox,-(sp)
move 162+_ldbox,-(sp)
move 160+_ldbox,-(sp)
move #128,-(sp)
move.l _librob,-(sp)
jsr _vbfill4
adda.l #14,sp
*line 339
*line 340
tst.l 8(R14)
beq L61
*line 341
move #14,(sp)
move.l 8(R14),-(sp)
move 174+_ldbox,-(sp)
move 172+_ldbox,-(sp)
move 20(R14),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 342
L61:
*line 343
*line 344
tst.l 12(R14)
beq L62
*line 345
move #14,(sp)
move.l 12(R14),-(sp)
move 174+_ldbox,-(sp)
move 172+_ldbox,-(sp)
add #1,(sp)
move 20(R14),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 346
L62:
*line 347
*line 348
tst.l 16(R14)
beq L63
*line 349
move #14,(sp)
move.l 16(R14),-(sp)
move 174+_ldbox,-(sp)
move 172+_ldbox,-(sp)
add #2,(sp)
move 20(R14),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
L63:L59:unlk R14
rts
.globl _chksum
.text
_chksum:
~~chksum:
~area=R13
~len=R7
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~cs=R6
~i=R5
*line 368
move.l 8(R14),R13
*line 368
move.l 12(R14),R7
*line 368
clr.l R6
*line 370
clr.l R5
bra L67
L68:
*line 371
move.b (R13)+,R0
ext.w R0
ext.l R0
and.l #$ff,R0
add.l R0,R6
L66:
*line 370
add.l #$1,R5
L67:
*line 370
cmp.l R7,R5
blt L68
L65:
*line 373
move.l R6,R0
bra L64
L64:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _makelh
.text
_makelh:
~~makelh:
~kind=8
link R14,#-4
*line 385
move #8,(sp)
move #63,-(sp)
move.l #_ldhead,-(sp)
jsr _memset
addq.l #6,sp
*line 386
move #8,(sp)
move.l #_ldfile,-(sp)
move.l #8+_ldhead,-(sp)
jsr _memcpy
addq.l #8,sp
*line 387
move #3,(sp)
move 8(R14),R0
sub #1,R0
muls #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 0(R8,R9.l),-(sp)
move.l #16+_ldhead,-(sp)
jsr _memcpy
addq.l #8,sp
*line 388
move #37,(sp)
move.l #_ldcmnt,-(sp)
move.l #19+_ldhead,-(sp)
jsr _memcpy
addq.l #8,sp
*line 390
move.l #$30,(sp)
move.l #8+_ldhead,-(sp)
jsr _chksum
addq.l #4,sp
move.l R0,_lcsum
L69:unlk R14
rts
.globl _ldbusy
.text
_ldbusy:
~~ldbusy:
~msg=8
link R14,#-4
*line 405
*line 406
tst _ndisp
bne L70
*line 407
*line 408
*line 409
move 170+_ldbox,(sp)
move 168+_ldbox,-(sp)
move.l 8(R14),-(sp)
move.l #L71,-(sp)
clr.l -(sp)
jsr _ldwmsg
adda.l #14,sp
L70:unlk R14
rts
.globl _noslot
.text
_noslot:
~~noslot:
~fctype=8
link R14,#-4
*line 420
move 8(R14),R0
sub #1,R0
muls #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 8(R8,R9.l),(sp)
move.l #L73,-(sp)
move.l #_ldmsg1,-(sp)
jsr _sprintf
addq.l #8,sp
*line 422
*line 423
move #9,(sp)
move #14,-(sp)
move.l #L75,-(sp)
move.l #_ldmsg1,-(sp)
move.l #L74,-(sp)
jsr _ldermsg
adda.l #14,sp
L72:unlk R14
rts
.globl _wr_ec
.text
_wr_ec:
~~wr_ec:
~fp=R13
~from=R12
~len=R7
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~count=R6
~c=R5
*line 443
move.l 8(R14),R13
*line 443
move.l 12(R14),R12
*line 443
move.l 16(R14),R7
*line 443
clr.l R6
bra L79
L80:
*line 444
*line 445
clr _errno
*line 446
move.b (R12)+,R5
*line 447
*line 448
*line 448
move.l R13,(sp)
move.b R5,R0
ext.w R0
move R0,-(sp) 
jsr _putc
addq.l #2,sp
cmp #-1,R0
bne L81
*line 449
*line 450
move _errno,(sp)
move.l #L82,-(sp)
move.l #_errbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 451
*line 452
*line 453
move #9,(sp)
move #14,-(sp)
clr.l -(sp)
move.l #_errbuf,-(sp)
move.l #L83,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 454
*line 455
move.l R13,(sp)
jsr _fclose
*line 456
jsr _postio
*line 457
move #-1,R0
bra L76
*line 458
*line 459
*line 463
L81:L78:
*line 443
add.l #$1,R6
L79:
*line 443
cmp.l R7,R6
blt L80
L77:
*line 466
clr R0
bra L76
L76:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _rd_ec
.text
_rd_ec:
~~rd_ec:
~fp=R13
~to=R12
~len=R7
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~count=R6
~c=R5
*line 487
move.l 8(R14),R13
*line 487
move.l 12(R14),R12
*line 487
move.l 16(R14),R7
*line 487
clr.l R6
bra L87
L88:
*line 488
*line 489
clr _errno
*line 490
*line 491
*line 491
move.l R13,(sp)
jsr _getc
move R0,R5
cmp #-1,R5
bne L89
*line 492
*line 493
move _errno,(sp)
move.l #L90,-(sp)
move.l #_errbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 494
*line 495
*line 496
move #9,(sp)
move #14,-(sp)
clr.l -(sp)
move.l #_errbuf,-(sp)
move.l #L91,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 497
*line 498
move.l R13,(sp)
jsr _fclose
*line 499
jsr _postio
*line 500
move #-1,R0
bra L84
*line 501
bra L92
L89:
*line 502
*line 503
*line 504
move.b R5,(R12)+
*line 505
*line 509
L92:
*line 510
L86:
*line 487
add.l #$1,R6
L87:
*line 487
cmp.l R7,R6
blt L88
L85:
*line 513
clr R0
bra L84
L84:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _srchcat
.text
_srchcat:
~~srchcat:
~extn=8
link R14,#0
movem.l R6-R7,-(sp)
~fcslot=R7
*line 533
clr R7
bra L96
L97:
*line 534
*line 535
*line 536
move R7,(sp)
jsr _ocslot
tst R0
beq L98
*line 536
*line 537
*line 538
move #8,(sp)
move.l #_ldfile,-(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #4,(sp)
jsr _memcmp
addq.l #8,sp
tst R0
bne L99
move #3,(sp)
move.l 8(R14),-(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #13,(sp)
jsr _memcmpu
addq.l #8,sp
tst R0
bne L99
*line 538
move R7,R0
bra L93
L99:L98:L95:
*line 533
add #1,R7
L96:
*line 533
cmp #20,R7
blt L97
L94:
*line 541
move #-1,R0
bra L93
L93:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _clrcat
.text
_clrcat:
~~clrcat:
link R14,#-58
movem.l R6-R7,-(sp)
~i=R7
~fcebuf=-58
*line 555
clr R7
bra L103
L104:
*line 556
*line 557
*line 558
*line 559
move #10,(sp)
move #13,-(sp)
move.l #L106,-(sp)
move R7,-(sp)
move.l #L105,-(sp)
move.l R14,-(sp)
add.l #-58,(sp)
jsr _sprintf
adda.l #16,sp
*line 560
*line 561
move #56,(sp)
move.l R14,-(sp)
add.l #-58,(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
L102:
*line 555
add #1,R7
L103:
*line 555
cmp #20,R7
blt L104
L101:L100:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _clreq
.text
_clreq:
~~clreq:
~bytes=8
link R14,#0
movem.l R5-R7,-(sp)
~rclusts=R7
~clmask=R6
*line 583
move.l __thebpb,R8
clr R0
move 4(R8),R0
sub #1,R0
swap R0
clr R0
swap R0
move.l R0,R6
*line 585
*line 586
move.l __thebpb,R8
clr R0
move 4(R8),R0
swap R0
clr R0
swap R0
move.l R0,-(sp)
move.l 8(R14),-(sp)
jsr ldiv
addq.l #8,sp
move.l R6,R1
and.l 8(R14),R1
beq L10003
move #1,R1
bra L10005
L10003:clr R1
L10005:ext.l R1
add.l R1,R0
move R0,R7
*line 588
move R7,R0
bra L107
L107:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _spacerq
.text
_spacerq:
~~spacerq:
~kind=8
link R14,#0
movem.l R5-R7,-(sp)
~howmuch=R7
~k=R6
*line 607
clr.l R6
*line 609
move 8(R14),R0
bra L110
*line 610
L111:
*line 611
*line 612
*line 613
move.l #$809c,R6
bra L109
*line 614
*line 615
L112:
*line 616
L113:
*line 617
L114:
*line 618
*line 619
*line 620
move.l #$14,-(sp)
move.l #1778+_idefs,R0
sub.l #_idefs,R0
move.l R0,-(sp)
add.l #$478,(sp)
jsr lmul
addq.l #8,sp
move.l R0,R6
add.l #$38,R6
bra L109
*line 621
*line 622
L115:
*line 623
*line 624
*line 625
jsr _ptsizer
move.l R0,R6
add.l #$38,R6
bra L109
*line 626
*line 627
L116:
*line 628
*line 629
*line 630
jsr _scsizer
move.l R0,R6
add.l #$38,R6
bra L109
*line 631
*line 632
L117:
*line 633
*line 634
*line 635
jsr _sqsizer
move.l R0,R6
add.l #$38,R6
bra L109
*line 636
*line 637
L118:
*line 638
*line 639
*line 640
move.l #$a58,R6
bra L109
*line 641
*line 642
L119:
*line 643
*line 644
*line 645
move.l #$2ce8,R6
bra L109
*line 646
*line 647
L120:
*line 648
*line 649
*line 650
clr.l R6
bra L109
*line 651
bra L109
L110:sub #1,R0
cmp #8,R0
bhi L120
asl #2,R0
move R0,R8
add.l #L121,R8
move.l (R8),R8
jmp (R8)
.data
L121:.dc.l L111
.dc.l L112
.dc.l L113
.dc.l L116
.dc.l L118
.dc.l L119
.dc.l L114
.dc.l L115
.dc.l L117
.text
L109:
*line 655
tst.l R6
beq L10006
move.l R6,(sp)
jsr _clreq
bra L10008
L10006:move #-1,R0
L10008:move R0,R7
*line 656
move.l R6,_ndbytes
*line 657
move R7,R0
bra L108
L108:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ckstor
.text
_ckstor:
~~ckstor:
link R14,#-4
*line 672
*line 673
tst _lasgsw
beq L123
*line 673
clr R0
bra L122
*line 674
L123:
*line 675
*line 676
tst _lorchsw
beq L124
*line 676
clr R0
bra L122
*line 677
L124:
*line 678
*line 679
tst _lorclsw
beq L125
*line 679
clr R0
bra L122
*line 680
L125:
*line 681
*line 682
tst _lpatsw
beq L126
*line 682
clr R0
bra L122
*line 683
L126:
*line 684
*line 685
tst _lscrsw
beq L127
*line 685
clr R0
bra L122
*line 686
L127:
*line 687
*line 688
tst _lseqsw
beq L128
*line 688
clr R0
bra L122
*line 689
L128:
*line 690
*line 691
tst _ltunsw
beq L129
*line 691
clr R0
bra L122
*line 692
L129:
*line 693
*line 694
tst _lwavsw
beq L130
*line 694
clr R0
bra L122
*line 695
L130:
*line 696
move #-1,R0
bra L122
L122:unlk R14
rts
.globl _ckdups
.text
_ckdups:
~~ckdups:
link R14,#-4
*line 711
*line 712
tst _lasgsw
beq L132
*line 712
*line 713
move.l #L133,(sp)
jsr _srchcat
cmp #-1,R0
beq L134
*line 713
move #1,R0
bra L131
*line 714
L134:L132:
*line 715
*line 716
tst _lorchsw
beq L135
*line 716
*line 717
move.l #L136,(sp)
jsr _srchcat
cmp #-1,R0
beq L137
*line 717
move #3,R0
bra L131
*line 718
L137:L135:
*line 719
*line 720
tst _lorclsw
beq L138
*line 720
*line 721
move.l #L139,(sp)
jsr _srchcat
cmp #-1,R0
beq L140
*line 721
move #2,R0
bra L131
*line 722
L140:L138:
*line 723
*line 724
tst _lorchsw
bne L10009
tst _lorclsw
beq L141
L10009:*line 724
*line 725
move.l #L142,(sp)
jsr _srchcat
cmp #-1,R0
beq L143
*line 725
move #7,R0
bra L131
*line 726
L143:L141:
*line 727
*line 728
tst _lpatsw
beq L144
*line 728
*line 729
move.l #L145,(sp)
jsr _srchcat
cmp #-1,R0
beq L146
*line 729
move #8,R0
bra L131
*line 730
L146:L144:
*line 731
*line 732
tst _lscrsw
beq L147
*line 732
*line 733
move.l #L148,(sp)
jsr _srchcat
cmp #-1,R0
beq L149
*line 733
move #4,R0
bra L131
*line 734
L149:L147:
*line 735
*line 736
tst _lseqsw
beq L150
*line 736
*line 737
move.l #L151,(sp)
jsr _srchcat
cmp #-1,R0
beq L152
*line 737
move #9,R0
bra L131
*line 738
L152:L150:
*line 739
*line 740
tst _ltunsw
beq L153
*line 740
*line 741
move.l #L154,(sp)
jsr _srchcat
cmp #-1,R0
beq L155
*line 741
move #5,R0
bra L131
*line 742
L155:L153:
*line 743
*line 744
tst _lwavsw
beq L156
*line 744
*line 745
move.l #L157,(sp)
jsr _srchcat
cmp #-1,R0
beq L158
*line 745
move #6,R0
bra L131
L158:L156:
*line 746
clr R0
bra L131
L131:unlk R14
rts
.globl _showsiz
.text
_showsiz:
~~showsiz:
link R14,#0
movem.l R4-R7,-(sp)
~dcap=R7
~drem=R6
~dused=R5
*line 764
clr __bpbin
*line 766
clr (sp)
jsr _dspace
move R0,R7
*line 768
*line 768
cmp #-1,R7
bne L160
*line 769
*line 770
*line 771
*line 772
move #9,(sp)
move #14,-(sp)
clr.l -(sp)
clr.l -(sp)
move.l #L161,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 773
*line 774
move #-1,R0
bra L159
*line 775
*line 776
L160:
*line 777
move #1,(sp)
jsr _dspace
move R0,R6
*line 778
move R7,R5
sub R6,R5
*line 780
move R7,(sp)
move.l #L162,-(sp)
move.l #_ldmsg1,-(sp)
jsr _sprintf
addq.l #8,sp
*line 781
move R5,(sp)
move.l #L163,-(sp)
move.l #_ldmsg2,-(sp)
jsr _sprintf
addq.l #8,sp
*line 782
move R6,(sp)
move.l #L164,-(sp)
move.l #_ldmsg3,-(sp)
jsr _sprintf
addq.l #8,sp
*line 784
move 170+_ldbox,(sp)
move 168+_ldbox,-(sp)
move.l #_ldmsg3,-(sp)
move.l #_ldmsg2,-(sp)
move.l #_ldmsg1,-(sp)
jsr _ldwmsg
adda.l #14,sp
L159:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _getcat
.text
_getcat:
~~getcat:
~msgsw=8
link R14,#-4
movem.l R7-R7/R13-R13,-(sp)
~fp=R13
~rc=-2
~fesize=-4
*line 803
clr _ldidsiz
*line 804
clr __bpbin
*line 805
clr _catin
*line 807
clr _errno
*line 808
jsr _preio
*line 809
move.l #L167,(sp)
move.l #L166,-(sp)
jsr _fopenb
addq.l #4,sp
move.l R0,R13
*line 811
*line 811
move.l R13,R0
bne L168
*line 812
*line 813
jsr _clrcat
*line 814
move #1,_catin
*line 815
*line 816
*line 816
tst 8(R14)
beq L169
*line 817
*line 818
jsr _showsiz
*line 819
move #1,_ldidsiz
*line 820
*line 821
L169:
*line 822
clr R0
bra L165
*line 823
*line 824
L168:
*line 825
move #56,-4(R14)
*line 826
move #1120,(sp)
clr -(sp)
move.l #_filecat,-(sp)
jsr _memset
addq.l #6,sp
*line 830
clr _errno
*line 831
move.l R13,(sp)
move #20,-(sp)
move -4(R14),-(sp)
move.l #_filecat,-(sp)
jsr _fread
addq.l #8,sp
move R0,-2(R14)
*line 833
*line 833
cmp #20,-2(R14)
beq L170
*line 834
*line 835
*line 835
tst -2(R14)
beq L171
*line 836
*line 837
move -2(R14),(sp)
move.l #L172,-(sp)
move.l #_ldmsg1,-(sp)
jsr _sprintf
addq.l #8,sp
*line 838
*line 839
move -4(R14),(sp)
move _errno,-(sp)
move.l #L173,-(sp)
move.l #_ldmsg2,-(sp)
jsr _sprintf
adda.l #10,sp
*line 840
*line 841
*line 842
move #9,(sp)
move #14,-(sp)
move.l #_ldmsg2,-(sp)
move.l #_ldmsg1,-(sp)
move.l #L174,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 843
*line 844
clr _catin
*line 845
bra L175
L171:
*line 846
*line 847
*line 848
*line 849
*line 850
move #9,(sp)
move #14,-(sp)
clr.l -(sp)
clr.l -(sp)
move.l #L176,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 851
*line 852
jsr _clrcat
*line 853
move #1,_catin
L175:
*line 854
*line 855
*line 856
move.l R13,(sp)
jsr _fclose
*line 857
jsr _postio
*line 858
move #-1,R0
bra L165
*line 859
*line 860
L170:
*line 861
move #1,_catin
*line 862
move.l R13,(sp)
jsr _fclose
*line 863
jsr _postio
*line 864
clr R0
bra L165
L165:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _putcat
.text
_putcat:
~~putcat:
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~fp=R13
~i=R7
~rc=R6
~fesize=R5
*line 882
clr R7
bra L180
L181:
*line 883
*line 884
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,R8
move.b #13,54(R8)
*line 885
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,R8
move.b #10,55(R8)
L179:
*line 882
add #1,R7
L180:
*line 882
cmp #20,R7
blt L181
L178:
*line 888
clr _errno
*line 889
jsr _preio
*line 890
move.l #L183,(sp)
move.l #L182,-(sp)
jsr _fopenb
addq.l #4,sp
move.l R0,R13
*line 892
*line 892
move.l R13,R0
bne L184
*line 893
*line 894
move _errno,(sp)
move.l #L185,-(sp)
move.l #_ldmsg2,-(sp)
jsr _sprintf
addq.l #8,sp
*line 895
*line 896
*line 897
move #9,(sp)
move #14,-(sp)
move.l #_ldmsg2,-(sp)
clr.l -(sp)
move.l #L186,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 898
*line 899
move #-1,R0
bra L177
*line 900
*line 901
L184:
*line 902
move #56,R5
*line 906
clr _errno
*line 907
move.l R13,(sp)
move #20,-(sp)
move R5,-(sp)
move.l #_filecat,-(sp)
jsr _fwrite
addq.l #8,sp
move R0,R6
*line 909
*line 909
cmp #20,R6
beq L187
*line 910
*line 911
*line 911
tst R6
beq L188
*line 912
*line 913
move R6,(sp)
move.l #L189,-(sp)
move.l #_ldmsg1,-(sp)
jsr _sprintf
addq.l #8,sp
*line 914
*line 915
move R5,(sp)
move _errno,-(sp)
move.l #L190,-(sp)
move.l #_ldmsg2,-(sp)
jsr _sprintf
adda.l #10,sp
*line 916
*line 917
*line 918
move #9,(sp)
move #14,-(sp)
move.l #_ldmsg2,-(sp)
move.l #_ldmsg1,-(sp)
move.l #L191,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 919
bra L192
L188:
*line 920
*line 921
*line 922
move _errno,(sp)
move.l #L193,-(sp)
move.l #_ldmsg2,-(sp)
jsr _sprintf
addq.l #8,sp
*line 923
*line 924
*line 925
*line 926
move #9,(sp)
move #14,-(sp)
move.l #_ldmsg2,-(sp)
clr.l -(sp)
move.l #L194,-(sp)
jsr _ldermsg
adda.l #14,sp
L192:
*line 927
*line 928
*line 929
move.l R13,(sp)
jsr _fclose
*line 930
jsr _postio
*line 931
move #-1,R0
bra L177
*line 932
*line 933
L187:
*line 934
move.l R13,(sp)
jsr _fclose
*line 935
jsr _postio
*line 936
clr R0
bra L177
L177:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _dslslot
.text
_dslslot:
~~dslslot:
~slot=R7
~fg=10
~row=12
link R14,#-42
movem.l R3-R7,-(sp)
~color=R6
~chilon=R5
~chilorc=R4
~c=-2
~buf=-42
*line 957
move 8(R14),R7
*line 957
*line 958
tst _ndisp
bne L195
*line 959
*line 960
move 10(R14),(sp)
jsr _exp_c
move R0,R6
*line 961
move 24+_ldbox,(sp)
jsr _exp_c
move R0,R5
*line 962
move #6,(sp)
jsr _exp_c
move R0,R4
*line 966
move #14,(sp)
clr -(sp)
move R7,-(sp)
jsr _fctstr
addq.l #4,sp
move.l R0,-(sp)
move #1,-(sp)
move 12(R14),-(sp)
move 26+_ldbox,-(sp)
move R6,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 970
move R7,R0
muls #56,R0
move.l R0,R8
move.l #_filecat,R9
move.b 3(R8,R9.l),R0
ext.w R0
move R0,-2(R14)
*line 971
move -2(R14),R0
and #127,R0
move.b R0,-42(R14)
*line 972
clr.b -41(R14)
*line 973
*line 974
move #14,(sp)
move.l R14,-(sp)
add.l #-42,(sp)
move #11,-(sp)
move 12(R14),-(sp)
move 26+_ldbox,-(sp)
btst #7,-1(R14)
beq L10010
move R4,-(sp)
bra L10012
L10010:move R5,-(sp)
L10012:move #64,-(sp)
move.l _librob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 978
move #8,(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #4,(sp)
move.l R14,-(sp)
add.l #-42,(sp)
jsr _memcpy
addq.l #8,sp
*line 979
clr.b -34(R14)
*line 980
move #14,(sp)
move.l R14,-(sp)
add.l #-42,(sp)
move #13,-(sp)
move 12(R14),-(sp)
move 26+_ldbox,-(sp)
move R6,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 984
move #37,(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #17,(sp)
move.l R14,-(sp)
add.l #-42,(sp)
jsr _memcpy
addq.l #8,sp
*line 985
clr.b -5(R14)
*line 986
move #14,(sp)
move.l R14,-(sp)
add.l #-42,(sp)
move #22,-(sp)
move 12(R14),-(sp)
move 26+_ldbox,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 990
move #3,(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
move.l R14,-(sp)
add.l #-42,(sp)
jsr _memcpy
addq.l #8,sp
*line 991
clr.b -39(R14)
*line 992
move #14,(sp)
move.l R14,-(sp)
add.l #-42,(sp)
move #60,-(sp)
move 12(R14),-(sp)
move 26+_ldbox,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _vcputsv
adda.l #18,sp
L195:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _showcat
.text
_showcat:
~~showcat:
link R14,#0
movem.l R2-R7,-(sp)
~i=R7
~fcslot=R6
~fcrow=R5
~fcount=R4
~color=R3
*line 1010
*line 1011
tst _ndisp
bne L196
*line 1012
*line 1013
clr (sp)
jsr _ldswin
*line 1015
move 26+_ldbox,(sp)
jsr _exp_c
move R0,R3
*line 1017
*line 1018
clr R0
move 10+_v_regs,R0
and #384,R0
beq L197
*line 1018
clr (sp)
jsr _vbank
*line 1019
L197:
*line 1020
*line 1021
move R3,(sp)
move 22+_ldbox,-(sp)
move 20+_ldbox,-(sp)
move 18+_ldbox,-(sp)
move 16+_ldbox,-(sp)
move #128,-(sp)
move.l _librob,-(sp)
jsr _vbfill4
adda.l #14,sp
*line 1023
move 24+_ldbox,R3
*line 1025
move #1,R5
*line 1026
clr R4
*line 1028
clr R6
bra L200
L201:
*line 1029
*line 1030
*line 1030
move R6,(sp)
jsr _ocslot
tst R0
beq L202
*line 1031
*line 1032
move R5,(sp)
move R3,-(sp)
move R6,-(sp)
jsr _dslslot
addq.l #4,sp
*line 1033
add #1,R5
*line 1034
add #1,R4
*line 1035
L202:L199:
*line 1028
add #1,R6
L200:
*line 1028
cmp #20,R6
blt L201
L198:
*line 1038
move R4,R0
bra L196
L196:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _fcindex
.text
_fcindex:
~~fcindex:
link R14,#-4
*line 1053
*line 1054
tst _lderrsw
bne L204
*line 1054
move.l #L205,(sp)
jsr _ldbusy
*line 1055
L204:
*line 1056
*line 1057
move #1,(sp)
jsr _getcat
tst R0
beq L206
*line 1057
move #-1,R0
bra L203
*line 1058
L206:
*line 1059
*line 1060
tst _lderrsw
bne L207
*line 1060
jsr _showcat
*line 1061
*line 1062
*line 1063
L207:
*line 1064
*line 1065
tst _ldidsiz
bne L208
tst _lderrsw
bne L208
*line 1065
jsr _showsiz
*line 1066
L208:
*line 1067
clr R0
bra L203
L203:unlk R14
rts
.globl _streset
.text
_streset:
~~streset:
link R14,#-4
*line 1081
clr _lstrsw
*line 1083
clr _lasgsw
*line 1084
clr _lorchsw
*line 1085
clr _lorclsw
*line 1086
clr _lpatsw
*line 1087
clr _lscrsw
*line 1088
clr _lseqsw
*line 1089
clr _ltunsw
*line 1090
clr _lwavsw
*line 1092
move #9,(sp)
jsr _ldswin
L209:unlk R14
rts
.globl _fcreset
.text
_fcreset:
~~fcreset:
link R14,#-4
*line 1103
clr _lselsw
*line 1105
move #6,(sp)
jsr _ldswin
L210:unlk R14
rts
.globl _getslot
.text
_getslot:
~~getslot:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 1124
clr R7
bra L214
L215:
*line 1125
*line 1126
move R7,(sp)
jsr _ocslot
tst R0
bne L216
*line 1126
move R7,R0
bra L211
*line 1127
L216:L213:
*line 1124
add #1,R7
L214:
*line 1124
cmp #20,R7
blt L215
L212:
*line 1128
move #-1,R0
bra L211
L211:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _slotnam
.text
_slotnam:
~~slotnam:
~slot=8
~kind=10
link R14,#-4
~thename=L218
.bss
L218:.ds.b 14
.text
*line 1143
*line 1144
clr R0
move 10(R14),R0
sub #1,R0
mulu #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 0(R8,R9.l),(sp)
move 8(R14),-(sp)
move.l #L219,-(sp)
move.l #L218,-(sp)
jsr _sprintf
adda.l #10,sp
*line 1146
move.l #L218,R0
bra L217
L217:unlk R14
rts
.globl _wrtfile
.text
_wrtfile:
~~wrtfile:
~kind=8
link R14,#-4
movem.l R4-R7,-(sp)
~slot=R7
~flspace=R6
~tkind=R5
~sizetmp=-4
*line 1165
jsr _getslot
move R0,R7
*line 1167
*line 1167
cmp #-1,R7
bne L221
*line 1168
*line 1169
move 8(R14),(sp)
jsr _noslot
*line 1170
jsr _streset
*line 1171
move #-1,R0
bra L220
*line 1172
*line 1173
*line 1174
*line 1175
*line 1176
L221:
*line 1177
move 8(R14),R0
bra L223
*line 1178
L224:
*line 1179
*line 1180
*line 1181
*line 1182
move R7,(sp)
jsr _wrt_asg
tst R0
beq L225
*line 1182
move #-1,R0
bra L220
*line 1183
bra L226
L225:bra L222
L226:
*line 1184
*line 1185
L227:
*line 1186
*line 1187
*line 1188
*line 1189
clr (sp)
move R7,-(sp)
jsr _wrt_orc
addq.l #2,sp
tst R0
beq L228
*line 1189
move #-1,R0
bra L220
*line 1190
bra L229
L228:bra L222
L229:
*line 1191
*line 1192
L230:
*line 1193
*line 1194
*line 1195
*line 1196
move #1,(sp)
move R7,-(sp)
jsr _wrt_orc
addq.l #2,sp
tst R0
beq L231
*line 1196
move #-1,R0
bra L220
*line 1197
bra L232
L231:bra L222
L232:
*line 1198
*line 1199
L233:
*line 1200
*line 1201
*line 1202
*line 1203
move R7,(sp)
jsr _wrt_pat
tst R0
beq L234
*line 1203
move #-1,R0
bra L220
*line 1204
bra L235
L234:bra L222
L235:
*line 1205
*line 1206
L236:
*line 1207
*line 1208
*line 1209
*line 1210
move R7,(sp)
jsr _wrt_scr
tst R0
beq L237
*line 1210
move #-1,R0
bra L220
*line 1211
bra L238
L237:bra L222
L238:
*line 1212
*line 1213
L239:
*line 1214
*line 1215
*line 1216
*line 1217
move R7,(sp)
jsr _wrt_seq
tst R0
beq L240
*line 1217
move #-1,R0
bra L220
*line 1218
bra L241
L240:bra L222
L241:
*line 1219
*line 1220
*line 1221
*line 1222
L242:
*line 1223
*line 1224
*line 1225
*line 1226
move R7,(sp)
jsr _wrt_tun
tst R0
beq L243
*line 1226
move #-1,R0
bra L220
*line 1227
bra L244
L243:bra L222
L244:
*line 1228
*line 1229
L245:
*line 1230
*line 1231
*line 1232
*line 1233
move R7,(sp)
jsr _wrt_wav
tst R0
beq L246
*line 1233
move #-1,R0
bra L220
*line 1234
bra L247
L246:bra L222
L247:
*line 1235
*line 1236
L248:
*line 1237
*line 1238
*line 1239
move 8(R14),(sp)
move.l #L249,-(sp)
move.l #_ldmsg1,-(sp)
jsr _sprintf
addq.l #8,sp
*line 1240
*line 1241
*line 1242
move #9,(sp)
move #14,-(sp)
clr.l -(sp)
move.l #_ldmsg1,-(sp)
move.l #L250,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 1243
*line 1244
move #-1,R0
bra L220
bra L222
L223:sub #1,R0
cmp #8,R0
bhi L248
asl #2,R0
move R0,R8
add.l #L251,R8
move.l (R8),R8
jmp (R8)
.data
L251:.dc.l L224
.dc.l L227
.dc.l L230
.dc.l L236
.dc.l L242
.dc.l L245
.dc.l L248
.dc.l L233
.dc.l L239
.text
L222:
*line 1252
*line 1253
cmp #2,8(R14)
beq L10013
cmp #3,8(R14)
bne L252
L10013:*line 1253
move #7,R5
*line 1254
bra L253
L252:
*line 1255
move 8(R14),R5
L253:
*line 1257
move 8(R14),(sp)
jsr _spacerq
move R0,R6
*line 1259
move R6,(sp)
move.l #L254,-(sp)
move.l R14,-(sp)
sub.l #4,(sp)
jsr _sprintf
addq.l #8,sp
*line 1260
move #3,(sp)
move.l R14,-(sp)
sub.l #4,(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
*line 1262
move #8,(sp)
move.l #_ldfile,-(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #4,(sp)
jsr _memcpy
addq.l #8,sp
*line 1263
move #3,(sp)
move R5,R0
sub #1,R0
muls #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 0(R8,R9.l),-(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #13,(sp)
jsr _memcpy
addq.l #8,sp
*line 1264
move #37,(sp)
move.l #_ldcmnt,-(sp)
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,-(sp)
add.l #17,(sp)
jsr _memcpy
addq.l #8,sp
*line 1266
move 8(R14),(sp)
jsr _savefc
*line 1268
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,R8
move.b #13,54(R8)
*line 1269
move R7,R0
muls #56,R0
add.l #_filecat,R0
move.l R0,R8
move.b #10,55(R8)
*line 1271
clr R0
bra L220
L220:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _writem
.text
_writem:
~~writem:
link R14,#-4
*line 1286
*line 1287
tst _lasgsw
beq L256
*line 1287
*line 1288
move #1,(sp)
jsr _wrtfile
tst R0
beq L257
*line 1288
move #-1,R0
bra L255
*line 1289
L257:L256:
*line 1290
*line 1291
tst _lorchsw
beq L258
*line 1291
*line 1292
move #3,(sp)
jsr _wrtfile
tst R0
beq L259
*line 1292
move #-1,R0
bra L255
*line 1293
L259:L258:
*line 1294
*line 1295
tst _lorclsw
beq L260
*line 1295
*line 1296
move #2,(sp)
jsr _wrtfile
tst R0
beq L261
*line 1296
move #-1,R0
bra L255
*line 1297
L261:L260:
*line 1298
*line 1299
tst _lpatsw
beq L262
*line 1299
*line 1300
move #8,(sp)
jsr _wrtfile
tst R0
beq L263
*line 1300
move #-1,R0
bra L255
*line 1301
L263:L262:
*line 1302
*line 1303
tst _lscrsw
beq L264
*line 1303
*line 1304
move #4,(sp)
jsr _wrtfile
tst R0
beq L265
*line 1304
move #-1,R0
bra L255
*line 1305
L265:L264:
*line 1306
*line 1307
tst _lseqsw
beq L266
*line 1307
*line 1308
move #9,(sp)
jsr _wrtfile
tst R0
beq L267
*line 1308
move #-1,R0
bra L255
*line 1309
L267:L266:
*line 1310
*line 1311
tst _ltunsw
beq L268
*line 1311
*line 1312
move #5,(sp)
jsr _wrtfile
tst R0
beq L269
*line 1312
move #-1,R0
bra L255
*line 1313
L269:L268:
*line 1314
*line 1315
tst _lwavsw
beq L270
*line 1315
*line 1316
move #6,(sp)
jsr _wrtfile
tst R0
beq L271
*line 1316
move #-1,R0
bra L255
*line 1317
L271:L270:
*line 1318
clr R0
bra L255
L255:unlk R14
rts
.globl _storit
.text
_storit:
~~storit:
link R14,#-4
movem.l R3-R7,-(sp)
~weneed=R7
~i=R6
~slotnd=R5
~slothv=R4
~rc=-2
~drem=-4
*line 1338
*line 1338
move #8,(sp)
move.l #L273,-(sp)
move.l #_ldfile,-(sp)
jsr _memcmp
addq.l #8,sp
tst R0
bne L274
*line 1339
*line 1340
*line 1341
move #9,(sp)
move #14,-(sp)
move.l #_ld_em2,-(sp)
move.l #_ld_em1,-(sp)
move.l #L275,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 1342
*line 1343
jsr _streset
*line 1344
move #-1,R0
bra L272
*line 1345
*line 1346
*line 1347
*line 1348
L274:
*line 1349
*line 1349
jsr _ckstor
tst R0
beq L276
*line 1350
*line 1351
*line 1352
move #9,(sp)
move #14,-(sp)
move.l #_ld_em2,-(sp)
move.l #_ld_em1,-(sp)
move.l #L277,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 1353
*line 1354
jsr _streset
*line 1355
move #-1,R0
bra L272
*line 1356
*line 1357
L276:
*line 1358
*line 1359
tst _lderrsw
bne L278
*line 1359
move.l #L279,(sp)
jsr _ldbusy
*line 1360
L278:
*line 1361
*line 1361
clr (sp)
jsr _getcat
tst R0
beq L280
*line 1362
*line 1363
jsr _streset
*line 1364
move #-1,R0
bra L272
*line 1365
*line 1366
*line 1367
*line 1368
L280:
*line 1369
move #1,(sp)
jsr _dspace
move R0,-4(R14)
*line 1370
clr R5
*line 1371
clr R7
*line 1375
*line 1375
tst _lasgsw
beq L281
*line 1376
*line 1377
move #1,(sp)
jsr _spacerq
add R0,R7
*line 1378
add #1,R5
*line 1379
*line 1380
L281:
*line 1381
*line 1381
tst _lorchsw
beq L282
*line 1382
*line 1383
move #3,(sp)
jsr _spacerq
add R0,R7
*line 1384
add #1,R5
*line 1385
*line 1386
L282:
*line 1387
*line 1387
tst _lorclsw
beq L283
*line 1388
*line 1389
move #2,(sp)
jsr _spacerq
add R0,R7
*line 1390
add #1,R5
*line 1391
*line 1392
L283:
*line 1393
*line 1393
tst _lpatsw
beq L284
*line 1394
*line 1395
move #8,(sp)
jsr _spacerq
add R0,R7
*line 1396
add #1,R5
*line 1397
*line 1398
L284:
*line 1399
*line 1399
tst _lscrsw
beq L285
*line 1400
*line 1401
move #4,(sp)
jsr _spacerq
add R0,R7
*line 1402
add #1,R5
*line 1403
*line 1404
L285:
*line 1405
*line 1405
tst _lseqsw
beq L286
*line 1406
*line 1407
move #9,(sp)
jsr _spacerq
add R0,R7
*line 1408
add #1,R5
*line 1409
*line 1410
L286:
*line 1411
*line 1411
tst _ltunsw
beq L287
*line 1412
*line 1413
move #5,(sp)
jsr _spacerq
add R0,R7
*line 1414
add #1,R5
*line 1415
*line 1416
L287:
*line 1417
*line 1417
tst _lwavsw
beq L288
*line 1418
*line 1419
move #6,(sp)
jsr _spacerq
add R0,R7
*line 1420
add #1,R5
*line 1421
*line 1422
L288:
*line 1423
*line 1423
cmp -4(R14),R7
ble L289
*line 1424
*line 1425
move -4(R14),(sp)
move R7,-(sp)
clr -(sp)
jsr _nospace
addq.l #4,sp
*line 1426
jsr _streset
*line 1427
move #-1,R0
bra L272
*line 1428
*line 1429
*line 1430
*line 1431
*line 1432
*line 1433
*line 1434
L289:
*line 1435
clr R4
*line 1437
clr R6
bra L292
L293:
*line 1438
*line 1439
move R6,(sp)
jsr _ocslot
tst R0
bne L294
*line 1439
add #1,R4
*line 1440
L294:L291:
*line 1437
add #1,R6
L292:
*line 1437
cmp #20,R6
blt L293
L290:
*line 1441
*line 1441
cmp R5,R4
bge L295
*line 1442
*line 1443
move R5,(sp)
move R4,-(sp)
move #1,-(sp)
jsr _nospace
addq.l #4,sp
*line 1444
jsr _streset
*line 1445
move #-1,R0
bra L272
*line 1446
*line 1447
*line 1448
*line 1449
L295:
*line 1450
*line 1450
jsr _ckdups
move R0,-2(R14)
beq L296
*line 1451
*line 1452
move -2(R14),R0
sub #1,R0
muls #12,R0
move.l R0,R8
move.l #_ftypes,R9
move.l 8(R8,R9.l),(sp)
move.l #L297,-(sp)
move.l #_ldmsg1,-(sp)
jsr _sprintf
addq.l #8,sp
*line 1453
move #9,(sp)
move #14,-(sp)
move.l #_ld_em2,-(sp)
move.l #_ld_em1,-(sp)
move.l #_ldmsg1,-(sp)
jsr _ldermsg
adda.l #14,sp
*line 1454
*line 1455
jsr _streset
*line 1456
move #-1,R0
bra L272
*line 1457
*line 1458
*line 1459
*line 1460
*line 1461
*line 1462
*line 1463
L296:
*line 1464
jsr _writem
move R0,-2(R14)
*line 1466
*line 1467
tst -2(R14)
bne L298
*line 1467
move.l #L299,(sp)
jsr _ldbusy
*line 1468
L298:
*line 1469
*line 1469
jsr _putcat
tst R0
beq L300
*line 1470
*line 1471
jsr __clsvol
*line 1472
jsr _streset
*line 1473
jsr _showcat
*line 1474
move #-1,R0
bra L272
*line 1475
*line 1476
L300:
*line 1477
jsr __clsvol
*line 1478
jsr _streset
*line 1479
jsr _showcat
*line 1481
*line 1482
tst -2(R14)
beq L301
*line 1482
move #-1,R0
bra L272
*line 1483
L301:
*line 1484
jsr _showsiz
*line 1485
clr R0
bra L272
L272:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _advlcur
.text
_advlcur:
~~advlcur:
link R14,#0
movem.l R6-R7,-(sp)
~newcol=R7
*line 1501
*line 1502
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L303
*line 1502
move.l _infetp,_cfetp
*line 1503
bra L304
L303:bra L302
L304:
*line 1506
move _stccol,R7
add #1,R7
*line 1508
*line 1509
move.l _cfetp,R8
cmp 4(R8),R7
bgt L305
*line 1509
move R7,(sp)
move _stcrow,-(sp)
jsr _itcpos
addq.l #2,sp
*line 1510
L305:
*line 1511
move _stccol,R0
asl #3,R0
move R0,_cxval
*line 1512
move _stcrow,R0
muls #14,R0
move R0,_cyval
L302:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _bsplcur
.text
_bsplcur:
~~bsplcur:
link R14,#0
movem.l R6-R7,-(sp)
~newcol=R7
*line 1525
*line 1526
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L307
*line 1526
move.l _infetp,_cfetp
*line 1527
bra L308
L307:bra L306
L308:
*line 1530
move _stccol,R7
sub #1,R7
*line 1532
*line 1533
move.l _cfetp,R8
cmp 2(R8),R7
blt L309
*line 1533
move R7,(sp)
move _stcrow,-(sp)
jsr _itcpos
addq.l #2,sp
*line 1534
L309:
*line 1535
move _stccol,R0
asl #3,R0
move R0,_cxval
*line 1536
move _stcrow,R0
muls #14,R0
move R0,_cyval
L306:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ldswin
.text
_ldswin:
~~ldswin:
~n=R7
link R14,#0
movem.l R4-R7,-(sp)
~cx=R6
~cy=R5
*line 1553
move 8(R14),R7
*line 1553
*line 1554
tst _ndisp
bne L310
*line 1555
*line 1556
*line 1557
cmp #10,R7
bne L311
cmp #1,_lmwtype
bne L311
*line 1557
move #10,(sp)
jsr _exp_c
move R0,R6
*line 1558
bra L312
L311:
*line 1559
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 10(R8,R9.l),(sp)
jsr _exp_c
move R0,R6
L312:
*line 1563
*line 1564
clr R0
move 10+_v_regs,R0
and #384,R0
beq L313
*line 1564
clr (sp)
jsr _vbank
*line 1565
L313:
*line 1566
*line 1567
move R6,(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 6(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 4(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 2(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 0(R8,R9.l),-(sp)
move #128,-(sp)
move.l _librob,-(sp)
jsr _vbfill4
adda.l #14,sp
*line 1571
*line 1572
move #14,(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_ldbxlb0,R9
move.l 0(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 12(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1576
move R7,R0
bra L315
*line 1577
L316:
*line 1578
*line 1579
*line 1580
move.l #_ldpoint,_point
*line 1581
*line 1582
move #12,(sp)
move #13,-(sp)
move #79,-(sp)
move #13,-(sp)
move #8,-(sp)
jsr _lseg
addq.l #8,sp
*line 1583
move #12,(sp)
move #13,-(sp)
move #95,-(sp)
move #13,-(sp)
move #88,-(sp)
jsr _lseg
addq.l #8,sp
*line 1584
move #12,(sp)
move #13,-(sp)
move #167,-(sp)
move #13,-(sp)
move #104,-(sp)
jsr _lseg
addq.l #8,sp
*line 1585
move #12,(sp)
move #13,-(sp)
move #471,-(sp)
move #13,-(sp)
move #176,-(sp)
jsr _lseg
addq.l #8,sp
*line 1586
move #12,(sp)
move #13,-(sp)
move #504,-(sp)
move #13,-(sp)
move #480,-(sp)
jsr _lseg
addq.l #8,sp
*line 1587
bra L310
*line 1588
*line 1589
L317:
*line 1590
*line 1591
bra L310
*line 1592
*line 1593
L318:
*line 1594
*line 1595
*line 1596
*line 1597
move #14,(sp)
move.l #_ldfile,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 12(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
bra L310
*line 1598
*line 1599
L319:
*line 1600
*line 1601
*line 1602
*line 1603
move #14,(sp)
move.l #_ldcmnt,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 12(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
bra L310
*line 1604
*line 1605
*line 1606
*line 1607
*line 1608
L320:
*line 1609
*line 1610
*line 1611
*line 1612
tst _lrasw
beq L321
*line 1612
move #13,(sp)
jsr _exp_c
move R0,R5
*line 1613
bra L322
L321:
*line 1614
move R7,R0
asl #4,R0
ext.l R0
add.l #_ldbox,R0
move.l R0,R8
move 8(R8),R5
L322:
*line 1615
*line 1616
*line 1617
move #14,(sp)
move.l #L323,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 12(R8,R9.l),-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1618
bra L310
*line 1619
*line 1620
L324:
*line 1621
*line 1622
*line 1623
*line 1623
tst _lselsw
beq L325
*line 1624
*line 1625
move _ldslot,(sp)
jsr _ftkind
move R0,_ldkind
*line 1626
*line 1627
*line 1628
*line 1629
*line 1630
cmp #7,_ldkind
beq L10014
cmp #2,_ldkind
beq L10014
cmp #3,_ldkind
bne L326
L10014:*line 1630
move #13,(sp)
jsr _exp_c
move R0,R5
*line 1631
bra L327
L326:
*line 1632
move R7,R0
asl #4,R0
ext.l R0
add.l #_ldbox,R0
move.l R0,R8
move 8(R8),R5
L327:
*line 1633
bra L328
L325:
*line 1634
*line 1635
*line 1636
move R7,R0
asl #4,R0
ext.l R0
add.l #_ldbox,R0
move.l R0,R8
move 8(R8),R5
L328:
*line 1637
*line 1638
*line 1639
*line 1640
move #14,(sp)
tst _lorchl
beq L10015
move.l #L329,-(sp)
bra L10017
L10015:move.l #L330,-(sp)
L10017:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 12(R8,R9.l),-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1641
bra L310
*line 1642
*line 1643
*line 1644
L331:
*line 1645
*line 1646
*line 1647
tst _lstrsw
beq L10018
move #13,(sp)
bra L10020
L10018:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10020:jsr _exp_c
move R0,R5
*line 1648
move #14,(sp)
move.l #L332,-(sp)
move #10,-(sp)
move #22,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1649
*line 1650
tst _lscrsw
beq L10021
move #13,(sp)
bra L10023
L10021:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10023:jsr _exp_c
move R0,R5
*line 1651
move #14,(sp)
move.l #L333,-(sp)
move #17,-(sp)
move #22,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1652
*line 1653
tst _lorchsw
beq L10024
move #13,(sp)
bra L10026
L10024:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10026:jsr _exp_c
move R0,R5
*line 1654
move #14,(sp)
move.l #L334,-(sp)
move #24,-(sp)
move #22,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1655
*line 1656
*line 1657
tst _lwavsw
beq L10027
move #13,(sp)
bra L10029
L10027:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10029:jsr _exp_c
move R0,R5
*line 1658
move #14,(sp)
move.l #L335,-(sp)
move #10,-(sp)
move #23,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1659
*line 1660
tst _lpatsw
beq L10030
move #13,(sp)
bra L10032
L10030:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10032:jsr _exp_c
move R0,R5
*line 1661
move #14,(sp)
move.l #L336,-(sp)
move #17,-(sp)
move #23,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1662
*line 1663
tst _lorclsw
beq L10033
move #13,(sp)
bra L10035
L10033:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10035:jsr _exp_c
move R0,R5
*line 1664
move #14,(sp)
move.l #L337,-(sp)
move #24,-(sp)
move #23,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1665
*line 1666
*line 1667
tst _lasgsw
beq L10036
move #13,(sp)
bra L10038
L10036:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10038:jsr _exp_c
move R0,R5
*line 1668
move #14,(sp)
move.l #L338,-(sp)
move #10,-(sp)
move #24,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1669
*line 1670
tst _lseqsw
beq L10039
move #13,(sp)
bra L10041
L10039:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10041:jsr _exp_c
move R0,R5
*line 1671
move #14,(sp)
move.l #L339,-(sp)
move #17,-(sp)
move #24,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1672
*line 1673
tst _ltunsw
beq L10042
move #13,(sp)
bra L10044
L10042:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),(sp)
L10044:jsr _exp_c
move R0,R5
*line 1674
move #14,(sp)
move.l #L340,-(sp)
move #24,-(sp)
move #24,-(sp)
move R5,-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1675
bra L310
*line 1676
*line 1677
L341:
*line 1678
*line 1679
*line 1680
move #14,(sp)
move.l _lmln22,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move #22,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1681
move #14,(sp)
move.l _lmln23,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move #23,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1682
move #14,(sp)
move.l _lmln24,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 14(R8,R9.l),-(sp)
move #24,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_ldbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _librob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 1683
bra L310
*line 1684
bra L314
L315:cmp #10,R0
bhi L314
asl #2,R0
move R0,R8
add.l #L342,R8
move.l (R8),R8
jmp (R8)
.data
L342:.dc.l L316
.dc.l L317
.dc.l L314
.dc.l L318
.dc.l L314
.dc.l L319
.dc.l L314
.dc.l L320
.dc.l L324
.dc.l L331
.dc.l L341
.text
L314:L310:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _lwins
.text
_lwins:
~~lwins:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 1701
clr R7
bra L346
L347:
*line 1702
move R7,(sp)
jsr _ldswin
L345:
*line 1701
add #1,R7
L346:
*line 1701
cmp #11,R7
blt L347
L344:L343:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ldpoint
.text
_ldpoint:
~~ldpoint:
~x=8
~y=10
~pen=12
link R14,#-4
*line 1714
*line 1715
clr R0
move 10+_v_regs,R0
and #384,R0
beq L349
*line 1715
clr (sp)
jsr _vbank
*line 1716
L349:
*line 1717
move 12(R14),(sp)
jsr _exp_c
move R0,(sp)
move 10(R14),-(sp)
move 8(R14),-(sp)
move.l _ldoct,-(sp)
jsr _vputp
addq.l #8,sp
L348:unlk R14
rts
.globl _ldbord
.text
_ldbord:
~~ldbord:
link R14,#-4
*line 1731
move.l #_ldpoint,_point
*line 1733
move #11,(sp)
clr -(sp)
move #511,-(sp)
clr -(sp)
clr -(sp)
jsr _lseg
addq.l #8,sp
*line 1734
move #11,(sp)
move #349,-(sp)
move #511,-(sp)
clr -(sp)
move #511,-(sp)
jsr _lseg
addq.l #8,sp
*line 1735
move #11,(sp)
move #349,-(sp)
clr -(sp)
move #349,-(sp)
move #511,-(sp)
jsr _lseg
addq.l #8,sp
*line 1736
move #11,(sp)
clr -(sp)
clr -(sp)
move #349,-(sp)
clr -(sp)
jsr _lseg
addq.l #8,sp
*line 1738
move #11,(sp)
move #293,-(sp)
move #511,-(sp)
move #293,-(sp)
clr -(sp)
jsr _lseg
addq.l #8,sp
*line 1739
move #11,(sp)
move #308,-(sp)
clr -(sp)
move #308,-(sp)
move #511,-(sp)
jsr _lseg
addq.l #8,sp
*line 1741
move #11,(sp)
move #308,-(sp)
move #79,-(sp)
move #293,-(sp)
move #79,-(sp)
jsr _lseg
addq.l #8,sp
*line 1742
move #11,(sp)
move #308,-(sp)
move #144,-(sp)
move #293,-(sp)
move #144,-(sp)
jsr _lseg
addq.l #8,sp
*line 1743
move #11,(sp)
move #308,-(sp)
move #215,-(sp)
move #293,-(sp)
move #215,-(sp)
jsr _lseg
addq.l #8,sp
*line 1744
move #11,(sp)
move #349,-(sp)
move #71,-(sp)
move #308,-(sp)
move #71,-(sp)
jsr _lseg
addq.l #8,sp
*line 1745
move #11,(sp)
move #349,-(sp)
move #256,-(sp)
move #308,-(sp)
move #256,-(sp)
jsr _lseg
addq.l #8,sp
L350:unlk R14
rts
.globl _lmwclr
.text
_lmwclr:
~~lmwclr:
link R14,#-4
*line 1759
clr _lmwtype
*line 1760
clr _submenu
*line 1762
move.l #L352,_lmln22
*line 1763
move.l #L353,_lmln23
*line 1764
move.l #L354,_lmln24
L351:unlk R14
rts
.globl _lmwvtyp
.text
_lmwvtyp:
~~lmwvtyp:
link R14,#-4
*line 1775
move #1,_lmwtype
*line 1776
move #1,_submenu
*line 1778
move.l #_vtlin1,_lmln22
*line 1779
move.l #_vtlin2,_lmln23
*line 1780
move.l #_vtlin3,_lmln24
L355:unlk R14
rts
.globl _libdsp
.text
_libdsp:
~~libdsp:
link R14,#-4
*line 1794
move.l #_v_score,_librob
*line 1795
move.l #_v_curs0,_obj0
*line 1796
move.l #_v_tcur,_obj2
*line 1797
move.l #144+_v_obtab,_ldoct
*line 1799
clr _lselsw
*line 1800
clr _ldelsw
*line 1801
clr _lstrsw
*line 1803
clr _lasgsw
*line 1804
clr _lorchsw
*line 1805
clr _lorclsw
*line 1806
clr _lpatsw
*line 1807
clr _lscrsw
*line 1808
clr _lseqsw
*line 1809
clr _ltunsw
*line 1810
clr _lwavsw
*line 1812
clr _lderrsw
*line 1813
clr _ltagged
*line 1814
move #-1,_lksel
*line 1817
jsr _clrcat
*line 1818
clr _catin
*line 1820
jsr _lmwclr
*line 1822
jsr _dswap
*line 1824
*line 1825
clr R0
move 10+_v_regs,R0
and #384,R0
beq L357
*line 1825
clr (sp)
jsr _vbank
*line 1826
L357:
*line 1827
move #32767,(sp)
clr -(sp)
move.l _librob,-(sp)
jsr _memsetw
addq.l #6,sp
*line 1828
move #12033,(sp)
clr -(sp)
move.l _librob,R0
add.l #$fffe,R0
move.l R0,-(sp)
jsr _memsetw
addq.l #6,sp
*line 1830
move #-1,(sp)
move #1536,-(sp)
clr -(sp)
clr -(sp)
move #350,-(sp)
move #512,-(sp)
move.l _librob,-(sp)
clr -(sp)
clr -(sp)
move #8,-(sp)
jsr _SetObj
adda.l #20,sp
*line 1831
move #-1,(sp)
move #1540,-(sp)
move #316,-(sp)
move #32,-(sp)
move #16,-(sp)
move #16,-(sp)
move.l _obj0,-(sp)
move #1,-(sp)
clr -(sp)
clr -(sp)
jsr _SetObj
adda.l #20,sp
*line 1832
move #-1,(sp)
move #1572,-(sp)
clr -(sp)
clr -(sp)
move #16,-(sp)
move #16,-(sp)
move.l _obj2,-(sp)
move #1,-(sp)
clr -(sp)
move #2,-(sp)
jsr _SetObj
adda.l #20,sp
*line 1834
move #1,(sp)
jsr _arcurs
*line 1835
move #1,(sp)
jsr _itcini
*line 1836
move #1,(sp)
jsr _ttcini
*line 1838
jsr _ldbord
*line 1839
jsr _lwins
*line 1841
move.l #_lbrpal,(sp)
jsr _vsndpal
*line 1843
move #8,(sp)
move #8,-(sp)
jsr _SetPri
addq.l #2,sp
*line 1844
move #15,(sp)
clr -(sp)
jsr _SetPri
addq.l #2,sp
*line 1846
move #316,(sp)
move #32,-(sp)
jsr _setgc
addq.l #2,sp
*line 1848
move _thcwval,_chtime
*line 1849
move _tvcwval,_cvtime
*line 1850
move #1,_cmtype
*line 1851
move _cxval,R0
asr #3,R0
move R0,(sp)
move _cyval,R0
ext.l R0
divs #14,R0
move R0,-(sp)
jsr _itcpos
addq.l #2,sp
L356:unlk R14
rts
.data
L1:.dc.b $41,$53,$47,$0
L2:.dc.b $41,$73,$73,$69,$67,$6E,$6D,$6E,$74,$0
L3:.dc.b $41,$73,$73,$69,$67,$6E,$6D,$6E,$74,$0
L4:.dc.b $4F,$52,$4C,$0
L5:.dc.b $4F,$72,$63,$68,$65,$73,$74,$72,$61,$0
L6:.dc.b $4F,$72,$63,$68,$65,$73,$74,$72,$61,$0
L7:.dc.b $4F,$52,$48,$0
L8:.dc.b $4F,$72,$63,$68,$65,$73,$74,$72,$61,$0
L9:.dc.b $4F,$72,$63,$68,$65,$73,$74,$72,$61,$0
L10:.dc.b $53,$43,$52,$0
L11:.dc.b $20,$20,$20,$20,$53,$63,$6F,$72,$65,$0
L12:.dc.b $53,$63,$6F,$72,$65,$0
L13:.dc.b $54,$55,$4E,$0
L14:.dc.b $20,$20,$20,$54,$75,$6E,$69,$6E,$67,$0
L15:.dc.b $54,$75,$6E,$69,$6E,$67,$0
L16:.dc.b $57,$41,$56,$0
L17:.dc.b $57,$61,$76,$65,$73,$68,$61,$70,$65,$0
L18:.dc.b $57,$61,$76,$65,$73,$68,$61,$70,$65,$0
L19:.dc.b $4F,$52,$43,$0
L20:.dc.b $4F,$72,$63,$68,$65,$73,$74,$72,$61,$0
L21:.dc.b $4F,$72,$63,$68,$65,$73,$74,$72,$61,$0
L22:.dc.b $50,$41,$54,$0
L23:.dc.b $20,$20,$20,$20,$50,$61,$74,$63,$68,$0
L24:.dc.b $50,$61,$74,$63,$68,$0
L25:.dc.b $53,$45,$51,$0
L26:.dc.b $20,$53,$65,$71,$75,$65,$6E,$63,$65,$0
L27:.dc.b $53,$65,$71,$75,$65,$6E,$63,$65,$0
L43:.dc.b $3F,$3F,$20,$25,$33,$2E,$33,$73,$20,$20,$3F,$3F,$0
L45:.dc.b $30,$30,$30,$0
L71:.dc.b $20,$20,$20,$20,$42,$75,$73,$79,$20,$2D,$20,$50,$6C,$65,$61,$73,$65,$20,$73,$74,$61,$6E,$64,$20,$62,$79,$0
L73:.dc.b $20,$74,$68,$65,$20,$25,$73,$20,$66,$69,$6C,$65,$2C,$0
L74:.dc.b $43,$61,$6E,$27,$74,$20,$66,$69,$6E,$64,$20,$61,$20,$73,$6C,$6F,$74,$20,$66,$6F,$72,$0
L75:.dc.b $20,$61,$6E,$64,$20,$6F,$6E,$65,$20,$77,$61,$73,$20,$65,$78,$70,$65,$63,$74,$65,$64,$0
L82:.dc.b $65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$0
L83:.dc.b $44,$69,$73,$6B,$20,$6D,$61,$79,$20,$62,$65,$20,$66,$75,$6C,$6C,$0
L90:.dc.b $65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$0
L91:.dc.b $55,$6E,$65,$78,$70,$65,$63,$74,$65,$64,$20,$45,$4F,$46,$0
L105:.dc.b $30,$30,$30,$20,$45,$6D,$70,$74,$79,$2D,$25,$30,$32,$2E,$32,$64,$20,$3F,$3F,$3F,$20,$25,$2D,$33,$37,$2E,$33,$37,$73,$25
.dc.b $63,$25,$63,$0
L106:.dc.b $31,$32,$33,$34,$35,$36,$37,$38,$39,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$30
.dc.b $31,$32,$33,$34,$35,$36,$37,$0
L133:.dc.b $61,$73,$67,$0
L136:.dc.b $6F,$72,$68,$0
L139:.dc.b $6F,$72,$6C,$0
L142:.dc.b $6F,$72,$63,$0
L145:.dc.b $70,$61,$74,$0
L148:.dc.b $73,$63,$72,$0
L151:.dc.b $73,$65,$71,$0
L154:.dc.b $74,$75,$6E,$0
L157:.dc.b $77,$61,$76,$0
L161:.dc.b $44,$69,$73,$6B,$20,$6E,$6F,$74,$20,$72,$65,$61,$64,$79,$20,$3F,$0
L162:.dc.b $4D,$69,$63,$72,$6F,$64,$69,$73,$6B,$20,$63,$61,$70,$61,$63,$69,$74,$79,$20,$25,$34,$75,$20,$62,$6C,$6F,$63,$6B,$73,$0
L163:.dc.b $54,$68,$69,$73,$20,$64,$69,$73,$6B,$20,$63,$6F,$6E,$73,$75,$6D,$65,$73,$20,$25,$34,$75,$20,$62,$6C,$6F,$63,$6B,$73,$0
L164:.dc.b $41,$76,$61,$69,$6C,$61,$62,$6C,$65,$20,$73,$70,$61,$63,$65,$20,$69,$73,$20,$25,$34,$75,$20,$62,$6C,$6F,$63,$6B,$73,$0
L166:.dc.b $4D,$37,$46,$49,$4C,$45,$53,$2E,$43,$41,$54,$0
L167:.dc.b $72,$0
L172:.dc.b $20,$20,$66,$72,$65,$61,$64,$20,$72,$65,$74,$75,$72,$6E,$65,$64,$20,$25,$64,$0
L173:.dc.b $20,$20,$65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$2C,$20,$66,$65,$73,$69,$7A,$65,$3D,$25,$64,$0
L174:.dc.b $55,$6E,$61,$62,$6C,$65,$20,$74,$6F,$20,$72,$65,$61,$64,$20,$63,$61,$74,$61,$6C,$6F,$67,$0
L176:.dc.b $46,$69,$6C,$65,$20,$63,$61,$74,$61,$6C,$6F,$67,$20,$69,$73,$20,$4E,$55,$4C,$4C,$0
L182:.dc.b $4D,$37,$46,$49,$4C,$45,$53,$2E,$43,$41,$54,$0
L183:.dc.b $77,$0
L185:.dc.b $20,$20,$65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$0
L186:.dc.b $55,$6E,$61,$62,$6C,$65,$20,$74,$6F,$20,$6F,$70,$65,$6E,$20,$63,$61,$74,$61,$6C,$6F,$67,$0
L189:.dc.b $20,$20,$66,$77,$72,$69,$74,$65,$20,$72,$65,$74,$75,$72,$6E,$65,$64,$20,$25,$64,$0
L190:.dc.b $20,$20,$65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$2C,$20,$66,$65,$73,$69,$7A,$65,$3D,$25,$64,$0
L191:.dc.b $43,$61,$6E,$27,$74,$20,$77,$72,$69,$74,$65,$20,$63,$61,$74,$61,$6C,$6F,$67,$0
L193:.dc.b $20,$20,$65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$0
L194:.dc.b $44,$69,$73,$6B,$20,$6D,$61,$79,$20,$62,$65,$20,$66,$75,$6C,$6C,$0
L205:.dc.b $20,$20,$20,$20,$20,$20,$20,$52,$65,$61,$64,$69,$6E,$67,$20,$63,$61,$74,$61,$6C,$6F,$67,$0
L219:.dc.b $4D,$37,$53,$4C,$4F,$54,$25,$30,$32,$2E,$32,$75,$2E,$25,$2D,$33,$2E,$33,$73,$0
L249:.dc.b $20,$6B,$69,$6E,$64,$3D,$25,$64,$0
L250:.dc.b $62,$61,$64,$20,$77,$72,$74,$66,$69,$6C,$65,$20,$61,$72,$67,$75,$6D,$65,$6E,$74,$3A,$0
L254:.dc.b $25,$30,$33,$2E,$33,$64,$0
L273:.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$0
L275:.dc.b $46,$69,$6C,$65,$20,$6D,$75,$73,$74,$20,$62,$65,$20,$6E,$61,$6D,$65,$64,$0
L277:.dc.b $4E,$6F,$20,$66,$69,$6C,$65,$20,$74,$79,$70,$65,$20,$73,$65,$6C,$65,$63,$74,$65,$64,$0
L279:.dc.b $20,$20,$20,$20,$20,$20,$20,$53,$74,$6F,$72,$69,$6E,$67,$20,$66,$69,$6C,$65,$73,$0
L297:.dc.b $44,$75,$70,$6C,$69,$63,$61,$74,$65,$20,$25,$73,$0
L299:.dc.b $20,$20,$20,$20,$20,$20,$20,$57,$72,$69,$74,$69,$6E,$67,$20,$63,$61,$74,$61,$6C,$6F,$67,$0
L323:.dc.b $43,$6F,$6E,$74,$65,$6E,$74,$0
L329:.dc.b $48,$69,$20,$4F,$72,$63,$68,$0
L330:.dc.b $4C,$6F,$20,$4F,$72,$63,$68,$0
L332:.dc.b $53,$74,$6F,$72,$65,$0
L333:.dc.b $53,$63,$6F,$72,$65,$0
L334:.dc.b $48,$69,$20,$4F,$72,$63,$68,$0
L335:.dc.b $57,$61,$76,$65,$73,$0
L336:.dc.b $50,$61,$74,$63,$68,$0
L337:.dc.b $4C,$6F,$20,$4F,$72,$63,$68,$0
L338:.dc.b $41,$73,$73,$67,$6E,$0
L339:.dc.b $53,$65,$71,$6E,$63,$0
L340:.dc.b $54,$75,$6E,$69,$6E,$67,$73,$0
L352:.dc.b $0
L353:.dc.b $0
L354:.dc.b $0
