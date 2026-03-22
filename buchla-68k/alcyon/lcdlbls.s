.globl _lcdx
.globl _lcdy
.globl _lcdbit
.globl _lcdrow
.globl _lcdcol
.globl _lcdbase
.globl _lcdctl1
.globl _lcdctl2
.globl _v_obtab
.globl _v_curob
.globl _v_nobj
.globl _v_obpri
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
.globl _QQsw
.globl _QQanch
.globl _QQin
.globl _QQip
.globl _QQop
.globl _QQnum
.globl _QQlnum
.globl _QQchr
.globl _QQdig
.globl _QQstr
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
.globl _filecat
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
.globl _d_key
.globl _e_key
.globl _m_key
.globl _x_key
.globl _olddkey
.globl _oldekey
.globl _oldmkey
.globl _oldxkey
.globl _point
.globl _oldsw
.globl _swpt
.globl _aswtbl
.globl _asig
.globl _asmode
.globl _astat
.globl _aval
.globl _clkrun
.globl _ctrsw
.globl _curasg
.globl _gomode
.globl _ismode
.globl _lampio
.globl _lampsw
.globl _loadrow
.globl _loadsw
.globl _ltagged
.globl _ndisp
.globl _oldpk
.globl _oldsl
.globl _pkctrl
.globl _recsw
.globl _sliders
.globl _tagslot
.globl _tmpomlt
.globl _tmpoval
.globl _tuneval
.globl _seqdupd
.globl _BGeq
.globl _BGother
.globl _BGprmtr
.globl _articen
.globl _grpmode
.globl _grpsel
.globl _grpstat
.globl _ins2grp
.globl _lastart
.globl _s_trns
.globl _vce2grp
.globl _vce2trg
.globl _anrs
.globl _iotime
.globl _lcdontm
.globl _lcdtime
.globl _gdstbc
.globl _valents
.globl _BarType
.data
_BarType:
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $0
.globl _artitab
.data
_artitab:
.dc.w $3E80
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $3E80
.dc.w $3E80
.dc.w $3E80
.dc.w $3E80
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $3E80
.dc.w $0
.globl _arpar
.data
_arpar:
.dc.w $4
.dc.w $2
.dc.w $9
.dc.w $B
.dc.w $C
.dc.w $1
.dc.w $3
.dc.w $5
.dc.w $7
.dc.w $D
.dc.w $E
.dc.w $F
.dc.w $A
.dc.w $6
.globl _sl2gain
.data
_sl2gain:
.dc.w $FFF4
.dc.w $FFF4
.dc.w $FFF4
.dc.w $FFF4
.dc.w $FFF4
.dc.w $FFF5
.dc.w $FFF6
.dc.w $FFF7
.dc.w $FFF8
.dc.w $FFF9
.dc.w $FFFA
.dc.w $FFFB
.dc.w $FFFC
.dc.w $FFFD
.dc.w $FFFE
.dc.w $FFFF
.dc.w $0
.dc.w $1
.dc.w $2
.dc.w $3
.dc.w $4
.dc.w $5
.dc.w $6
.dc.w $7
.dc.w $8
.dc.w $9
.dc.w $A
.dc.w $B
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $C
.globl _vmasks
.data
_vmasks:
.dc.w $8000
.dc.w $C000
.dc.w $E000
.dc.w $F000
.dc.w $F800
.dc.w $FC00
.dc.w $FE00
.dc.w $FF00
.dc.w $FF80
.dc.w $FFC0
.dc.w $FFE0
.dc.w $FFF0
.dc.w $FFF8
.dc.w $FFFC
.dc.w $FFFE
.dc.w $FFFF
.globl _src2var
.data
_src2var:
.dc.w $FFFF
.dc.w $FFFF
.dc.w $3
.dc.w $FFFF
.dc.w $FFFF
.dc.w $FFFF
.dc.w $5
.dc.w $FFFF
.dc.w $4
.dc.w $FFFF
.dc.w $FFFF
.dc.w $0
.dc.w $1
.dc.w $2
.globl _potlbls
.data
_potlbls:
*line 183
.dc.l L1
*line 184
.dc.l L2
*line 185
.dc.l L3
*line 186
.dc.l L4
*line 187
.dc.l L5
*line 188
.dc.l L6
*line 189
.dc.l L7
*line 191
.dc.l L8
.globl _swtlbls
.data
_swtlbls:
*line 196
.dc.l L9
*line 197
.dc.l L10
*line 198
.dc.l L11
*line 199
.dc.l L12
*line 200
.dc.l L13
*line 201
.dc.l L14
*line 202
.dc.l L15
*line 204
.dc.l L16
.globl _aslbls
.data
_aslbls:
*line 221
.dc.l L17
*line 222
.dc.l L18
*line 223
.dc.l L19
*line 224
.dc.l L20
*line 225
.dc.l L21
*line 227
.dc.l L22
.globl _t_prmtr
.data
_t_prmtr:
*line 234
.dc.l _quiet
*line 235
.dc.l _trapper
*line 237
.dc.l _setlamp
*line 238
.dc.l _l_clock
*line 239
.dc.l _rpctl
*line 241
.dc.l _l_goto
*line 242
.dc.l _l_inst
*line 243
.dc.l _l_asgn
*line 244
.dc.l _l_load
*line 246
.dc.l _nokey
*line 247
.dc.l _nokey
*line 248
.dc.l _l_other
*line 250
.dc.l _l_prmtr
*line 252
.dc.l _l_init
.globl _t_voice
.data
_t_voice:
*line 256
.dc.l _l_voice
*line 257
.dc.l _l_voice
*line 259
.dc.l _l_voice
*line 260
.dc.l _l_voice
*line 261
.dc.l _l_voice
*line 263
.dc.l _l_voice
*line 264
.dc.l _l_voice
*line 265
.dc.l _l_voice
*line 266
.dc.l _l_voice
*line 268
.dc.l _l_voice
*line 269
.dc.l _l_voice
*line 270
.dc.l _l_voice
*line 272
.dc.l _l_prmtr
*line 274
.dc.l _l_init
.globl _t_other
.data
_t_other:
*line 281
.dc.l _quiet
*line 282
.dc.l _trapper
*line 284
.dc.l _setlamp
*line 285
.dc.l _l_clock
*line 286
.dc.l _rpctl
*line 288
.dc.l _l_goto
*line 289
.dc.l _l_inst
*line 290
.dc.l _l_asgn
*line 291
.dc.l _l_load
*line 293
.dc.l _nokey
*line 294
.dc.l _nokey
*line 295
.dc.l _l_eq
*line 297
.dc.l _l_prmtr
*line 299
.dc.l _l_init
.globl _t_eq
.data
_t_eq:
*line 303
.dc.l _quiet
*line 304
.dc.l _trapper
*line 306
.dc.l _setlamp
*line 307
.dc.l _l_clock
*line 308
.dc.l _rpctl
*line 310
.dc.l _l_goto
*line 311
.dc.l _l_inst
*line 312
.dc.l _l_asgn
*line 313
.dc.l _l_load
*line 315
.dc.l _nokey
*line 316
.dc.l _nokey
*line 317
.dc.l _l_eq
*line 319
.dc.l _l_prmtr
*line 321
.dc.l _l_init
.globl _t_inst
.data
_t_inst:
*line 328
.dc.l _l_group
*line 329
.dc.l _l_group
*line 331
.dc.l _l_group
*line 332
.dc.l _l_group
*line 333
.dc.l _l_group
*line 335
.dc.l _l_group
*line 336
.dc.l _l_group
*line 337
.dc.l _l_group
*line 338
.dc.l _l_group
*line 340
.dc.l _l_group
*line 341
.dc.l _l_group
*line 342
.dc.l _l_group
*line 344
.dc.l _l_inst
*line 346
.dc.l _l_dflt
.globl _t_libr
.data
_t_libr:
*line 350
.dc.l _quiet
*line 351
.dc.l _trapper
*line 353
.dc.l _setlamp
*line 354
.dc.l _l_clock
*line 355
.dc.l _rpctl
*line 357
.dc.l _nokey
*line 358
.dc.l _nokey
*line 359
.dc.l _nokey
*line 360
.dc.l _nokey
*line 362
.dc.l _nokey
*line 363
.dc.l _nokey
*line 364
.dc.l _nokey
*line 366
.dc.l _nokey
*line 368
.dc.l _nokey
.globl _t_ngrp
.data
_t_ngrp:
*line 375
.dc.l _quiet
*line 376
.dc.l _trapper
*line 378
.dc.l _setlamp
*line 379
.dc.l _l_clock
*line 380
.dc.l _rpctl
*line 382
.dc.l _nokey
*line 383
.dc.l _nokey
*line 384
.dc.l _nokey
*line 385
.dc.l _nokey
*line 387
.dc.l _nokey
*line 388
.dc.l _nokey
*line 389
.dc.l _nokey
*line 391
.dc.l _nokey
*line 393
.dc.l _nokey
.globl _t_load
.data
_t_load:
*line 397
.dc.l _quiet
*line 398
.dc.l _trapper
*line 400
.dc.l _setlamp
*line 401
.dc.l _nokey
*line 402
.dc.l _nokey
*line 404
.dc.l _nokey
*line 405
.dc.l _nokey
*line 406
.dc.l _nokey
*line 407
.dc.l _l_load
*line 409
.dc.l _nokey
*line 410
.dc.l _nokey
*line 411
.dc.l _nokey
*line 413
.dc.l _nokey
*line 415
.dc.l _nokey
.globl _quiet
.text
_quiet:
~~quiet:
link R14,#0
movem.l R6-R7,-(sp)
~vce=R7
*line 430
clr R7
bra L26
L27:
*line 431
clr (sp)
move #2,-(sp)
move R7,-(sp)
jsr _sendval
addq.l #4,sp
L25:
*line 430
add #1,R7
L26:
*line 430
cmp #12,R7
blt L27
L24:
*line 433
move #16,(sp)
clr -(sp)
move.l #_seqflag,-(sp)
jsr _memsetw
addq.l #6,sp
*line 434
move #16,(sp)
clr -(sp)
move.l #_seqtime,-(sp)
jsr _memsetw
addq.l #6,sp
*line 436
move #16,(sp)
clr -(sp)
move.l #_trstate,-(sp)
jsr _memsetw
addq.l #6,sp
*line 438
move #-1,_seqdupd
*line 440
move #4608,(sp)
jsr _stmproc
L23:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rpctl
.text
_rpctl:
~~rpctl:
~stat=8
link R14,#-4
*line 452
*line 453
tst 8(R14)
beq L28
*line 454
*line 455
tst _recsw
beq L10000
clr R0
bra L10001
L10000:move #1,R0
L10001:move R0,_recsw
*line 456
jsr _dsrpmod
L28:unlk R14
rts
.globl _trapper
.text
_trapper:
~~trapper:
~stat=8
link R14,#-4
*line 471
*line 472
tst 8(R14)
beq L30
*line 472
jsr _xtrap15
L30:L29:unlk R14
rts
.globl _l_clock
.text
_l_clock:
~~l_clock:
~stat=8
link R14,#-4
*line 484
*line 485
tst 8(R14)
beq L31
*line 486
*line 487
tst _clkrun
beq L10002
clr (sp)
bra L10003
L10002:move #1,(sp)
L10003:jsr _clkset
*line 488
jsr _dclkmd
L31:unlk R14
rts
.globl _ulamp
.text
_ulamp:
~~ulamp:
link R14,#-4
*line 499
*line 500
cmp #1,_sliders
beq L32
cmp #4,_sliders
beq L32
*line 501
*line 502
move.l #_GLCplot,_point
*line 503
move #1,(sp)
jsr _GLCcurs
*line 505
*line 506
tst _lampsw
beq L33
*line 506
move #1,(sp)
move #54,-(sp)
move #101,-(sp)
move #54,-(sp)
move #78,-(sp)
jsr _lseg
addq.l #8,sp
*line 507
bra L34
L33:
*line 508
clr (sp)
move #54,-(sp)
move #101,-(sp)
move #54,-(sp)
move #78,-(sp)
jsr _lseg
addq.l #8,sp
L34:
*line 510
clr (sp)
jsr _GLCcurs
L32:unlk R14
rts
.globl _preio
.text
_preio:
~~preio:
link R14,#-6
~oldipl=-2
*line 526
move #4,(sp)
jsr _setipl
move R0,-2(R14)
*line 528
move _lampsw,_lampio
*line 529
move.l _lcdtime,_iotime
*line 530
clr _lampsw
*line 531
move.b #31,_io_leds
*line 533
move -2(R14),(sp)
jsr _setipl
L35:unlk R14
rts
.globl _postio
.text
_postio:
~~postio:
link R14,#-6
~oldipl=-2
*line 546
move #4,(sp)
jsr _setipl
move R0,-2(R14)
*line 548
move _lampio,_lampsw
*line 550
*line 550
tst.l _iotime
bne L10004
tst _lampsw
beq L37
L10004:*line 551
*line 552
move.l _lcdontm,_lcdtime
*line 553
move.b #159,_io_leds
*line 554
*line 555
L37:
*line 556
move -2(R14),(sp)
jsr _setipl
L36:unlk R14
rts
.globl _setlamp
.text
_setlamp:
~~setlamp:
~stat=8
link R14,#0
movem.l R6-R7,-(sp)
~oldi=R7
*line 572
*line 573
tst 8(R14)
beq L38
*line 574
*line 575
move #4,(sp)
jsr _setipl
move R0,R7
*line 577
move.l _lcdontm,_lcdtime
*line 579
*line 579
tst _lampsw
beq L39
*line 580
*line 581
clr _lampsw
*line 582
move.b #31,_io_leds
*line 583
bra L40
L39:
*line 584
*line 585
*line 586
move #1,_lampsw
*line 587
move.b #159,_io_leds
L40:
*line 590
move R7,(sp)
jsr _setipl
*line 592
jsr _ulamp
L38:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _lcd_on
.text
_lcd_on:
~~lcd_on:
link R14,#0
movem.l R6-R7,-(sp)
~oldi=R7
*line 605
move #4,(sp)
jsr _setipl
move R0,R7
*line 607
move.l _lcdontm,_lcdtime
*line 608
move.b #159,_io_leds
*line 610
move R7,(sp)
jsr _setipl
L41:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _loadkey
.text
_loadkey:
~~loadkey:
~key=8
link R14,#-4
*line 625
*line 626
tst _astat
beq L42
*line 627
*line 628
*line 628
tst _loadsw
beq L43
*line 629
*line 630
*line 630
cmp #7,8(R14)
bge L44
*line 631
*line 632
move 8(R14),(sp)
add #65,(sp)
jsr _loadem
*line 633
*line 634
clr _loadsw
*line 635
clr _ltagged
*line 636
move.l _olddkey,_d_key
*line 637
move.l _oldxkey,_x_key
*line 638
move.l _oldekey,_e_key
*line 639
move.l _oldmkey,_m_key
*line 640
move _oldpk,_pkctrl
*line 641
move _oldsl,_sliders
*line 642
move.l _oldsw,_swpt
*line 643
jsr _lcdlbls
*line 644
*line 645
L44:bra L42
*line 646
*line 647
L43:L42:unlk R14
rts
.globl _pcancel
.text
_pcancel:
~~pcancel:
~pm=8
link R14,#-4
*line 662
move.l #_GLCplot,_point
*line 663
move #1,(sp)
jsr _GLCcurs
*line 665
*line 665
tst 8(R14)
beq L46
tst _asmode
beq L46
*line 666
*line 667
*line 668
*line 669
clr _asmode
*line 670
move _oldpk,_pkctrl
*line 671
move.l _oldsw,_swpt
*line 672
clr (sp)
move #54,-(sp)
move #287,-(sp)
move #54,-(sp)
move #258,-(sp)
jsr _lseg
addq.l #8,sp
*line 673
*line 674
L46:
*line 675
*line 675
cmp #1,8(R14)
beq L47
tst _gomode
beq L47
*line 676
*line 677
*line 678
*line 679
clr _gomode
*line 680
move _oldpk,_pkctrl
*line 681
clr (sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
*line 682
*line 683
L47:
*line 684
*line 684
cmp #2,8(R14)
beq L48
tst _ismode
beq L48
*line 685
*line 686
*line 687
*line 688
clr _ismode
*line 689
move _oldpk,_pkctrl
*line 690
move _oldsl,_sliders
*line 691
move.l _oldsw,_swpt
*line 692
jsr _lcdlbls
*line 693
*line 694
L48:
*line 695
clr (sp)
jsr _GLCcurs
*line 696
jsr _setleds
L45:unlk R14
rts
.globl _l_load
.text
_l_load:
~~l_load:
~stat=8
link R14,#-4
*line 711
*line 712
tst 8(R14)
beq L49
*line 713
*line 714
move #3,(sp)
jsr _pcancel
*line 715
move #3,(sp)
jsr _lcancel
*line 717
move.l #_GLCplot,_point
*line 718
move #1,(sp)
jsr _GLCcurs
*line 720
*line 720
tst _loadsw
beq L50
*line 721
*line 722
move.l _olddkey,_d_key
*line 723
move.l _oldekey,_e_key
*line 724
move.l _oldmkey,_m_key
*line 725
move.l _oldxkey,_x_key
*line 726
*line 727
move _oldpk,_pkctrl
*line 728
move _oldsl,_sliders
*line 729
move.l _oldsw,_swpt
*line 730
*line 731
clr _loadsw
*line 732
*line 733
jsr _lcdlbls
*line 734
*line 735
bra L51
L50:
*line 736
*line 737
*line 738
clr (sp)
jsr _clkset
*line 739
*line 740
*line 740
tst _ltagged
beq L52
*line 741
*line 742
move _loadrow,(sp)
move #12,-(sp)
jsr _exp_c
addq.l #2,sp
move R0,-(sp)
move _tagslot,-(sp)
jsr _dslslot
addq.l #4,sp
*line 743
clr _ltagged
*line 744
*line 745
L52:
*line 746
*line 747
tst _pkctrl
beq L10005
cmp #1,_pkctrl
bne L53
L10005:*line 747
move _pkctrl,_oldpk
*line 748
L53:
*line 749
*line 750
cmp #7,_sliders
beq L54
*line 750
move _sliders,_oldsl
*line 751
L54:
*line 752
move #7,_pkctrl
*line 753
move #7,_sliders
*line 754
move.l _swpt,_oldsw
*line 755
move.l #_t_load,_swpt
*line 756
*line 757
move.l _d_key,_olddkey
*line 758
move.l _x_key,_oldxkey
*line 759
move.l _e_key,_oldekey
*line 760
move.l _m_key,_oldmkey
*line 761
move.l #_loadkey,_d_key
*line 762
move.l #_l_load,_x_key
*line 763
move.l #_l_load,_e_key
*line 764
move.l #_l_load,_m_key
*line 765
*line 766
move #1,_loadsw
*line 767
*line 768
jsr _lcdlbls
*line 769
move #1,(sp)
move #54,-(sp)
move #317,-(sp)
move #54,-(sp)
move #294,-(sp)
jsr _lseg
addq.l #8,sp
L51:
*line 772
clr (sp)
jsr _GLCcurs
*line 773
jsr _setleds
L49:unlk R14
rts
.globl _lcdlbls
.text
_lcdlbls:
~~lcdlbls:
link R14,#-94
movem.l R5-R7,-(sp)
~i=R7
~barval=R6
~buf=-8
~dsp=-94
*line 791
move.l #_GLCplot,_point
*line 793
jsr _GLCinit
*line 794
move #1,(sp)
jsr _GLCcurs
*line 798
move _sliders,R0
bra L57
*line 799
L58:
*line 800
L59:
*line 801
L60:
*line 802
*line 803
*line 804
move _sliders,R8
add.l R8,R8
add.l R8,R8
move.l #_swtlbls,R9
move.l 0(R8,R9.l),(sp)
move #1,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 805
*line 806
move _gomode,R0
bra L62
*line 807
L63:
*line 808
*line 809
*line 810
move.l #L64,(sp)
move #31,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 811
move #1,(sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
bra L61
*line 812
*line 813
L65:
*line 814
*line 815
*line 816
move.l #L66,(sp)
move #31,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 817
move #1,(sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
bra L61
*line 818
*line 819
L67:
*line 820
*line 821
*line 822
move.l #L68,(sp)
move #31,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 823
clr (sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
bra L61
*line 824
bra L61
L62:cmp #1,R0
beq L63
cmp #2,R0
beq L65
bra L67
L61:
*line 825
*line 826
bra L56
*line 827
*line 828
*line 829
L69:
*line 830
*line 831
*line 832
clr.b -94(R14)
*line 833
*line 834
clr R7
bra L72
L73:
*line 835
*line 836
*line 837
*line 838
move R7,R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L10006
move #127,(sp)
bra L10008
L10006:move #32,(sp)
L10008:move R7,-(sp)
add #1,(sp)
move R7,R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L10009
move #126,-(sp)
bra L10011
L10009:move #32,-(sp)
L10011:move.l #L74,-(sp)
move.l R14,-(sp)
sub.l #8,(sp)
jsr _sprintf
adda.l #12,sp
*line 839
*line 840
move.l R14,(sp)
sub.l #8,(sp)
move.l R14,-(sp)
add.l #-94,(sp)
jsr _strcat
addq.l #4,sp
L71:
*line 834
add #1,R7
L72:
*line 834
cmp #12,R7
blt L73
L70:
*line 841
*line 842
*line 843
move.l #L75,(sp)
move.l R14,-(sp)
add.l #-94,(sp)
jsr _strcat
addq.l #4,sp
*line 844
*line 845
move.l R14,(sp)
add.l #-94,(sp)
move #1,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
bra L56
*line 846
*line 847
L76:
*line 848
*line 849
*line 850
clr.b -94(R14)
*line 851
*line 852
clr R7
bra L79
L80:
*line 853
*line 854
*line 855
*line 856
move R7,R8
add.l R8,R8
move.l #_grpsel,R9
tst 0(R8,R9.l)
beq L10012
move #127,(sp)
bra L10014
L10012:move #32,(sp)
L10014:move R7,-(sp)
add #1,(sp)
move R7,R8
add.l R8,R8
move.l #_grpsel,R9
tst 0(R8,R9.l)
beq L10015
move #126,-(sp)
bra L10017
L10015:move #32,-(sp)
L10017:move.l #L81,-(sp)
move.l R14,-(sp)
sub.l #8,(sp)
jsr _sprintf
adda.l #12,sp
*line 857
*line 858
move.l R14,(sp)
sub.l #8,(sp)
move.l R14,-(sp)
add.l #-94,(sp)
jsr _strcat
addq.l #4,sp
L78:
*line 852
add #1,R7
L79:
*line 852
cmp #12,R7
blt L80
L77:
*line 859
*line 860
*line 861
*line 862
cmp #2,_ismode
bne L82
*line 862
move.l #L83,(sp)
move.l R14,-(sp)
add.l #-94,(sp)
jsr _strcat
addq.l #4,sp
*line 863
bra L84
L82:
*line 864
move.l #L85,(sp)
move.l R14,-(sp)
add.l #-94,(sp)
jsr _strcat
addq.l #4,sp
L84:
*line 865
*line 866
move.l #L86,(sp)
move.l R14,-(sp)
add.l #-94,(sp)
jsr _strcat
addq.l #4,sp
*line 867
*line 868
move.l R14,(sp)
add.l #-94,(sp)
move #1,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
bra L56
*line 869
*line 870
L87:
*line 871
L88:
*line 872
L89:
*line 873
*line 874
*line 875
move _sliders,R8
add.l R8,R8
add.l R8,R8
move.l #_swtlbls,R9
move.l 0(R8,R9.l),(sp)
move #1,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
bra L56
*line 876
bra L56
L57:cmp #7,R0
bhi L56
asl #2,R0
move R0,R8
add.l #L90,R8
move.l (R8),R8
jmp (R8)
.data
L90:.dc.l L58
.dc.l L69
.dc.l L59
.dc.l L60
.dc.l L76
.dc.l L87
.dc.l L88
.dc.l L89
.text
L56:
*line 881
move _sliders,R8
add.l R8,R8
add.l R8,R8
move.l #_potlbls,R9
move.l 0(R8,R9.l),(sp)
move #1,-(sp)
move #7,-(sp)
jsr _GLCtext
addq.l #4,sp
*line 883
clr R7
bra L93
L94:
*line 884
move #1,(sp)
move #63,-(sp)
move R7,R0
muls #36,R0
move R0,-(sp)
add #39,(sp)
clr -(sp)
move R7,R0
muls #36,R0
move R0,-(sp)
add #39,(sp)
jsr _lseg
addq.l #8,sp
L92:
*line 883
add #1,R7
L93:
*line 883
cmp #13,R7
blt L94
L91:
*line 886
move _sliders,R0
bra L96
*line 887
L97:
*line 888
L98:
*line 889
L99:
*line 890
L100:
*line 891
L101:
*line 892
L102:
*line 893
*line 894
*line 895
clr R7
bra L105
L106:
*line 896
*line 897
*line 897
move R7,R8
add.l R8,R8
move.l #_BarType,R9
tst 0(R8,R9.l)
beq L107
*line 898
*line 899
move R7,R8
add.l R8,R8
add.l #_BGprmtr,R8
move (R8),R6
asr #5,R6
add #-500,R6
asl #6,R6
ext.l R6
divs #252,R6
*line 900
move R6,(sp)
move R7,-(sp)
jsr _BarCset
addq.l #2,sp
*line 901
bra L108
L107:
*line 902
*line 903
*line 904
move R7,R8
add.l R8,R8
add.l #_BGprmtr,R8
move (R8),R6
ext.l R6
divs #252,R6
*line 905
move R6,(sp)
move R7,-(sp)
jsr _BarBset
addq.l #2,sp
L108:
*line 906
L104:
*line 895
add #1,R7
L105:
*line 895
cmp #14,R7
blt L106
L103:
*line 907
*line 908
bra L95
*line 909
*line 910
L109:
*line 911
*line 912
*line 913
clr R7
bra L112
L113:
*line 914
move R7,R8
add.l R8,R8
move.l #_BGother,R9
move 0(R8,R9.l),R0
ext.l R0
divs #252,R0
move R0,(sp)
move R7,-(sp)
jsr _BarBset
addq.l #2,sp
L111:
*line 913
add #1,R7
L112:
*line 913
cmp #14,R7
blt L113
L110:
*line 914
*line 915
bra L95
*line 916
*line 917
L114:
*line 918
*line 919
*line 920
clr R7
bra L117
L118:
*line 921
move R7,R8
add.l R8,R8
move.l #_BGeq,R9
move 0(R8,R9.l),(sp)
move R7,-(sp)
jsr _BarCset
addq.l #2,sp
L116:
*line 920
add #1,R7
L117:
*line 920
cmp #14,R7
blt L118
L115:
*line 921
*line 922
bra L95
*line 923
*line 924
L119:
*line 925
*line 926
bra L95
*line 927
bra L95
L96:cmp #7,R0
bhi L119
asl #2,R0
move R0,R8
add.l #L120,R8
move.l (R8),R8
jmp (R8)
.data
L120:.dc.l L97
.dc.l L98
.dc.l L109
.dc.l L114
.dc.l L99
.dc.l L100
.dc.l L101
.dc.l L102
.text
L95:
*line 930
clr (sp)
jsr _GLCcurs
*line 931
jsr _dsrpmod
*line 932
jsr _dclkmd
*line 933
jsr _ulamp
L55:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _selasg
.text
_selasg:
~~selasg:
~n=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~ep=R13
*line 950
move 8(R14),R0
move R0,_curasg
move R0,(sp)
jsr _getasg
*line 952
*line 952
tst _recsw
beq L122
*line 953
*line 954
*line 954
move #-1,(sp)
move #-1,-(sp)
move #16,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L123
*line 955
*line 956
move 8(R14),R0
move.b R0,6(R13)
*line 957
bra L124
L123:
*line 958
*line 958
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L125
*line 959
*line 960
move.b #16,5(R13)
*line 961
move 8(R14),R0
move.b R0,6(R13)
*line 962
move.l _t_cur,(R13)
*line 963
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
*line 964
move #9,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 965
*line 966
*line 966
cmp #2,_ndisp
bne L126
*line 967
*line 968
move #1,_ctrsw
*line 969
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 970
jsr _scupd
*line 971
L126:
*line 972
L125:L124:
*line 973
*line 974
L122:
*line 975
clr _asmode
*line 976
move _oldpk,_pkctrl
*line 977
move.l _oldsw,_swpt
*line 979
move.l #_GLCplot,_point
*line 980
move #1,(sp)
jsr _GLCcurs
*line 981
clr (sp)
move #54,-(sp)
move #287,-(sp)
move #54,-(sp)
move #258,-(sp)
jsr _lseg
addq.l #8,sp
*line 982
move _sliders,R8
add.l R8,R8
add.l R8,R8
move.l #_swtlbls,R9
move.l 0(R8,R9.l),(sp)
move #1,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 983
clr (sp)
jsr _GLCcurs
*line 985
jsr _mpcupd
*line 986
jsr _setleds
L121:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _l_adfl
.text
_l_adfl:
~~l_adfl:
~stat=8
link R14,#-4
*line 1001
*line 1002
tst 8(R14)
beq L127
*line 1003
*line 1004
clr (sp)
jsr _selasg
L127:unlk R14
rts
.globl _l_asgn
.text
_l_asgn:
~~l_asgn:
~stat=8
link R14,#-4
*line 1019
*line 1020
tst 8(R14)
beq L128
*line 1021
*line 1022
move.l #_GLCplot,_point
*line 1023
move #1,(sp)
jsr _GLCcurs
*line 1025
*line 1025
tst _ismode
beq L129
*line 1026
*line 1027
clr _ismode
*line 1028
move _oldpk,_pkctrl
*line 1029
move _oldsl,_sliders
*line 1030
move.l _oldsw,_swpt
*line 1031
jsr _lcdlbls
*line 1032
*line 1033
L129:
*line 1034
*line 1034
tst _gomode
beq L130
*line 1035
*line 1036
clr _gomode
*line 1037
move _oldpk,_pkctrl
*line 1038
clr (sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
*line 1039
*line 1040
*line 1041
L130:
*line 1042
move _asmode,R0
bra L132
*line 1043
L133:
*line 1044
*line 1045
*line 1046
*line 1047
tst _pkctrl
beq L10018
cmp #1,_pkctrl
bne L134
L10018:*line 1047
move _pkctrl,_oldpk
*line 1048
L134:
*line 1049
tst _curasg
beq L10019
move _curasg,R0
sub #1,R0
ext.l R0
divs #20,R0
bra L10021
L10019:clr R0
L10021:add #1,R0
move R0,_asmode
*line 1050
move #4,_pkctrl
*line 1051
move #56,(sp)
move.l _swpt,-(sp)
move.l #_aswtbl,-(sp)
jsr _memcpy
addq.l #8,sp
*line 1052
move.l _swpt,_oldsw
*line 1053
move.l #_aswtbl,_swpt
*line 1054
move.l #_l_adfl,52+_aswtbl
*line 1055
move #1,(sp)
move #54,-(sp)
move #287,-(sp)
move #54,-(sp)
move #258,-(sp)
jsr _lseg
addq.l #8,sp
*line 1056
move.l #L135,(sp)
move #79,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
bra L131
*line 1057
*line 1058
L136:
*line 1059
L137:
*line 1060
L138:
*line 1061
L139:
*line 1062
*line 1063
*line 1064
add #1,_asmode
bra L131
*line 1065
*line 1066
L140:
*line 1067
*line 1068
*line 1069
move #1,_asmode
bra L131
*line 1070
*line 1071
bra L131
L132:cmp #5,R0
bhi L131
asl #2,R0
move R0,R8
add.l #L141,R8
move.l (R8),R8
jmp (R8)
.data
L141:.dc.l L133
.dc.l L136
.dc.l L137
.dc.l L138
.dc.l L139
.dc.l L140
.text
L131:
*line 1074
move _asmode,R8
add.l R8,R8
add.l R8,R8
move.l #_aslbls,R9
move.l 0(R8,R9.l),(sp)
move #43,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1075
clr (sp)
jsr _GLCcurs
*line 1076
jsr _setleds
L128:unlk R14
rts
.globl _l_inst
.text
_l_inst:
~~l_inst:
~stat=8
link R14,#-4
*line 1091
*line 1092
tst 8(R14)
beq L142
*line 1093
*line 1094
move.l #_GLCplot,_point
*line 1095
move #1,(sp)
jsr _GLCcurs
*line 1097
*line 1097
tst _asmode
beq L143
*line 1098
*line 1099
clr _asmode
*line 1100
move _oldpk,_pkctrl
*line 1101
move.l _oldsw,_swpt
*line 1102
clr (sp)
move #54,-(sp)
move #287,-(sp)
move #54,-(sp)
move #258,-(sp)
jsr _lseg
addq.l #8,sp
*line 1103
*line 1104
L143:
*line 1105
*line 1105
tst _gomode
beq L144
*line 1106
*line 1107
clr _gomode
*line 1108
move _oldpk,_pkctrl
*line 1109
clr (sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
*line 1110
*line 1111
L144:
*line 1112
clr (sp)
jsr _GLCcurs
*line 1115
move _ismode,R0
bra L146
*line 1116
L147:
*line 1117
*line 1118
*line 1119
*line 1120
tst _pkctrl
beq L10022
cmp #1,_pkctrl
bne L148
L10022:*line 1120
move _pkctrl,_oldpk
*line 1121
L148:
*line 1122
*line 1123
cmp #4,_sliders
beq L149
*line 1123
move _sliders,_oldsl
*line 1124
L149:
*line 1125
move.l _swpt,_oldsw
*line 1126
move.l #_t_inst,_swpt
*line 1127
move #3,_pkctrl
*line 1128
move #1,_ismode
*line 1129
move #4,_sliders
*line 1130
jsr _lcdlbls
bra L145
*line 1131
*line 1132
L150:
*line 1133
*line 1134
*line 1135
move #2,_ismode
*line 1136
move #1,(sp)
jsr _GLCcurs
*line 1137
move.l #L151,(sp)
move #73,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1138
clr (sp)
jsr _GLCcurs
bra L145
*line 1139
*line 1140
L152:
*line 1141
L153:
*line 1142
*line 1143
*line 1144
clr _ismode
*line 1145
move _oldpk,_pkctrl
*line 1146
move _oldsl,_sliders
*line 1147
move.l _oldsw,_swpt
*line 1148
jsr _lcdlbls
bra L145
*line 1149
bra L145
L146:tst R0
beq L147
cmp #1,R0
beq L150
cmp #2,R0
beq L152
bra L153
L145:
*line 1152
jsr _setleds
L142:unlk R14
rts
.globl _selins
.text
_selins:
~~selins:
~ival=R7
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~n=R6
~ep=R13
*line 1170
move 8(R14),R7
*line 1170
clr R6
bra L157
L158:
*line 1171
*line 1172
*line 1173
move R6,R8
add.l R8,R8
add.l #_grpsel,R8
tst (R8)
beq L156
*line 1174
*line 1175
move R7,R0
move R6,R9
add.l R9,R9
add.l #_ins2grp,R9
move (R9),R1
and #-256,R1
or R1,R0
move R6,R9
add.l R9,R9
add.l #_ins2grp,R9
move R0,(R9)
*line 1176
move R6,(sp)
jsr _setv2gi
*line 1177
*line 1178
*line 1178
tst _recsw
beq L159
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L159
move R6,R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L159
*line 1179
*line 1180
*line 1180
move #-1,(sp)
move R6,-(sp)
move #4,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L160
*line 1181
*line 1182
move.b R7,7(R13)
*line 1183
bra L161
L160:
*line 1184
*line 1184
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L162
*line 1185
*line 1186
move.b #4,5(R13)
*line 1187
move.b R6,6(R13)
*line 1188
move.b R7,7(R13)
*line 1189
move.l _t_cur,(R13)
*line 1190
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
*line 1191
clr (sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 1192
*line 1193
*line 1193
cmp #2,_ndisp
bne L163
*line 1194
*line 1195
move #1,_ctrsw
*line 1196
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 1197
jsr _scupd
*line 1198
L163:
*line 1199
L162:L161:
*line 1200
L159:L156:
*line 1170
add #1,R6
L157:
*line 1170
cmp #12,R6
blt L158
L155:
*line 1203
jsr _setinst
*line 1207
clr _ismode
*line 1208
move _oldpk,_pkctrl
*line 1209
move _oldsl,_sliders
*line 1210
move.l _oldsw,_swpt
*line 1211
jsr _lcdlbls
*line 1212
jsr _setleds
*line 1213
jsr _mpcupd
L154:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _l_dflt
.text
_l_dflt:
~~l_dflt:
~stat=8
link R14,#-4
*line 1228
*line 1229
tst 8(R14)
beq L164
*line 1230
*line 1231
clr (sp)
jsr _selins
L164:unlk R14
rts
.globl _l_goto
.text
_l_goto:
~~l_goto:
~stat=8
link R14,#-4
*line 1246
*line 1247
tst 8(R14)
beq L165
*line 1248
*line 1249
move.l #_GLCplot,_point
*line 1250
move #1,(sp)
jsr _GLCcurs
*line 1252
*line 1252
tst _asmode
beq L166
*line 1253
*line 1254
clr _asmode
*line 1255
move _oldpk,_pkctrl
*line 1256
move.l _oldsw,_swpt
*line 1257
clr (sp)
move #54,-(sp)
move #287,-(sp)
move #54,-(sp)
move #258,-(sp)
jsr _lseg
addq.l #8,sp
*line 1258
*line 1259
L166:
*line 1260
*line 1260
tst _ismode
beq L167
*line 1261
*line 1262
clr _ismode
*line 1263
move _oldsl,_sliders
*line 1264
move _oldpk,_pkctrl
*line 1265
move.l _oldsw,_swpt
*line 1266
jsr _lcdlbls
*line 1267
*line 1268
L167:
*line 1269
clr _recsw
*line 1270
jsr _dsrpmod
*line 1273
move _gomode,R0
bra L169
*line 1274
L170:
*line 1275
*line 1276
*line 1277
*line 1278
tst _pkctrl
beq L10023
cmp #1,_pkctrl
bne L171
L10023:*line 1278
move _pkctrl,_oldpk
*line 1279
L171:
*line 1280
move #2,_pkctrl
*line 1281
move #1,_gomode
*line 1282
move.l #L172,(sp)
move #31,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1283
move #1,(sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
bra L168
*line 1284
*line 1285
L173:
*line 1286
*line 1287
*line 1288
move #2,_gomode
*line 1289
move.l #L174,(sp)
move #31,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1290
move #1,(sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
bra L168
*line 1291
*line 1292
L175:
*line 1293
L176:
*line 1294
*line 1295
*line 1296
move _oldpk,_pkctrl
*line 1297
clr _gomode
*line 1298
move.l #L177,(sp)
move #31,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1299
clr (sp)
move #54,-(sp)
move #215,-(sp)
move #54,-(sp)
move #186,-(sp)
jsr _lseg
addq.l #8,sp
bra L168
*line 1300
bra L168
L169:tst R0
beq L170
cmp #1,R0
beq L173
cmp #2,R0
beq L175
bra L176
L168:
*line 1303
clr (sp)
jsr _GLCcurs
*line 1304
jsr _setleds
L165:unlk R14
rts
.globl _newpps
.text
_newpps:
~~newpps:
~trg=R7
~ival=R6
~grp=10
~src=12
link R14,#-4
movem.l R2-R7/R11-R13,-(sp)
~smf=R13
~smp=R12
~fpu=R11
~ltmp=R5
~val=R4
~vce=R3
~gs=-2
~oldi=-4
*line 1328
move 8(R14),R7
*line 1328
move 14(R14),R6
*line 1328
move 10(R14),R0
asl #4,R0
or 12(R14),R0
move R0,-2(R14)
*line 1329
move.l #16384+_io_fpu,R11
*line 1330
move -2(R14),R0
muls #10,R0
add.l #_valents,R0
move.l R0,R8
move R6,8(R8)
*line 1331
move -2(R14),R0
muls #10,R0
move.l R0,R13
add.l #_valents,R13
move.l R13,R12
*line 1335
bra L181
L180:
*line 1336
*line 1337
move 8(R12),R3
asr #4,R3
and #15,R3
*line 1338
*line 1339
*line 1339
move R3,R8
add.l R8,R8
add.l #_vce2trg,R8
cmp (R8),R7
bne L182
*line 1340
*line 1341
clr R0
move 8(R12),R0
and #15,R0
bra L184
*line 1342
L185:
*line 1343
L186:
*line 1344
L187:
*line 1345
L188:
*line 1346
*line 1347
*line 1348
move R6,R4
asr #3,R4
bra L183
*line 1349
*line 1350
L189:
*line 1351
*line 1352
*line 1353
move R6,R5
ext.l R5
asr.l #$1,R5
move R6,R0
ext.l R0
asr.l #$2,R0
add.l R0,R5
*line 1354
*line 1355
*line 1356
cmp.l #$7d00,R5
ble L190
*line 1356
move.l #$7d00,R5
bra L191
L190:
*line 1357
*line 1358
cmp.l #$ffff8300,R5
bge L192
*line 1358
move.l #$ffff8300,R5
*line 1359
L192:L191:
*line 1360
move R5,R4
bra L183
*line 1361
*line 1362
L193:
*line 1363
*line 1364
*line 1365
move R6,R4
bra L183
L184:sub #1,R0
cmp #9,R0
bhi L193
asl #2,R0
move R0,R8
add.l #L194,R8
move.l (R8),R8
jmp (R8)
.data
L194:.dc.l L185
.dc.l L193
.dc.l L186
.dc.l L193
.dc.l L187
.dc.l L193
.dc.l L188
.dc.l L193
.dc.l L193
.dc.l L189
.text
L183:
*line 1366
*line 1367
*line 1368
move #2,(sp)
jsr _setipl
move R0,-4(R14)
*line 1369
*line 1370
*line 1371
*line 1372
move.l R11,R8
clr R1
move 8(R12),R1
lsl #4,R1
lsl #1,R1
swap R1
clr R1
swap R1
add.l R1,R8
move R4,8(R8)
*line 1373
*line 1374
move -4(R14),(sp)
jsr _setipl
*line 1375
*line 1376
*line 1377
*line 1378
L182:L181:
*line 1379
move.l (R12),R12
cmp.l R12,R13
bne L180
L179:L178:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _newsv
.text
_newsv:
~~newsv:
~ival=R7
~grp=8
~src=10
link R14,#-4
movem.l R2-R7/R11-R13,-(sp)
~smf=R13
~smp=R12
~fpu=R11
~ltmp=R6
~val=R5
~gs=R4
~oldi=R3
~vmask=-2
~var=-4
*line 1404
move 12(R14),R7
*line 1404
move 8(R14),R4
asl #4,R4
or 10(R14),R4
*line 1406
*line 1406
move 10(R14),R8
add.l R8,R8
move.l #_src2var,R9
move 0(R8,R9.l),R0
move R0,-4(R14)
cmp #-1,R0
beq L196
*line 1407
*line 1408
move -4(R14),R0
asl #5,R0
ext.l R0
move 8(R14),R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_anrs,R9
move 0(R8,R9.l),R8
add.l R8,R8
add.l #_vmasks,R8
move (R8),-2(R14)
*line 1409
*line 1410
*line 1411
*line 1412
*line 1412
move R4,R0
muls #10,R0
add.l #_valents,R0
move.l R0,R8
move 8(R8),R5
move R5,R0
and -2(R14),R0
move R7,R1
and -2(R14),R1
cmp R1,R0
bne L197
*line 1413
*line 1414
*line 1415
*line 1416
*line 1417
tst R7
bne L10024
tst R5
bne L198
L10024:*line 1417
clr R0
bra L195
L198:
*line 1418
L197:
*line 1419
*line 1420
L196:
*line 1421
move.l #16384+_io_fpu,R11
*line 1423
move R4,R0
muls #10,R0
add.l #_valents,R0
move.l R0,R8
move R7,8(R8)
*line 1425
move R4,R0
muls #10,R0
move.l R0,R13
add.l #_valents,R13
*line 1426
move.l R13,R12
*line 1430
bra L201
L200:
*line 1431
*line 1432
clr R0
move 8(R12),R0
and #15,R0
bra L203
*line 1433
L204:
*line 1434
L205:
*line 1435
L206:
*line 1436
L207:
*line 1437
*line 1438
*line 1439
move R7,R5
asr #3,R5
bra L202
*line 1440
*line 1441
L208:
*line 1442
*line 1443
*line 1444
move R7,R6
ext.l R6
asr.l #$1,R6
move R7,R0
ext.l R0
asr.l #$2,R0
add.l R0,R6
*line 1445
*line 1446
*line 1447
cmp.l #$7d00,R6
ble L209
*line 1447
move.l #$7d00,R6
bra L210
L209:
*line 1448
*line 1449
cmp.l #$ffff8300,R6
bge L211
*line 1449
move.l #$ffff8300,R6
*line 1450
L211:L210:
*line 1451
move R6,R5
bra L202
*line 1452
*line 1453
L212:
*line 1454
*line 1455
*line 1456
move R7,R5
bra L202
L203:sub #1,R0
cmp #9,R0
bhi L212
asl #2,R0
move R0,R8
add.l #L213,R8
move.l (R8),R8
jmp (R8)
.data
L213:.dc.l L204
.dc.l L212
.dc.l L205
.dc.l L212
.dc.l L206
.dc.l L212
.dc.l L207
.dc.l L212
.dc.l L212
.dc.l L208
.text
L202:
*line 1457
*line 1458
*line 1459
move #2,(sp)
jsr _setipl
move R0,R3
*line 1460
*line 1461
*line 1462
*line 1463
move.l R11,R8
clr R1
move 8(R12),R1
lsl #4,R1
lsl #1,R1
swap R1
clr R1
swap R1
add.l R1,R8
move R5,8(R8)
*line 1464
*line 1465
move R3,(sp)
jsr _setipl
*line 1466
*line 1467
*line 1468
L201:
*line 1469
move.l (R12),R12
cmp.l R12,R13
bne L200
L199:
*line 1471
move #1,R0
bra L195
L195:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _setsv
.text
_setsv:
~~setsv:
~ival=R7
~grp=8
~src=10
link R14,#0
movem.l R2-R7/R11-R13,-(sp)
~smf=R13
~smp=R12
~fpu=R11
~ltmp=R6
~val=R5
~gs=R4
~oldi=R3
*line 1494
move 12(R14),R7
*line 1494
move 8(R14),R4
asl #4,R4
or 10(R14),R4
*line 1495
move.l #16384+_io_fpu,R11
*line 1497
move R4,R0
muls #10,R0
add.l #_valents,R0
move.l R0,R8
move R7,8(R8)
*line 1499
move R4,R0
muls #10,R0
move.l R0,R13
add.l #_valents,R13
*line 1500
move.l R13,R12
*line 1504
bra L217
L216:
*line 1505
*line 1506
clr R0
move 8(R12),R0
and #15,R0
bra L219
*line 1507
L220:
*line 1508
L221:
*line 1509
L222:
*line 1510
L223:
*line 1511
*line 1512
*line 1513
move R7,R5
asr #3,R5
bra L218
*line 1514
*line 1515
L224:
*line 1516
*line 1517
*line 1518
move R7,R6
ext.l R6
asr.l #$1,R6
move R7,R0
ext.l R0
asr.l #$2,R0
add.l R0,R6
*line 1519
*line 1520
*line 1521
cmp.l #$7d00,R6
ble L225
*line 1521
move.l #$7d00,R6
bra L226
L225:
*line 1522
*line 1523
cmp.l #$ffff8300,R6
bge L227
*line 1523
move.l #$ffff8300,R6
*line 1524
L227:L226:
*line 1525
move R6,R5
bra L218
*line 1526
*line 1527
L228:
*line 1528
*line 1529
*line 1530
move R7,R5
bra L218
L219:sub #1,R0
cmp #9,R0
bhi L228
asl #2,R0
move R0,R8
add.l #L229,R8
move.l (R8),R8
jmp (R8)
.data
L229:.dc.l L220
.dc.l L228
.dc.l L221
.dc.l L228
.dc.l L222
.dc.l L228
.dc.l L223
.dc.l L228
.dc.l L228
.dc.l L224
.text
L218:
*line 1531
*line 1532
*line 1533
move #2,(sp)
jsr _setipl
move R0,R3
*line 1534
*line 1535
*line 1536
*line 1537
move.l R11,R8
clr R1
move 8(R12),R1
lsl #4,R1
lsl #1,R1
swap R1
clr R1
swap R1
add.l R1,R8
move R5,8(R8)
*line 1538
*line 1539
move R3,(sp)
jsr _setipl
*line 1540
*line 1541
*line 1542
L217:
*line 1543
move.l (R12),R12
cmp.l R12,R13
bne L216
L215:L214:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _l_prmtr
.text
_l_prmtr:
~~l_prmtr:
~stat=8
~sig=10
link R14,#-4
*line 1558
*line 1559
tst 8(R14)
beq L230
*line 1560
*line 1561
move _sliders,R0
bra L232
*line 1562
L233:
*line 1563
L234:
*line 1564
L235:
*line 1565
*line 1566
*line 1567
move #1,_sliders
*line 1568
move.l #_t_voice,_swpt
bra L231
*line 1569
*line 1570
L236:
*line 1571
L237:
*line 1572
*line 1573
*line 1574
clr _sliders
*line 1575
move.l #_t_prmtr,_swpt
bra L231
*line 1576
bra L231
L232:tst R0
beq L233
cmp #1,R0
beq L236
cmp #2,R0
beq L234
cmp #3,R0
beq L235
bra L237
L231:
*line 1579
jsr _lcdlbls
*line 1580
jsr _setleds
L230:unlk R14
rts
.globl _l_voice
.text
_l_voice:
~~l_voice:
~stat=8
~vce=10
link R14,#-8
movem.l R4-R7/R13-R13,-(sp)
~ap=R7
~j=R6
~par=R5
~fpu=R13
~buf=-8
*line 1600
*line 1601
tst 8(R14)
beq L238
*line 1602
*line 1603
move 10(R14),R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L10025
clr R0
bra L10026
L10025:move #1,R0
L10026:move 10(R14),R9
add.l R9,R9
add.l #_articen,R9
move R0,(R9)
*line 1605
*line 1606
move 10(R14),R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L10027
move #127,(sp)
bra L10029
L10027:move #32,(sp)
L10029:move 10(R14),-(sp)
add #1,(sp)
move 10(R14),R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L10030
move #126,-(sp)
bra L10032
L10030:move #32,-(sp)
L10032:move.l #L239,-(sp)
move.l R14,-(sp)
sub.l #8,(sp)
jsr _sprintf
adda.l #12,sp
*line 1608
move #1,(sp)
jsr _GLCcurs
*line 1609
move.l R14,(sp)
sub.l #8,(sp)
move 10(R14),R0
muls #6,R0
move R0,-(sp)
add #1,(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1610
clr (sp)
jsr _GLCcurs
*line 1612
*line 1612
move 10(R14),R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L240
*line 1613
*line 1614
clr R7
bra L243
L244:
*line 1615
*line 1616
move R7,R8
add.l R8,R8
add.l #_arpar,R8
move (R8),R5
*line 1617
move R5,R8
add.l R8,R8
move.l #_lastart,R9
move 0(R8,R9.l),(sp)
move R5,-(sp)
move 10(R14),-(sp)
jsr _sendart
addq.l #4,sp
L242:
*line 1614
add #1,R7
L243:
*line 1614
cmp #14,R7
blt L244
L241:
*line 1618
*line 1619
bra L245
L240:
*line 1620
*line 1621
*line 1622
move 10(R14),R0
asl #8,R0
asl #1,R0
ext.l R0
move.l R0,R13
add.l #_io_fpu,R13
add.l #$4000,R13
*line 1623
*line 1624
move #1,R6
bra L248
L249:
*line 1625
move.l R13,R8
move R6,R1
asl #4,R1
move R1,R9
add.l R9,R9
add.l R9,R8
clr 14(R8)
L247:
*line 1624
add #1,R6
L248:
*line 1624
cmp #16,R6
blt L249
L246:
*line 1625
L245:L238:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _l_group
.text
_l_group:
~~l_group:
~stat=8
~grp=10
link R14,#-12
~buf=-8
*line 1643
*line 1644
tst 8(R14)
beq L250
*line 1645
*line 1646
move 10(R14),R8
add.l R8,R8
move.l #_grpsel,R9
tst 0(R8,R9.l)
beq L10033
clr R0
bra L10034
L10033:move #1,R0
L10034:move 10(R14),R9
add.l R9,R9
add.l #_grpsel,R9
move R0,(R9)
*line 1648
*line 1649
move 10(R14),R8
add.l R8,R8
move.l #_grpsel,R9
tst 0(R8,R9.l)
beq L10035
move #127,(sp)
bra L10037
L10035:move #32,(sp)
L10037:move 10(R14),-(sp)
add #1,(sp)
move 10(R14),R8
add.l R8,R8
move.l #_grpsel,R9
tst 0(R8,R9.l)
beq L10038
move #126,-(sp)
bra L10040
L10038:move #32,-(sp)
L10040:move.l #L251,-(sp)
move.l R14,-(sp)
sub.l #8,(sp)
jsr _sprintf
adda.l #12,sp
*line 1651
move #1,(sp)
jsr _GLCcurs
*line 1652
move.l R14,(sp)
sub.l #8,(sp)
move 10(R14),R0
muls #6,R0
move R0,-(sp)
add #1,(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 1653
clr (sp)
jsr _GLCcurs
L250:unlk R14
rts
.globl _l_other
.text
_l_other:
~~l_other:
~stat=8
~sig=10
link R14,#-4
*line 1665
*line 1666
tst 8(R14)
beq L252
*line 1667
*line 1668
move #2,_sliders
*line 1669
move.l #_t_other,_swpt
*line 1671
jsr _lcdlbls
L252:unlk R14
rts
.globl _l_eq
.text
_l_eq:
~~l_eq:
~stat=8
~sig=10
link R14,#-4
*line 1686
*line 1687
tst 8(R14)
beq L253
*line 1688
*line 1689
*line 1689
cmp #3,_sliders
bne L254
*line 1690
*line 1691
clr _sliders
*line 1692
move.l #_t_prmtr,_swpt
*line 1693
bra L255
L254:
*line 1694
*line 1695
*line 1696
move #3,_sliders
*line 1697
move.l #_t_eq,_swpt
L255:
*line 1700
jsr _lcdlbls
L253:unlk R14
rts
.globl _artclr
.text
_artclr:
~~artclr:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 1713
clr R7
bra L259
L260:
*line 1714
move R7,R8
add.l R8,R8
move.l #_arpar,R9
move 0(R8,R9.l),R8
add.l R8,R8
add.l #_lastart,R8
move R7,R9
add.l R9,R9
add.l #_artitab,R9
move (R9),(R8)
L258:
*line 1713
add #1,R7
L259:
*line 1713
cmp #14,R7
blt L260
L257:L256:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _l_init
.text
_l_init:
~~l_init:
~stat=8
~sig=10
link R14,#-16
movem.l R4-R7/R13-R13,-(sp)
~fpu=R13
~barval=R7
~i=R6
~j=R5
~buf=-16
*line 1733
*line 1734
tst 8(R14)
beq L261
*line 1735
*line 1736
move.l #16384+_io_fpu,R13
*line 1738
move _sliders,R0
bra L263
*line 1739
L264:
*line 1740
L265:
*line 1741
L266:
*line 1742
L267:
*line 1743
L268:
*line 1744
L269:
*line 1745
*line 1746
*line 1747
*line 1748
*line 1749
clr R6
bra L272
L273:
*line 1750
move #1,R5
bra L276
L277:
*line 1751
move.l R13,R8
move R6,R1
asl #8,R1
move R1,R9
add.l R9,R9
add.l R9,R8
move R5,R1
asl #4,R1
move R1,R9
add.l R9,R9
add.l R9,R8
clr 14(R8)
L275:
*line 1750
add #1,R5
L276:
*line 1750
cmp #16,R5
blt L277
L274:L271:
*line 1749
add #1,R6
L272:
*line 1749
cmp #12,R6
blt L273
L270:
*line 1751
*line 1752
*line 1753
jsr _artclr
*line 1754
*line 1755
clr R6
bra L280
L281:
*line 1756
*line 1757
move R6,R8
add.l R8,R8
add.l #_BGprmtr,R8
move R6,R9
add.l R9,R9
add.l #_artitab,R9
move (R9),(R8)
*line 1758
*line 1759
*line 1759
move R6,R8
add.l R8,R8
move.l #_BarType,R9
tst 0(R8,R9.l)
beq L282
*line 1760
*line 1761
move R6,R8
add.l R8,R8
add.l #_artitab,R8
move (R8),R7
asr #5,R7
add #-500,R7
asl #6,R7
ext.l R7
divs #252,R7
*line 1762
move R7,(sp)
move R6,-(sp)
jsr _BarCset
addq.l #2,sp
*line 1763
bra L283
L282:
*line 1764
*line 1765
*line 1766
move R6,R8
add.l R8,R8
add.l #_artitab,R8
move (R8),R7
ext.l R7
divs #252,R7
*line 1767
move R7,(sp)
move R6,-(sp)
jsr _BarBset
addq.l #2,sp
L283:
*line 1768
L279:
*line 1755
add #1,R6
L280:
*line 1755
cmp #14,R6
blt L281
L278:
*line 1769
*line 1770
bra L262
*line 1771
*line 1772
L284:
*line 1773
*line 1774
*line 1775
*line 1776
*line 1777
move #1,R6
bra L287
L288:
*line 1778
move.l R13,R8
move R6,R1
asl #8,R1
move R1,R9
add.l R9,R9
add.l R9,R8
clr 14(R8)
L286:
*line 1777
add #1,R6
L287:
*line 1777
cmp #12,R6
blt L288
L285:
*line 1778
*line 1779
*line 1780
clr R6
bra L291
L292:
*line 1781
move R6,R8
add.l R8,R8
add.l #_BGother,R8
move #0,R0
move R0,(R8)
move R0,(sp)
move R6,-(sp)
jsr _BarBset
addq.l #2,sp
L290:
*line 1780
add #1,R6
L291:
*line 1780
cmp #14,R6
blt L292
L289:
*line 1781
*line 1782
bra L262
*line 1783
*line 1784
L293:
*line 1785
*line 1786
*line 1787
clr R6
bra L296
L297:
*line 1788
*line 1789
clr (sp)
jsr _gain2eq
move R0,(sp)
move R6,-(sp)
jsr _sendeq
addq.l #2,sp
*line 1790
move R6,R8
add.l R8,R8
add.l #_BGeq,R8
move #0,R0
move R0,(R8)
move R0,(sp)
move R6,-(sp)
jsr _BarCset
addq.l #2,sp
L295:
*line 1787
add #1,R6
L296:
*line 1787
cmp #14,R6
blt L297
L294:
*line 1791
*line 1792
bra L262
*line 1793
bra L262
L263:cmp #7,R0
bhi L262
asl #2,R0
move R0,R8
add.l #L298,R8
move.l (R8),R8
jmp (R8)
.data
L298:.dc.l L264
.dc.l L265
.dc.l L284
.dc.l L293
.dc.l L266
.dc.l L267
.dc.l L268
.dc.l L269
.text
L262:L261:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _sendart
.text
_sendart:
~~sendart:
~vce=8
~par=10
~ival=12
link R14,#-2
movem.l R4-R7/R13-R13,-(sp)
~fpu=R13
~val=R7
~oldi=R6
~mult=R5
~nop=-2
*line 1813
move 10(R14),R8
add.l R8,R8
add.l #_lastart,R8
move 12(R14),(R8)
*line 1815
move 8(R14),R0
asl #8,R0
asl #1,R0
ext.l R0
move.l R0,R13
move 10(R14),R0
asl #4,R0
asl #1,R0
ext.l R0
add.l R0,R13
add.l #_io_fpu,R13
add.l #$4000,R13
*line 1816
move #32767,R5
*line 1818
move 10(R14),R0
bra L301
*line 1819
L302:
*line 1820
L303:
*line 1821
L304:
*line 1822
L305:
*line 1823
*line 1824
*line 1825
clr (sp)
move 12(R14),-(sp)
jsr _addpch
addq.l #2,sp
move R0,R7
bra L300
*line 1826
*line 1827
L306:
*line 1828
*line 1829
*line 1830
move 12(R14),R7
asr #5,R7
add #-500,R7
asl #5,R7
bra L300
*line 1831
*line 1832
*line 1833
*line 1834
*line 1835
L307:
*line 1836
*line 1837
*line 1838
move 12(R14),R7
*line 1839
move #-1,R5
bra L300
*line 1840
*line 1841
L308:
*line 1842
*line 1843
*line 1844
move 12(R14),R7
asr #5,R7
add #-500,R7
asl #5,R7
*line 1845
move #-1,R5
bra L300
*line 1846
*line 1847
L309:
*line 1848
*line 1849
*line 1850
move 12(R14),R7
bra L300
L301:sub #1,R0
cmp #9,R0
bhi L309
asl #2,R0
move R0,R8
add.l #L310,R8
move.l (R8),R8
jmp (R8)
.data
L310:.dc.l L302
.dc.l L307
.dc.l L303
.dc.l L308
.dc.l L304
.dc.l L309
.dc.l L305
.dc.l L309
.dc.l L309
.dc.l L306
.text
L300:
*line 1853
move #2,(sp)
jsr _setipl
move R0,R6
*line 1857
move R7,12(R13)
*line 1858
add #1,-2(R14)
*line 1858
add #1,-2(R14)
*line 1858
add #1,-2(R14)
*line 1859
move R5,14(R13)
*line 1861
move R6,(sp)
jsr _setipl
L299:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _doslide
.text
_doslide:
~~doslide:
link R14,#0
movem.l R2-R7,-(sp)
~arp=R7
~bar=R6
~barval=R5
~i=R4
~slval=R3
*line 1880
move _aval,R0
sub #5,R0
cmp #100,R0
ble L10041
move #100,R0
bra L10043
L10041:move _aval,R0
sub #5,R0
bge L10044
clr R0
bra L10046
L10044:move _aval,R0
sub #5,R0
L10046:L10043:move R0,R3
muls #320,R3
*line 1881
move _asig,R6
add #-25,R6
*line 1883
move _sliders,R0
bra L313
*line 1884
L314:
*line 1885
L315:
*line 1886
L316:
*line 1887
L317:
*line 1888
L318:
*line 1889
L319:
*line 1890
*line 1891
*line 1892
move R6,R8
add.l R8,R8
add.l #_BGprmtr,R8
move R3,(R8)
*line 1893
move R6,R8
add.l R8,R8
add.l #_arpar,R8
move (R8),R7
*line 1894
*line 1895
clr R4
bra L322
L323:
*line 1896
*line 1897
move R4,R8
add.l R8,R8
move.l #_articen,R9
tst 0(R8,R9.l)
beq L324
*line 1897
move R3,(sp)
move R7,-(sp)
move R4,-(sp)
jsr _sendart
addq.l #4,sp
*line 1898
L324:L321:
*line 1895
add #1,R4
L322:
*line 1895
cmp #12,R4
blt L323
L320:
*line 1899
*line 1899
move R6,R8
add.l R8,R8
move.l #_BarType,R9
tst 0(R8,R9.l)
beq L325
*line 1900
*line 1901
move R3,R5
asr #5,R5
add #-500,R5
asl #6,R5
ext.l R5
divs #252,R5
*line 1902
move R5,(sp)
move R6,-(sp)
jsr _BarCadj
addq.l #2,sp
*line 1903
bra L326
L325:
*line 1904
*line 1905
*line 1906
move R3,R5
ext.l R5
divs #252,R5
*line 1907
move R5,(sp)
move R6,-(sp)
jsr _BarBadj
addq.l #2,sp
L326:
*line 1908
*line 1909
bra L311
*line 1910
*line 1911
*line 1912
L327:
*line 1913
*line 1914
*line 1915
move _asig,R0
bra L329
*line 1916
L330:
*line 1917
*line 1918
move R3,(sp)
clr -(sp)
move #9,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1919
*line 1920
L331:
*line 1921
*line 1922
move R3,(sp)
clr -(sp)
move #3,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1923
*line 1924
L332:
*line 1925
*line 1926
move R3,(sp)
clr -(sp)
move #2,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1927
*line 1928
L333:
*line 1929
*line 1930
move R3,(sp)
clr -(sp)
move #1,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1931
*line 1932
L334:
*line 1933
*line 1934
move R3,(sp)
clr -(sp)
move #11,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1935
*line 1936
L335:
*line 1937
*line 1938
move R3,(sp)
clr -(sp)
move #10,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1939
*line 1940
L336:
*line 1941
*line 1942
move R3,(sp)
clr -(sp)
move #6,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1943
*line 1944
L337:
*line 1945
*line 1946
move R3,(sp)
clr -(sp)
move #8,-(sp)
jsr _sendart
addq.l #4,sp
bra L328
*line 1947
*line 1948
L338:
*line 1949
*line 1950
clr R3
bra L328
*line 1951
bra L328
L329:sub #26,R0
cmp #7,R0
bhi L338
asl #2,R0
move R0,R8
add.l #L339,R8
move.l (R8),R8
jmp (R8)
.data
L339:.dc.l L330
.dc.l L331
.dc.l L332
.dc.l L333
.dc.l L334
.dc.l L335
.dc.l L336
.dc.l L337
.text
L328:
*line 1952
*line 1953
*line 1954
move R6,R8
add.l R8,R8
add.l #_BGother,R8
move R3,(R8)
*line 1955
move R3,R5
ext.l R5
divs #252,R5
*line 1956
move R5,(sp)
move R6,-(sp)
jsr _BarBadj
addq.l #2,sp
*line 1957
bra L311
*line 1958
*line 1959
*line 1960
*line 1961
L340:
*line 1962
*line 1963
*line 1964
move R3,R5
asr #5,R5
add #-500,R5
asl #6,R5
ext.l R5
divs #252,R5
*line 1965
move R6,R8
add.l R8,R8
add.l #_BGeq,R8
move R5,(R8)
*line 1966
move R3,R0
move #11,R1
asr R1,R0
add #16,R0
move R0,R8
add.l R8,R8
move.l #_sl2gain,R9
move 0(R8,R9.l),(sp)
jsr _gain2eq
move R0,(sp)
move R6,-(sp)
jsr _sendeq
addq.l #2,sp
*line 1967
move R5,(sp)
move R6,-(sp)
jsr _BarCadj
addq.l #2,sp
*line 1968
bra L311
*line 1969
*line 1970
L341:
*line 1971
bra L311
*line 1972
bra L312
L313:cmp #7,R0
bhi L341
asl #2,R0
move R0,R8
add.l #L342,R8
move.l (R8),R8
jmp (R8)
.data
L342:.dc.l L314
.dc.l L315
.dc.l L327
.dc.l L340
.dc.l L316
.dc.l L317
.dc.l L318
.dc.l L319
.text
L312:L311:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _settmpo
.text
_settmpo:
~~settmpo:
~val=8
link R14,#0
movem.l R6-R7,-(sp)
~timeval=R7
*line 1990
move 8(R14),_tmpoval
*line 1991
move _tmpomlt,R7
add #50,R7
muls _tmpoval,R7
ext.l R7
divs #100,R7
*line 1992
move R7,R0
ext.l R0
move.l R0,-(sp)
move.l #$2ee00,-(sp)
jsr ldiv
addq.l #8,sp
sub.l #$1,R0
move R0,R7
*line 1993
move R7,R0
asr #8,R0
move.b R0,8+_io_time
*line 1994
move R7,R0
and #255,R0
move.b R0,10+_io_time
L343:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _settune
.text
_settune:
~~settune:
link R14,#-2
movem.l R2-R7/R13-R13,-(sp)
~oldi=R7
~i=R6
~grp=R5
~fpu=R13
~trval=R4
~trmax=R3
~nop=-2
*line 2013
move.l #$55a0,R3
*line 2015
move #8704,(sp)
jsr _setsr
move R0,R7
*line 2019
clr R6
bra L347
L348:
*line 2020
*line 2021
*line 2021
move R6,R8
add.l R8,R8
add.l #_vce2grp,R8
move (R8),R5
cmp #-1,R5
beq L349
*line 2022
*line 2023
move _tuneval,R4
ext.l R4
move R5,R8
sub #1,R8
add.l R8,R8
move.l #_s_trns,R9
move 0(R8,R9.l),R0
ext.l R0
asl.l #$1,R0
add.l R0,R4
*line 2024
*line 2025
*line 2026
cmp.l R3,R4
ble L350
*line 2026
move.l R3,R4
*line 2027
L350:bra L351
L349:
*line 2028
*line 2029
*line 2030
move _tuneval,R4
ext.l R4
L351:
*line 2031
*line 2032
*line 2033
move R6,R0
asl #8,R0
asl #1,R0
ext.l R0
move.l R0,R13
add.l #_io_fpu,R13
add.l #$4020,R13
*line 2034
*line 2035
move.l R4,R0
and.l #$ffff,R0
move R0,16(R13)
*line 2036
add #1,-2(R14)
*line 2036
add #1,-2(R14)
*line 2036
add #1,-2(R14)
*line 2037
move #32767,18(R13)
L346:
*line 2019
add #1,R6
L347:
*line 2019
cmp #12,R6
blt L348
L345:
*line 2040
move R7,(sp)
jsr _setsr
L344:tst.l (sp)+
movem.l (sp)+,R3-R7/R13-R13
unlk R14
rts
.data
L1:.dc.b $4C,$6F,$63,$6E,$20,$20,$4C,$65,$76,$65,$6C,$20,$49,$6E,$64,$20,$31,$20,$49,$6E,$64,$20,$32,$20,$49,$6E,$64,$20,$33,$20
.dc.b $46,$72,$71,$20,$31,$20,$46,$72,$71,$20,$32,$20,$46,$72,$71,$20,$33,$20,$46,$72,$71,$20,$34,$20,$49,$6E,$64,$20,$34,$20
.dc.b $49,$6E,$64,$20,$35,$20,$49,$6E,$64,$20,$36,$20,$46,$69,$6C,$74,$72,$20,$52,$65,$73,$6F,$6E,$0
L2:.dc.b $4C,$6F,$63,$6E,$20,$20,$4C,$65,$76,$65,$6C,$20,$49,$6E,$64,$20,$31,$20,$49,$6E,$64,$20,$32,$20,$49,$6E,$64,$20,$33,$20
.dc.b $46,$72,$71,$20,$31,$20,$46,$72,$71,$20,$32,$20,$46,$72,$71,$20,$33,$20,$46,$72,$71,$20,$34,$20,$49,$6E,$64,$20,$34,$20
.dc.b $49,$6E,$64,$20,$35,$20,$49,$6E,$64,$20,$36,$20,$46,$69,$6C,$74,$72,$20,$52,$65,$73,$6F,$6E,$0
L3:.dc.b $20,$20,$20,$20,$20,$20,$41,$75,$78,$20,$20,$20,$44,$65,$70,$74,$68,$20,$52,$61,$74,$65,$20,$20,$49,$6E,$74,$65,$6E,$20
.dc.b $43,$56,$20,$31,$20,$20,$43,$56,$20,$32,$20,$20,$43,$56,$20,$33,$20,$20,$43,$56,$20,$34,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0
L4:.dc.b $20,$35,$30,$20,$20,$20,$20,$31,$35,$30,$20,$20,$20,$34,$30,$30,$20,$20,$20,$20,$31,$6B,$20,$20,$32,$2E,$35,$6B,$20,$20
.dc.b $20,$20,$36,$6B,$20,$20,$20,$31,$35,$6B,$20,$20,$20,$35,$30,$20,$20,$20,$20,$31,$35,$30,$20,$20,$20,$34,$30,$30,$20,$20
.dc.b $20,$20,$31,$6B,$20,$20,$32,$2E,$35,$6B,$20,$20,$20,$20,$36,$6B,$20,$20,$20,$31,$35,$6B,$20,$0
L5:.dc.b $4C,$6F,$63,$6E,$20,$20,$4C,$65,$76,$65,$6C,$20,$49,$6E,$64,$20,$31,$20,$49,$6E,$64,$20,$32,$20,$49,$6E,$64,$20,$33,$20
.dc.b $46,$72,$71,$20,$31,$20,$46,$72,$71,$20,$32,$20,$46,$72,$71,$20,$33,$20,$46,$72,$71,$20,$34,$20,$49,$6E,$64,$20,$34,$20
.dc.b $49,$6E,$64,$20,$35,$20,$49,$6E,$64,$20,$36,$20,$46,$69,$6C,$74,$72,$20,$52,$65,$73,$6F,$6E,$0
L6:.dc.b $4C,$6F,$63,$6E,$20,$20,$4C,$65,$76,$65,$6C,$20,$49,$6E,$64,$20,$31,$20,$49,$6E,$64,$20,$32,$20,$49,$6E,$64,$20,$33,$20
.dc.b $46,$72,$71,$20,$31,$20,$46,$72,$71,$20,$32,$20,$46,$72,$71,$20,$33,$20,$46,$72,$71,$20,$34,$20,$49,$6E,$64,$20,$34,$20
.dc.b $49,$6E,$64,$20,$35,$20,$49,$6E,$64,$20,$36,$20,$46,$69,$6C,$74,$72,$20,$52,$65,$73,$6F,$6E,$0
L7:.dc.b $4C,$6F,$63,$6E,$20,$20,$4C,$65,$76,$65,$6C,$20,$49,$6E,$64,$20,$31,$20,$49,$6E,$64,$20,$32,$20,$49,$6E,$64,$20,$33,$20
.dc.b $46,$72,$71,$20,$31,$20,$46,$72,$71,$20,$32,$20,$46,$72,$71,$20,$33,$20,$46,$72,$71,$20,$34,$20,$49,$6E,$64,$20,$34,$20
.dc.b $49,$6E,$64,$20,$35,$20,$49,$6E,$64,$20,$36,$20,$46,$69,$6C,$74,$72,$20,$52,$65,$73,$6F,$6E,$0
L8:.dc.b $4C,$6F,$63,$6E,$20,$20,$4C,$65,$76,$65,$6C,$20,$49,$6E,$64,$20,$31,$20,$49,$6E,$64,$20,$32,$20,$49,$6E,$64,$20,$33,$20
.dc.b $46,$72,$71,$20,$31,$20,$46,$72,$71,$20,$32,$20,$46,$72,$71,$20,$33,$20,$46,$72,$71,$20,$34,$20,$49,$6E,$64,$20,$34,$20
.dc.b $49,$6E,$64,$20,$35,$20,$49,$6E,$64,$20,$36,$20,$46,$69,$6C,$74,$72,$20,$52,$65,$73,$6F,$6E,$0
L9:.dc.b $51,$75,$69,$65,$74,$20,$52,$4F,$4D,$50,$20,$20,$4C,$61,$6D,$70,$20,$20,$43,$6C,$6F,$63,$6B,$20,$20,$50,$2F,$52,$20,$20
.dc.b $47,$6F,$20,$54,$6F,$20,$49,$6E,$73,$74,$72,$20,$41,$73,$67,$6D,$74,$20,$4C,$6F,$61,$64,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$4F,$74,$68,$65,$72,$20,$56,$6F,$69,$63,$65,$20,$49,$6E,$69,$74,$20,$0
L10:.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$56,$6F,$69,$63,$65,$20,$49,$6E,$69,$74,$20,$0
L11:.dc.b $51,$75,$69,$65,$74,$20,$52,$4F,$4D,$50,$20,$20,$4C,$61,$6D,$70,$20,$20,$43,$6C,$6F,$63,$6B,$20,$20,$50,$2F,$52,$20,$20
.dc.b $47,$6F,$20,$54,$6F,$20,$49,$6E,$73,$74,$72,$20,$41,$73,$67,$6D,$74,$20,$4C,$6F,$61,$64,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$45,$51,$20,$20,$20,$56,$6F,$69,$63,$65,$20,$49,$6E,$69,$74,$20,$0
L12:.dc.b $51,$75,$69,$65,$74,$20,$52,$4F,$4D,$50,$20,$20,$4C,$61,$6D,$70,$20,$20,$43,$6C,$6F,$63,$6B,$20,$20,$50,$2F,$52,$20,$20
.dc.b $47,$6F,$20,$54,$6F,$20,$49,$6E,$73,$74,$72,$20,$41,$73,$67,$6D,$74,$20,$4C,$6F,$61,$64,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$50,$72,$6D,$74,$72,$20,$56,$6F,$69,$63,$65,$20,$49,$6E,$69,$74,$20,$0
L13:.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2B,$30,$30,$20,$20,$44,$65,$66,$6C,$74,$0
L14:.dc.b $51,$75,$69,$65,$74,$20,$52,$4F,$4D,$50,$20,$20,$4C,$61,$6D,$70,$20,$20,$43,$6C,$6F,$63,$6B,$20,$20,$50,$2F,$52,$20,$20
.dc.b $47,$6F,$20,$54,$6F,$20,$49,$6E,$73,$74,$72,$20,$41,$73,$67,$6D,$74,$20,$4C,$6F,$61,$64,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$4F,$74,$68,$65,$72,$20,$56,$6F,$69,$63,$65,$20,$44,$65,$66,$6C,$74,$0
L15:.dc.b $51,$75,$69,$65,$74,$20,$52,$4F,$4D,$50,$20,$20,$4C,$61,$6D,$70,$20,$20,$43,$6C,$6F,$63,$6B,$20,$20,$50,$2F,$52,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0
L16:.dc.b $51,$75,$69,$65,$74,$20,$52,$4F,$4D,$50,$20,$20,$4C,$61,$6D,$70,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$4C,$6F,$61,$64,$20,$20,$20,$20,$20,$20,$20,$20
.dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0
L17:.dc.b $41,$73,$67,$6D,$74,$0
L18:.dc.b $20,$2B,$30,$30,$20,$0
L19:.dc.b $20,$2B,$32,$30,$20,$0
L20:.dc.b $20,$2B,$34,$30,$20,$0
L21:.dc.b $20,$2B,$36,$30,$20,$0
L22:.dc.b $20,$2B,$38,$30,$20,$0
L64:.dc.b $53,$65,$63,$74,$6E,$0
L66:.dc.b $53,$63,$6F,$72,$65,$0
L68:.dc.b $47,$6F,$20,$54,$6F,$0
L74:.dc.b $25,$63,$25,$32,$64,$20,$25,$63,$20,$0
L75:.dc.b $56,$6F,$69,$63,$65,$20,$49,$6E,$69,$74,$20,$0
L81:.dc.b $25,$63,$25,$32,$64,$20,$25,$63,$20,$0
L83:.dc.b $20,$2B,$32,$30,$20,$0
L85:.dc.b $20,$2B,$30,$30,$20,$0
L86:.dc.b $20,$44,$65,$66,$6C,$74,$0
L135:.dc.b $44,$65,$66,$6C,$74,$0
L151:.dc.b $20,$2B,$32,$30,$20,$0
L172:.dc.b $53,$65,$63,$74,$6E,$0
L174:.dc.b $53,$63,$6F,$72,$65,$0
L177:.dc.b $47,$6F,$20,$54,$6F,$0
L239:.dc.b $25,$63,$25,$32,$64,$20,$25,$63,$0
L251:.dc.b $25,$63,$25,$32,$64,$20,$25,$63,$0
