.globl ___atab
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
.globl _wzcrsh
.globl _crshpc
.globl _crshsp
.globl _crshus
.globl _crshst
.globl _B_log_s
.globl _B_dbg_s
.globl _B_buf_a
.globl __bpbin
.globl _dfltpal
.globl _crshsr
.globl _crshrg
.globl _crshvc
.globl _hs_mtst
.comm _hs_mtst,2
.globl _cmtab
.data
_cmtab:
*line 212
.dc.l L1
*line 212
.dc.l _cp_null
*line 212
.dc.l _cx_adsp
*line 212
.dc.l L2
*line 213
.dc.l L3
*line 213
.dc.l _cp_boot
*line 213
.dc.l _cx_boot
*line 213
.dc.l L4
*line 214
.dc.l L5
*line 214
.dc.l _cp_null
*line 214
.dc.l _cx_bpb
*line 214
.dc.l L6
*line 217
.dc.l L7
*line 217
.dc.l _cp_chek
*line 217
.dc.l _cx_chek
*line 217
.dc.l L8
*line 218
.dc.l L9
*line 218
.dc.l _cp_copy
*line 218
.dc.l _cx_copy
*line 218
.dc.l L10
*line 221
.dc.l L11
*line 221
.dc.l _cp_null
*line 221
.dc.l _cx_crsh
*line 221
.dc.l L12
*line 222
.dc.l L13
*line 222
.dc.l _cp_null
*line 222
.dc.l _cx_dini
*line 222
.dc.l L14
*line 225
.dc.l L15
*line 225
.dc.l _cp_dump
*line 225
.dc.l _cx_dump
*line 225
.dc.l L16
*line 226
.dc.l L17
*line 226
.dc.l _cp_null
*line 226
.dc.l _cx_exit
*line 226
.dc.l L18
*line 227
.dc.l L19
*line 227
.dc.l _cp_fill
*line 227
.dc.l _cx_fill
*line 227
.dc.l L20
*line 228
.dc.l L21
*line 228
.dc.l _cp_go
*line 228
.dc.l _cx_go
*line 228
.dc.l L22
*line 229
.dc.l L23
*line 229
.dc.l _cp_null
*line 229
.dc.l _cx_help
*line 229
.dc.l L24
*line 230
.dc.l L25
*line 230
.dc.l _cp_ilev
*line 230
.dc.l _cx_ilev
*line 230
.dc.l L26
*line 231
.dc.l L27
*line 231
.dc.l _cp_ldmp
*line 231
.dc.l _cx_ldmp
*line 231
.dc.l L28
*line 232
.dc.l L29
*line 232
.dc.l _cp_null
*line 232
.dc.l _cx_load
*line 232
.dc.l L30
*line 235
.dc.l L31
*line 235
.dc.l _cp_null
*line 235
.dc.l _cx_mlod
*line 235
.dc.l L32
*line 238
.dc.l L33
*line 238
.dc.l _cp_monc
*line 238
.dc.l _cx_mon
*line 238
.dc.l L34
*line 239
.dc.l L35
*line 239
.dc.l _cp_mons
*line 239
.dc.l _cx_mon
*line 239
.dc.l L36
*line 240
.dc.l L37
*line 240
.dc.l _cp_monl
*line 240
.dc.l _cx_mon
*line 240
.dc.l L38
*line 241
.dc.l L39
*line 241
.dc.l _cp_mset
*line 241
.dc.l _cx_mset
*line 241
.dc.l L40
*line 242
.dc.l L41
*line 242
.dc.l _cp_mtst
*line 242
.dc.l _cx_mtst
*line 242
.dc.l _hs_mtst
*line 243
.dc.l L42
*line 243
.dc.l _cp_null
*line 243
.dc.l _cx_next
*line 243
.dc.l L43
*line 244
.dc.l L44
*line 244
.dc.l _cp_null
*line 244
.dc.l _cx_omap
*line 244
.dc.l L45
*line 247
.dc.l L46
*line 247
.dc.l _cp_read
*line 247
.dc.l _cx_read
*line 247
.dc.l L47
*line 250
.dc.l L48
*line 250
.dc.l _cp_null
*line 250
.dc.l _cx_regs
*line 250
.dc.l L49
*line 251
.dc.l L50
*line 251
.dc.l _cp_null
*line 251
.dc.l _cx_rest
*line 251
.dc.l L51
*line 252
.dc.l L52
*line 252
.dc.l _cp_rset
*line 252
.dc.l _cx_rset
*line 252
.dc.l L53
*line 253
.dc.l L54
*line 253
.dc.l _cp_null
*line 253
.dc.l _cx_vreg
*line 253
.dc.l L55
*line 254
.dc.l L56
*line 254
.dc.l _cp_vrst
*line 254
.dc.l _cx_vrst
*line 254
.dc.l L57
*line 255
.dc.l L58
*line 255
.dc.l _cp_wdmp
*line 255
.dc.l _cx_wdmp
*line 255
.dc.l L59
*line 256
.dc.l L60
*line 256
.dc.l _cp_wfil
*line 256
.dc.l _cx_wfil
*line 256
.dc.l L61
*line 259
.dc.l L62
*line 259
.dc.l _cp_read
*line 259
.dc.l _cx_writ
*line 259
.dc.l L63
*line 262
.dc.l L64
*line 262
.dc.l _cp_wset
*line 262
.dc.l _cx_wset
*line 262
.dc.l L65
*line 263
.dc.l L66
*line 263
.dc.l _cp_null
*line 263
.dc.l _cx_zap
*line 263
.dc.l L67
.globl _ahex
.data
_ahex:
.dc.b $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$61,$62,$63,$64,$65,$66,$41,$42,$43,$44,$45,$46,$0
.even
.globl _rlist
.data
_rlist:
*line 275
.dc.l L69
*line 275
.dc.l L70
*line 275
.dc.l L71
*line 275
.dc.l L72
*line 275
.dc.l L73
*line 275
.dc.l L74
*line 275
.dc.l L75
*line 275
.dc.l L76
*line 276
.dc.l L77
*line 276
.dc.l L78
*line 276
.dc.l L79
*line 276
.dc.l L80
*line 276
.dc.l L81
*line 276
.dc.l L82
*line 276
.dc.l L83
*line 276
.dc.l L84
*line 277
.dc.l L85
*line 277
.dc.l L86
*line 277
.dc.l L87
.dc.l $0
.globl _vrlist
.data
_vrlist:
*line 283
.dc.l L88
*line 283
.dc.l L89
*line 283
.dc.l L90
*line 283
.dc.l L91
*line 283
.dc.l L92
*line 283
.dc.l L93
*line 283
.dc.l L94
*line 283
.dc.l L95
*line 284
.dc.l L96
*line 284
.dc.l L97
*line 284
.dc.l L98
*line 284
.dc.l L99
*line 284
.dc.l L100
*line 284
.dc.l L101
*line 284
.dc.l L102
*line 284
.dc.l L103
*line 285
.dc.l L104
*line 285
.dc.l L105
*line 285
.dc.l L106
*line 285
.dc.l L107
*line 285
.dc.l L108
*line 285
.dc.l L109
*line 285
.dc.l L110
*line 285
.dc.l L111
.dc.l $0
.globl _sigadr
.data
_sigadr:
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $1
.dc.w $1
.dc.w $1
.dc.w $2
.dc.w $2
.dc.w $2
.dc.w $2
.dc.w $2
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $4
.dc.w $4
.dc.w $4
.dc.w $4
.dc.w $7
.dc.w $7
.dc.w $7
.dc.w $7
.dc.w $7
.dc.w $8
.dc.w $8
.dc.w $8
.dc.w $8
.dc.w $8
.dc.w $9
.dc.w $9
.dc.w $9
.dc.w $9
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $11
.dc.w $11
.dc.w $14
.dc.w $14
.dc.w $17
.dc.w $17
.dc.w $1A
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $20
.dc.w $20
.dc.w $20
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $25
.dc.w $25
.dc.w $27
.dc.w $27
.dc.w $27
.dc.w $27
.globl _argsep
.comm _argsep,2
.globl _aptr
.comm _aptr,4
.globl _monptr
.comm _monptr,4
.globl _d_cur
.comm _d_cur,4
.globl _d_next
.comm _d_next,4
.globl _d_last
.comm _d_last,4
.globl _p_end
.comm _p_end,4
.globl _p_from
.comm _p_from,4
.globl _p_goto
.comm _p_goto,4
.globl _p_to
.comm _p_to,4
.globl _sptr
.comm _sptr,4
.globl _argln
.comm _argln,2
.globl _b0flag
.comm _b0flag,2
.globl _b1flag
.comm _b1flag,2
.globl _cmdunit
.comm _cmdunit,2
.globl _dflag
.comm _dflag,2
.globl _exflag
.comm _exflag,2
.globl _first1
.comm _first1,2
.globl _goflag
.comm _goflag,2
.globl _ilast
.comm _ilast,2
.globl _inext
.comm _inext,2
.globl _iplev
.comm _iplev,2
.globl _monsw
.comm _monsw,2
.globl _redo
.comm _redo,2
.globl _rnum
.comm _rnum,2
.globl _vrnum
.comm _vrnum,2
.globl _asig
.comm _asig,2
.globl _aval
.comm _aval,2
.globl _astat
.comm _astat,2
.globl _aflag
.comm _aflag,2
.globl _baseled
.comm _baseled,2
.globl _ledcntr
.comm _ledcntr,2
.globl _sigtab
.comm _sigtab,512
.globl _afi
.comm _afi,4
.globl _ftimer
.comm _ftimer,4
.globl _baron
.comm _baron,2
.globl _baroff
.comm _baroff,2
.globl _swon
.comm _swon,2
.globl _swoff
.comm _swoff,2
.globl _obj0
.comm _obj0,4
.globl _tba0
.comm _tba0,4
.globl _tba1
.comm _tba1,4
.globl _p_bv0
.comm _p_bv0,2
.globl _p_bv1
.comm _p_bv1,2
.globl _p_ba0
.comm _p_ba0,4
.globl _p_ba1
.comm _p_ba1,4
.globl _restart
.comm _restart,60
.globl _p_len
.comm _p_len,4
.globl _p_value
.comm _p_value,4
.globl _p_width
.comm _p_width,4
.globl _regptr
.comm _regptr,4
.globl _argstr
.comm _argstr,82
.globl _cmdline
.comm _cmdline,130
.globl _bfname
.comm _bfname,14
.globl _hs_mtst
.comm _hs_mtst,82
.globl _idbuf
.comm _idbuf,92
.globl _promdate
.comm _promdate,16
.globl _cx_exit
.text
_cx_exit:
~~cx_exit:
link R14,#-4
*line 408
move #1,(sp)
move.l #_restart,-(sp)
jsr _longjmp
addq.l #4,sp
L112:unlk R14
rts
.globl _cx_rest
.text
_cx_rest:
~~cx_rest:
link R14,#-4
*line 420
move.l #$100000,(sp)
jsr _rjumpto
L113:unlk R14
rts
.globl _cx_mlod
.text
_cx_mlod:
~~cx_mlod:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 434
move #1,_B_log_s
*line 435
clr _B_dbg_s
*line 436
clr _redo
*line 438
jsr _hdvini
*line 439
clr __bpbin
*line 441
*line 441
clr.l (sp)
move.l #L115,-(sp)
jsr _booter
addq.l #4,sp
tst R0
beq L116
*line 442
*line 443
clr R0
bra L114
*line 444
bra L117
L116:
*line 445
*line 446
*line 447
clr R7
bra L120
L121:
*line 448
move R7,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l #$0,(R8)
L119:
*line 447
add #1,R7
L120:
*line 447
cmp #8,R7
blt L121
L118:
*line 448
*line 449
*line 450
clr R7
bra L124
L125:
*line 451
move R7,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l #$0,32(R8)
L123:
*line 450
add #1,R7
L124:
*line 450
cmp #7,R7
blt L125
L122:
*line 451
*line 452
*line 453
move.l _regptr,R8
move.l #$ffffe,60(R8)
*line 454
*line 455
move.l _regptr,R8
move #8704,66(R8)
*line 456
move.l _regptr,R8
move.l _B_buf_a,68(R8)
*line 457
*line 458
move #1,R0
bra L114
L117:L114:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _cp_boot
.text
_cp_boot:
~~cp_boot:
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~endc=R6
*line 477
clr _redo
L129:
*line 479
*line 480
*line 481
move.l #L130,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 482
move.l #_bfname,(sp)
move #14,-(sp)
move _cmdunit,-(sp)
jsr _getln
addq.l #4,sp
move.b R0,R6
*line 483
move.l #L131,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 484
*line 485
*line 486
cmp.b #13,R6
beq L127
*line 487
*line 488
*line 488
cmp.b #24,R6
bne L132
*line 489
*line 490
move.l #L133,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 491
clr R0
bra L126
*line 492
*line 493
L132:
*line 494
*line 495
cmp.b #$ffffffff,R6
bne L134
*line 495
move.l #L135,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L134:L128:bra L129
L127:
*line 498
clr R7
bra L138
L139:
*line 499
*line 500
move R7,R8
add.l #_bfname,R8
cmp.b #13,(R8)
bne L140
*line 500
move R7,R8
add.l #_bfname,R8
clr.b (R8)
*line 501
L140:L137:
*line 498
add #1,R7
L138:
*line 498
cmp #14,R7
blt L139
L136:
*line 502
move #1,R0
bra L126
L126:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _cx_boot
.text
_cx_boot:
~~cx_boot:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 519
move #1,_B_log_s
*line 520
clr _B_dbg_s
*line 522
jsr _hdvini
*line 523
clr __bpbin
*line 525
*line 525
clr.l (sp)
move.l #_bfname,-(sp)
jsr _booter
addq.l #4,sp
tst R0
beq L142
*line 526
*line 527
clr R0
bra L141
*line 528
bra L143
L142:
*line 529
*line 530
*line 531
clr R7
bra L146
L147:
*line 532
move R7,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l #$0,(R8)
L145:
*line 531
add #1,R7
L146:
*line 531
cmp #8,R7
blt L147
L144:
*line 532
*line 533
*line 534
clr R7
bra L150
L151:
*line 535
move R7,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l #$0,32(R8)
L149:
*line 534
add #1,R7
L150:
*line 534
cmp #7,R7
blt L151
L148:
*line 535
*line 536
*line 537
move.l _regptr,R8
move.l #$ffffe,60(R8)
*line 538
*line 539
move.l _regptr,R8
move #8704,66(R8)
*line 540
move.l _regptr,R8
move.l _B_buf_a,68(R8)
*line 541
*line 542
move #1,R0
bra L141
L143:L141:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _dobar
.text
_dobar:
~~dobar:
~nb=R7
~bv=R6
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~bp=R13
~i=R5
*line 561
move 8(R14),R7
*line 561
move 10(R14),R6
*line 561
*line 562
cmp #1,R7
blt L152
cmp #82,R7
bgt L152
*line 563
*line 564
sub #1,R7
*line 565
move R7,R0
move R7,R9
add.l R9,R9
add.l #_sigadr,R9
move (R9),R1
add R1,R0
add #4,R0
ext.l R0
asl.l #1,R0
move.l R0,R13
add.l _obj0,R13
add.l #$2800,R13
*line 567
move #127,R5
bra L155
L156:
*line 568
*line 569
*line 569
cmp R6,R5
ble L157
*line 570
*line 571
move _baroff,(R13)
*line 572
add.l #$100,R13
*line 573
move _baroff,(R13)
*line 574
bra L158
L157:
*line 575
*line 576
*line 577
move _baron,(R13)
*line 578
add.l #$100,R13
*line 579
move _baron,(R13)
L158:
*line 580
*line 581
*line 582
add.l #$100,R13
L154:
*line 567
sub #1,R5
L155:
*line 567
tst R5
bge L156
L153:L152:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _dosw
.text
_dosw:
~~dosw:
~nb=R7
~sv=R6
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~bp=R13
~i=R5
~j=R4
*line 601
move 8(R14),R7
*line 601
move 10(R14),R6
*line 601
*line 602
cmp #1,R7
blt L159
cmp #82,R7
bgt L159
*line 603
*line 604
sub #1,R7
*line 605
move R7,R0
move R7,R9
add.l R9,R9
add.l #_sigadr,R9
move (R9),R1
add R1,R0
add #4,R0
ext.l R0
asl.l #1,R0
move.l R0,R13
add.l _obj0,R13
add.l #$12c00,R13
*line 607
*line 608
tst R6
beq L160
*line 608
move _swon,R4
*line 609
bra L161
L160:
*line 610
move _swoff,R4
L161:
*line 612
clr R5
bra L164
L165:
*line 613
*line 614
move R4,(R13)
*line 615
add.l #$100,R13
L163:
*line 612
add #1,R5
L164:
*line 612
cmp #8,R5
blt L165
L162:L159:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _exp_c
.text
_exp_c:
~~exp_c:
~c=8
link R14,#-4
*line 632
and #15,8(R14)
*line 633
clr R0
move 8(R14),R0
lsl #4,R0
or R0,8(R14)
*line 634
clr R0
move 8(R14),R0
lsl #8,R0
or R0,8(R14)
*line 636
clr R0
move 8(R14),R0
bra L166
L166:unlk R14
rts
.globl _cx_adsp
.text
_cx_adsp:
~~cx_adsp:
link R14,#-8
movem.l R2-R7/R13-R13,-(sp)
~xasig=R7
~xastat=R6
~xaval=R5
~xafi=R4
~lc=R3
~bp=R13
~i=-2
~j=-4
~k=-6
~oldi=-8
*line 657
move #256,(sp)
clr -(sp)
move.l #_sigtab,-(sp)
jsr _memsetw
addq.l #6,sp
*line 659
jsr _VHinit
*line 660
jsr _VSinit
*line 661
move.l #_dfltpal,(sp)
jsr _vsndpal
*line 663
move.l #$200400,_obj0
*line 665
move #-1,(sp)
move #1540,-(sp)
clr -(sp)
clr -(sp)
move #350,-(sp)
move #512,-(sp)
move.l _obj0,-(sp)
clr -(sp)
clr -(sp)
clr -(sp)
jsr _SetObj
adda.l #20,sp
*line 667
move.l _obj0,R13
*line 669
clr.l R3
bra L170
L171:
*line 670
clr (R13)+
L169:
*line 669
add.l #$1,R3
L170:
*line 669
cmp.l #$af00,R3
blt L171
L168:
*line 672
move #15,(sp)
jsr _exp_c
and #4095,R0
move R0,_baron
*line 673
move #1,(sp)
jsr _exp_c
and #4095,R0
move R0,_baroff
*line 674
move #13,(sp)
jsr _exp_c
and #4095,R0
move R0,_swon
*line 675
move #1,(sp)
jsr _exp_c
and #4095,R0
move R0,_swoff
*line 677
move #7,(sp)
clr -(sp)
jsr _SetPri
addq.l #2,sp
*line 679
move #1,-2(R14)
bra L174
L175:
*line 680
*line 681
clr (sp)
move -2(R14),-(sp)
jsr _dobar
addq.l #2,sp
*line 682
clr (sp)
move -2(R14),-(sp)
jsr _dosw
addq.l #2,sp
L173:
*line 679
add #1,-2(R14)
L174:
*line 679
cmp #83,-2(R14)
blt L175
L172:
*line 685
move #2,(sp)
jsr _setipl
move R0,-8(R14)
*line 690
bra L178
L177:
*line 691
*line 692
*line 692
move #8,(sp)
jsr _trap14
move.l R0,R4
cmp.l #$ffffffff,R4
beq L179
*line 693
*line 694
move.l R4,R0
asr.l #$8,R0
and.l #$7f,R0
move R0,R7
*line 695
move.l R4,R0
asr.l #$7,R0
and.l #$1,R0
move R0,R6
*line 696
move.l R4,R0
and.l #$7f,R0
move R0,R5
*line 697
*line 698
*line 698
tst R7
beq L180
*line 699
*line 700
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
move R5,(R8)
*line 701
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
move R6,2(R8)
*line 702
*line 703
*line 703
cmp #83,R7
bge L181
*line 704
*line 705
move R5,(sp)
move R7,-(sp)
jsr _dobar
addq.l #2,sp
*line 706
move R6,(sp)
move R7,-(sp)
jsr _dosw
addq.l #2,sp
*line 707
*line 708
L181:bra L182
L180:
*line 709
*line 710
*line 711
clr -2(R14)
bra L185
L186:
*line 712
move -2(R14),R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
clr 2(R8)
L184:
*line 711
add #1,-2(R14)
L185:
*line 711
cmp #83,-2(R14)
blt L186
L183:
*line 712
L182:
*line 713
*line 714
L179:L178:
*line 715
move #2,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
tst.l R0
beq L177
L176:
*line 720
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
*line 722
move #1,-4(R14)
bra L189
L190:
*line 723
*line 724
move -4(R14),R8
add.l R8,R8
add.l R8,R8
move.l #_sigtab,R9
move 0(R8,R9.l),(sp)
move -4(R14),-(sp)
jsr _dobar
addq.l #2,sp
*line 725
move -4(R14),R8
add.l R8,R8
add.l R8,R8
move.l #_sigtab,R9
move 2(R8,R9.l),(sp)
move -4(R14),-(sp)
jsr _dosw
addq.l #2,sp
L188:
*line 722
add #1,-4(R14)
L189:
*line 722
cmp #83,-4(R14)
blt L190
L187:
*line 728
clr -6(R14)
*line 730
move.l #L191,(sp)
jsr _printf
*line 731
move.l #L192,(sp)
jsr _printf
*line 732
move.l #L193,(sp)
jsr _printf
*line 734
clr -2(R14)
bra L196
L197:
*line 735
*line 736
move -6(R14),R0
ext.l R0
divs #10,R0
move R0,(sp)
move.l #L198,-(sp)
jsr _printf
addq.l #4,sp
*line 737
*line 738
clr -4(R14)
bra L201
L202:
*line 739
*line 740
*line 741
tst -6(R14)
beq L203
*line 741
move -6(R14),R8
add.l R8,R8
add.l R8,R8
move.l #_sigtab,R9
move 0(R8,R9.l),(sp)
move -6(R14),R8
add.l R8,R8
add.l R8,R8
move.l #_sigtab,R9
move 2(R8,R9.l),-(sp)
move.l #L204,-(sp)
jsr _printf
addq.l #6,sp
*line 742
bra L205
L203:
*line 743
move.l #L206,(sp)
jsr _printf
L205:
*line 744
*line 745
*line 746
add #1,-6(R14)
move -6(R14),R0
cmp #83,R0
beq L207
L200:
*line 738
add #1,-4(R14)
L201:
*line 738
cmp #10,-4(R14)
blt L202
L199:
*line 747
*line 748
*line 749
move.l #L208,(sp)
jsr _printf
L195:
*line 734
add #1,-2(R14)
L196:
*line 734
cmp #9,-2(R14)
blt L197
L194:L207:
*line 752
*line 753
*line 754
*line 755
*line 756
move 304+_sigtab,(sp)
move 300+_sigtab,-(sp)
move 296+_sigtab,-(sp)
move 292+_sigtab,-(sp)
move.l #L209,-(sp)
jsr _printf
adda.l #10,sp
*line 758
*line 759
*line 760
move 236+_sigtab,(sp)
move 232+_sigtab,-(sp)
move 228+_sigtab,-(sp)
move.l #L210,-(sp)
jsr _printf
addq.l #8,sp
*line 762
*line 763
move 216+_sigtab,(sp)
move 212+_sigtab,-(sp)
move.l #L211,-(sp)
jsr _printf
addq.l #6,sp
*line 765
*line 766
move 224+_sigtab,(sp)
move 220+_sigtab,-(sp)
move.l #L212,-(sp)
jsr _printf
addq.l #6,sp
*line 768
move -8(R14),(sp)
jsr _setipl
*line 769
move #1,R0
bra L167
L167:tst.l (sp)+
movem.l (sp)+,R3-R7/R13-R13
unlk R14
rts
.globl _waitcr
.text
_waitcr:
~~waitcr:
link R14,#-6
~c=-2
*line 788
move #7,(sp)
move #2,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 790
bra L216
L215:
*line 791
*line 792
*line 793
cmp.b #7,-2(R14)
bne L217
*line 793
move #1,R0
bra L213
L217:L216:
*line 794
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$7f,R0
move.b R0,-2(R14)
cmp #13,R0
bne L215
L214:
*line 796
clr R0
bra L213
L213:unlk R14
rts
.globl _xdtoi
.text
_xdtoi:
~~xdtoi:
~c=R7
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~i=R6
~ap=R13
*line 813
move.l #_ahex,R13
*line 815
move 8(R14),R7
*line 815
clr R6
bra L221
L222:
*line 816
*line 817
move.b (R13)+,R0
ext.w R0
cmp R0,R7
bne L223
*line 817
*line 818
cmp #15,R6
ble L224
*line 818
move R6,R0
sub #6,R0
bra L218
*line 819
bra L225
L224:
*line 820
move R6,R0
bra L218
L225:
*line 821
L223:L220:
*line 815
add #1,R6
L221:
*line 815
cmp #22,R6
blt L222
L219:
*line 822
move #-1,R0
bra L218
L218:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _getcmd
.text
_getcmd:
~~getcmd:
link R14,#0
movem.l R6-R7,-(sp)
~c=R7
*line 839
move.l #_cmdline,_sptr
*line 840
clr _argln
*line 841
move.l #_argstr,_aptr
*line 842
move #81,(sp)
clr -(sp)
move.l #_argstr,-(sp)
jsr _memset
addq.l #6,sp
*line 844
L229:
*line 845
*line 846
move.l _sptr,R8
move.b (R8),R0
ext.w R0
move R0,R7
and #255,R7
move R7,R0
bra L231
*line 847
L232:
*line 848
L233:
*line 849
L234:
*line 850
*line 851
*line 852
move.b R7,_argsep
*line 853
move _argln,R0
bra L226
*line 854
L235:
*line 855
*line 856
*line 857
add.l #1,_sptr
*line 858
*line 859
bra L238
L237:
*line 860
add.l #1,_sptr
L238:
*line 860
move.l _sptr,R8
cmp.b #32,(R8)
beq L237
L236:
*line 861
*line 862
*line 863
move.l _sptr,R8
cmp.b #13,(R8)
beq L10000
move.l _sptr,R8
cmp.b #10,(R8)
beq L10000
move.l _sptr,R8
tst.b (R8)
bne L239
L10000:*line 863
move.l _sptr,R8
move.b (R8),R0
ext.w R0
move R0,R7
and #255,R7
*line 864
L239:
*line 865
move.b R7,_argsep
*line 866
move _argln,R0
bra L226
*line 867
*line 868
*line 869
*line 870
L240:
*line 871
*line 872
*line 873
*line 874
move R7,R8
add.l #___atab,R8
btst #3,(R8)
beq L241
*line 874
add #32,R7
*line 875
L241:
*line 876
move R7,R0
move.l _aptr,R9
move.b R0,(R9)
add.l #1,_aptr
*line 877
add.l #1,_sptr
*line 878
add #1,_argln
bra L230
L231:tst R0
beq L232
cmp #10,R0
beq L234
cmp #13,R0
beq L233
cmp #32,R0
beq L235
bra L240
L230:
*line 879
*line 880
L228:
*line 881
move.l _sptr,R8
tst.b (R8)
bne L229
L227:
*line 883
clr.b _argsep
*line 884
move _argln,R0
bra L226
L226:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _getarg
.text
_getarg:
~~getarg:
link R14,#0
movem.l R6-R7,-(sp)
~c=R7
*line 901
clr _argln
*line 902
move.l #_argstr,_aptr
*line 903
move #81,(sp)
clr -(sp)
move.l #_argstr,-(sp)
jsr _memset
addq.l #6,sp
*line 905
L245:
*line 906
*line 907
move.l _sptr,R8
move.b (R8),R0
ext.w R0
move R0,R7
and #255,R7
move R7,R0
bra L247
*line 908
L248:
*line 909
L249:
*line 910
L250:
*line 911
*line 912
*line 913
move.b R7,_argsep
*line 914
move _argln,R0
bra L242
*line 915
L251:
*line 916
*line 917
*line 918
add.l #1,_sptr
*line 919
*line 920
bra L254
L253:
*line 921
add.l #1,_sptr
L254:
*line 921
move.l _sptr,R8
cmp.b #32,(R8)
beq L253
L252:
*line 922
*line 923
*line 924
move.l _sptr,R8
cmp.b #13,(R8)
beq L10001
move.l _sptr,R8
cmp.b #10,(R8)
beq L10001
move.l _sptr,R8
tst.b (R8)
bne L255
L10001:*line 924
move.l _sptr,R8
move.b (R8),R0
ext.w R0
move R0,R7
and #255,R7
*line 925
L255:
*line 926
move.b R7,_argsep
*line 927
move _argln,R0
bra L242
*line 928
L256:
*line 929
*line 930
*line 931
add.l #1,_sptr
*line 932
move.b R7,_argsep
*line 933
move _argln,R0
bra L242
*line 934
*line 935
*line 936
*line 937
L257:
*line 938
*line 939
*line 940
move R7,R0
move.l _aptr,R9
move.b R0,(R9)
add.l #1,_aptr
*line 941
add.l #1,_sptr
*line 942
add #1,_argln
bra L246
L247:ext.l R0
move.l #L258,R8
move #5,R1
L259:cmp.l (R8)+,R0
dbeq R1,L259
move.l 20(R8),R8
jmp (R8)
.data
L258:.dc.l 0
.dc.l 10
.dc.l 13
.dc.l 32
.dc.l 44
.dc.l 0
.dc.l L248
.dc.l L250
.dc.l L249
.dc.l L251
.dc.l L256
.dc.l L257
.text
L246:
*line 943
*line 944
L244:
*line 945
move.l _sptr,R8
tst.b (R8)
bne L245
L243:
*line 947
clr.b _argsep
*line 948
move _argln,R0
bra L242
L242:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _getlong
.text
_getlong:
~~getlong:
~var=8
link R14,#0
movem.l R4-R7,-(sp)
~temp=R7
*line 964
clr.l R7
~csw=R6
*line 965
clr R6
~c=R5
*line 968
*line 968
move.l _aptr,R8
cmp.b #36,(R8)
bne L261
*line 969
*line 970
add.l #1,_aptr
*line 971
*line 972
bra L264
L263:
*line 973
*line 974
move R5,(sp)
jsr _xdtoi
ext.l R0
move.l R7,R1
asl.l #$4,R1
add.l R1,R0
move.l R0,R7
*line 975
move #1,R6
L264:
*line 976
move.l _aptr,R8
move.b (R8),R0
ext.w R0
move R0,R5
move.l #___atab,R8
move.b 0(R8,R5),R0
ext.w R0
and #128,R0
add.l #1,_aptr
tst R0
bne L263
L262:
*line 977
bra L265
L261:
*line 978
*line 979
*line 980
bra L268
L267:
*line 981
*line 982
move.l #$a,-(sp)
move.l R7,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R7
move R5,R0
add #-48,R0
ext.l R0
add.l R0,R7
*line 983
move #1,R6
L268:
*line 984
move.l _aptr,R8
move.b (R8),R0
ext.w R0
move R0,R5
move.l #___atab,R8
move.b 0(R8,R5),R0
ext.w R0
and #4,R0
add.l #1,_aptr
tst R0
bne L267
L266:L265:
*line 987
*line 988
tst R6
beq L269
*line 988
move.l 8(R14),R8
move.l R7,(R8)
*line 989
L269:
*line 990
move R5,R0
bra L260
L260:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _setvar
.text
_setvar:
~~setvar:
~var=8
~deflt=12
link R14,#-10
~rc=-2
~temp=-6
*line 1009
move.l 8(R14),R8
move.l 12(R14),(R8)
*line 1010
move.l #_argstr,_aptr
*line 1012
move.l 8(R14),(sp)
jsr _getlong
move R0,-2(R14)
*line 1014
*line 1014
tst -2(R14)
beq L271
*line 1015
*line 1016
L274:
*line 1017
*line 1018
move -2(R14),R0
bra L276
*line 1019
L277:
*line 1020
*line 1021
*line 1022
clr.l -6(R14)
*line 1023
move.l R14,(sp)
sub.l #6,(sp)
jsr _getlong
move R0,-2(R14)
*line 1024
move.l 8(R14),R8
move.l (R8),R0
add.l -6(R14),R0
move.l 8(R14),R9
move.l R0,(R9)
bra L273
*line 1025
*line 1026
L278:
*line 1027
*line 1028
*line 1029
clr.l -6(R14)
*line 1030
move.l R14,(sp)
sub.l #6,(sp)
jsr _getlong
move R0,-2(R14)
*line 1031
move.l 8(R14),R8
move.l (R8),R0
sub.l -6(R14),R0
move.l 8(R14),R9
move.l R0,(R9)
bra L273
*line 1032
*line 1033
L279:
*line 1034
*line 1035
*line 1036
move.l 8(R14),R8
move.l 12(R14),(R8)
*line 1037
clr R0
bra L270
bra L275
L276:cmp #43,R0
beq L277
cmp #45,R0
beq L278
bra L279
L275:
*line 1038
*line 1039
L273:
*line 1040
tst -2(R14)
bne L274
L272:
*line 1041
*line 1042
move #1,R0
bra L270
*line 1043
*line 1044
L271:
*line 1045
move #1,R0
bra L270
L270:unlk R14
rts
.globl _putn
.text
_putn:
~~putn:
~num=8
~cw=12
~unit=14
link R14,#0
movem.l R6-R7,-(sp)
~d=R7
*line 1063
*line 1064
tst 12(R14)
beq L280
*line 1065
*line 1066
move 14(R14),(sp)
move 12(R14),-(sp)
sub #1,(sp)
move.l #$a,-(sp)
move.l 8(R14),-(sp)
jsr ldiv
addq.l #8,sp
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1068
move.l #$a,-(sp)
move.l 8(R14),-(sp)
jsr lrem
addq.l #8,sp
move R0,R7
*line 1070
move R7,(sp)
add #48,(sp)
move 14(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
bra L280
L280:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _puthn
.text
_puthn:
~~puthn:
~num=8
~cw=12
~unit=14
link R14,#0
movem.l R6-R7,-(sp)
~d=R7
*line 1090
*line 1091
tst 12(R14)
beq L281
*line 1092
*line 1093
move 14(R14),(sp)
move 12(R14),-(sp)
sub #1,(sp)
move.l 8(R14),R0
asr.l #$4,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 1095
move.l 8(R14),R0
and.l #$f,R0
move R0,R7
*line 1097
*line 1098
cmp #9,R7
ble L282
*line 1098
move R7,(sp)
add #55,(sp)
move 14(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1099
bra L283
L282:
*line 1100
move R7,(sp)
add #48,(sp)
move 14(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L283:bra L281
L281:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ddump
.text
_ddump:
~~ddump:
~loc=R13
~lastloc=R12
~nwide=R7
~unit=R6
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
*line 1119
move.l 8(R14),R13
*line 1119
move.l 12(R14),R12
*line 1119
move 16(R14),R7
*line 1119
move 18(R14),R6
*line 1119
bra L287
L286:
*line 1120
*line 1121
move R6,(sp)
move #2,-(sp)
move.b (R13),R0
ext.w R0
and #255,R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 1122
move #32,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1123
*line 1124
*line 1124
move R6,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
tst.l R0
beq L288
*line 1125
*line 1126
move R6,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
*line 1127
move #1,R0
bra L284
*line 1128
*line 1129
L288:
*line 1130
*line 1130
cmp.l R12,R13
bne L289
*line 1131
*line 1132
move #1,_dflag
*line 1133
clr R0
bra L284
*line 1134
*line 1135
L289:
*line 1136
add.l #1,R13
L287:
*line 1137
move R7,R0
sub #1,R7
tst R0
bne L286
L285:
*line 1140
clr R0
bra L284
L284:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.globl _padr
.text
_padr:
~~padr:
~adr=8
~unit=12
link R14,#-4
*line 1156
move 12(R14),(sp)
move #8,-(sp)
move.l 8(R14),-(sp)
jsr _puthn
addq.l #6,sp
*line 1157
move #32,(sp)
move 12(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1158
move #45,(sp)
move 12(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1159
move #32,(sp)
move 12(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L290:unlk R14
rts
.globl _dtext
.text
_dtext:
~~dtext:
~loc=R13
~lastloc=R12
~nwide=R7
~unit=R6
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~c=R5
*line 1178
move.l 8(R14),R13
*line 1178
move.l 12(R14),R12
*line 1178
move 16(R14),R7
*line 1178
move 18(R14),R6
*line 1178
move #32,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1179
move #124,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1181
bra L294
L293:
*line 1182
*line 1183
move.b (R13),R5
ext.w R5
and #255,R5
*line 1184
*line 1185
*line 1186
move R5,R0
and #-128,R0
bne L295
move.l #___atab,R8
move.b 0(R8,R5),R0
ext.w R0
and #94,R0
beq L295
*line 1186
move R5,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1187
bra L296
L295:
*line 1188
move #46,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L296:
*line 1189
*line 1190
*line 1190
move R6,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
tst.l R0
beq L297
*line 1191
*line 1192
move R6,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
*line 1193
move #124,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1194
move #1,R0
bra L291
*line 1195
*line 1196
L297:
*line 1197
*line 1197
cmp.l R12,R13
bne L298
*line 1198
*line 1199
move #124,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1200
clr R0
bra L291
*line 1201
*line 1202
L298:
*line 1203
add.l #1,R13
L294:
*line 1204
move R7,R0
sub #1,R7
tst R0
bne L293
L292:
*line 1206
move #124,(sp)
move R6,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 1207
clr R0
bra L291
L291:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _cp_mset
.text
_cp_mset:
~~cp_mset:
link R14,#-4
*line 1222
clr _redo
*line 1224
*line 1225
jsr _getarg
tst R0
bne L300
*line 1225
clr R0
bra L299
*line 1226
L300:
*line 1227
*line 1228
cmp.b #44,_argsep
beq L301
*line 1228
clr R0
bra L299
*line 1229
L301:
*line 1230
*line 1231
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L302
*line 1231
clr R0
bra L299
*line 1232
L302:
*line 1233
move #1,R0
bra L299
L299:unlk R14
rts
.globl _cx_mset
.text
_cx_mset:
~~cx_mset:
link R14,#-4
*line 1245
bra L306
L305:
*line 1246
*line 1247
*line 1248
jsr _getarg
tst R0
beq L307
*line 1248
*line 1249
move.l _p_value,(sp)
move.l #_p_value,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L308
*line 1249
clr R0
bra L303
*line 1250
L308:L307:
*line 1251
*line 1252
move.l _p_value,R0
and.l #$ffffff00,R0
beq L309
*line 1252
clr R0
bra L303
*line 1253
L309:
*line 1254
move.l _p_value,R0
and.l #$ff,R0
move.l _p_from,R9
move.b R0,(R9)
add.l #1,_p_from
*line 1255
*line 1256
*line 1257
cmp.b #13,_argsep
bne L310
*line 1257
move #1,R0
bra L303
L310:L306:
*line 1258
bra L305
L304:L303:unlk R14
rts
.globl _cp_wset
.text
_cp_wset:
~~cp_wset:
link R14,#-4
*line 1272
clr _redo
*line 1274
*line 1275
jsr _getarg
tst R0
bne L312
*line 1275
clr R0
bra L311
*line 1276
L312:
*line 1277
*line 1278
cmp.b #44,_argsep
beq L313
*line 1278
clr R0
bra L311
*line 1279
L313:
*line 1280
*line 1281
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L314
*line 1281
clr R0
bra L311
*line 1282
L314:
*line 1283
*line 1284
btst #0,3+_p_from
beq L315
*line 1284
clr R0
bra L311
*line 1285
L315:
*line 1286
move #1,R0
bra L311
L311:unlk R14
rts
.globl _cx_wset
.text
_cx_wset:
~~cx_wset:
link R14,#-8
~p_uint=-4
*line 1303
move.l _p_from,-4(R14)
*line 1305
bra L319
L318:
*line 1306
*line 1307
*line 1308
jsr _getarg
tst R0
beq L320
*line 1308
*line 1309
move.l _p_value,(sp)
move.l #_p_value,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L321
*line 1309
clr R0
bra L316
*line 1310
L321:L320:
*line 1311
*line 1312
move.l _p_value,R0
and.l #$ffff0000,R0
beq L322
*line 1312
clr R0
bra L316
*line 1313
L322:
*line 1314
move.l _p_value,R0
move.l -4(R14),R9
move R0,(R9)
add.l #2,-4(R14)
*line 1315
*line 1316
*line 1317
cmp.b #13,_argsep
bne L323
*line 1317
move #1,R0
bra L316
L323:L319:
*line 1318
bra L318
L317:L316:unlk R14
rts
.globl _cp_mtst
.text
_cp_mtst:
~~cp_mtst:
link R14,#-4
*line 1333
move _ilast,_inext
*line 1335
*line 1335
cmp.b #13,_argsep
beq L10002
tst.b _argsep
bne L325
L10002:*line 1336
*line 1337
move.l #$8,_p_from
*line 1338
move.l #$fffe,_p_to
*line 1339
move #1,R0
bra L324
*line 1340
*line 1341
L325:
*line 1342
*line 1343
jsr _getarg
tst R0
beq L326
*line 1343
*line 1344
move.l #$10000,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L327
*line 1344
clr R0
bra L324
*line 1345
L327:L326:
*line 1346
*line 1347
cmp.b #44,_argsep
beq L328
*line 1347
clr R0
bra L324
*line 1348
L328:
*line 1349
*line 1350
jsr _getarg
tst R0
beq L329
*line 1350
*line 1351
move.l #$ffffe,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L330
*line 1351
clr R0
bra L324
*line 1352
L330:L329:
*line 1353
*line 1354
btst #0,3+_p_from
beq L331
*line 1354
clr R0
bra L324
*line 1355
L331:
*line 1356
*line 1357
btst #0,3+_p_to
beq L332
*line 1357
clr R0
bra L324
*line 1358
L332:
*line 1359
*line 1360
move.l _p_from,R0
cmp.l _p_to,R0
bls L333
*line 1360
clr R0
bra L324
*line 1361
L333:
*line 1362
move #1,R0
bra L324
L324:unlk R14
rts
.globl _cx_mtst
.text
_cx_mtst:
~~cx_mtst:
link R14,#0
movem.l R5-R7/R11-R13,-(sp)
~mask=R7
~was=R6
~loc=R13
~eloc=R12
~oldloc=R11
*line 1379
move #1,R7
*line 1380
move.l _p_from,R13
*line 1381
move.l _p_to,R12
*line 1382
move.l R13,R11
*line 1384
*line 1385
move.l _p_from,R0
cmp.l #$10000,R0
bcc L335
*line 1385
move #7,(sp)
jsr _setipl
*line 1386
L335:
*line 1387
L338:
*line 1388
*line 1389
bra L341
L340:
*line 1390
*line 1391
move R7,(R13)
*line 1392
*line 1393
*line 1394
move (R13),R6
cmp R6,R7
beq L342
*line 1394
*line 1395
move.l _p_from,R0
cmp.l #$10000,R0
bcc L343
*line 1395
jsr _halt
*line 1396
bra L344
L343:
*line 1397
*line 1398
move R7,(sp)
move R6,-(sp)
move.l R13,-(sp)
move.l #L345,-(sp)
jsr _printf
adda.l #10,sp
L344:
*line 1399
L342:
*line 1400
move R7,R0
not R0
move R0,(R13)
*line 1401
*line 1402
*line 1403
move (R13),R6
move R7,R0
not R0
cmp R0,R6
beq L346
*line 1403
*line 1404
move.l _p_from,R0
cmp.l #$10000,R0
bcc L347
*line 1404
jsr _halt
*line 1405
bra L348
L347:
*line 1406
*line 1407
move R7,R0
not R0
move R0,(sp)
move R6,-(sp)
move.l R13,-(sp)
move.l #L349,-(sp)
jsr _printf
adda.l #10,sp
L348:
*line 1408
L346:
*line 1409
asl R7
L341:
*line 1410
tst R7
bne L340
L339:
*line 1411
*line 1412
move #1,R7
*line 1413
add.l #2,R13
*line 1414
L337:
*line 1415
cmp.l R12,R13
bls L338
L336:
*line 1417
*line 1418
cmp.l #$10000,R11
bcc L350
*line 1418
move.l #$100000,(sp)
jsr _rjumpto
*line 1419
L350:
*line 1420
move #1,R0
bra L334
L334:tst.l (sp)+
movem.l (sp)+,R6-R7/R11-R13
unlk R14
rts
.globl _cp_go
.text
_cp_go:
~~cp_go:
link R14,#-4
*line 1435
clr _redo
*line 1436
clr _b0flag
*line 1437
clr _b1flag
*line 1438
clr _goflag
*line 1440
*line 1440
jsr _getarg
tst R0
beq L352
*line 1441
*line 1442
*line 1443
move.l _p_goto,(sp)
move.l #_p_goto,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L353
*line 1443
clr R0
bra L351
*line 1444
L353:
*line 1445
*line 1446
btst #0,3+_p_goto
beq L354
*line 1446
clr R0
bra L351
*line 1447
L354:
*line 1448
move #1,_goflag
*line 1449
*line 1450
*line 1451
L352:
*line 1452
*line 1452
jsr _getarg
tst R0
beq L355
*line 1453
*line 1454
*line 1455
clr.l (sp)
move.l #_tba0,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L356
*line 1455
clr R0
bra L351
*line 1456
L356:
*line 1457
*line 1458
btst #0,3+_tba0
beq L357
*line 1458
clr R0
bra L351
*line 1459
L357:
*line 1460
move #1,_b0flag
*line 1461
*line 1462
L355:
*line 1463
*line 1463
jsr _getarg
tst R0
beq L358
*line 1464
*line 1465
*line 1466
clr.l (sp)
move.l #_tba1,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L359
*line 1466
clr R0
bra L351
*line 1467
L359:
*line 1468
*line 1469
btst #0,3+_tba1
beq L360
*line 1469
clr R0
bra L351
*line 1470
L360:
*line 1471
move #1,_b1flag
*line 1472
*line 1473
L358:
*line 1474
move #1,R0
bra L351
L351:unlk R14
rts
.globl _cx_dini
.text
_cx_dini:
~~cx_dini:
link R14,#-4
*line 1491
move #1,_redo
*line 1492
jsr _hdvini
*line 1493
move #1,R0
bra L361
L361:unlk R14
rts
.globl _cx_zap
.text
_cx_zap:
~~cx_zap:
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~p=R13
~q=R12
*line 1509
move.l #$10000,R13
*line 1510
move.l #$ffffe,R12
*line 1512
move #7,(sp)
jsr _setipl
*line 1514
bra L365
L364:
*line 1515
clr (R13)+
L365:
*line 1515
cmp.l R12,R13
bls L364
L363:
*line 1517
move.l #$100000,(sp)
jsr _rjumpto
L362:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _cx_omap
.text
_cx_omap:
~~cx_omap:
link R14,#0
movem.l R4-R7,-(sp)
~i=R7
~width=R6
~xloc=R5
*line 1534
move.l #L367,(sp)
jsr _printf
*line 1536
clr R7
bra L370
L371:
*line 1537
*line 1538
move R7,R0
asl #3,R0
ext.l R0
add.l #_v_odtab,R0
move.l R0,R8
move 2(R8),R5
and #1023,R5
*line 1539
*line 1540
*line 1541
btst #9,R5
beq L372
*line 1541
or #-1024,R5
*line 1542
L372:
*line 1543
move R7,R0
asl #3,R0
ext.l R0
add.l #_v_odtab,R0
move.l R0,R8
move 2(R8),R6
move #10,R0
asr R0,R6
and #63,R6
*line 1544
*line 1545
*line 1546
move R7,R0
asl #3,R0
ext.l R0
add.l #_v_odtab,R0
move.l R0,R8
btst #3,(R8)
beq L10003
move.l #L374,(sp)
bra L10005
L10003:move.l #L375,(sp)
L10005:move R7,-(sp)
move.l #L373,-(sp)
jsr _printf
addq.l #6,sp
*line 1547
*line 1548
*line 1549
move R5,(sp)
move R6,-(sp)
move R7,R0
asl #3,R0
ext.l R0
move.l R0,R8
move.l #_v_odtab,R9
clr R0
move 4(R8,R9.l),R0
swap R0
clr R0
swap R0
asl.l #$1,R0
move.l R0,-(sp)
move.l #L376,-(sp)
jsr _printf
adda.l #10,sp
*line 1550
*line 1551
move R7,R0
asl #3,R0
ext.l R0
move.l R0,R8
move.l #_v_odtab,R9
move 0(R8,R9.l),(sp)
move.l #L377,-(sp)
jsr _printf
addq.l #4,sp
L369:
*line 1536
add #1,R7
L370:
*line 1536
cmp #16,R7
blt L371
L368:
*line 1554
move #1,R0
bra L366
L366:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _cx_help
.text
_cx_help:
~~cx_help:
link R14,#-8
~i=-2
~j=-4
*line 1571
clr -4(R14)
*line 1573
move.l #L379,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1575
clr -2(R14)
bra L382
L383:
*line 1576
*line 1577
*line 1577
cmp #22,-4(R14)
move sr,R0
add #1,-4(R14)
move R0,ccr
bne L384
*line 1578
*line 1579
clr -4(R14)
*line 1580
*line 1581
*line 1582
jsr _waitcr
tst R0
beq L385
*line 1582
move #1,R0
bra L378
L385:
*line 1583
*line 1584
L384:
*line 1585
move.l #L386,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1586
move -2(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 0(R8,R9.l),(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1587
move.l #L387,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1588
move -2(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 12(R8,R9.l),(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1589
move.l #L388,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L381:
*line 1575
add #1,-2(R14)
L382:
*line 1575
cmp #34,-2(R14)
blt L383
L380:
*line 1592
move.l #L389,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1593
move #1,R0
bra L378
L378:unlk R14
rts
.globl _cx_bpb
.text
_cx_bpb:
~~cx_bpb:
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~bpp=R13
*line 1610
*line 1610
clr (sp)
move #7,-(sp)
jsr _trap13
addq.l #2,sp
move.l R0,R13
move.l R13,R0
bne L391
*line 1611
*line 1612
move.l #L392,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1613
clr R0
bra L390
*line 1614
bra L393
L391:
*line 1615
*line 1616
*line 1617
move.l #L394,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1618
move.l #L395,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1619
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move (R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1620
move.l #L396,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1621
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 2(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1622
move.l #L397,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1623
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move 4(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1624
move.l #L398,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1625
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 6(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1626
move.l #L399,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1627
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 8(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1628
move.l #L400,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1629
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move 10(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1630
move.l #L401,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1631
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move 12(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1632
move.l #L402,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1633
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move 14(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1634
move.l #L403,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1635
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 16(R13),R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 1636
move.l #L404,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1637
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 18(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1638
move.l #L405,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1639
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 20(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1640
move.l #L406,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1641
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move 22(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1642
move.l #L407,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1643
move _cmdunit,(sp)
move #5,-(sp)
clr.l R0
move 24(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1644
move.l #L408,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1645
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move 26(R13),R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 1646
move.l #L409,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1647
move #1,R0
bra L390
L393:L390:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _cx_go
.text
_cx_go:
~~cx_go:
link R14,#-4
*line 1663
clr _redo
*line 1664
move #1,_exflag
*line 1665
clr _wzcrsh
*line 1667
*line 1668
tst _goflag
beq L411
*line 1668
move.l _regptr,R8
move.l _p_goto,68(R8)
*line 1669
L411:
*line 1670
*line 1670
tst _b0flag
beq L412
*line 1671
*line 1672
*line 1672
tst.l _p_ba0
beq L413
*line 1673
*line 1674
*line 1674
move.l _p_ba0,R8
cmp #20047,(R8)
beq L414
*line 1675
*line 1676
move.l #L415,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1677
move _cmdunit,(sp)
move #8,-(sp)
move.l _p_ba0,-(sp)
jsr _puthn
addq.l #6,sp
*line 1678
move.l #L416,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1679
move _cmdunit,(sp)
move #4,-(sp)
move.l _p_ba0,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 1680
move.l #L417,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1681
move _cmdunit,(sp)
move #4,-(sp)
move.l #$4e4f,-(sp)
jsr _puthn
addq.l #6,sp
*line 1682
move.l #L418,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1683
*line 1684
L414:
*line 1685
move.l _p_ba0,R8
move _p_bv0,(R8)
*line 1686
*line 1687
L413:
*line 1688
move.l _tba0,_p_ba0
*line 1689
move.l _p_ba0,R8
move (R8),_p_bv0
*line 1690
move.l _p_ba0,R8
move #20047,(R8)
*line 1691
*line 1692
*line 1693
*line 1694
*line 1695
L412:
*line 1696
*line 1696
tst _b1flag
beq L419
*line 1697
*line 1698
*line 1698
tst.l _p_ba1
beq L420
*line 1699
*line 1700
*line 1700
move.l _p_ba1,R8
cmp #20047,(R8)
beq L421
*line 1701
*line 1702
move.l #L422,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1703
move _cmdunit,(sp)
move #8,-(sp)
move.l _p_ba1,-(sp)
jsr _puthn
addq.l #6,sp
*line 1704
move.l #L423,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1705
move _cmdunit,(sp)
move #4,-(sp)
move.l _p_ba1,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 1706
move.l #L424,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1707
move _cmdunit,(sp)
move #4,-(sp)
move.l #$4e4f,-(sp)
jsr _puthn
addq.l #6,sp
*line 1708
move.l #L425,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 1709
*line 1710
L421:
*line 1711
move.l _p_ba1,R8
move _p_bv1,(R8)
*line 1712
*line 1713
L420:
*line 1714
move.l _tba1,_p_ba1
*line 1715
move.l _p_ba1,R8
move (R8),_p_bv1
*line 1716
move.l _p_ba1,R8
move #20047,(R8)
*line 1717
*line 1718
L419:
*line 1719
move #1,R0
bra L410
L410:unlk R14
rts
.globl _cp_dump
.text
_cp_dump:
~~cp_dump:
link R14,#-4
*line 1734
move _ilast,_inext
*line 1736
*line 1737
jsr _getarg
tst R0
beq L427
*line 1737
*line 1737
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L428
*line 1738
*line 1739
clr _redo
*line 1740
clr R0
bra L426
*line 1741
*line 1742
L428:L427:
*line 1743
*line 1743
cmp.b #13,_argsep
beq L10006
tst.b _argsep
bne L429
L10006:*line 1744
*line 1745
move.l _p_from,_p_to
*line 1746
move.l #$10,_p_width
*line 1747
move #1,_redo
*line 1748
move #1,R0
bra L426
*line 1749
*line 1750
L429:
*line 1751
*line 1752
jsr _getarg
tst R0
beq L430
*line 1752
*line 1752
move.l _p_to,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L431
*line 1753
*line 1754
clr _redo
*line 1755
clr R0
bra L426
*line 1756
*line 1757
L431:L430:
*line 1758
*line 1758
cmp.b #13,_argsep
beq L10007
tst.b _argsep
bne L432
L10007:*line 1759
*line 1760
move.l #$10,_p_width
*line 1761
move #1,_redo
*line 1762
move #1,R0
bra L426
*line 1763
*line 1764
L432:
*line 1765
*line 1766
jsr _getarg
tst R0
beq L433
*line 1766
*line 1766
move.l _p_width,(sp)
move.l #_p_width,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L434
*line 1767
*line 1768
clr _redo
*line 1769
clr R0
bra L426
*line 1770
*line 1771
L434:L433:
*line 1772
*line 1772
tst.l _p_width
ble L10008
cmp.l #$10,_p_width
ble L435
L10008:*line 1773
*line 1774
move.l #$10,_p_width
*line 1775
clr _redo
*line 1776
clr R0
bra L426
*line 1777
*line 1778
L435:
*line 1779
move #1,_redo
*line 1780
move #1,R0
bra L426
L426:unlk R14
rts
.globl _cp_fill
.text
_cp_fill:
~~cp_fill:
link R14,#-4
*line 1795
clr _redo
*line 1797
*line 1798
jsr _getarg
tst R0
beq L437
*line 1798
*line 1799
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L438
*line 1799
clr R0
bra L436
*line 1800
L438:L437:
*line 1801
*line 1802
jsr _getarg
tst R0
beq L439
*line 1802
*line 1803
move.l _p_len,(sp)
move.l #_p_len,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L440
*line 1803
clr R0
bra L436
*line 1804
L440:L439:
*line 1805
*line 1806
jsr _getarg
tst R0
beq L441
*line 1806
*line 1807
move.l _p_value,(sp)
move.l #_p_value,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L442
*line 1807
clr R0
bra L436
*line 1808
L442:L441:
*line 1809
*line 1810
move.l _p_value,R0
and.l #$ffffff00,R0
beq L443
*line 1810
clr R0
bra L436
*line 1811
L443:
*line 1812
move #1,R0
bra L436
L436:unlk R14
rts
.globl _cp_wfil
.text
_cp_wfil:
~~cp_wfil:
link R14,#-4
*line 1827
clr _redo
*line 1829
*line 1830
jsr _getarg
tst R0
beq L445
*line 1830
*line 1831
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L446
*line 1831
clr R0
bra L444
*line 1832
L446:L445:
*line 1833
*line 1834
jsr _getarg
tst R0
beq L447
*line 1834
*line 1835
move.l _p_len,(sp)
move.l #_p_len,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L448
*line 1835
clr R0
bra L444
*line 1836
L448:L447:
*line 1837
*line 1838
jsr _getarg
tst R0
beq L449
*line 1838
*line 1839
move.l _p_value,(sp)
move.l #_p_value,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L450
*line 1839
clr R0
bra L444
*line 1840
L450:L449:
*line 1841
*line 1842
btst #0,3+_p_from
beq L451
*line 1842
clr R0
bra L444
*line 1843
L451:
*line 1844
*line 1845
move.l _p_value,R0
and.l #$ffff0000,R0
beq L452
*line 1845
clr R0
bra L444
*line 1846
L452:
*line 1847
move #1,R0
bra L444
L444:unlk R14
rts
.globl _cp_copy
.text
_cp_copy:
~~cp_copy:
link R14,#-4
*line 1862
clr _redo
*line 1864
*line 1865
jsr _getarg
tst R0
beq L454
*line 1865
*line 1866
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L455
*line 1866
clr R0
bra L453
*line 1867
L455:L454:
*line 1868
*line 1869
jsr _getarg
tst R0
beq L456
*line 1869
*line 1870
move.l _p_to,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L457
*line 1870
clr R0
bra L453
*line 1871
L457:L456:
*line 1872
*line 1873
jsr _getarg
tst R0
beq L458
*line 1873
*line 1874
move.l _p_len,(sp)
move.l #_p_len,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L459
*line 1874
clr R0
bra L453
*line 1875
L459:L458:
*line 1876
move #1,R0
bra L453
L453:unlk R14
rts
.globl _cp_chek
.text
_cp_chek:
~~cp_chek:
link R14,#-4
*line 1890
clr _redo
*line 1892
*line 1893
jsr _getarg
tst R0
beq L461
*line 1893
*line 1894
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L462
*line 1894
clr R0
bra L460
*line 1895
L462:L461:
*line 1896
*line 1897
jsr _getarg
tst R0
beq L463
*line 1897
*line 1898
move.l _p_to,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L464
*line 1898
clr R0
bra L460
*line 1899
L464:L463:
*line 1900
move #1,R0
bra L460
L460:unlk R14
rts
.globl _cp_read
.text
_cp_read:
~~cp_read:
link R14,#-4
*line 1915
clr _redo
*line 1917
*line 1918
jsr _getarg
tst R0
beq L466
*line 1918
*line 1919
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L467
*line 1919
clr R0
bra L465
*line 1920
L467:L466:
*line 1921
*line 1922
jsr _getarg
tst R0
beq L468
*line 1922
*line 1923
move.l _p_to,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L469
*line 1923
clr R0
bra L465
*line 1924
L469:L468:
*line 1925
*line 1926
jsr _getarg
tst R0
beq L470
*line 1926
*line 1927
move.l _p_len,(sp)
move.l #_p_len,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L471
*line 1927
clr R0
bra L465
*line 1928
L471:L470:
*line 1929
*line 1930
move.l _p_len,R0
and.l #$ffff8000,R0
beq L472
*line 1930
clr R0
bra L465
*line 1931
L472:
*line 1932
*line 1933
move.l _p_from,R0
and.l #$ffff0000,R0
beq L473
*line 1933
clr R0
bra L465
*line 1934
L473:
*line 1935
move #1,R0
bra L465
L465:unlk R14
rts
.globl _cp_null
.text
_cp_null:
~~cp_null:
link R14,#-4
*line 1947
move #1,R0
bra L474
L474:unlk R14
rts
.globl _cp_rset
.text
_cp_rset:
~~cp_rset:
link R14,#-6
~rc=-2
*line 1964
clr -2(R14)
*line 1965
clr _redo
*line 1967
*line 1968
jsr _getarg
tst R0
bne L476
*line 1968
clr R0
bra L475
*line 1969
L476:
*line 1970
move.l #_argstr,(sp)
jsr _str2lc
*line 1972
*line 1973
move.l #_rlist,(sp)
move.l #_argstr,-(sp)
jsr _strlcmp
addq.l #4,sp
move R0,-2(R14)
bne L477
*line 1973
clr R0
bra L475
*line 1974
L477:
*line 1975
*line 1976
jsr _getarg
tst R0
bne L478
*line 1976
clr R0
bra L475
*line 1977
L478:
*line 1978
*line 1979
clr.l (sp)
move.l #_p_value,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L479
*line 1979
clr R0
bra L475
*line 1980
L479:
*line 1981
move -2(R14),_rnum
*line 1982
move #1,R0
bra L475
L475:unlk R14
rts
.globl _cx_chek
.text
_cx_chek:
~~cx_chek:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~csum=R7
~cp=R13
*line 1999
clr _redo
*line 2000
clr.l R7
*line 2002
move.l _p_from,R13
bra L483
L484:
*line 2003
move.b (R13),R0
ext.w R0
ext.l R0
and.l #$ff,R0
add.l R0,R7
L482:
*line 2002
add.l #1,R13
L483:
*line 2002
cmp.l _p_to,R13
bls L484
L481:
*line 2005
move.l R7,(sp)
move.l #L485,-(sp)
jsr _printf
addq.l #4,sp
*line 2007
move #1,R0
bra L480
L480:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _cx_rset
.text
_cx_rset:
~~cx_rset:
link R14,#-4
*line 2022
clr _redo
*line 2024
*line 2025
cmp #1,_rnum
bge L487
*line 2025
clr R0
bra L486
*line 2026
L487:
*line 2027
*line 2027
cmp #9,_rnum
bge L488
*line 2028
*line 2029
move _rnum,R8
sub #1,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l _p_value,(R8)
*line 2030
move #1,R0
bra L486
*line 2031
*line 2032
L488:
*line 2033
*line 2033
cmp #17,_rnum
bge L489
*line 2034
*line 2035
move _rnum,R8
add #-9,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l _p_value,32(R8)
*line 2036
move #1,R0
bra L486
*line 2037
*line 2038
*line 2039
*line 2040
*line 2041
L489:
*line 2042
*line 2042
cmp #17,_rnum
bne L490
*line 2043
*line 2044
*line 2045
move.l _p_value,R0
and.l #$ffff0000,R0
beq L491
*line 2045
clr R0
bra L486
*line 2046
L491:
*line 2047
move.l _p_value,R0
move.l _regptr,R9
move R0,66(R9)
*line 2048
move #1,R0
bra L486
*line 2049
*line 2050
L490:
*line 2051
*line 2051
cmp #18,_rnum
bne L492
*line 2052
*line 2053
*line 2054
btst #0,3+_p_value
beq L493
*line 2054
clr R0
bra L486
*line 2055
L493:
*line 2056
move.l _regptr,R8
move.l _p_value,68(R8)
*line 2057
move #1,R0
bra L486
*line 2058
*line 2059
L492:
*line 2060
*line 2060
cmp #19,_rnum
bne L494
*line 2061
*line 2062
*line 2063
btst #0,3+_p_value
beq L495
*line 2063
clr R0
bra L486
*line 2064
L495:
*line 2065
move.l _regptr,R8
move.l _p_value,60(R8)
*line 2066
move #1,R0
bra L486
*line 2067
*line 2068
L494:
*line 2069
clr R0
bra L486
L486:unlk R14
rts
.globl _cp_vrst
.text
_cp_vrst:
~~cp_vrst:
link R14,#-6
~rc=-2
*line 2086
clr -2(R14)
*line 2087
clr _redo
*line 2089
*line 2090
jsr _getarg
tst R0
bne L497
*line 2090
clr R0
bra L496
*line 2091
L497:
*line 2092
move.l #_argstr,(sp)
jsr _str2lc
*line 2094
*line 2095
move.l #_vrlist,(sp)
move.l #_argstr,-(sp)
jsr _strlcmp
addq.l #4,sp
move R0,-2(R14)
bne L498
*line 2095
clr R0
bra L496
*line 2096
L498:
*line 2097
*line 2098
jsr _getarg
tst R0
bne L499
*line 2098
clr R0
bra L496
*line 2099
L499:
*line 2100
*line 2101
clr.l (sp)
move.l #_p_value,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L500
*line 2101
clr R0
bra L496
*line 2102
L500:
*line 2103
*line 2103
cmp #17,_vrnum
bge L501
*line 2104
*line 2105
move -2(R14),_vrnum
*line 2106
move #1,R0
bra L496
*line 2107
*line 2108
L501:
*line 2109
*line 2109
cmp #21,_vrnum
bge L502
*line 2110
*line 2111
*line 2112
move.l _p_value,R0
and.l #$ffffffc0,R0
beq L503
*line 2112
clr R0
bra L496
*line 2113
L503:
*line 2114
move -2(R14),_vrnum
*line 2115
move #1,R0
bra L496
*line 2116
*line 2117
L502:
*line 2118
*line 2118
cmp #25,_vrnum
bge L504
*line 2119
*line 2120
*line 2121
move.l _p_value,R0
and.l #$fffffc00,R0
beq L505
*line 2121
clr R0
bra L496
*line 2122
L505:
*line 2123
move -2(R14),_vrnum
*line 2124
move #1,R0
bra L496
*line 2125
*line 2126
L504:
*line 2127
clr R0
bra L496
L496:unlk R14
rts
.globl _cx_vrst
.text
_cx_vrst:
~~cx_vrst:
link R14,#-4
*line 2142
clr _redo
*line 2144
*line 2145
cmp #1,_vrnum
bge L507
*line 2145
clr R0
bra L506
*line 2146
L507:
*line 2147
*line 2147
cmp #17,_vrnum
bge L508
*line 2148
*line 2149
move.l _p_value,R0
move _vrnum,R9
sub #1,R9
add.l R9,R9
add.l #_v_regs,R9
move R0,(R9)
*line 2150
move #1,R0
bra L506
*line 2151
*line 2152
L508:
*line 2153
*line 2153
cmp #21,_vrnum
bge L509
*line 2154
*line 2155
*line 2156
move _vrnum,R8
sub #5,R8
add.l R8,R8
move.l #_v_regs,R9
clr R0
move 0(R8,R9.l),R0
and #1023,R0
swap R0
clr R0
swap R0
move.l _p_value,R1
move.l #$a,R2
asl.l R2,R1
and.l #$fffffc00,R1
or.l R1,R0
move _vrnum,R9
sub #5,R9
add.l R9,R9
add.l #_v_regs,R9
move R0,(R9)
*line 2157
move #1,R0
bra L506
*line 2158
*line 2159
L509:
*line 2160
*line 2160
cmp #25,_vrnum
bge L510
*line 2161
*line 2162
move _vrnum,R8
add #-9,R8
add.l R8,R8
move.l #_v_regs,R9
clr R0
move 0(R8,R9.l),R0
and #-1024,R0
swap R0
clr R0
swap R0
or.l _p_value,R0
move _vrnum,R9
add #-9,R9
add.l R9,R9
add.l #_v_regs,R9
move R0,(R9)
*line 2163
move #1,R0
bra L506
*line 2164
*line 2165
L510:
*line 2166
clr R0
bra L506
L506:unlk R14
rts
.globl _cx_vreg
.text
_cx_vreg:
~~cx_vreg:
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~i=R7
~j=R6
~k=R5
~l=R4
~rp=R13
*line 2184
move.l #_v_regs,R13
*line 2185
clr R4
*line 2187
clr R7
bra L514
L515:
*line 2188
*line 2189
clr R6
bra L518
L519:
*line 2190
*line 2191
clr R5
bra L522
L523:
*line 2192
*line 2193
move.l #L524,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2194
move _cmdunit,(sp)
move #2,-(sp)
move R4,R8
move.l R8,-(sp)
jsr _putn
addq.l #6,sp
add #1,R4
*line 2195
move.l #L525,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2196
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move (R13)+,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
L521:
*line 2191
add #1,R5
L522:
*line 2191
cmp #4,R5
blt L523
L520:
*line 2197
*line 2198
*line 2199
move.l #L526,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L517:
*line 2189
add #1,R6
L518:
*line 2189
cmp #2,R6
blt L519
L516:
*line 2200
*line 2201
*line 2202
move.l #L527,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L513:
*line 2187
add #1,R7
L514:
*line 2187
cmp #2,R7
blt L515
L512:
*line 2205
move #1,R0
bra L511
L511:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _do_srec
.text
_do_srec:
~~do_srec:
~line=R13
link R14,#0
movem.l R2-R7/R12-R13,-(sp)
~ldadr=R12
~c=R7
~csum=R6
~i=R5
~len=R4
~val=R3
*line 2225
move.l 8(R14),R13
*line 2225
*line 2226
move.b (R13)+,R7
ext.w R7
cmp #83,R7
beq L529
*line 2226
move #-1,R0
bra L528
*line 2227
L529:
*line 2228
move.b (R13)+,R7
ext.w R7
move R7,R0
bra L531
*line 2229
L532:
*line 2230
*line 2231
*line 2232
clr R6
*line 2233
*line 2234
*line 2235
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L533
*line 2235
move R7,(sp)
jsr _xdtoi
move R0,R4
*line 2236
bra L534
L533:
*line 2237
move #-2,R0
bra L528
L534:
*line 2238
*line 2239
*line 2240
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L535
*line 2240
move R7,(sp)
jsr _xdtoi
move R4,R1
asl #4,R1
add R1,R0
move R0,R4
*line 2241
bra L536
L535:
*line 2242
move #-2,R0
bra L528
L536:
*line 2243
*line 2244
move R4,R0
and #255,R0
add R0,R6
*line 2245
clr.l R12
*line 2246
sub #4,R4
*line 2247
*line 2248
clr R5
bra L539
L540:
*line 2249
*line 2250
*line 2251
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L541
*line 2251
move R7,(sp)
jsr _xdtoi
move R0,R3
*line 2252
bra L542
L541:
*line 2253
move #-3,R0
bra L528
L542:
*line 2254
*line 2255
*line 2256
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L543
*line 2256
move R7,(sp)
jsr _xdtoi
clr R1
move R3,R1
lsl #4,R1
add R1,R0
move R0,R3
*line 2257
bra L544
L543:
*line 2258
move #-3,R0
bra L528
L544:
*line 2259
*line 2260
move.l R12,R0
asl.l #$8,R0
move.l R0,R12
clr.l R0
move R3,R0
add.l R0,R12
*line 2261
clr R0
move R3,R0
and #255,R0
add R0,R6
L538:
*line 2248
add #1,R5
L539:
*line 2248
cmp #3,R5
blt L540
L537:
*line 2262
*line 2263
*line 2264
clr R5
bra L547
L548:
*line 2265
*line 2266
*line 2267
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L549
*line 2267
move R7,(sp)
jsr _xdtoi
move R0,R3
*line 2268
bra L550
L549:
*line 2269
move #-4,R0
bra L528
L550:
*line 2270
*line 2271
*line 2272
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L551
*line 2272
move R7,(sp)
jsr _xdtoi
clr R1
move R3,R1
lsl #4,R1
add R1,R0
move R0,R3
*line 2273
bra L552
L551:
*line 2274
move #-4,R0
bra L528
L552:
*line 2275
*line 2276
clr R0
move R3,R0
and #255,R0
add R0,R6
*line 2277
clr R0
move R3,R0
and #255,R0
move.b R0,(R12)
*line 2278
*line 2279
*line 2280
move.b (R12),R0
ext.w R0
and #255,R0
clr R1
move R3,R1
and #255,R1
cmp R1,R0
beq L553
*line 2280
move #-5,R0
bra L528
*line 2281
L553:
*line 2282
add.l #1,R12
L546:
*line 2264
add #1,R5
L547:
*line 2264
cmp R4,R5
blt L548
L545:
*line 2283
*line 2284
*line 2285
move R6,R0
not R0
move R0,R6
and #255,R6
*line 2286
*line 2287
*line 2288
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L554
*line 2288
move R7,(sp)
jsr _xdtoi
move R0,R3
*line 2289
bra L555
L554:
*line 2290
move #-6,R0
bra L528
L555:
*line 2291
*line 2292
*line 2293
move.b (R13)+,R7
ext.w R7
move R7,R8
add.l #___atab,R8
btst #7,(R8)
beq L556
*line 2293
move R7,(sp)
jsr _xdtoi
clr R1
move R3,R1
lsl #4,R1
add R1,R0
move R0,R3
*line 2294
bra L557
L556:
*line 2295
move #-6,R0
bra L528
L557:
*line 2296
*line 2297
*line 2298
clr R0
move R3,R0
and #255,R0
cmp R0,R6
beq L558
*line 2298
move #-7,R0
bra L528
*line 2299
L558:
*line 2300
move #1,R0
bra L528
*line 2301
L559:
*line 2302
*line 2303
*line 2304
*line 2305
move #10,(sp)
move.l #L560,-(sp)
move.l R13,-(sp)
jsr _memcmpu
addq.l #8,sp
tst R0
bne L561
*line 2305
clr R0
bra L528
*line 2306
bra L562
L561:
*line 2307
move #-8,R0
bra L528
L562:
*line 2308
L563:
*line 2309
*line 2310
*line 2311
move #-9,R0
bra L528
bra L530
L531:cmp #50,R0
beq L532
cmp #57,R0
beq L559
bra L563
L530:
*line 2314
move #-10,R0
bra L528
L528:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.globl _cx_load
.text
_cx_load:
~~cx_load:
link R14,#0
movem.l R6-R7,-(sp)
~rc=R7
*line 2331
L567:
*line 2332
*line 2333
move.l #_cmdline,(sp)
move #128,-(sp)
move _cmdunit,-(sp)
jsr _getrln
addq.l #4,sp
move R0,R7
*line 2334
*line 2335
move R7,R0
bra L569
*line 2336
L570:
*line 2337
*line 2338
*line 2339
move.l #_cmdline,(sp)
jsr _do_srec
move R0,R7
*line 2340
*line 2341
*line 2341
tst R7
bge L571
*line 2342
*line 2343
move R7,R0
neg R0
move R0,R7
*line 2344
move.l #L572,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2345
move.l #L573,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2346
move _cmdunit,(sp)
move #3,-(sp)
move R7,R8
move.l R8,-(sp)
jsr _putn
addq.l #6,sp
*line 2347
move.l #L574,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2348
clr R0
bra L564
*line 2349
bra L575
L571:
*line 2350
*line 2351
*line 2352
move.l #L576,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L575:
*line 2353
*line 2354
bra L566
*line 2355
*line 2356
L577:
*line 2357
*line 2358
*line 2359
move #1,R7
*line 2360
move.l #L578,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
bra L566
*line 2361
*line 2362
*line 2363
*line 2364
*line 2365
L579:
*line 2366
*line 2367
*line 2368
move.l #L580,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2369
move.l #L581,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2370
move _cmdunit,(sp)
move #2,-(sp)
move R7,-(sp)
jsr _puthn
addq.l #4,sp
*line 2371
move.l #L582,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2372
clr R0
bra L564
bra L568
L569:cmp #13,R0
beq L570
cmp #24,R0
beq L577
bra L579
L568:
*line 2373
*line 2374
L566:
*line 2375
tst R7
bne L567
L565:
*line 2377
move #1,R0
bra L564
L564:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _cx_fill
.text
_cx_fill:
~~cx_fill:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~cp=R13
*line 2392
move.l _p_from,R13
~count=R7
*line 2395
clr _redo
*line 2397
move.l _p_len,R7
bra L586
L587:
*line 2398
*line 2399
move.l _p_value,R0
and.l #$ff,R0
ext.w R0
move.b R0,(R13)
*line 2400
*line 2401
*line 2401
move.l _p_value,R0
and.l #$ff,R0
ext.w R0
cmp.b (R13),R0
beq L588
*line 2402
*line 2403
move.l #L589,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2404
move _cmdunit,(sp)
move #8,-(sp)
move.l R13,-(sp)
jsr _puthn
addq.l #6,sp
*line 2405
move.l #L590,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2406
clr R0
bra L583
*line 2407
*line 2408
L588:
*line 2409
add.l #1,R13
L585:
*line 2397
sub.l #$1,R7
L586:
*line 2397
tst.l R7
bgt L587
L584:
*line 2412
move #1,R0
bra L583
L583:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _cx_wfil
.text
_cx_wfil:
~~cx_wfil:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~cp=R13
*line 2427
move.l _p_from,R13
~count=R7
*line 2430
clr _redo
*line 2432
move.l _p_len,R7
bra L594
L595:
*line 2433
move.l _p_value,R0
and.l #$ffff,R0
move R0,(R13)+
L593:
*line 2432
sub.l #$1,R7
L594:
*line 2432
tst.l R7
bgt L595
L592:
*line 2435
move #1,R0
bra L591
L591:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _cx_copy
.text
_cx_copy:
~~cx_copy:
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~from=R13
*line 2450
move.l _p_from,R13
~to=R12
*line 2451
move.l _p_to,R12
~count=R7
*line 2452
move.l _p_len,R7
*line 2454
clr _redo
*line 2456
*line 2456
cmp.l R13,R12
bls L597
*line 2457
*line 2458
add.l R7,R13
*line 2459
add.l R7,R12
*line 2460
*line 2461
bra L600
L599:
*line 2462
*line 2463
sub.l #1,R13
*line 2464
sub.l #1,R12
*line 2465
move.b (R13),(R12)
*line 2466
*line 2467
*line 2467
move.b (R13),R0
ext.w R0
cmp.b (R12),R0
beq L601
*line 2468
*line 2469
move.l #L602,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2470
move _cmdunit,(sp)
move #8,-(sp)
move.l R13,-(sp)
jsr _puthn
addq.l #6,sp
*line 2471
move.l #L603,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2472
move _cmdunit,(sp)
move #8,-(sp)
move.l R12,-(sp)
jsr _puthn
addq.l #6,sp
*line 2473
move.l #L604,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2474
move _cmdunit,(sp)
move #2,-(sp)
move.b (R13),R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2475
move.l #L605,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2476
move _cmdunit,(sp)
move #2,-(sp)
move.b (R12),R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2477
move.l #L606,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2478
clr R0
bra L596
*line 2479
L601:L600:
*line 2480
move.l R7,R0
sub.l #$1,R7
tst.l R0
bne L599
L598:
*line 2481
*line 2482
*line 2483
*line 2484
bra L607
L597:
*line 2485
*line 2486
*line 2487
bra L610
L609:
*line 2488
*line 2489
move.b (R13),(R12)
*line 2490
*line 2491
*line 2491
move.b (R13),R0
ext.w R0
cmp.b (R12),R0
beq L611
*line 2492
*line 2493
move.l #L612,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2494
move _cmdunit,(sp)
move #8,-(sp)
move.l R13,-(sp)
jsr _puthn
addq.l #6,sp
*line 2495
move.l #L613,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2496
move _cmdunit,(sp)
move #8,-(sp)
move.l R12,-(sp)
jsr _puthn
addq.l #6,sp
*line 2497
move.l #L614,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2498
move _cmdunit,(sp)
move #2,-(sp)
move.b (R13),R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2499
move.l #L615,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2500
move _cmdunit,(sp)
move #2,-(sp)
move.b (R12),R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2501
move.l #L616,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2502
clr R0
bra L596
*line 2503
*line 2504
L611:
*line 2505
add.l #1,R13
*line 2506
add.l #1,R12
L610:
*line 2507
move.l R7,R0
sub.l #$1,R7
tst.l R0
bne L609
L608:L607:
*line 2510
move #1,R0
bra L596
L596:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _cx_dump
.text
_cx_dump:
~~cx_dump:
link R14,#0
movem.l R5-R7,-(sp)
~nw=R7
~rc=R6
*line 2527
move #1,_redo
*line 2528
move.l _p_from,_d_cur
*line 2529
move.l _p_to,R0
add.l #1,R0
move.l R0,_d_next
*line 2530
move.l _p_to,R0
sub.l _p_from,R0
add.l _d_next,R0
move.l R0,_d_last
*line 2531
move.l _p_width,R0
move R0,R7
*line 2532
move #1,R6
*line 2534
L620:
*line 2535
*line 2536
move.l #L621,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2537
move _cmdunit,(sp)
move.l _p_from,-(sp)
jsr _padr
addq.l #4,sp
*line 2538
*line 2539
clr _dflag
*line 2540
*line 2541
*line 2542
move _cmdunit,(sp)
move R7,-(sp)
move.l _p_to,-(sp)
move.l _p_from,-(sp)
jsr _ddump
adda.l #10,sp
tst R0
beq L622
*line 2542
clr R6
*line 2543
L622:
*line 2544
*line 2545
tst R6
beq L623
*line 2545
*line 2546
move _cmdunit,(sp)
move R7,-(sp)
move.l _p_to,-(sp)
move.l _p_from,-(sp)
jsr _dtext
adda.l #10,sp
tst R0
beq L624
*line 2546
clr R6
*line 2547
L624:L623:
*line 2548
move.l _p_from,R0
add.l _p_width,R0
move.l R0,_p_from
*line 2549
*line 2550
*line 2551
tst _dflag
beq L625
*line 2551
clr R6
*line 2552
L625:L619:
*line 2553
tst R6
bne L620
L618:
*line 2555
move.l _d_cur,_p_from
*line 2557
move.l #L626,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2558
move.l #L627,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2560
move #1,R0
bra L617
L617:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _wdump
.text
_wdump:
~~wdump:
~loc=R13
~lastloc=R12
~nwide=16
~unit=18
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
*line 2577
move.l 8(R14),R13
*line 2577
move.l 12(R14),R12
*line 2577
bra L631
L630:
*line 2578
*line 2579
move 18(R14),(sp)
move #4,-(sp)
clr.l R0
move (R13),R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2580
move #32,(sp)
move 18(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 2581
*line 2582
*line 2583
move 18(R14),(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
tst.l R0
beq L632
*line 2583
move #1,R0
bra L628
*line 2584
L632:
*line 2585
*line 2585
cmp.l R12,R13
bne L633
*line 2586
*line 2587
move #1,_dflag
*line 2588
clr R0
bra L628
*line 2589
*line 2590
L633:
*line 2591
add.l #2,R13
L631:
*line 2592
move 16(R14),R0
sub #1,16(R14)
tst R0
bne L630
L629:
*line 2594
clr R0
bra L628
L628:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _ldump
.text
_ldump:
~~ldump:
~loc=R13
~lastloc=R12
~nwide=16
~unit=18
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
*line 2611
move.l 8(R14),R13
*line 2611
move.l 12(R14),R12
*line 2611
bra L637
L636:
*line 2612
*line 2613
move 18(R14),(sp)
move #8,-(sp)
move.l (R13),-(sp)
jsr _puthn
addq.l #6,sp
*line 2614
move #32,(sp)
move 18(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 2615
*line 2616
*line 2617
move 18(R14),(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
tst.l R0
beq L638
*line 2617
move #1,R0
bra L634
*line 2618
L638:
*line 2619
*line 2619
cmp.l R12,R13
bne L639
*line 2620
*line 2621
move #1,_dflag
*line 2622
clr R0
bra L634
*line 2623
*line 2624
L639:
*line 2625
add.l #4,R13
L637:
*line 2626
move 16(R14),R0
sub #1,16(R14)
tst R0
bne L636
L635:
*line 2628
clr R0
bra L634
L634:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _cp_wdmp
.text
_cp_wdmp:
~~cp_wdmp:
link R14,#-4
*line 2643
move _ilast,_inext
*line 2645
*line 2646
jsr _getarg
tst R0
beq L641
*line 2646
*line 2646
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L642
*line 2647
*line 2648
clr _redo
*line 2649
clr R0
bra L640
*line 2650
*line 2651
L642:L641:
*line 2652
*line 2652
btst #0,3+_p_from
beq L643
*line 2653
*line 2654
clr _redo
*line 2655
clr R0
bra L640
*line 2656
*line 2657
L643:
*line 2658
*line 2658
cmp.b #13,_argsep
beq L10009
tst.b _argsep
bne L644
L10009:*line 2659
*line 2660
move.l _p_from,_p_to
*line 2661
move.l #$8,_p_width
*line 2662
move #1,_redo
*line 2663
move #1,R0
bra L640
*line 2664
*line 2665
L644:
*line 2666
*line 2667
jsr _getarg
tst R0
beq L645
*line 2667
*line 2667
move.l _p_to,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L646
*line 2668
*line 2669
clr _redo
*line 2670
clr R0
bra L640
*line 2671
*line 2672
L646:L645:
*line 2673
*line 2673
btst #0,3+_p_to
beq L647
*line 2674
*line 2675
clr _redo
*line 2676
clr R0
bra L640
*line 2677
*line 2678
L647:
*line 2679
*line 2679
cmp.b #13,_argsep
beq L10010
tst.b _argsep
bne L648
L10010:*line 2680
*line 2681
move.l #$8,_p_width
*line 2682
move #1,_redo
*line 2683
move #1,R0
bra L640
*line 2684
*line 2685
L648:
*line 2686
*line 2687
jsr _getarg
tst R0
beq L649
*line 2687
*line 2687
move.l _p_width,(sp)
move.l #_p_width,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L650
*line 2688
*line 2689
clr _redo
*line 2690
clr R0
bra L640
*line 2691
*line 2692
L650:L649:
*line 2693
move #1,_redo
*line 2694
move #1,R0
bra L640
L640:unlk R14
rts
.globl _cp_ldmp
.text
_cp_ldmp:
~~cp_ldmp:
link R14,#-4
*line 2709
move _ilast,_inext
*line 2711
*line 2712
jsr _getarg
tst R0
beq L652
*line 2712
*line 2712
move.l _p_from,(sp)
move.l #_p_from,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L653
*line 2713
*line 2714
clr _redo
*line 2715
clr R0
bra L651
*line 2716
*line 2717
L653:L652:
*line 2718
*line 2718
btst #0,3+_p_from
beq L654
*line 2719
*line 2720
clr _redo
*line 2721
clr R0
bra L651
*line 2722
*line 2723
L654:
*line 2724
*line 2724
cmp.b #13,_argsep
beq L10011
tst.b _argsep
bne L655
L10011:*line 2725
*line 2726
move.l _p_from,_p_to
*line 2727
move.l #$4,_p_width
*line 2728
move #1,_redo
*line 2729
move #1,R0
bra L651
*line 2730
*line 2731
L655:
*line 2732
*line 2733
jsr _getarg
tst R0
beq L656
*line 2733
*line 2733
move.l _p_to,(sp)
move.l #_p_to,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L657
*line 2734
*line 2735
clr _redo
*line 2736
clr R0
bra L651
*line 2737
*line 2738
L657:L656:
*line 2739
*line 2739
btst #0,3+_p_to
beq L658
*line 2740
*line 2741
clr _redo
*line 2742
clr R0
bra L651
*line 2743
*line 2744
L658:
*line 2745
*line 2745
cmp.b #13,_argsep
beq L10012
tst.b _argsep
bne L659
L10012:*line 2746
*line 2747
move.l #$4,_p_width
*line 2748
move #1,_redo
*line 2749
move #1,R0
bra L651
*line 2750
*line 2751
L659:
*line 2752
*line 2753
jsr _getarg
tst R0
beq L660
*line 2753
*line 2753
move.l _p_width,(sp)
move.l #_p_width,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L661
*line 2754
*line 2755
clr _redo
*line 2756
clr R0
bra L651
*line 2757
*line 2758
L661:L660:
*line 2759
move #1,_redo
*line 2760
move #1,R0
bra L651
L651:unlk R14
rts
.globl _cp_ilev
.text
_cp_ilev:
~~cp_ilev:
link R14,#-8
~iplevl=-4
*line 2777
*line 2778
cmp.b #13,_argsep
beq L10013
tst.b _argsep
bne L663
L10013:*line 2778
move #1,R0
bra L662
*line 2779
L663:
*line 2780
*line 2781
jsr _getarg
tst R0
beq L664
*line 2781
*line 2782
move.l -4(R14),(sp)
move.l R14,-(sp)
sub.l #4,(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L665
*line 2782
clr R0
bra L662
*line 2783
L665:L664:
*line 2784
*line 2785
cmp.l #$7,-4(R14)
ble L666
*line 2785
clr R0
bra L662
*line 2786
L666:
*line 2787
move.l -4(R14),R0
move R0,_iplev
*line 2789
move #1,R0
bra L662
L662:unlk R14
rts
.globl _cx_ilev
.text
_cx_ilev:
~~cx_ilev:
link R14,#-4
*line 2801
*line 2801
move _iplev,(sp)
jsr _setipl
cmp #-1,R0
bne L668
*line 2802
*line 2803
move _iplev,(sp)
move.l #L669,-(sp)
jsr _printf
addq.l #4,sp
*line 2804
clr R0
bra L667
*line 2805
bra L670
L668:
*line 2806
move _iplev,(sp)
move.l #L671,-(sp)
jsr _printf
addq.l #4,sp
L670:
*line 2808
move #1,R0
bra L667
L667:unlk R14
rts
.globl _cp_monc
.text
_cp_monc:
~~cp_monc:
link R14,#-4
*line 2823
*line 2824
jsr _getarg
tst R0
beq L673
*line 2824
*line 2825
move.l _monptr,(sp)
move.l #_monptr,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L674
*line 2825
clr R0
bra L672
*line 2826
L674:L673:
*line 2827
move #1,_monsw
*line 2828
move #1,_redo
*line 2829
move #1,R0
bra L672
L672:unlk R14
rts
.globl _cp_mons
.text
_cp_mons:
~~cp_mons:
link R14,#-4
*line 2841
*line 2842
jsr _getarg
tst R0
beq L676
*line 2842
*line 2843
move.l _monptr,(sp)
move.l #_monptr,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L677
*line 2843
clr R0
bra L675
*line 2844
L677:L676:
*line 2845
move #2,_monsw
*line 2846
move #1,_redo
*line 2847
move #1,R0
bra L675
L675:unlk R14
rts
.globl _cp_monl
.text
_cp_monl:
~~cp_monl:
link R14,#-4
*line 2862
*line 2863
jsr _getarg
tst R0
beq L679
*line 2863
*line 2864
move.l _monptr,(sp)
move.l #_monptr,-(sp)
jsr _setvar
addq.l #4,sp
tst R0
bne L680
*line 2864
clr R0
bra L678
*line 2865
L680:L679:
*line 2866
move #4,_monsw
*line 2867
move #1,_redo
*line 2868
move #1,R0
bra L678
L678:unlk R14
rts
.globl _cx_mon
.text
_cx_mon:
~~cx_mon:
link R14,#-4
movem.l R2-R7/R12-R13,-(sp)
~vc=R7
~vcc=R6
~vs=R5
~vss=R4
~vsp=R13
~vl=R3
~vll=-4
~vlp=R12
*line 2887
move _monsw,R0
bra L683
*line 2888
L684:
*line 2889
*line 2890
*line 2891
move.l _monptr,R8
move.b (R8),R7
and.b #255,R7
*line 2892
move _cmdunit,(sp)
move #2,-(sp)
move.b R7,R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2893
move.l #L685,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2894
*line 2895
bra L688
L687:
*line 2896
*line 2897
move.l _monptr,R8
move.b (R8),R6
and.b #255,R6
*line 2898
*line 2899
*line 2899
cmp.b R6,R7
beq L689
*line 2900
*line 2901
move.b R6,R7
*line 2902
move _cmdunit,(sp)
move #2,-(sp)
move.b R7,R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 2903
move.l #L690,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2904
L689:L688:
*line 2905
move #2,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$ffff,R0
beq L687
L686:
*line 2906
*line 2907
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
*line 2908
move #1,R0
bra L681
*line 2909
L691:
*line 2910
*line 2911
*line 2912
move.l _monptr,R13
*line 2913
move (R13),R5
*line 2914
move _cmdunit,(sp)
move #4,-(sp)
move R5,R8
move.l R8,-(sp)
jsr _puthn
addq.l #6,sp
*line 2915
move.l #L692,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2916
*line 2917
bra L695
L694:
*line 2918
*line 2919
move (R13),R4
*line 2920
*line 2921
*line 2921
cmp R4,R5
beq L696
*line 2922
*line 2923
move R4,R5
*line 2924
move _cmdunit,(sp)
move #4,-(sp)
move R5,R8
move.l R8,-(sp)
jsr _puthn
addq.l #6,sp
*line 2925
move.l #L697,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2926
L696:L695:
*line 2927
move #2,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$ffff,R0
beq L694
L693:
*line 2928
*line 2929
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
*line 2930
move #1,R0
bra L681
*line 2931
*line 2932
*line 2933
L698:
*line 2934
*line 2935
*line 2936
move.l _monptr,R12
*line 2937
move.l (R12),R3
*line 2938
move _cmdunit,(sp)
move #8,-(sp)
move.l R3,-(sp)
jsr _puthn
addq.l #6,sp
*line 2939
move.l #L699,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2940
*line 2941
bra L702
L701:
*line 2942
*line 2943
move.l (R12),-4(R14)
*line 2944
*line 2945
*line 2945
cmp.l -4(R14),R3
beq L703
*line 2946
*line 2947
move.l -4(R14),R3
*line 2948
move _cmdunit,(sp)
move #8,-(sp)
move.l R3,-(sp)
jsr _puthn
addq.l #6,sp
*line 2949
move.l #L704,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2950
L703:L702:
*line 2951
move #2,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$ffff,R0
beq L701
L700:
*line 2952
*line 2953
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
*line 2954
move #1,R0
bra L681
*line 2955
L705:
*line 2956
*line 2957
clr R0
bra L681
bra L682
L683:cmp #1,R0
beq L684
cmp #2,R0
beq L691
cmp #4,R0
beq L698
bra L705
L682:L681:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.globl _cx_wdmp
.text
_cx_wdmp:
~~cx_wdmp:
link R14,#-8
~nw=-2
~rc=-4
*line 2975
move.l _p_from,_d_cur
*line 2976
move.l _p_to,R0
add.l #2,R0
move.l R0,_d_next
*line 2977
move.l _p_to,R0
sub.l _p_from,R0
add.l _d_next,R0
move.l R0,_d_last
*line 2978
move.l _p_width,R0
move R0,-2(R14)
*line 2979
move #1,-4(R14)
*line 2981
L709:
*line 2982
*line 2983
move.l #L710,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 2984
move _cmdunit,(sp)
move.l _p_from,-(sp)
jsr _padr
addq.l #4,sp
*line 2985
clr _dflag
*line 2986
*line 2987
*line 2988
move _cmdunit,(sp)
move -2(R14),-(sp)
move.l _p_to,-(sp)
move.l _p_from,-(sp)
jsr _wdump
adda.l #10,sp
tst R0
beq L711
*line 2988
clr -4(R14)
*line 2989
L711:
*line 2990
move.l _p_width,R0
asl.l #$1,R0
add.l _p_from,R0
move.l R0,_p_from
*line 2991
*line 2992
*line 2993
tst _dflag
beq L712
*line 2993
clr -4(R14)
*line 2994
L712:L708:
*line 2995
tst -4(R14)
bne L709
L707:
*line 2997
move.l _d_cur,_p_from
*line 2999
move.l #L713,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3000
move.l #L714,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3001
move #1,R0
bra L706
L706:unlk R14
rts
.globl _cx_ldmp
.text
_cx_ldmp:
~~cx_ldmp:
link R14,#-8
~nw=-2
~rc=-4
*line 3018
move.l _p_from,_d_cur
*line 3019
move.l _p_to,R0
add.l #4,R0
move.l R0,_d_next
*line 3020
move.l _p_to,R0
sub.l _p_from,R0
add.l _d_next,R0
move.l R0,_d_last
*line 3021
move.l _p_width,R0
move R0,-2(R14)
*line 3022
move #1,-4(R14)
*line 3024
L718:
*line 3025
*line 3026
move.l #L719,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3027
move _cmdunit,(sp)
move.l _p_from,-(sp)
jsr _padr
addq.l #4,sp
*line 3028
clr _dflag
*line 3029
*line 3030
*line 3031
move _cmdunit,(sp)
move -2(R14),-(sp)
move.l _p_to,-(sp)
move.l _p_from,-(sp)
jsr _ldump
adda.l #10,sp
tst R0
beq L720
*line 3031
clr -4(R14)
*line 3032
L720:
*line 3033
move.l _p_width,R0
asl.l #$2,R0
add.l _p_from,R0
move.l R0,_p_from
*line 3034
*line 3035
*line 3036
tst _dflag
beq L721
*line 3036
clr -4(R14)
*line 3037
L721:L717:
*line 3038
tst -4(R14)
bne L718
L716:
*line 3040
move.l _d_cur,_p_from
*line 3042
move.l #L722,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3043
move.l #L723,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3044
move #1,R0
bra L715
L715:unlk R14
rts
.globl _do_cmd
.text
_do_cmd:
~~do_cmd:
link R14,#-8
~rc=-2
~i=-4
*line 3063
move.l #L725,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3068
move.l #_cmdline,(sp)
move #128,-(sp)
move _cmdunit,-(sp)
jsr _getln
addq.l #4,sp
move R0,-2(R14)
*line 3075
move -2(R14),R0
bra L727
*line 3076
L728:
*line 3077
*line 3078
*line 3079
move.l #L729,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3080
*line 3081
*line 3081
jsr _getcmd
tst R0
beq L730
*line 3082
*line 3083
clr -4(R14)
bra L733
L734:
*line 3084
*line 3085
*line 3085
move -4(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 0(R8,R9.l),(sp)
move.l #_argstr,-(sp)
jsr _strcmp
addq.l #4,sp
tst R0
bne L735
*line 3086
*line 3087
move -4(R14),_ilast
*line 3088
*line 3089
*line 3089
move -4(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 4(R8,R9.l),R8
jsr (R8)
tst R0
beq L736
*line 3090
*line 3091
*line 3092
move -4(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 8(R8,R9.l),R8
jsr (R8)
tst R0
bne L737
*line 3092
move.l #L738,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3093
L737:bra L739
L736:
*line 3094
*line 3095
*line 3096
move.l #L740,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L739:
*line 3097
*line 3098
bra L724
*line 3099
*line 3100
L735:L732:
*line 3083
add #1,-4(R14)
L733:
*line 3083
cmp #34,-4(R14)
blt L734
L731:
*line 3101
*line 3102
*line 3103
move.l #L741,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
bra L724
*line 3104
*line 3105
bra L742
L730:
*line 3106
*line 3107
*line 3108
*line 3109
*line 3110
*line 3111
*line 3111
tst _redo
beq L743
*line 3112
*line 3113
*line 3114
move _ilast,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 8(R8,R9.l),R8
jsr (R8)
tst R0
bne L744
*line 3114
move.l #L745,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3115
L744:bra L746
L743:
*line 3116
*line 3117
*line 3118
move.l #L747,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L746:
*line 3119
*line 3120
bra L724
*line 3121
L742:
*line 3122
*line 3123
L748:
*line 3124
*line 3125
*line 3126
move.l #L749,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
bra L724
*line 3127
*line 3128
L750:
*line 3129
*line 3130
*line 3131
move.l #L751,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
bra L724
*line 3132
bra L726
L727:cmp #13,R0
beq L728
cmp #24,R0
beq L748
bra L750
L726:
*line 3135
move.l #L752,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
bra L724
L724:unlk R14
rts
.globl _cx_next
.text
_cx_next:
~~cx_next:
link R14,#-4
*line 3151
move.l _d_last,_p_to
*line 3152
move.l _d_next,_p_from
*line 3153
move _inext,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_cmtab,R9
move.l 8(R8,R9.l),R8
jsr (R8)
bra L753
L753:unlk R14
rts
.globl _cx_read
.text
_cx_read:
~~cx_read:
link R14,#-12
~rc=-4
~ns=-6
~recno=-8
*line 3171
move.l _p_len,R0
and.l #$7fff,R0
move R0,-6(R14)
*line 3172
move.l _p_from,R0
and.l #$ffff,R0
move R0,-8(R14)
*line 3174
clr (sp)
move -8(R14),-(sp)
move -6(R14),-(sp)
move.l _p_to,-(sp)
move #2,-(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
move.l R0,-4(R14)
*line 3176
*line 3176
move.l -4(R14),R0
and.l #$ffff,R0
beq L755
*line 3177
*line 3178
move.l #L756,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3179
move _cmdunit,(sp)
move #8,-(sp)
move.l -4(R14),-(sp)
jsr _puthn
addq.l #6,sp
*line 3180
move.l #L757,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3181
clr R0
bra L754
*line 3182
bra L758
L755:
*line 3183
*line 3184
*line 3185
move #1,R0
bra L754
L758:L754:unlk R14
rts
.globl _cx_writ
.text
_cx_writ:
~~cx_writ:
link R14,#-12
~rc=-4
~ns=-6
~recno=-8
*line 3204
move.l _p_len,R0
and.l #$7fff,R0
move R0,-6(R14)
*line 3205
move.l _p_from,R0
and.l #$ffff,R0
move R0,-8(R14)
*line 3207
clr (sp)
move -8(R14),-(sp)
move -6(R14),-(sp)
move.l _p_to,-(sp)
move #3,-(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
move.l R0,-4(R14)
*line 3209
*line 3209
move.l -4(R14),R0
and.l #$ffff,R0
beq L760
*line 3210
*line 3211
move.l #L761,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3212
move _cmdunit,(sp)
move #8,-(sp)
move.l -4(R14),-(sp)
jsr _puthn
addq.l #6,sp
*line 3213
move.l #L762,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3214
clr R0
bra L759
*line 3215
bra L763
L760:
*line 3216
*line 3217
*line 3218
move #1,R0
bra L759
L763:L759:unlk R14
rts
.globl _showrs
.text
_showrs:
~~showrs:
~rp=8
link R14,#-8
~i=-2
~srtemp=-4
*line 3237
move.l #L765,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3239
clr -2(R14)
bra L768
L769:
*line 3240
*line 3241
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3242
move -2(R14),(sp)
add #48,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3243
move.l #L770,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L767:
*line 3239
add #1,-2(R14)
L768:
*line 3239
cmp #8,-2(R14)
blt L769
L766:
*line 3246
move.l #L771,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3248
clr -2(R14)
bra L774
L775:
*line 3249
*line 3250
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3251
move _cmdunit,(sp)
move #8,-(sp)
move.l 8(R14),R8
move -2(R14),R9
add.l R9,R9
add.l R9,R9
move.l 0(R8,R9.l),-(sp)
jsr _puthn
addq.l #6,sp
L773:
*line 3248
add #1,-2(R14)
L774:
*line 3248
cmp #8,-2(R14)
blt L775
L772:
*line 3254
move.l #L776,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3256
clr -2(R14)
bra L779
L780:
*line 3257
*line 3258
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3259
move _cmdunit,(sp)
move #8,-(sp)
move.l 8(R14),R8
move -2(R14),R9
add.l R9,R9
add.l R9,R9
move.l 32(R8,R9.l),-(sp)
jsr _puthn
addq.l #6,sp
L778:
*line 3256
add #1,-2(R14)
L779:
*line 3256
cmp #8,-2(R14)
blt L780
L777:
*line 3262
move.l #L781,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3263
move _cmdunit,(sp)
move #8,-(sp)
move.l 8(R14),R8
move.l 68(R8),-(sp)
jsr _puthn
addq.l #6,sp
*line 3265
move.l 8(R14),R8
move 66(R8),-4(R14)
*line 3266
move.l #L782,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3267
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move -4(R14),R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3272
move.l #L783,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3273
move _cmdunit,(sp)
move #1,-(sp)
clr R0
move -4(R14),R0
lsr #8,R0
swap R0
clr R0
swap R0
move.l R0,-(sp)
and.l #$7,(sp)
jsr _puthn
addq.l #6,sp
*line 3274
move.l #L784,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3276
*line 3277
clr R0
move -4(R14),R0
and #-32768,R0
beq L785
*line 3277
move #84,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3278
bra L786
L785:
*line 3279
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L786:
*line 3281
*line 3282
btst #5,-4(R14)
beq L787
*line 3282
move #83,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3283
bra L788
L787:
*line 3284
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L788:
*line 3286
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3288
*line 3289
btst #4,-3(R14)
beq L789
*line 3289
move #88,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3290
bra L790
L789:
*line 3291
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L790:
*line 3293
*line 3294
btst #3,-3(R14)
beq L791
*line 3294
move #78,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3295
bra L792
L791:
*line 3296
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L792:
*line 3298
*line 3299
btst #2,-3(R14)
beq L793
*line 3299
move #90,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3300
bra L794
L793:
*line 3301
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L794:
*line 3303
*line 3304
btst #1,-3(R14)
beq L795
*line 3304
move #86,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3305
bra L796
L795:
*line 3306
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L796:
*line 3308
*line 3309
btst #0,-3(R14)
beq L797
*line 3309
move #67,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3310
bra L798
L797:
*line 3311
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L798:
*line 3313
move.l #L799,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L764:unlk R14
rts
.globl _showcr
.text
_showcr:
~~showcr:
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~i=R7
~cause=R13
~srtemp=R6
*line 3331
move.l #L801,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3332
move.l #L802,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3334
clr R7
bra L805
L806:
*line 3335
*line 3336
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3337
move R7,(sp)
add #48,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3338
move.l #L807,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L804:
*line 3334
add #1,R7
L805:
*line 3334
cmp #8,R7
blt L806
L803:
*line 3341
move.l #L808,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3343
clr R7
bra L811
L812:
*line 3344
*line 3345
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3346
move _cmdunit,(sp)
move #8,-(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_crshrg,R9
move.l 0(R8,R9.l),-(sp)
jsr _puthn
addq.l #6,sp
L810:
*line 3343
add #1,R7
L811:
*line 3343
cmp #8,R7
blt L812
L809:
*line 3349
move.l #L813,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3351
move #8,R7
bra L816
L817:
*line 3352
*line 3353
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3354
move _cmdunit,(sp)
move #8,-(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_crshrg,R9
move.l 0(R8,R9.l),-(sp)
jsr _puthn
addq.l #6,sp
L815:
*line 3351
add #1,R7
L816:
*line 3351
cmp #16,R7
blt L817
L814:
*line 3357
move.l #L818,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3358
move _cmdunit,(sp)
move #8,-(sp)
move.l _crshpc,-(sp)
jsr _puthn
addq.l #6,sp
*line 3360
move _crshsr,R6
*line 3361
move.l #L819,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3362
move _cmdunit,(sp)
move #4,-(sp)
clr.l R0
move R6,R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3367
move.l #L820,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3368
move _cmdunit,(sp)
move #1,-(sp)
clr R0
move R6,R0
lsr #8,R0
swap R0
clr R0
swap R0
move.l R0,-(sp)
and.l #$7,(sp)
jsr _puthn
addq.l #6,sp
*line 3369
move.l #L821,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3371
*line 3372
clr R0
move R6,R0
and #-32768,R0
beq L822
*line 3372
move #84,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3373
bra L823
L822:
*line 3374
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L823:
*line 3376
*line 3377
btst #13,R6
beq L824
*line 3377
move #83,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3378
bra L825
L824:
*line 3379
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L825:
*line 3381
move #32,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3383
*line 3384
btst #4,R6
beq L826
*line 3384
move #88,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3385
bra L827
L826:
*line 3386
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L827:
*line 3388
*line 3389
btst #3,R6
beq L828
*line 3389
move #78,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3390
bra L829
L828:
*line 3391
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L829:
*line 3393
*line 3394
btst #2,R6
beq L830
*line 3394
move #90,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3395
bra L831
L830:
*line 3396
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L831:
*line 3398
*line 3399
btst #1,R6
beq L832
*line 3399
move #86,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3400
bra L833
L832:
*line 3401
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L833:
*line 3403
*line 3404
btst #0,R6
beq L834
*line 3404
move #67,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3405
bra L835
L834:
*line 3406
move #45,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L835:
*line 3408
move.l #L836,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3412
move.l #L837,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3413
move _cmdunit,(sp)
move #2,-(sp)
move.b _crshvc,R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 3415
move.l #L838,R13
*line 3417
move.b _crshvc,R0
ext.w R0
and #255,R0
bra L840
*line 3418
L841:
*line 3419
*line 3420
*line 3421
move.l #L842,R13
bra L839
*line 3422
*line 3423
L843:
*line 3424
*line 3425
*line 3426
move.l #L844,R13
bra L839
*line 3427
*line 3428
L845:
*line 3429
*line 3430
*line 3431
move.l #L846,R13
bra L839
*line 3432
*line 3433
L847:
*line 3434
*line 3435
*line 3436
move.l #L848,R13
bra L839
*line 3437
*line 3438
L849:
*line 3439
*line 3440
*line 3441
move.l #L850,R13
bra L839
*line 3442
*line 3443
L851:
*line 3444
*line 3445
*line 3446
move.l #L852,R13
bra L839
*line 3447
*line 3448
L853:
*line 3449
*line 3450
*line 3451
move.l #L854,R13
bra L839
*line 3452
*line 3453
L855:
*line 3454
*line 3455
*line 3456
move.l #L856,R13
bra L839
*line 3457
*line 3458
L857:
*line 3459
*line 3460
*line 3461
move.l #L858,R13
bra L839
*line 3462
*line 3463
L859:
*line 3464
*line 3465
*line 3466
move.l #L860,R13
bra L839
*line 3467
*line 3468
L861:
*line 3469
*line 3470
*line 3471
move.l #L862,R13
bra L839
*line 3472
*line 3473
L863:
*line 3474
*line 3475
*line 3476
move.l #L864,R13
bra L839
*line 3477
*line 3478
L865:
*line 3479
*line 3480
*line 3481
move.l #L866,R13
bra L839
*line 3482
*line 3483
L867:
*line 3484
*line 3485
*line 3486
move.l #L868,R13
bra L839
*line 3487
*line 3488
L869:
*line 3489
*line 3490
*line 3491
move.l #L870,R13
bra L839
*line 3492
*line 3493
L871:
*line 3494
*line 3495
*line 3496
move.l #L872,R13
bra L839
*line 3497
*line 3498
L873:
*line 3499
*line 3500
*line 3501
move.l #L874,R13
bra L839
*line 3502
*line 3503
L875:
*line 3504
*line 3505
*line 3506
move.l #L876,R13
bra L839
*line 3507
*line 3508
L877:
*line 3509
*line 3510
*line 3511
move.l #L878,R13
bra L839
*line 3512
*line 3513
bra L839
L840:sub #2,R0
cmp #29,R0
bhi L839
asl #2,R0
move R0,R8
add.l #L879,R8
move.l (R8),R8
jmp (R8)
.data
L879:.dc.l L841
.dc.l L843
.dc.l L845
.dc.l L847
.dc.l L849
.dc.l L851
.dc.l L853
.dc.l L855
.dc.l L857
.dc.l L859
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L861
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L839
.dc.l L863
.dc.l L865
.dc.l L867
.dc.l L869
.dc.l L871
.dc.l L873
.dc.l L875
.dc.l L877
.text
L839:
*line 3516
move.l R13,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3517
move.l #L880,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L800:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _cx_crsh
.text
_cx_crsh:
~~cx_crsh:
link R14,#-4
*line 3532
*line 3533
tst _wzcrsh
bne L882
*line 3533
move.l #L883,(sp)
jsr _printf
*line 3534
L882:
*line 3535
clr _redo
*line 3536
jsr _showcr
*line 3537
move #1,R0
bra L881
L881:unlk R14
rts
.globl _bphit
.text
_bphit:
~~bphit:
link R14,#-6
~rc=-2
*line 3554
clr -2(R14)
*line 3556
*line 3556
move.l _regptr,R8
move.l 68(R8),R0
cmp.l _p_ba0,R0
bne L885
*line 3557
*line 3558
*line 3558
move.l _p_ba0,R8
cmp #20047,(R8)
bne L886
*line 3559
*line 3560
move.l _p_ba0,R8
move _p_bv0,(R8)
*line 3561
clr.l _p_ba0
*line 3562
move #20047,_p_bv0
*line 3563
move #1,-2(R14)
*line 3564
bra L887
L886:
*line 3565
*line 3566
*line 3567
move.l #L888,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3568
move _cmdunit,(sp)
move #8,-(sp)
move.l _p_ba0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3569
move.l #L889,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3570
move _cmdunit,(sp)
move #4,-(sp)
move.l _p_ba0,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3571
move.l #L890,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3572
move _cmdunit,(sp)
move #4,-(sp)
move.l #$4e4f,-(sp)
jsr _puthn
addq.l #6,sp
*line 3573
move.l #L891,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3574
move #1,-2(R14)
L887:
*line 3575
*line 3576
*line 3577
*line 3578
*line 3579
*line 3580
L885:
*line 3581
*line 3581
move.l _regptr,R8
move.l 68(R8),R0
cmp.l _p_ba1,R0
bne L892
*line 3582
*line 3583
*line 3583
move.l _p_ba1,R8
cmp #20047,(R8)
bne L893
*line 3584
*line 3585
move.l _p_ba1,R8
move _p_bv1,(R8)
*line 3586
clr.l _p_ba1
*line 3587
move #20047,_p_bv1
*line 3588
move #1,-2(R14)
*line 3589
bra L894
L893:
*line 3590
*line 3591
*line 3592
move.l #L895,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3593
move _cmdunit,(sp)
move #8,-(sp)
move.l _p_ba0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3594
move.l #L896,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3595
move _cmdunit,(sp)
move #4,-(sp)
move.l _p_ba1,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3596
move.l #L897,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3597
move _cmdunit,(sp)
move #4,-(sp)
move.l #$4e4f,-(sp)
jsr _puthn
addq.l #6,sp
*line 3598
move.l #L898,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3599
move #1,-2(R14)
L894:
*line 3600
*line 3601
*line 3602
*line 3603
L892:
*line 3604
*line 3604
tst.l _p_ba0
beq L899
*line 3605
*line 3606
*line 3606
move.l _p_ba0,R8
cmp #20047,(R8)
bne L900
*line 3607
*line 3608
move.l _p_ba0,R8
move _p_bv0,(R8)
*line 3609
clr.l _p_ba0
*line 3610
move #20047,_p_bv0
*line 3611
move #1,-2(R14)
*line 3612
bra L901
L900:
*line 3613
*line 3614
*line 3615
move.l #L902,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3616
move _cmdunit,(sp)
move #8,-(sp)
move.l _p_ba0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3617
move.l #L903,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3618
move _cmdunit,(sp)
move #4,-(sp)
move.l _p_ba0,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3619
move.l #L904,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3620
move _cmdunit,(sp)
move #4,-(sp)
move.l #$4e4f,-(sp)
jsr _puthn
addq.l #6,sp
*line 3621
move.l #L905,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3622
move #1,-2(R14)
L901:
*line 3623
*line 3624
*line 3625
*line 3626
*line 3627
*line 3628
L899:
*line 3629
*line 3629
tst.l _p_ba1
beq L906
*line 3630
*line 3631
*line 3631
move.l _p_ba1,R8
cmp #20047,(R8)
bne L907
*line 3632
*line 3633
move.l _p_ba1,R8
move _p_bv1,(R8)
*line 3634
clr.l _p_ba1
*line 3635
move #20047,_p_bv1
*line 3636
move #1,-2(R14)
*line 3637
bra L908
L907:
*line 3638
*line 3639
*line 3640
move.l #L909,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3641
move _cmdunit,(sp)
move #8,-(sp)
move.l _p_ba0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3642
move.l #L910,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3643
move _cmdunit,(sp)
move #4,-(sp)
move.l _p_ba1,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
and.l #$ffff,R0
move.l R0,-(sp)
jsr _puthn
addq.l #6,sp
*line 3644
move.l #L911,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3645
move _cmdunit,(sp)
move #4,-(sp)
move.l #$4e4f,-(sp)
jsr _puthn
addq.l #6,sp
*line 3646
move.l #L912,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3647
move #1,-2(R14)
L908:
*line 3648
*line 3649
*line 3650
L906:
*line 3651
*line 3652
tst -2(R14)
beq L913
*line 3652
move -2(R14),R0
bra L884
*line 3653
L913:
*line 3654
move.l #L914,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3655
clr R0
bra L884
L884:unlk R14
rts
.globl _cx_regs
.text
_cx_regs:
~~cx_regs:
link R14,#-4
*line 3670
move.l _regptr,(sp)
jsr _showrs
*line 3671
move #1,R0
bra L915
L915:unlk R14
rts
.globl _rompbp
.text
_rompbp:
~~rompbp:
~d0=8
~d1=12
~d2=16
~d3=20
~d4=24
~d5=28
~d6=32
~d7=36
~a0=40
~a1=44
~a2=48
~a3=52
~a4=56
~a5=60
~a6=64
~a7=68
~sr0=72
~sr=74
~pc=76
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 3690
lea 8(R14),R8
move.l R8,_regptr
*line 3691
sub.l #$2,76(R14)
*line 3693
*line 3694
move _iplev,(sp)
jsr _setipl
cmp #-1,R0
bne L917
*line 3694
move.l #L918,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3695
L917:
*line 3696
*line 3696
tst _first1
beq L919
*line 3697
*line 3698
clr R7
bra L922
L923:
*line 3699
move R7,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l #$0,(R8)
L921:
*line 3698
add #1,R7
L922:
*line 3698
cmp #8,R7
blt L923
L920:
*line 3699
*line 3700
*line 3701
clr R7
bra L926
L927:
*line 3702
move R7,R8
add.l R8,R8
add.l R8,R8
add.l _regptr,R8
move.l #$0,32(R8)
L925:
*line 3701
add #1,R7
L926:
*line 3701
cmp #7,R7
blt L927
L924:
*line 3702
*line 3703
*line 3704
move.l _regptr,R8
move.l #$ffffe,60(R8)
*line 3705
*line 3706
move #8704,74(R14)
*line 3707
add.l #$2,76(R14)
*line 3708
bra L928
L919:
*line 3709
*line 3710
*line 3711
move.l #L929,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3712
*line 3713
move.l _regptr,(sp)
jsr _showrs
*line 3714
*line 3715
*line 3716
jsr _bphit
tst R0
bne L930
*line 3716
add.l #$2,76(R14)
*line 3717
L930:L928:
*line 3720
clr _first1
*line 3721
clr _exflag
*line 3723
L933:
*line 3724
*line 3725
jsr _do_cmd
*line 3726
L932:
*line 3727
tst _exflag
beq L933
L931:bra L916
L916:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _progid
.text
_progid:
~~progid:
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~pcptr=R13
*line 3748
move.l #L935,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3763
move.l #L936,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3764
move.l #L937,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3766
move.l #L938,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 3767
move.l #$100002,R13
*line 3768
move _cmdunit,(sp)
move #2,-(sp)
move.b (R13)+,R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 3769
move #46,(sp)
move _cmdunit,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 3770
move _cmdunit,(sp)
move #2,-(sp)
move.b (R13)+,R0
ext.w R0
ext.l R0
move.l R0,-(sp)
jsr _putn
addq.l #6,sp
*line 3771
move.l #_promdate,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L934:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _pclr
.text
_pclr:
~~pclr:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 3793
move.l #$ea60,_ftimer
*line 3795
bra L942
L941:
*line 3796
*line 3797
move.l _afi,R0
asr.l #$8,R0
and.l #$7f,R0
move R0,_asig
*line 3798
*line 3799
*line 3799
tst _asig
bne L943
*line 3800
*line 3801
*line 3802
*line 3803
clr R7
bra L946
L947:
*line 3804
*line 3805
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
clr (R8)
*line 3806
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
clr 2(R8)
L945:
*line 3803
add #1,R7
L946:
*line 3803
cmp #128,R7
blt L947
L944:
*line 3807
*line 3808
bra L940
*line 3809
*line 3810
*line 3811
L943:
*line 3812
*line 3813
move.l _ftimer,R0
sub.l #$1,_ftimer
tst.l R0
bge L948
*line 3813
move #-1,R0
bra L939
L948:L942:
*line 3814
move #8,(sp)
jsr _trap14
move.l R0,_afi
cmp.l #$ffffffff,R0
bne L941
L940:
*line 3816
clr R0
bra L939
L939:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _pscan
.text
_pscan:
~~pscan:
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~c=R6
*line 3833
*line 3833
move _ledcntr,R0
sub #1,_ledcntr
tst R0
bne L950
*line 3834
*line 3835
*line 3836
move _baseled,R0
add #3,R0
cmp #23,R0
ble L951
*line 3836
move _baseled,R0
add #-21,R0
move.b R0,_io_leds
*line 3837
bra L952
L951:
*line 3838
move _baseled,R0
add #3,R0
move.b R0,_io_leds
L952:
*line 3839
*line 3840
move _baseled,R0
add #128,R0
move.b R0,_io_leds
*line 3841
*line 3842
*line 3843
add #1,_baseled
move _baseled,R0
cmp #23,R0
ble L953
*line 3843
clr _baseled
*line 3844
L953:
*line 3845
move #200,_ledcntr
*line 3846
*line 3847
L950:
*line 3848
clr _aflag
*line 3850
*line 3850
move #8,(sp)
jsr _trap14
move.l R0,_afi
cmp.l #$ffffffff,R0
beq L954
*line 3851
*line 3852
move.l _afi,R0
asr.l #$8,R0
and.l #$7f,R0
move R0,_asig
*line 3853
move.l _afi,R0
asr.l #$7,R0
and.l #$1,R0
move R0,_astat
*line 3854
move.l _afi,R0
and.l #$7f,R0
move R0,_aval
*line 3855
*line 3856
*line 3856
tst _asig
beq L955
*line 3857
*line 3858
move #1,_aflag
*line 3859
*line 3860
move _asig,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
move _aval,(R8)
*line 3861
move _asig,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
move _astat,2(R8)
*line 3862
bra L956
L955:
*line 3863
*line 3864
*line 3865
clr _aflag
*line 3866
*line 3867
clr R7
bra L959
L960:
*line 3868
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
clr 2(R8)
L958:
*line 3867
add #1,R7
L959:
*line 3867
cmp #128,R7
blt L960
L957:
*line 3868
L956:
*line 3869
*line 3870
*line 3871
*line 3872
L954:
*line 3873
*line 3873
tst _aflag
beq L961
*line 3874
*line 3875
*line 3875
tst _astat
beq L962
cmp #39,_asig
bne L962
*line 3876
*line 3877
clr R7
bra L965
L966:
*line 3878
move R7,R0
add #128,R0
move.b R0,_io_leds
L964:
*line 3877
add #1,R7
L965:
*line 3877
cmp #24,R7
blt L966
L963:
*line 3878
*line 3879
*line 3880
move.b #31,_io_leds
*line 3881
*line 3882
*line 3883
*line 3884
clr _B_log_s
*line 3885
clr _B_dbg_s
*line 3886
*line 3887
jsr _hdvini
*line 3888
clr __bpbin
*line 3889
*line 3890
*line 3891
clr.l (sp)
move.l #L967,-(sp)
jsr _booter
addq.l #4,sp
tst R0
beq L968
*line 3891
clr R0
bra L949
*line 3892
bra L969
L968:
*line 3893
move.l #$ffffe,(sp)
move.l _B_buf_a,-(sp)
jsr _sjumpto
addq.l #4,sp
L969:
*line 3894
bra L970
L962:
*line 3895
*line 3895
tst _astat
beq L971
cmp #40,_asig
bne L971
*line 3896
*line 3897
clr R7
bra L974
L975:
*line 3898
move R7,R0
add #128,R0
move.b R0,_io_leds
L973:
*line 3897
add #1,R7
L974:
*line 3897
cmp #24,R7
blt L975
L972:
*line 3898
*line 3899
*line 3900
move #1,R0
bra L949
*line 3901
L971:L970:
*line 3902
*line 3903
*line 3904
*line 3905
*line 3906
L961:
*line 3907
*line 3907
move #2,(sp)
move #1,-(sp)
jsr _trap13
addq.l #2,sp
tst.l R0
beq L976
*line 3908
*line 3909
move #2,(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$7f,R0
move R0,R6
*line 3910
*line 3911
*line 3912
cmp #114,R6
beq L10014
cmp #82,R6
bne L977
L10014:*line 3912
move #1,R0
bra L949
L977:
*line 3913
*line 3914
L976:
*line 3915
clr R0
bra L949
L949:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _main
.text
_main:
~~main:
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~i=R7
~pdptr=R13
~pcptr=R12
*line 3935
move.l #$100008,R12
*line 3936
move.l #_promdate,R13
*line 3937
move.b #32,(R13)+
*line 3938
move.b #45,(R13)+
*line 3939
move.b #45,(R13)+
*line 3940
move.b #32,(R13)+
*line 3941
move.b (R12),R0
ext.w R0
asr #4,R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3942
move.b (R12)+,R0
ext.w R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3943
move.b (R12),R0
ext.w R0
asr #4,R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3944
move.b (R12)+,R0
ext.w R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3945
move.b #45,(R13)+
*line 3946
move.b (R12),R0
ext.w R0
asr #4,R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3947
move.b (R12)+,R0
ext.w R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3948
move.b #45,(R13)+
*line 3949
move.b (R12),R0
ext.w R0
asr #4,R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3950
move.b (R12)+,R0
ext.w R0
and #15,R0
add #48,R0
move.b R0,(R13)+
*line 3951
clr.b (R13)+
*line 3955
*line 3956
move.l #$fffe,(sp)
move.l #$ffffe,-(sp)
move.l #$10000,-(sp)
move.l #L979,-(sp)
move.l #_hs_mtst,-(sp)
jsr _sprintf
adda.l #16,sp
*line 3958
move #2,_cmdunit
*line 3960
clr _ilast
*line 3961
clr _inext
*line 3962
move #2,_iplev
*line 3964
clr _dflag
*line 3965
clr _exflag
*line 3966
clr _redo
*line 3967
clr _goflag
*line 3968
clr _b0flag
*line 3969
clr _b1flag
*line 3971
move.l #$100000,_p_goto
*line 3972
clr.l _p_len
*line 3973
move.l #$10,_p_width
*line 3974
clr.l _p_value
*line 3976
clr.l _p_ba0
*line 3977
move #20047,_p_bv0
*line 3979
clr.l _p_ba1
*line 3980
move #20047,_p_bv1
*line 3982
clr.l _tba0
*line 3983
clr.l _tba1
*line 3985
clr _inext
*line 3987
jsr _tsetup
*line 3990
move #21,_baseled
*line 3991
clr _ledcntr
*line 3992
move.b #159,_io_leds
*line 3993
jsr _GLCinit
*line 3995
move.l #L980,(sp)
move #1,-(sp)
clr -(sp)
jsr _GLCtext
addq.l #4,sp
*line 3996
move.l #L981,(sp)
move #1,-(sp)
move #1,-(sp)
jsr _GLCtext
addq.l #4,sp
*line 3998
move.l #L982,(sp)
move #15,-(sp)
move #3,-(sp)
jsr _GLCtext
addq.l #4,sp
*line 4000
*line 4001
move.l #_promdate,(sp)
move.b $100003,R0
ext.w R0
move R0,-(sp) 
move.b $100002,R0
ext.w R0
move R0,-(sp) 
move.l #L983,-(sp)
move.l #_idbuf,-(sp)
jsr _sprintf
adda.l #12,sp
*line 4002
move.l #_idbuf,(sp)
move #30,-(sp)
move #5,-(sp)
jsr _GLCtext
addq.l #4,sp
*line 4004
move.l #L985,(sp)
move.l #L984,-(sp)
move.l #_idbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 4005
move.l #_idbuf,(sp)
move #30,-(sp)
move #6,-(sp)
jsr _GLCtext
addq.l #4,sp
*line 4006
clr (sp)
clr -(sp)
jsr _GLCcrc
addq.l #2,sp
*line 4008
move.l #_trap15,(sp)
move #47,-(sp)
move #5,-(sp)
jsr _trap13
addq.l #4,sp
*line 4010
clr R7
bra L988
L989:
*line 4011
*line 4012
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
clr (R8)
*line 4013
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_sigtab,R8
clr 2(R8)
L987:
*line 4010
add #1,R7
L988:
*line 4010
cmp #128,R7
blt L989
L986:
*line 4016
move #9,(sp)
jsr _trap14
*line 4017
move #2,(sp)
jsr _setipl
*line 4018
jsr _pclr
*line 4019
move #9,(sp)
jsr _trap14
*line 4021
bra L992
L991:L992:
*line 4021
jsr _pscan
tst R0
beq L991
L990:
*line 4026
*line 4027
move.l #_restart,(sp)
jsr _setjmp
tst R0
beq L993
*line 4027
move.l #L994,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 4028
L993:
*line 4029
jsr _tsetup
*line 4030
jsr _progid
*line 4032
move.l #_trap15,(sp)
move #47,-(sp)
move #5,-(sp)
jsr _trap13
addq.l #4,sp
*line 4033
move.l #L995,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
*line 4037
move #1,_first1
*line 4039
bra L998
L997:
*line 4040
*line 4041
jsr _xtrap15
*line 4042
move.l #L999,(sp)
move _cmdunit,-(sp)
jsr _writeln
addq.l #2,sp
L998:
*line 4043
bra L997
L996:L978:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
L1:.dc.b $61,$64,$69,$73,$70,$0
L2:.dc.b $0
L3:.dc.b $62,$6F,$6F,$74,$0
L4:.dc.b $0
L5:.dc.b $62,$70,$62,$0
L6:.dc.b $0
L7:.dc.b $63,$68,$65,$63,$6B,$0
L8:.dc.b $73,$74,$61,$72,$74,$2C,$65,$6E,$64,$0
L9:.dc.b $63,$6F,$70,$79,$0
L10:.dc.b $66,$72,$6F,$6D,$2C,$74,$6F,$2C,$6C,$65,$6E,$0
L11:.dc.b $63,$72,$61,$73,$68,$0
L12:.dc.b $0
L13:.dc.b $64,$69,$6E,$69,$74,$0
L14:.dc.b $0
L15:.dc.b $64,$75,$6D,$70,$0
L16:.dc.b $66,$72,$6F,$6D,$5B,$2C,$5B,$74,$6F,$3D,$66,$72,$6F,$6D,$5D,$5B,$2C,$77,$69,$64,$74,$68,$3D,$31,$36,$5D,$5D,$0
L17:.dc.b $65,$78,$69,$74,$0
L18:.dc.b $0
L19:.dc.b $66,$69,$6C,$6C,$0
L20:.dc.b $6C,$6F,$63,$2C,$63,$6F,$75,$6E,$74,$2C,$62,$79,$74,$65,$0
L21:.dc.b $67,$6F,$0
L22:.dc.b $5B,$61,$64,$64,$72,$5D,$5B,$2C,$5B,$62,$72,$6B,$31,$5D,$5B,$2C,$62,$72,$6B,$32,$5D,$5D,$0
L23:.dc.b $68,$65,$6C,$70,$0
L24:.dc.b $0
L25:.dc.b $69,$70,$6C,$0
L26:.dc.b $6C,$65,$76,$65,$6C,$0
L27:.dc.b $6C,$64,$75,$6D,$70,$0
L28:.dc.b $66,$72,$6F,$6D,$5B,$2C,$5B,$74,$6F,$3D,$66,$72,$6F,$6D,$5D,$5B,$2C,$77,$69,$64,$74,$68,$3D,$34,$5D,$5D,$0
L29:.dc.b $6C,$6F,$61,$64,$0
L30:.dc.b $0
L31:.dc.b $6D,$69,$64,$61,$73,$0
L32:.dc.b $0
L33:.dc.b $6D,$6F,$6E,$63,$0
L34:.dc.b $61,$64,$64,$72,$0
L35:.dc.b $6D,$6F,$6E,$73,$0
L36:.dc.b $61,$64,$64,$72,$0
L37:.dc.b $6D,$6F,$6E,$6C,$0
L38:.dc.b $61,$64,$64,$72,$0
L39:.dc.b $6D,$73,$65,$74,$0
L40:.dc.b $61,$64,$64,$72,$2C,$62,$31,$5B,$2C,$2E,$2E,$2E,$2C,$62,$6E,$5D,$0
L41:.dc.b $6D,$74,$65,$73,$74,$0
L42:.dc.b $6E,$65,$78,$74,$0
L43:.dc.b $0
L44:.dc.b $6F,$62,$6D,$61,$70,$0
L45:.dc.b $0
L46:.dc.b $72,$65,$61,$64,$0
L47:.dc.b $73,$65,$63,$74,$6F,$72,$2C,$62,$75,$66,$66,$65,$72,$2C,$63,$6F,$75,$6E,$74,$0
L48:.dc.b $72,$65,$67,$73,$0
L49:.dc.b $0
L50:.dc.b $72,$65,$73,$65,$74,$0
L51:.dc.b $0
L52:.dc.b $72,$73,$65,$74,$0
L53:.dc.b $72,$65,$67,$69,$73,$74,$65,$72,$2C,$76,$61,$6C,$75,$65,$0
L54:.dc.b $76,$72,$65,$67,$73,$0
L55:.dc.b $0
L56:.dc.b $76,$72,$73,$65,$74,$0
L57:.dc.b $72,$65,$67,$69,$73,$74,$65,$72,$2C,$76,$61,$6C,$75,$65,$0
L58:.dc.b $77,$64,$75,$6D,$70,$0
L59:.dc.b $66,$72,$6F,$6D,$5B,$2C,$5B,$74,$6F,$3D,$66,$72,$6F,$6D,$5D,$5B,$2C,$77,$69,$64,$74,$68,$3D,$38,$5D,$5D,$0
L60:.dc.b $77,$66,$69,$6C,$6C,$0
L61:.dc.b $6C,$6F,$63,$2C,$63,$6F,$75,$6E,$74,$2C,$77,$6F,$72,$64,$0
L62:.dc.b $77,$72,$69,$74,$65,$0
L63:.dc.b $73,$65,$63,$74,$6F,$72,$2C,$62,$75,$66,$66,$65,$72,$2C,$63,$6F,$75,$6E,$74,$0
L64:.dc.b $77,$73,$65,$74,$0
L65:.dc.b $61,$64,$64,$72,$2C,$77,$31,$5B,$2C,$2E,$2E,$2E,$2C,$77,$6E,$5D,$0
L66:.dc.b $7A,$61,$70,$0
L67:.dc.b $0
L69:.dc.b $64,$30,$0
L70:.dc.b $64,$31,$0
L71:.dc.b $64,$32,$0
L72:.dc.b $64,$33,$0
L73:.dc.b $64,$34,$0
L74:.dc.b $64,$35,$0
L75:.dc.b $64,$36,$0
L76:.dc.b $64,$37,$0
L77:.dc.b $61,$30,$0
L78:.dc.b $61,$31,$0
L79:.dc.b $61,$32,$0
L80:.dc.b $61,$33,$0
L81:.dc.b $61,$34,$0
L82:.dc.b $61,$35,$0
L83:.dc.b $61,$36,$0
L84:.dc.b $61,$37,$0
L85:.dc.b $73,$72,$0
L86:.dc.b $70,$63,$0
L87:.dc.b $73,$70,$0
L88:.dc.b $72,$30,$0
L89:.dc.b $72,$31,$0
L90:.dc.b $72,$32,$0
L91:.dc.b $72,$33,$0
L92:.dc.b $72,$34,$0
L93:.dc.b $72,$35,$0
L94:.dc.b $72,$36,$0
L95:.dc.b $72,$37,$0
L96:.dc.b $72,$38,$0
L97:.dc.b $72,$39,$0
L98:.dc.b $72,$31,$30,$0
L99:.dc.b $72,$31,$31,$0
L100:.dc.b $72,$31,$32,$0
L101:.dc.b $72,$31,$33,$0
L102:.dc.b $72,$31,$34,$0
L103:.dc.b $72,$31,$35,$0
L104:.dc.b $68,$30,$0
L105:.dc.b $68,$31,$0
L106:.dc.b $68,$32,$0
L107:.dc.b $68,$33,$0
L108:.dc.b $76,$30,$0
L109:.dc.b $76,$31,$0
L110:.dc.b $76,$32,$0
L111:.dc.b $76,$33,$0
L115:.dc.b $6D,$69,$64,$61,$73,$2E,$61,$62,$73,$0
L130:.dc.b $46,$69,$6C,$65,$20,$6E,$61,$6D,$65,$3A,$20,$0
L131:.dc.b $D,$A,$0
L133:.dc.b $D,$A,$2D,$2D,$2D,$2D,$2D,$20,$43,$61,$6E,$63,$65,$6C,$6C,$65,$64,$20,$2D,$2D,$2D,$2D,$2D,$D,$A,$0
L135:.dc.b $D,$A,$2A,$2A,$20,$49,$6E,$76,$61,$6C,$69,$64,$20,$70,$61,$72,$61,$6D,$65,$74,$65,$72,$20,$2A,$2A,$D,$A,$0
L191:.dc.b $A,$0
L192:.dc.b $20,$20,$20,$20,$20,$20,$20,$78,$30,$20,$20,$20,$20,$20,$78,$31,$20,$20,$20,$20,$20,$78,$32,$20,$20,$20,$20,$20,$78,$33
.dc.b $20,$20,$20,$20,$20,$78,$34,$20,$20,$20,$20,$20,$78,$35,$20,$20,$20,$20,$20,$78,$36,$20,$20,$20,$20,$20,$78,$37,$20,$20
.dc.b $20,$20,$20,$78,$38,$20,$20,$20,$20,$20,$78,$39,$D,$A,$0
L193:.dc.b $20,$20,$20,$20,$20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D
.dc.b $2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$20
.dc.b $20,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$D,$A,$0
L198:.dc.b $25,$30,$31,$64,$78,$20,$20,$20,$0
L204:.dc.b $25,$31,$64,$3A,$25,$33,$64,$20,$20,$0
L206:.dc.b $20,$20,$20,$20,$20,$20,$20,$0
L208:.dc.b $A,$0
L209:.dc.b $A,$54,$65,$6D,$70,$6F,$20,$20,$20,$20,$20,$3D,$20,$25,$33,$64,$2C,$20,$20,$54,$69,$6D,$65,$20,$20,$20,$20,$20,$20,$3D
.dc.b $20,$25,$33,$64,$2C,$20,$20,$54,$75,$6E,$69,$6E,$67,$20,$3D,$20,$25,$33,$64,$2C,$20,$20,$4C,$65,$76,$65,$6C,$20,$3D,$20
.dc.b $25,$33,$64,$A,$0
L210:.dc.b $4C,$6F,$6E,$67,$50,$6F,$74,$20,$4C,$20,$3D,$20,$25,$33,$64,$2C,$20,$20,$4C,$6F,$6E,$67,$50,$6F,$74,$20,$52,$20,$3D,$20
.dc.b $25,$33,$64,$2C,$20,$20,$53,$63,$72,$6F,$6C,$6C,$20,$3D,$20,$25,$33,$64,$A,$0
L211:.dc.b $54,$61,$62,$6C,$65,$74,$20,$58,$20,$20,$3D,$20,$25,$33,$64,$2C,$20,$20,$54,$61,$62,$6C,$65,$74,$20,$59,$20,$20,$3D,$20
.dc.b $25,$33,$64,$A,$0
L212:.dc.b $43,$75,$72,$73,$6F,$72,$20,$58,$20,$20,$3D,$20,$25,$33,$64,$2C,$20,$20,$43,$75,$72,$73,$6F,$72,$20,$59,$20,$20,$3D,$20
.dc.b $25,$33,$64,$A,$0
L345:.dc.b $25,$30,$38,$6C,$58,$20,$77,$61,$73,$20,$25,$30,$34,$58,$2C,$20,$65,$78,$70,$65,$63,$74,$65,$64,$20,$25,$30,$34,$58,$D
.dc.b $A,$0
L349:.dc.b $25,$30,$38,$6C,$58,$20,$77,$61,$73,$20,$25,$30,$34,$58,$2C,$20,$65,$78,$70,$65,$63,$74,$65,$64,$20,$25,$30,$34,$58,$D
.dc.b $A,$0
L367:.dc.b $50,$72,$20,$42,$2F,$43,$20,$4C,$6F,$63,$6E,$20,$20,$20,$20,$20,$20,$57,$64,$20,$58,$6C,$6F,$63,$20,$46,$6C,$61,$67,$73
.dc.b $D,$A,$0
L373:.dc.b $25,$32,$64,$20,$25,$73,$20,$0
L374:.dc.b $43,$68,$72,$0
L375:.dc.b $42,$69,$74,$0
L376:.dc.b $24,$25,$30,$38,$6C,$58,$20,$25,$32,$64,$20,$25,$34,$64,$20,$0
L377:.dc.b $24,$25,$30,$34,$58,$D,$A,$0
L379:.dc.b $D,$A,$0
L386:.dc.b $20,$20,$20,$20,$20,$0
L387:.dc.b $20,$20,$0
L388:.dc.b $D,$A,$0
L389:.dc.b $D,$A,$0
L392:.dc.b $D,$A,$A,$45,$52,$52,$4F,$52,$20,$2D,$2D,$20,$55,$6E,$61,$62,$6C,$65,$20,$74,$6F,$20,$72,$65,$61,$64,$20,$42,$50,$42
.dc.b $D,$A,$A,$0
L394:.dc.b $D,$A,$A,$42,$50,$42,$20,$76,$61,$6C,$75,$65,$73,$3A,$D,$A,$0
L395:.dc.b $D,$A,$20,$20,$20,$72,$65,$63,$73,$69,$7A,$20,$20,$20,$0
L396:.dc.b $D,$A,$20,$20,$20,$63,$6C,$73,$69,$7A,$20,$20,$20,$20,$20,$0
L397:.dc.b $D,$A,$20,$20,$20,$63,$6C,$73,$69,$7A,$62,$20,$20,$20,$0
L398:.dc.b $D,$A,$20,$20,$20,$72,$64,$6C,$65,$6E,$20,$20,$20,$20,$20,$0
L399:.dc.b $D,$A,$20,$20,$20,$66,$73,$69,$7A,$20,$20,$20,$20,$20,$20,$0
L400:.dc.b $D,$A,$20,$20,$20,$66,$61,$74,$72,$65,$63,$20,$20,$20,$0
L401:.dc.b $D,$A,$20,$20,$20,$64,$61,$74,$72,$65,$63,$20,$20,$20,$0
L402:.dc.b $D,$A,$20,$20,$20,$6E,$75,$6D,$63,$6C,$20,$20,$20,$20,$0
L403:.dc.b $D,$A,$20,$20,$20,$62,$66,$6C,$61,$67,$73,$20,$20,$20,$20,$0
L404:.dc.b $D,$A,$20,$20,$20,$6E,$74,$72,$61,$63,$6B,$73,$20,$20,$20,$0
L405:.dc.b $D,$A,$20,$20,$20,$6E,$73,$69,$64,$65,$73,$20,$20,$20,$20,$0
L406:.dc.b $D,$A,$20,$20,$20,$73,$65,$63,$2F,$63,$79,$6C,$20,$20,$0
L407:.dc.b $D,$A,$20,$20,$20,$73,$65,$63,$2F,$74,$72,$6B,$20,$20,$0
L408:.dc.b $D,$A,$20,$20,$20,$68,$69,$64,$64,$65,$6E,$20,$20,$20,$20,$0
L409:.dc.b $D,$A,$A,$0
L415:.dc.b $D,$A,$A,$2A,$2A,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$30,$20,$61,$74,$20,$0
L416:.dc.b $20,$77,$61,$73,$20,$0
L417:.dc.b $20,$69,$6E,$73,$74,$65,$61,$64,$20,$6F,$66,$20,$0
L418:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L422:.dc.b $D,$A,$A,$2A,$2A,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$31,$20,$61,$74,$20,$0
L423:.dc.b $20,$77,$61,$73,$20,$0
L424:.dc.b $20,$69,$6E,$73,$74,$65,$61,$64,$20,$6F,$66,$20,$0
L425:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L485:.dc.b $43,$68,$65,$63,$6B,$73,$75,$6D,$20,$3D,$20,$30,$78,$25,$30,$38,$6C,$58,$D,$A,$0
L524:.dc.b $20,$20,$0
L525:.dc.b $3A,$0
L526:.dc.b $20,$20,$0
L527:.dc.b $D,$A,$0
L560:.dc.b $30,$34,$30,$30,$30,$30,$30,$30,$46,$42,$0
L572:.dc.b $3F,$D,$0
L573:.dc.b $2A,$2A,$20,$4C,$6F,$61,$64,$20,$65,$72,$72,$6F,$72,$20,$0
L574:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L576:.dc.b $4B,$D,$0
L578:.dc.b $4B,$D,$0
L580:.dc.b $3F,$D,$0
L581:.dc.b $2A,$2A,$20,$4C,$6F,$61,$64,$20,$61,$62,$6F,$72,$74,$65,$64,$20,$6F,$6E,$20,$0
L582:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L589:.dc.b $D,$A,$2A,$2A,$20,$46,$49,$4C,$4C,$20,$66,$61,$69,$6C,$65,$64,$20,$61,$74,$20,$0
L590:.dc.b $20,$2A,$2A,$D,$A,$0
L602:.dc.b $D,$A,$2A,$2A,$20,$43,$4F,$50,$59,$20,$66,$61,$69,$6C,$65,$64,$20,$66,$72,$6F,$6D,$20,$0
L603:.dc.b $20,$74,$6F,$20,$0
L604:.dc.b $20,$77,$69,$74,$68,$20,$28,$66,$72,$6F,$6D,$29,$20,$3D,$20,$0
L605:.dc.b $20,$61,$6E,$64,$20,$28,$74,$6F,$29,$20,$3D,$20,$0
L606:.dc.b $20,$2A,$2A,$D,$A,$0
L612:.dc.b $D,$A,$2A,$2A,$20,$43,$4F,$50,$59,$20,$66,$61,$69,$6C,$65,$64,$20,$66,$72,$6F,$6D,$20,$0
L613:.dc.b $20,$74,$6F,$20,$0
L614:.dc.b $20,$77,$69,$74,$68,$20,$28,$66,$72,$6F,$6D,$29,$20,$3D,$20,$0
L615:.dc.b $20,$61,$6E,$64,$20,$28,$74,$6F,$29,$20,$3D,$20,$0
L616:.dc.b $20,$2A,$2A,$D,$A,$0
L621:.dc.b $D,$A,$0
L626:.dc.b $D,$A,$0
L627:.dc.b $D,$A,$0
L669:.dc.b $45,$52,$52,$4F,$52,$20,$2D,$2D,$20,$43,$6F,$75,$6C,$64,$20,$6E,$6F,$74,$20,$73,$65,$74,$20,$49,$50,$4C,$20,$74,$6F,$20
.dc.b $25,$64,$D,$A,$0
L671:.dc.b $52,$4F,$4D,$50,$20,$49,$50,$4C,$20,$6E,$6F,$77,$20,$73,$65,$74,$20,$74,$6F,$20,$25,$64,$D,$A,$0
L685:.dc.b $D,$A,$0
L690:.dc.b $D,$A,$0
L692:.dc.b $D,$A,$0
L697:.dc.b $D,$A,$0
L699:.dc.b $D,$A,$0
L704:.dc.b $D,$A,$0
L710:.dc.b $D,$A,$0
L713:.dc.b $D,$A,$0
L714:.dc.b $D,$A,$0
L719:.dc.b $D,$A,$0
L722:.dc.b $D,$A,$0
L723:.dc.b $D,$A,$0
L725:.dc.b $52,$4F,$4D,$50,$3A,$20,$0
L729:.dc.b $D,$A,$0
L738:.dc.b $D,$A,$2A,$2A,$20,$43,$6F,$6D,$6D,$61,$6E,$64,$20,$65,$72,$72,$6F,$72,$20,$2A,$2A,$D,$A,$0
L740:.dc.b $D,$A,$2A,$2A,$20,$49,$6E,$76,$61,$6C,$69,$64,$20,$70,$61,$72,$61,$6D,$65,$74,$65,$72,$20,$2A,$2A,$D,$A,$0
L741:.dc.b $D,$A,$2A,$2A,$20,$55,$6E,$72,$65,$63,$6F,$67,$6E,$69,$7A,$65,$64,$20,$63,$6F,$6D,$6D,$61,$6E,$64,$20,$2A,$2A,$D,$A,$0
L745:.dc.b $D,$A,$2A,$2A,$20,$43,$6F,$6D,$6D,$61,$6E,$64,$20,$65,$72,$72,$6F,$72,$20,$2A,$2A,$D,$A,$0
L747:.dc.b $D,$A,$2A,$2A,$20,$43,$6F,$6D,$6D,$61,$6E,$64,$20,$6E,$6F,$74,$20,$72,$65,$70,$65,$61,$74,$61,$62,$6C,$65,$20,$2A,$2A
.dc.b $D,$A,$0
L749:.dc.b $D,$A,$2D,$2D,$2D,$2D,$2D,$20,$43,$61,$6E,$63,$65,$6C,$6C,$65,$64,$20,$2D,$2D,$2D,$2D,$2D,$D,$A,$0
L751:.dc.b $D,$A,$2A,$2A,$20,$49,$6E,$76,$61,$6C,$69,$64,$20,$6C,$69,$6E,$65,$20,$74,$65,$72,$6D,$69,$6E,$61,$74,$6F,$72,$20,$2A
.dc.b $2A,$D,$A,$0
L752:.dc.b $D,$A,$2A,$2A,$20,$64,$6F,$5F,$63,$6D,$64,$28,$29,$20,$73,$77,$69,$74,$63,$68,$20,$66,$61,$69,$6C,$65,$64,$20,$2A,$2A
.dc.b $D,$A,$0
L756:.dc.b $D,$A,$45,$52,$52,$4F,$52,$20,$72,$65,$61,$64,$69,$6E,$67,$20,$64,$69,$73,$6B,$3A,$20,$20,$0
L757:.dc.b $D,$A,$A,$0
L761:.dc.b $D,$A,$45,$52,$52,$4F,$52,$20,$77,$72,$69,$74,$69,$6E,$67,$20,$64,$69,$73,$6B,$3A,$20,$20,$0
L762:.dc.b $D,$A,$A,$0
L765:.dc.b $20,$20,$20,$20,$20,$20,$20,$0
L770:.dc.b $5F,$5F,$5F,$5F,$5F,$5F,$5F,$0
L771:.dc.b $D,$A,$64,$30,$2E,$2E,$64,$37,$20,$0
L776:.dc.b $D,$A,$61,$30,$2E,$2E,$61,$37,$20,$0
L781:.dc.b $D,$A,$50,$43,$20,$3D,$20,$20,$0
L782:.dc.b $2C,$20,$20,$20,$20,$53,$52,$20,$3D,$20,$0
L783:.dc.b $20,$20,$28,$49,$50,$4C,$20,$3D,$20,$0
L784:.dc.b $2C,$20,$0
L799:.dc.b $20,$29,$D,$A,$0
L801:.dc.b $42,$49,$4F,$53,$20,$43,$72,$61,$73,$68,$20,$41,$72,$65,$61,$20,$44,$75,$6D,$70,$D,$A,$0
L802:.dc.b $20,$20,$20,$20,$20,$20,$20,$0
L807:.dc.b $5F,$5F,$5F,$5F,$5F,$5F,$5F,$0
L808:.dc.b $D,$A,$64,$30,$2E,$2E,$64,$37,$20,$0
L813:.dc.b $D,$A,$61,$30,$2E,$2E,$61,$37,$20,$0
L818:.dc.b $D,$A,$A,$50,$43,$20,$3D,$20,$20,$0
L819:.dc.b $2C,$20,$20,$20,$20,$53,$52,$20,$3D,$20,$0
L820:.dc.b $20,$20,$28,$49,$50,$4C,$20,$3D,$20,$0
L821:.dc.b $2C,$20,$0
L836:.dc.b $20,$29,$D,$A,$0
L837:.dc.b $54,$52,$41,$50,$20,$76,$65,$63,$74,$6F,$72,$20,$6E,$75,$6D,$62,$65,$72,$20,$3D,$20,$0
L838:.dc.b $20,$20,$28,$6E,$6F,$20,$68,$61,$6E,$64,$6C,$65,$72,$20,$66,$6F,$72,$20,$69,$6E,$74,$65,$72,$72,$75,$70,$74,$29,$0
L842:.dc.b $20,$20,$28,$42,$75,$73,$20,$65,$72,$72,$6F,$72,$29,$0
L844:.dc.b $20,$20,$28,$41,$64,$64,$72,$65,$73,$73,$20,$65,$72,$72,$6F,$72,$29,$0
L846:.dc.b $20,$20,$28,$49,$6C,$6C,$65,$67,$61,$6C,$20,$69,$6E,$73,$74,$72,$75,$63,$74,$69,$6F,$6E,$29,$0
L848:.dc.b $20,$20,$28,$5A,$65,$72,$6F,$20,$64,$69,$76,$69,$64,$65,$29,$0
L850:.dc.b $20,$20,$28,$43,$48,$4B,$20,$69,$6E,$73,$74,$72,$75,$63,$74,$69,$6F,$6E,$29,$0
L852:.dc.b $20,$20,$28,$54,$52,$41,$50,$56,$20,$69,$6E,$73,$74,$72,$75,$63,$74,$69,$6F,$6E,$29,$0
L854:.dc.b $20,$20,$28,$50,$72,$69,$76,$69,$6C,$65,$67,$65,$20,$76,$69,$6F,$6C,$61,$74,$69,$6F,$6E,$29,$0
L856:.dc.b $20,$20,$28,$54,$72,$61,$63,$65,$20,$2D,$2D,$20,$6E,$6F,$74,$20,$69,$6D,$70,$6C,$65,$6D,$65,$6E,$74,$65,$64,$29,$0
L858:.dc.b $20,$20,$28,$4C,$69,$6E,$65,$20,$31,$30,$31,$30,$20,$45,$6D,$75,$6C,$61,$74,$6F,$72,$20,$2D,$2D,$20,$6E,$6F,$74,$20,$69
.dc.b $6D,$70,$6C,$65,$6D,$65,$6E,$74,$65,$64,$29,$0
L860:.dc.b $20,$20,$28,$4C,$69,$6E,$65,$20,$31,$31,$31,$31,$20,$45,$6D,$75,$6C,$61,$74,$6F,$72,$20,$2D,$2D,$20,$6E,$6F,$74,$20,$69
.dc.b $6D,$70,$6C,$65,$6D,$65,$6E,$74,$65,$64,$0
L862:.dc.b $20,$20,$28,$55,$6E,$69,$6E,$69,$74,$69,$61,$6C,$69,$7A,$65,$64,$20,$69,$6E,$74,$65,$72,$72,$75,$70,$74,$29,$0
L864:.dc.b $20,$20,$28,$53,$70,$75,$72,$69,$6F,$75,$73,$20,$69,$6E,$74,$65,$72,$72,$75,$70,$74,$29,$0
L866:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$31,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L868:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$32,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L870:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$33,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L872:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$34,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L874:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$35,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L876:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$36,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L878:.dc.b $20,$20,$28,$4C,$65,$76,$65,$6C,$20,$37,$20,$49,$6E,$74,$65,$72,$72,$75,$70,$74,$20,$2D,$2D,$20,$75,$6E,$69,$6D,$70,$6C
.dc.b $6D,$65,$6E,$74,$65,$64,$29,$0
L880:.dc.b $D,$A,$0
L883:.dc.b $2A,$2A,$20,$43,$72,$61,$73,$68,$20,$73,$77,$69,$74,$63,$68,$20,$4E,$4F,$54,$20,$73,$65,$74,$20,$2A,$2A,$D,$A,$0
L888:.dc.b $2A,$2A,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$77,$6F,$72,$64,$20,$61,$74,$20,$0
L889:.dc.b $20,$77,$61,$73,$20,$0
L890:.dc.b $20,$69,$6E,$73,$74,$65,$61,$64,$20,$6F,$66,$20,$0
L891:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L895:.dc.b $2A,$2A,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$77,$6F,$72,$64,$20,$61,$74,$20,$0
L896:.dc.b $20,$77,$61,$73,$20,$0
L897:.dc.b $20,$69,$6E,$73,$74,$65,$61,$64,$20,$6F,$66,$20,$0
L898:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L902:.dc.b $2A,$2A,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$77,$6F,$72,$64,$20,$61,$74,$20,$0
L903:.dc.b $20,$77,$61,$73,$20,$0
L904:.dc.b $20,$69,$6E,$73,$74,$65,$61,$64,$20,$6F,$66,$20,$0
L905:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L909:.dc.b $2A,$2A,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$77,$6F,$72,$64,$20,$61,$74,$20,$0
L910:.dc.b $20,$77,$61,$73,$20,$0
L911:.dc.b $20,$69,$6E,$73,$74,$65,$61,$64,$20,$6F,$66,$20,$0
L912:.dc.b $20,$2A,$2A,$D,$A,$A,$0
L914:.dc.b $D,$A,$2A,$2A,$20,$50,$72,$6F,$67,$72,$61,$6D,$20,$69,$6E,$76,$6F,$6B,$65,$64,$20,$52,$4F,$4D,$50,$20,$74,$72,$61,$70
.dc.b $20,$2A,$2A,$D,$A,$0
L918:.dc.b $D,$A,$A,$2A,$2A,$2A,$2A,$2A,$20,$73,$65,$74,$69,$70,$6C,$28,$29,$20,$66,$61,$69,$6C,$65,$64,$20,$2A,$2A,$2A,$2A,$2A
.dc.b $D,$A,$A,$0
L929:.dc.b $D,$A,$A,$2A,$2A,$20,$52,$4F,$4D,$50,$20,$42,$72,$65,$61,$6B,$70,$6F,$69,$6E,$74,$20,$54,$52,$41,$50,$20,$2A,$2A,$D
.dc.b $A,$0
L935:.dc.b $D,$A,$A,$42,$75,$63,$68,$6C,$61,$20,$37,$30,$30,$20,$42,$49,$4F,$53,$20,$2F,$20,$44,$65,$62,$75,$67,$20,$50,$52,$4F
.dc.b $4D,$D,$A,$0
L936:.dc.b $20,$20,$52,$4F,$4D,$50,$20,$56,$65,$72,$73,$69,$6F,$6E,$20,$0
L937:.dc.b $32,$32,$2E,$30,$30,$20,$2D,$2D,$20,$31,$39,$38,$38,$2D,$30,$36,$2D,$32,$30,$0
L938:.dc.b $D,$A,$20,$20,$42,$49,$4F,$53,$20,$56,$65,$72,$73,$69,$6F,$6E,$20,$0
L967:.dc.b $6D,$69,$64,$61,$73,$2E,$61,$62,$73,$0
L979:.dc.b $5B,$5B,$73,$74,$61,$72,$74,$3D,$24,$25,$6C,$58,$5D,$2C,$5B,$65,$6E,$64,$3D,$24,$25,$6C,$78,$5D,$5D,$20,$20,$28,$6F,$72
.dc.b $20,$24,$38,$2E,$2E,$24,$25,$6C,$58,$29,$0
L980:.dc.b $4C,$6F,$61,$64,$20,$20,$47,$6F,$54,$6F,$0
L981:.dc.b $44,$69,$73,$6B,$20,$20,$52,$4F,$4D,$50,$0
L982:.dc.b $42,$75,$63,$68,$6C,$61,$20,$37,$30,$30,$20,$2D,$2D,$20,$42,$49,$4F,$53,$2F,$52,$4F,$4D,$50,$20,$46,$69,$72,$6D,$77,$61
.dc.b $72,$65,$20,$62,$79,$20,$44,$2E,$4E,$2E,$20,$4C,$79,$6E,$78,$20,$43,$72,$6F,$77,$65,$0
L983:.dc.b $42,$49,$4F,$53,$20,$56,$65,$72,$73,$69,$6F,$6E,$20,$25,$30,$32,$64,$2E,$25,$30,$32,$64,$25,$73,$0
L984:.dc.b $52,$4F,$4D,$50,$20,$56,$65,$72,$73,$69,$6F,$6E,$20,$25,$73,$0
L985:.dc.b $32,$32,$2E,$30,$30,$20,$2D,$2D,$20,$31,$39,$38,$38,$2D,$30,$36,$2D,$32,$30,$0
L994:.dc.b $D,$A,$2A,$2A,$2A,$2A,$2A,$20,$52,$4F,$4D,$50,$20,$52,$65,$2D,$73,$74,$61,$72,$74,$69,$6E,$67,$20,$2A,$2A,$2A,$2A,$2A
.dc.b $D,$A,$A,$0
L995:.dc.b $D,$A,$A,$0
L999:.dc.b $D,$A,$2A,$2A,$20,$78,$74,$72,$61,$70,$31,$35,$28,$29,$20,$72,$65,$74,$75,$72,$6E,$65,$64,$20,$74,$6F,$20,$52,$4F,$4D
.dc.b $50,$20,$2A,$2A,$D,$A,$A,$0
