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
.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
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
.globl _cx_key
.globl _cy_key
.globl _cx_upd
.globl _cy_upd
.globl _xy_up
.globl _xy_dn
.globl _not_fld
.globl _x_key
.globl _e_key
.globl _m_key
.globl _d_key
.globl _premove
.globl _pstmove
.globl _curtype
.globl _cratex
.globl _cratey
.globl _asig
.globl _aval
.globl _astat
.globl _aflag
.globl _xkstat
.globl _ykstat
.globl _xkcount
.globl _ykcount
.globl _cmtype
.globl _cmfirst
.globl _xycntr
.globl _curpos
.globl _cxrate
.globl _cyrate
.globl _cxval
.globl _cyval
.globl _ncvwait
.globl _nchwait
.globl _chwait
.globl _cvwait
.globl _cvtime
.globl _chtime
.globl _stcrow
.globl _stccol
.globl _runit
.globl _submenu
.globl _vtcrow
.globl _vtccol
.globl _trkball
.globl _tkctrl
.globl _txflag
.globl _tyflag
.globl _curhold
.globl _hcwval
.globl _thcwval
.globl _tvcwval
.globl _vcwval
.globl _sigtab
.globl _crate0
.globl _syrate
.data
_syrate:
.dc.w $4
.globl _LastRow
.data
_LastRow:
.dc.w $FFFF
.globl _LastCol
.data
_LastCol:
.dc.w $FFFF
.globl _enterit
.text
_enterit:
~~enterit:
link R14,#-4
*line 74
*line 75
tst _astat
beq L1
*line 76
*line 81
*line 82
*line 83
*line 83
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L2
*line 84
*line 85
move.l _infetp,_cfetp
*line 86
*line 87
*line 88
tst.l _cfetp
beq L3
tst _ebflag
bne L3
*line 88
move.l _cfetp,R8
move 6(R8),-(sp)
move.l _cfetp,R8
move.l 8(R8),R8
jsr (R8)
addq.l #2,sp
*line 89
L3:
*line 90
*line 91
tst.l _cfetp
beq L4
*line 91
move.l _cfetp,R8
move 6(R8),-(sp)
move.l _cfetp,R8
move.l 12(R8),R8
jsr (R8)
addq.l #2,sp
*line 92
L4:
*line 93
*line 94
tst.l _cfetp
beq L5
*line 94
move.l _cfetp,R8
move 6(R8),-(sp)
move.l _cfetp,R8
move.l 16(R8),R8
jsr (R8)
addq.l #2,sp
*line 95
L5:
*line 96
clr _ebflag
*line 97
L2:L1:unlk R14
rts
.globl _nokey
.text
_nokey:
~~nokey:
link R14,#-4
*line 112
clr R0
bra L6
L6:unlk R14
rts
.globl _cmvgen
.text
_cmvgen:
~~cmvgen:
link R14,#0
movem.l R3-R7,-(sp)
~nc=R7
~newrow=R6
~newcol=R5
~newpos=R4
*line 128
move.l _premove,R8
jsr (R8)
*line 130
move.l _curtype,R8
jsr (R8)
move R0,R7
*line 132
move _cyval,R6
ext.l R6
divs #14,R6
*line 133
move _cxval,R5
asr #3,R5
*line 135
*line 135
cmp _cmtype,R7
beq L8
*line 136
*line 137
move _curhold,_nchwait
*line 138
move _curhold,_ncvwait
*line 139
*line 140
move #-1,_LastRow
*line 141
move #-1,_LastCol
*line 142
*line 143
*line 144
*line 145
L8:
*line 146
*line 147
cmp _LastRow,R6
bne L10000
cmp _LastCol,R5
beq L9
L10000:*line 147
move #1,R4
*line 148
bra L10
L9:
*line 149
clr R4
L10:
*line 153
tst R7
bne L10001
move _hcwval,R0
bra L10003
L10001:move _thcwval,R0
L10003:move R0,_chtime
*line 154
tst R7
bne L10004
move _vcwval,R0
bra L10006
L10004:cmp #4,R7
bne L10007
move _syrate,R0
bra L10009
L10007:move _tvcwval,R0
L10009:L10006:move R0,_cvtime
*line 156
move R7,R0
bra L12
*line 157
L13:
*line 158
*line 159
*line 160
*line 160
cmp #3,_cmtype
bne L14
*line 161
*line 162
jsr _stcoff
*line 163
jsr _sgcon
*line 164
*line 165
L14:
*line 166
move R7,_cmtype
*line 167
move _cyval,(sp)
move _cxval,-(sp)
jsr _gcurpos
addq.l #2,sp
bra L11
*line 168
*line 169
*line 170
*line 171
L15:
*line 172
*line 173
*line 174
move R7,_cmtype
*line 175
*line 176
*line 177
tst R4
beq L16
*line 177
move R5,(sp)
move R6,-(sp)
jsr _itcpos
addq.l #2,sp
*line 178
L16:bra L11
*line 179
*line 180
L17:
*line 181
*line 182
*line 183
move R7,_cmtype
*line 184
move _vtccol,(sp)
move _vtcrow,-(sp)
jsr _ttcpos
addq.l #2,sp
bra L11
*line 185
*line 186
L18:
*line 187
*line 188
*line 189
*line 190
tst _cmtype
bne L19
*line 190
jsr _sgcoff
*line 191
L19:
*line 192
move R7,_cmtype
*line 193
*line 194
*line 195
tst R4
beq L20
*line 195
move R5,(sp)
move R6,-(sp)
jsr _stcpos
addq.l #2,sp
*line 196
L20:bra L11
*line 197
*line 198
L21:
*line 199
*line 200
*line 201
move R7,_cmtype
*line 202
*line 203
*line 204
tst R4
beq L22
*line 204
move R5,(sp)
move R6,-(sp)
jsr _ctcpos
addq.l #2,sp
*line 205
L22:bra L11
*line 206
*line 207
L23:
*line 208
*line 209
*line 210
move R7,_cmtype
*line 211
move _vtccol,(sp)
move _vtcrow,-(sp)
jsr _mtcpos
addq.l #2,sp
bra L11
*line 212
bra L11
L12:cmp #5,R0
bhi L11
asl #2,R0
move R0,R8
add.l #L24,R8
move.l (R8),R8
jmp (R8)
.data
L24:.dc.l L13
.dc.l L15
.dc.l L17
.dc.l L18
.dc.l L21
.dc.l L23
.text
L11:
*line 215
move R6,_LastRow
*line 216
move R5,_LastCol
*line 218
move.l _pstmove,R8
jsr (R8)
L7:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _crxrate
.text
_crxrate:
~~crxrate:
~cv=R7
link R14,#0
movem.l R5-R7,-(sp)
~cs=R6
*line 236
move 8(R14),R7
*line 236
*line 236
cmp _xycntr,R7
blt L26
*line 237
*line 238
sub _xycntr,R7
*line 239
move #1,R6
*line 240
move R7,R0
neg R0
move R0,_curpos
*line 241
bra L27
L26:
*line 242
*line 243
*line 244
move _xycntr,R0
sub R7,R0
move R0,R7
*line 245
clr R6
*line 246
move R7,_curpos
L27:
*line 249
*line 250
cmp #127,R7
ble L28
*line 250
move #127,R7
*line 251
L28:
*line 252
tst R6
beq L10010
move.l _cratex,R8
move R7,R9
add.l R9,R9
move 0(R8,R9.l),R0
neg R0
bra L10012
L10010:move.l _cratex,R8
move R7,R9
add.l R9,R9
move 0(R8,R9.l),R0
L10012:bra L25
L25:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _cryrate
.text
_cryrate:
~~cryrate:
~cv=R7
link R14,#0
movem.l R5-R7,-(sp)
~cs=R6
*line 270
move 8(R14),R7
*line 270
*line 270
cmp _xycntr,R7
blt L30
*line 271
*line 272
sub _xycntr,R7
*line 273
move #1,R6
*line 274
move R7,R0
neg R0
move R0,_curpos
*line 275
bra L31
L30:
*line 276
*line 277
*line 278
move _xycntr,R0
sub R7,R0
move R0,R7
*line 279
clr R6
*line 280
move R7,_curpos
L31:
*line 283
*line 284
cmp #127,R7
ble L32
*line 284
move #127,R7
*line 285
L32:
*line 286
tst R6
beq L10013
move.l _cratey,R8
move R7,R9
add.l R9,R9
move 0(R8,R9.l),R0
neg R0
bra L10015
L10013:move.l _cratey,R8
move R7,R9
add.l R9,R9
move 0(R8,R9.l),R0
L10015:bra L29
L29:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _cmfix
.text
_cmfix:
~~cmfix:
link R14,#0
movem.l R3-R7,-(sp)
~acx=R7
~acy=R6
~scx=R5
~scy=R4
*line 302
move 220+_sigtab,(sp)
jsr _crxrate
*line 303
tst _curpos
bge L10016
move _curpos,R0
neg R0
bra L10018
L10016:move _curpos,R0
L10018:move R0,R7
*line 305
move 224+_sigtab,(sp)
jsr _cryrate
*line 306
tst _curpos
bge L10019
move _curpos,R0
neg R0
bra L10021
L10019:move _curpos,R0
L10021:move R0,R6
*line 308
tst _cxrate
bge L10022
move #-1,R0
bra L10024
L10022:move #1,R0
L10024:move R0,R5
*line 309
tst _cyrate
bge L10025
move #-1,R0
bra L10027
L10025:move #1,R0
L10027:move R0,R4
*line 311
*line 311
tst _cmfirst
beq L34
*line 312
*line 313
*line 313
cmp R6,R7
blt L35
*line 314
*line 315
clr _cyrate
*line 316
move R5,_cxrate
*line 317
move _curhold,_nchwait
*line 318
move _cvtime,_ncvwait
*line 319
bra L36
L35:
*line 320
*line 321
*line 322
clr _cxrate
*line 323
move R4,_cyrate
*line 324
move _curhold,_ncvwait
*line 325
move _chtime,_nchwait
L36:
*line 326
*line 327
*line 328
clr _cmfirst
*line 329
bra L37
L34:
*line 330
*line 331
*line 332
*line 333
*line 334
*line 335
tst _cmtype
beq L38
*line 335
*line 336
cmp R6,R7
blt L39
*line 336
clr _cyrate
*line 337
bra L40
L39:
*line 338
clr _cxrate
L40:L38:L37:L33:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _cxkstd
.text
_cxkstd:
~~cxkstd:
link R14,#-4
*line 353
clr _trkball
*line 354
clr _tkctrl
*line 355
clr _txflag
*line 356
clr _tyflag
*line 358
*line 358
tst _astat
beq L42
*line 359
*line 360
*line 360
tst _xkstat
bne L43
*line 361
*line 362
*line 362
tst _xkcount
beq L44
*line 363
*line 364
sub #1,_xkcount
bra L41
*line 365
*line 366
*line 367
L44:
*line 368
move #1,_xkstat
*line 369
move #1,_chwait
*line 370
move _curhold,_nchwait
*line 371
*line 372
*line 373
tst _ykstat
beq L45
*line 373
move.l _xy_dn,R8
jsr (R8)
L45:
*line 374
*line 375
L43:
*line 376
move _aval,(sp)
jsr _crxrate
neg R0
move R0,_cxrate
*line 377
*line 378
bra L46
L42:
*line 379
*line 380
*line 381
*line 382
tst _xkstat
beq L47
tst _ykstat
beq L47
*line 382
move.l _xy_up,R8
jsr (R8)
*line 383
L47:
*line 384
clr _xkstat
*line 385
move #1,_xkcount
*line 386
clr _cxrate
*line 387
*line 388
*line 388
tst _ykstat
bne L48
*line 389
*line 390
clr _cyrate
*line 391
move #1,_ykcount
*line 392
move _chtime,_nchwait
*line 393
move _cvtime,_ncvwait
*line 394
move #1,_chwait
*line 395
move #1,_cvwait
*line 396
move #1,_cmfirst
*line 397
L48:L46:bra L41
L41:unlk R14
rts
.globl _cykstd
.text
_cykstd:
~~cykstd:
link R14,#-4
*line 414
clr _trkball
*line 415
clr _tkctrl
*line 416
clr _txflag
*line 417
clr _tyflag
*line 419
*line 419
tst _astat
beq L50
*line 420
*line 421
*line 421
tst _ykstat
bne L51
*line 422
*line 423
*line 423
tst _ykcount
beq L52
*line 424
*line 425
sub #1,_ykcount
bra L49
*line 426
*line 427
*line 428
L52:
*line 429
move #1,_ykstat
*line 430
move #1,_cvwait
*line 431
move _curhold,_ncvwait
*line 432
*line 433
*line 434
tst _xkstat
beq L53
*line 434
move.l _xy_dn,R8
jsr (R8)
L53:
*line 435
*line 436
L51:
*line 437
move _aval,(sp)
jsr _cryrate
move R0,_cyrate
*line 438
*line 439
bra L54
L50:
*line 440
*line 441
*line 442
*line 443
tst _xkstat
beq L55
tst _ykstat
beq L55
*line 443
move.l _xy_up,R8
jsr (R8)
*line 444
L55:
*line 445
clr _ykstat
*line 446
move #1,_ykcount
*line 447
clr _cyrate
*line 448
*line 449
*line 449
tst _xkstat
bne L56
*line 450
*line 451
clr _cxrate
*line 452
move #1,_xkcount
*line 453
move _chtime,_nchwait
*line 454
move _cvtime,_ncvwait
*line 455
move #1,_chwait
*line 456
move #1,_cvwait
*line 457
move #1,_cmfirst
*line 458
L56:L54:bra L49
L49:unlk R14
rts
.globl _stdmkey
.text
_stdmkey:
~~stdmkey:
link R14,#-4
*line 475
*line 475
tst _astat
beq L58
*line 476
*line 477
clr _runit
*line 478
clr _submenu
*line 479
L58:L57:unlk R14
rts
.globl _stddkey
.text
_stddkey:
~~stddkey:
link R14,#-4
*line 490
*line 490
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L60
*line 491
*line 492
move.l _infetp,_cfetp
*line 493
*line 494
*line 494
tst _astat
beq L61
*line 495
*line 496
*line 497
tst _ebflag
bne L62
*line 497
move.l _cfetp,R8
move 6(R8),-(sp)
move.l _cfetp,R8
move.l 8(R8),R8
jsr (R8)
addq.l #2,sp
*line 498
L62:
*line 499
move _asig,-(sp)
add #-60,(sp)
move.l _cfetp,R8
move 6(R8),-(sp)
move.l _cfetp,R8
move.l 20(R8),R8
jsr (R8)
addq.l #4,sp
*line 500
*line 501
L61:bra L63
L60:
*line 502
*line 503
*line 504
*line 505
tst _astat
beq L64
*line 505
move _asig,-(sp)
add #-60,(sp)
move.l _not_fld,R8
jsr (R8)
addq.l #2,sp
L64:L63:L59:unlk R14
rts
.globl _cxgen
.text
_cxgen:
~~cxgen:
link R14,#-4
*line 520
move _cxrate,R0
add R0,_cxval
*line 522
*line 523
cmp #511,_cxval
ble L66
*line 523
move #511,_cxval
bra L67
L66:
*line 524
*line 525
tst _cxval
bge L68
*line 525
clr _cxval
*line 526
L68:L67:bra L65
L65:unlk R14
rts
.globl _cygen
.text
_cygen:
~~cygen:
link R14,#-4
*line 538
move _cyrate,R0
add R0,_cyval
*line 540
*line 541
cmp #349,_cyval
ble L70
*line 541
move #349,_cyval
bra L71
L70:
*line 542
*line 543
tst _cyval
bge L72
*line 543
clr _cyval
*line 544
L72:L71:bra L69
L69:unlk R14
rts
.data
