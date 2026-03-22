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
.globl _stcrow
.globl _stccol
.globl _cxval
.globl _cyval
.globl _curtun
.globl _submenu
.globl _tunmod
.globl _tunval
.globl _ttcmdsv
.globl _tdnamsw
.globl _oldtun
.globl _tuntab
.globl _tunlib
.globl _panlkey
.globl _lclkmap
.globl _tuncurn
.globl _tunname
.globl _sfdsp
.globl _obj0
.globl _obj2
.globl _bfs
.globl _tdbxlb
.globl _tdbox
.globl _tunob
.globl _tdoct
.globl _tunpal
.data
_tunpal:
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $1
.dc.w $0
.dc.w $1
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $1
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $0
.dc.w $2
.dc.w $3
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
.dc.w $3
.dc.w $0
.dc.w $3
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $3
.data
L1:.dc.b $4C,$6F,$63,$61,$6C,$20,$33,$72,$64,$73,$20,$2B,$20,$4D,$49,$44,$49,$20,$31,$32,$20,$74,$6F,$6E,$65,$20,$73,$63,$61,$6C
.dc.b $65,$20,$0
.even
.text
.globl _tdlabl
.data
_tdlabl:
*line 82
.dc.l L3
*line 82
.dc.l L4
*line 82
.dc.l L5
*line 82
.dc.l L6
*line 82
.dc.l L7
*line 82
.dc.l L8
*line 82
.dc.l L9
*line 82
.dc.l L10
*line 83
.dc.l L11
*line 83
.dc.l L12
*line 83
.dc.l L13
*line 83
.dc.l L14
*line 83
.dc.l L15
*line 83
.dc.l L16
*line 83
.dc.l L17
*line 83
.dc.l L18
*line 84
.dc.l L19
*line 84
.dc.l L20
*line 84
.dc.l L21
*line 84
.dc.l L22
*line 84
.dc.l L23
*line 84
.dc.l L24
*line 84
.dc.l L25
*line 85
.dc.l L26
.globl _gettun
.text
_gettun:
~~gettun:
~n=8
link R14,#-4
*line 99
move #128,(sp)
move 8(R14),R0
asl #8,R0
ext.l R0
add.l #_tunlib,R0
move.l R0,-(sp)
move.l #_tuntab,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 100
move #32,(sp)
move 8(R14),R0
asl #5,R0
ext.l R0
add.l #_tunname,R0
move.l R0,-(sp)
move.l #_tuncurn,-(sp)
jsr _memcpy
addq.l #8,sp
*line 101
move 8(R14),_curtun
*line 102
clr _tunmod
L27:unlk R14
rts
.globl _puttun
.text
_puttun:
~~puttun:
~n=8
link R14,#-4
*line 114
move #128,(sp)
move.l #_tuntab,-(sp)
move 8(R14),R0
asl #8,R0
ext.l R0
add.l #_tunlib,R0
move.l R0,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 115
move #32,(sp)
move.l #_tuncurn,-(sp)
move 8(R14),R0
asl #5,R0
ext.l R0
add.l #_tunname,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
*line 116
clr _tunmod
L28:unlk R14
rts
.globl _inittt
.text
_inittt:
~~inittt:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 133
clr R7
bra L32
L33:
*line 134
*line 135
cmp #21,R7
bge L10000
move #160,R0
bra L10002
L10000:cmp #108,R7
ble L10003
move #10960,R0
bra L10005
L10003:move R7,R0
add #-12,R0
muls #100,R0
add #160,R0
L10005:L10002:asl #1,R0
move 8(R14),R1
asl #8,R1
ext.l R1
move R7,R2
asl #1,R2
ext.l R2
add.l R2,R1
add.l #_tunlib,R1
move.l R1,R9
move R0,(R9)
L31:
*line 133
add #1,R7
L32:
*line 133
cmp #128,R7
blt L33
L30:
*line 137
clr R7
bra L36
L37:
*line 138
move R7,R8
add.l R8,R8
move.l #_panlkey,R9
move 0(R8,R9.l),R0
asl #1,R0
move 8(R14),R1
asl #8,R1
ext.l R1
move R7,R10
add.l R10,R10
add.l #_lclkmap,R10
move (R10),R2
asl #1,R2
ext.l R2
add.l R2,R1
add.l #_tunlib,R1
move.l R1,R9
move R0,(R9)
L35:
*line 137
add #1,R7
L36:
*line 137
cmp #24,R7
blt L37
L34:
*line 140
move.l #L1,(sp)
move 8(R14),R0
asl #5,R0
ext.l R0
add.l #_tunname,R0
move.l R0,-(sp)
jsr _strcpy
addq.l #4,sp
L29:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _inittl
.text
_inittl:
~~inittl:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 154
clr R7
bra L41
L42:
*line 155
move R7,(sp)
jsr _inittt
L40:
*line 154
add #1,R7
L41:
*line 154
cmp #10,R7
blt L42
L39:
*line 157
move #200,_tunval
*line 158
clr (sp)
jsr _gettun
*line 159
move #128,(sp)
move.l #_tuntab,-(sp)
move.l #_oldtun,-(sp)
jsr _memcpyw
addq.l #8,sp
L38:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _tt_trcp
.text
_tt_trcp:
~~tt_trcp:
~start=8
~finish=10
~dest=12
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~v=R6
*line 177
move #128,(sp)
move.l #_tuntab,-(sp)
move.l #_oldtun,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 179
*line 179
move 8(R14),R0
cmp 10(R14),R0
ble L44
*line 180
*line 181
move 10(R14),R7
bra L47
L48:
*line 182
*line 183
*line 184
*line 185
move R7,R8
add.l R8,R8
move.l #_oldtun,R9
move 0(R8,R9.l),R0
ext.l R0
move.l R0,R6
move _tunval,R0
ext.l R0
add.l R0,R6
*line 186
*line 187
*line 188
cmp.l #$55a0,R6
ble L49
*line 188
move.l #$55a0,R6
bra L50
L49:
*line 189
*line 190
cmp.l #$140,R6
bge L51
*line 190
move.l #$140,R6
*line 191
L51:L50:
*line 192
move.l R6,R0
move 12(R14),R9
add.l R9,R9
add.l #_tuntab,R9
move R0,(R9)
add #1,12(R14)
L46:
*line 181
add #1,R7
L47:
*line 181
cmp 8(R14),R7
bgt L10006
cmp #128,12(R14)
blt L48
L10006:L45:
*line 193
*line 194
bra L52
L44:
*line 195
*line 196
*line 197
move 8(R14),R7
bra L55
L56:
*line 198
*line 199
*line 200
*line 201
move R7,R8
add.l R8,R8
move.l #_oldtun,R9
move 0(R8,R9.l),R0
ext.l R0
move.l R0,R6
move _tunval,R0
ext.l R0
add.l R0,R6
*line 202
*line 203
*line 204
cmp.l #$55a0,R6
ble L57
*line 204
move.l #$55a0,R6
bra L58
L57:
*line 205
*line 206
cmp.l #$140,R6
bge L59
*line 206
move.l #$140,R6
*line 207
L59:L58:
*line 208
move.l R6,R0
move 12(R14),R9
add.l R9,R9
add.l #_tuntab,R9
move R0,(R9)
add #1,12(R14)
L54:
*line 197
add #1,R7
L55:
*line 197
cmp 10(R14),R7
bgt L10007
cmp #128,12(R14)
blt L56
L10007:L53:
*line 209
L52:
*line 212
move #1,_tunmod
L43:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _tt_intp
.text
_tt_intp:
~~tt_intp:
~from=8
~to=10
link R14,#0
movem.l R2-R7,-(sp)
~i=R7
~j=R6
~k=R5
~n=R4
~t=R3
*line 231
move #128,(sp)
move.l #_tuntab,-(sp)
move.l #_oldtun,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 233
*line 233
move 8(R14),R0
cmp 10(R14),R0
ble L61
*line 234
*line 235
move 8(R14),R7
*line 236
move 10(R14),8(R14)
*line 237
move R7,10(R14)
*line 238
*line 239
L61:
*line 240
move 10(R14),R4
sub 8(R14),R4
*line 242
*line 243
cmp #2,R4
bge L62
*line 243
move #-1,R0
bra L60
*line 244
L62:
*line 245
move 8(R14),R8
add.l R8,R8
add.l #_tuntab,R8
move (R8),R5
*line 246
move R4,R0
ext.l R0
move.l R0,-(sp)
move 10(R14),R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),R0
ext.l R0
move R5,R1
ext.l R1
sub.l R1,R0
move.l #$10,R1
asl.l R1,R0
move.l R0,-(sp)
jsr ldiv
addq.l #8,sp
move.l R0,R3
*line 247
move 8(R14),R6
add #1,R6
*line 248
sub #1,R4
*line 250
clr R7
bra L65
L66:
*line 251
move R7,R0
add #1,R0
ext.l R0
move.l R0,-(sp)
move.l R3,-(sp)
jsr lmul
addq.l #8,sp
move.l #$10,R1
asr.l R1,R0
move R0,-(sp)
move R5,R0
add R0,(sp)
move R6,R8
add.l R8,R8
add.l #_tuntab,R8
move (sp)+,(R8)
add #1,R6
L64:
*line 250
add #1,R7
L65:
*line 250
cmp R4,R7
blt L66
L63:
*line 253
move #1,_tunmod
*line 254
clr R0
bra L60
L60:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _tt_incr
.text
_tt_incr:
~~tt_incr:
~from=8
~to=10
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~v=R6
*line 272
move #128,(sp)
move.l #_tuntab,-(sp)
move.l #_oldtun,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 274
*line 274
move 8(R14),R0
cmp 10(R14),R0
ble L68
*line 275
*line 276
move 8(R14),R7
*line 277
move 10(R14),8(R14)
*line 278
move R7,10(R14)
*line 279
*line 280
*line 281
L68:
*line 282
move 8(R14),R8
add.l R8,R8
move.l #_oldtun,R9
move 0(R8,R9.l),R0
ext.l R0
move.l R0,R6
*line 284
*line 285
move 8(R14),R0
cmp 10(R14),R0
move sr,R0
add #1,8(R14)
move R0,ccr
bne L69
*line 285
move #-1,R0
bra L67
*line 286
L69:
*line 287
move 8(R14),R7
bra L72
L73:
*line 288
*line 289
move _tunval,R0
ext.l R0
add.l R0,R6
*line 290
*line 291
*line 292
cmp.l #$55a0,R6
ble L74
*line 292
move.l #$55a0,R6
bra L75
L74:
*line 293
*line 294
cmp.l #$140,R6
bge L76
*line 294
move.l #$140,R6
*line 295
L76:L75:
*line 296
move.l R6,R0
move R7,R9
add.l R9,R9
add.l #_tuntab,R9
move R0,(R9)
L71:
*line 287
add #1,R7
L72:
*line 287
cmp 10(R14),R7
ble L73
L70:
*line 299
move #1,_tunmod
*line 300
clr R0
bra L67
L67:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _td_trcp
.text
_td_trcp:
~~td_trcp:
~mode=8
link R14,#0
movem.l R6-R7,-(sp)
~cx=R7
*line 317
tst 8(R14)
beq L10008
move #13,(sp)
bra L10010
L10008:move 104+_tdbox,(sp)
L10010:jsr _exp_c
move R0,R7
*line 318
clr (sp)
jsr _vbank
*line 319
move #14,(sp)
move.l #L78,-(sp)
move #54,-(sp)
move #9,-(sp)
move 106+_tdbox,-(sp)
move R7,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 320
move #14,(sp)
move.l #L79,-(sp)
move #54,-(sp)
move #10,-(sp)
move 106+_tdbox,-(sp)
move R7,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
L77:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _td_incr
.text
_td_incr:
~~td_incr:
~mode=8
link R14,#0
movem.l R6-R7,-(sp)
~cx=R7
*line 334
tst 8(R14)
beq L10011
move #13,(sp)
bra L10013
L10011:move 104+_tdbox,(sp)
L10013:jsr _exp_c
move R0,R7
*line 335
clr (sp)
jsr _vbank
*line 336
move #14,(sp)
move.l #L81,-(sp)
move #54,-(sp)
move #12,-(sp)
move 106+_tdbox,-(sp)
move R7,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
L80:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _td_intp
.text
_td_intp:
~~td_intp:
~mode=8
link R14,#0
movem.l R6-R7,-(sp)
~cx=R7
*line 350
tst 8(R14)
beq L10014
move #13,(sp)
bra L10016
L10014:move 104+_tdbox,(sp)
L10016:jsr _exp_c
move R0,R7
*line 351
clr (sp)
jsr _vbank
*line 352
move #14,(sp)
move.l #L83,-(sp)
move #54,-(sp)
move #14,-(sp)
move 106+_tdbox,-(sp)
move R7,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
L82:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _advtcur
.text
_advtcur:
~~advtcur:
link R14,#0
movem.l R6-R7,-(sp)
~newcol=R7
*line 368
*line 369
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L85
*line 369
move.l _infetp,_cfetp
*line 370
bra L86
L85:bra L84
L86:
*line 373
move _stccol,R7
add #1,R7
*line 375
*line 376
move.l _cfetp,R8
cmp 4(R8),R7
bgt L87
*line 376
move R7,(sp)
move _stcrow,-(sp)
jsr _itcpos
addq.l #2,sp
*line 377
L87:
*line 378
move _stccol,R0
asl #3,R0
move R0,_cxval
*line 379
move _stcrow,R0
muls #14,R0
move R0,_cyval
L84:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _bsptcur
.text
_bsptcur:
~~bsptcur:
link R14,#0
movem.l R6-R7,-(sp)
~newcol=R7
*line 392
*line 393
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L89
*line 393
move.l _infetp,_cfetp
*line 394
bra L90
L89:bra L88
L90:
*line 397
move _stccol,R7
sub #1,R7
*line 399
*line 400
move.l _cfetp,R8
cmp 2(R8),R7
blt L91
*line 400
move R7,(sp)
move _stcrow,-(sp)
jsr _itcpos
addq.l #2,sp
*line 401
L91:
*line 402
move _stccol,R0
asl #3,R0
move R0,_cxval
*line 403
move _stcrow,R0
muls #14,R0
move R0,_cyval
L88:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _dsttval
.text
_dsttval:
~~dsttval:
~row=8
~col=10
~val=12
~fg=14
~bg=16
link R14,#0
movem.l R5-R7,-(sp)
~cfg=R7
~cbg=R6
*line 421
move 14(R14),(sp)
jsr _exp_c
move R0,R7
*line 422
move 16(R14),(sp)
jsr _exp_c
move R0,R6
*line 424
move 12(R14),R0
asr #1,R0
move R0,(sp)
move.l #_bfs,-(sp)
jsr _cnvc2p
addq.l #4,sp
*line 426
add.b #48,_bfs
*line 427
add.b #65,1+_bfs
*line 428
move.b 2+_bfs,R0
ext.w R0
ext.l R0
add.l #_sfdsp,R0
move.l R0,R8
move.b -7(R8),2+_bfs
*line 429
add.b #48,3+_bfs
*line 430
add.b #48,4+_bfs
*line 431
clr.b 5+_bfs
*line 433
clr (sp)
jsr _vbank
*line 434
move #14,(sp)
move.l #_bfs,-(sp)
move 10(R14),-(sp)
move 8(R14),-(sp)
move R6,-(sp)
move R7,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
L92:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _tdswin
.text
_tdswin:
~~tdswin:
~n=R7
link R14,#-2
movem.l R3-R7,-(sp)
~cx=R6
~i=R5
~tv=R4
~ts=-2
*line 452
move 8(R14),R7
*line 452
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
jsr _exp_c
move R0,R6
*line 456
clr (sp)
jsr _vbank
*line 457
*line 458
move R6,(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 6(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 4(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 2(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 0(R8,R9.l),-(sp)
move #128,-(sp)
move.l _tunob,-(sp)
jsr _vbfill4
adda.l #14,sp
*line 462
*line 463
move #14,(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_tdbxlb,R9
move.l 0(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 14(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 12(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 467
move R7,R0
bra L95
*line 468
L96:
*line 469
*line 470
*line 471
clr R5
bra L99
L100:
*line 472
*line 473
move #14,(sp)
move R5,R8
add.l R8,R8
add.l R8,R8
move.l #_tdlabl,R9
move.l 0(R8,R9.l),-(sp)
move #1,-(sp)
move R5,-(sp)
move #9,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 474
move R5,(sp)
add #1,(sp)
move.l #L101,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
addq.l #8,sp
*line 475
move #14,(sp)
move.l #_bfs,-(sp)
move #3,-(sp)
move R5,-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 476
*line 477
*line 478
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #320,(R8)
beq L10018
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #21920,(R8)
bne L10017
L10018:move #10,-(sp)
bra L10020
L10017:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10020:move R5,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move #6,-(sp)
move R5,-(sp)
jsr _dsttval
addq.l #8,sp
L98:
*line 471
add #1,R5
L99:
*line 471
cmp #24,R5
blt L100
L97:
*line 479
*line 480
bra L93
*line 481
*line 482
L102:
*line 483
*line 484
*line 485
move #24,R5
bra L105
L106:
*line 486
*line 487
move R5,(sp)
add #1,(sp)
move.l #L107,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
addq.l #8,sp
*line 488
move #14,(sp)
move.l #_bfs,-(sp)
move #13,-(sp)
move R5,-(sp)
add #-24,(sp)
move #10,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 489
*line 490
*line 491
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #320,(R8)
beq L10022
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #21920,(R8)
bne L10021
L10022:move #10,-(sp)
bra L10024
L10021:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10024:move R5,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move #16,-(sp)
move R5,-(sp)
add #-24,(sp)
jsr _dsttval
addq.l #8,sp
L104:
*line 485
add #1,R5
L105:
*line 485
cmp #48,R5
blt L106
L103:
*line 492
*line 493
bra L93
*line 494
*line 495
L108:
*line 496
*line 497
*line 498
move #48,R5
bra L111
L112:
*line 499
*line 500
move R5,(sp)
add #1,(sp)
move.l #L113,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
addq.l #8,sp
*line 501
move #14,(sp)
move.l #_bfs,-(sp)
move #23,-(sp)
move R5,-(sp)
add #-48,(sp)
move #10,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 502
*line 503
*line 504
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #320,(R8)
beq L10026
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #21920,(R8)
bne L10025
L10026:move #10,-(sp)
bra L10028
L10025:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10028:move R5,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move #26,-(sp)
move R5,-(sp)
add #-48,(sp)
jsr _dsttval
addq.l #8,sp
L110:
*line 498
add #1,R5
L111:
*line 498
cmp #72,R5
blt L112
L109:
*line 505
*line 506
bra L93
*line 507
*line 508
*line 509
L114:
*line 510
*line 511
*line 512
move #72,R5
bra L117
L118:
*line 513
*line 514
move R5,(sp)
add #1,(sp)
move.l #L119,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
addq.l #8,sp
*line 515
move #14,(sp)
move.l #_bfs,-(sp)
move #33,-(sp)
move R5,-(sp)
add #-72,(sp)
move #10,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 516
*line 517
*line 518
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #320,(R8)
beq L10030
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #21920,(R8)
bne L10029
L10030:move #10,-(sp)
bra L10032
L10029:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10032:move R5,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move #36,-(sp)
move R5,-(sp)
add #-72,(sp)
jsr _dsttval
addq.l #8,sp
L116:
*line 512
add #1,R5
L117:
*line 512
cmp #96,R5
blt L118
L115:
*line 519
*line 520
bra L93
*line 521
*line 522
L120:
*line 523
*line 524
*line 525
move #96,R5
bra L123
L124:
*line 526
*line 527
move R5,(sp)
add #1,(sp)
move.l #L125,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
addq.l #8,sp
*line 528
move #14,(sp)
move.l #_bfs,-(sp)
move #43,-(sp)
move R5,-(sp)
add #-96,(sp)
move #10,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 529
*line 530
*line 531
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #320,(R8)
beq L10034
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #21920,(R8)
bne L10033
L10034:move #10,-(sp)
bra L10036
L10033:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10036:move R5,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move #47,-(sp)
move R5,-(sp)
add #-96,(sp)
jsr _dsttval
addq.l #8,sp
L122:
*line 525
add #1,R5
L123:
*line 525
cmp #120,R5
blt L124
L121:
*line 532
*line 533
bra L93
*line 534
*line 535
L126:
*line 536
*line 537
*line 538
move #120,R5
bra L129
L130:
*line 539
*line 540
move R5,(sp)
add #1,(sp)
move.l #L131,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
addq.l #8,sp
*line 541
move #14,(sp)
move.l #_bfs,-(sp)
move #54,-(sp)
move R5,-(sp)
add #-120,(sp)
move #10,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 542
*line 543
*line 544
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #320,(R8)
beq L10038
move R5,R8
add.l R8,R8
add.l #_tuntab,R8
cmp #21920,(R8)
bne L10037
L10038:move #10,-(sp)
bra L10040
L10037:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10040:move R5,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move #58,-(sp)
move R5,-(sp)
add #-120,(sp)
jsr _dsttval
addq.l #8,sp
L128:
*line 538
add #1,R5
L129:
*line 538
cmp #128,R5
blt L130
L127:
*line 545
*line 546
bra L93
*line 547
*line 548
*line 549
L132:
*line 550
*line 551
*line 552
clr (sp)
jsr _td_trcp
*line 553
clr (sp)
jsr _td_incr
*line 554
clr (sp)
jsr _td_intp
*line 555
move #14,(sp)
move.l #L133,-(sp)
move #54,-(sp)
move #16,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 556
*line 557
tst _tunval
blt L10041
move _tunval,R0
bra L10043
L10041:move _tunval,R0
neg R0
L10043:move R0,R4
asr R4
*line 558
tst _tunval
blt L10044
move #43,R0
bra L10046
L10044:move #45,R0
L10046:move.b R0,-2(R14)
*line 559
move R4,(sp)
move.b -2(R14),R0
ext.w R0
move R0,-(sp) 
move.l #L134,-(sp)
move.l #_bfs,-(sp)
jsr _sprintf
adda.l #10,sp
*line 560
move #14,(sp)
move.l #_bfs,-(sp)
move #54,-(sp)
move #18,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 561
*line 562
move #14,(sp)
move.l #L135,-(sp)
move #54,-(sp)
move #20,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 563
move #14,(sp)
move.l #L136,-(sp)
move #54,-(sp)
move #22,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 564
*line 565
move #14,(sp)
move.l #L137,-(sp)
move #54,-(sp)
move #24,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 566
move _curtun,R0
add #48,R0
move.b R0,_bfs
*line 567
clr.b 1+_bfs
*line 568
*line 569
move #14,(sp)
move.l #_bfs,-(sp)
move #61,-(sp)
move #24,-(sp)
tst _tunmod
beq L10047
move #14,-(sp)
bra L10049
L10047:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10049:move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 570
bra L93
*line 571
*line 572
L138:
*line 573
*line 574
*line 575
move #14,(sp)
move.l #_tuncurn,-(sp)
move #7,-(sp)
move #24,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
bra L93
*line 576
bra L94
L95:cmp #7,R0
bhi L94
asl #2,R0
move R0,R8
add.l #L139,R8
move.l (R8),R8
jmp (R8)
.data
L139:.dc.l L96
.dc.l L102
.dc.l L108
.dc.l L114
.dc.l L120
.dc.l L126
.dc.l L132
.dc.l L138
.text
L94:L93:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _twins
.text
_twins:
~~twins:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 593
clr R7
bra L143
L144:
*line 594
move R7,(sp)
jsr _tdswin
L142:
*line 593
add #1,R7
L143:
*line 593
cmp #8,R7
blt L144
L141:L140:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _tundsp
.text
_tundsp:
~~tundsp:
link R14,#-4
*line 608
move.l #_v_score,_tunob
*line 609
move.l #_v_curs0,_obj0
*line 610
move.l #_v_tcur,_obj2
*line 611
move.l #144+_v_obtab,_tdoct
*line 613
clr _ttcmdsv
*line 614
clr _tdnamsw
*line 615
clr _submenu
*line 617
jsr _dswap
*line 619
*line 620
clr R0
move 10+_v_regs,R0
and #384,R0
beq L146
*line 620
clr (sp)
jsr _vbank
*line 621
L146:
*line 622
move #32767,(sp)
clr -(sp)
move.l _tunob,-(sp)
jsr _memsetw
addq.l #6,sp
*line 623
move #12033,(sp)
clr -(sp)
move.l _tunob,R0
add.l #$fffe,R0
move.l R0,-(sp)
jsr _memsetw
addq.l #6,sp
*line 625
move #-1,(sp)
move #1536,-(sp)
clr -(sp)
clr -(sp)
move #350,-(sp)
move #512,-(sp)
move.l _tunob,-(sp)
clr -(sp)
clr -(sp)
move #8,-(sp)
jsr _SetObj
adda.l #20,sp
*line 626
move #-1,(sp)
move #1540,-(sp)
move #336,-(sp)
move #488,-(sp)
move #16,-(sp)
move #16,-(sp)
move.l _obj0,-(sp)
move #1,-(sp)
clr -(sp)
clr -(sp)
jsr _SetObj
adda.l #20,sp
*line 627
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
*line 629
move #1,(sp)
jsr _arcurs
*line 630
move #1,(sp)
jsr _itcini
*line 631
move #3,(sp)
jsr _ttcini
*line 633
jsr _twins
*line 635
move #8,(sp)
move #8,-(sp)
jsr _SetPri
addq.l #2,sp
*line 637
move #61,(sp)
move #24,-(sp)
jsr _settc
addq.l #2,sp
*line 639
move.l #_tunpal,(sp)
jsr _vsndpal
L145:unlk R14
rts
.data
L3:.dc.b $43,$0
L4:.dc.b $23,$0
L5:.dc.b $44,$0
L6:.dc.b $23,$0
L7:.dc.b $45,$0
L8:.dc.b $46,$0
L9:.dc.b $23,$0
L10:.dc.b $47,$0
L11:.dc.b $23,$0
L12:.dc.b $41,$0
L13:.dc.b $23,$0
L14:.dc.b $42,$0
L15:.dc.b $43,$0
L16:.dc.b $23,$0
L17:.dc.b $44,$0
L18:.dc.b $23,$0
L19:.dc.b $45,$0
L20:.dc.b $46,$0
L21:.dc.b $23,$0
L22:.dc.b $47,$0
L23:.dc.b $23,$0
L24:.dc.b $41,$0
L25:.dc.b $23,$0
L26:.dc.b $42,$0
L78:.dc.b $54,$72,$61,$6E,$73,$70,$6F,$73,$65,$0
L79:.dc.b $61,$6E,$64,$20,$43,$6F,$70,$79,$0
L81:.dc.b $49,$6E,$63,$72,$65,$6D,$65,$6E,$74,$0
L83:.dc.b $49,$6E,$74,$72,$70,$6F,$6C,$61,$74,$0
L101:.dc.b $25,$32,$64,$0
L107:.dc.b $25,$32,$64,$0
L113:.dc.b $25,$32,$64,$0
L119:.dc.b $25,$32,$64,$0
L125:.dc.b $25,$33,$64,$0
L131:.dc.b $25,$33,$64,$0
L133:.dc.b $55,$6E,$64,$6F,$0
L134:.dc.b $56,$61,$6C,$20,$25,$63,$25,$30,$34,$64,$0
L135:.dc.b $53,$74,$6F,$72,$65,$0
L136:.dc.b $52,$65,$74,$72,$69,$65,$76,$65,$0
L137:.dc.b $54,$61,$62,$6C,$65,$20,$23,$0
