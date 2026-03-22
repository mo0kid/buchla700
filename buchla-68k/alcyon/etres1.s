.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
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
.globl _ancmsw
.globl _angroup
.globl _ctrsw
.globl _recsw
.globl _stccol
.globl _obj8
.globl _anrs
.globl _grpmode
.globl _grpstat
.globl _var2src
.globl _varmode
.globl _gdstbc
.globl _valents
.globl _et_res1
.text
_et_res1:
~~et_res1:
~n=8
link R14,#-4
*line 49
move 8(R14),R0
asl #5,R0
ext.l R0
tst _angroup
bge L10000
move _angroup,R1
neg R1
bra L10002
L10000:move _angroup,R1
L10002:sub #1,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_anrs,R9
move 0(R8,R9.l),R0
move.b R0,_ebuf
*line 50
move #1,_ebflag
*line 51
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_res1
.text
_ef_res1:
~~ef_res1:
~n=8
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~ival=R7
~grp=R6
~vg=R5
~ep=R13
*line 70
clr _ebflag
*line 71
tst _angroup
bge L10003
move _angroup,R0
neg R0
bra L10005
L10003:move _angroup,R0
L10005:move R0,R6
sub #1,R6
*line 72
move.b _ebuf,R7
ext.w R7
and #255,R7
*line 74
*line 75
cmp #3,R7
blt L10006
cmp #8,R7
ble L3
L10006:*line 75
move #-1,R0
bra L2
*line 76
L3:
*line 77
move 8(R14),R0
asl #5,R0
ext.l R0
move R6,R1
asl #1,R1
ext.l R1
add.l R1,R0
add.l #_anrs,R0
move.l R0,R8
move R7,(R8)
*line 79
*line 80
tst _recsw
beq L4
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L4
tst _ancmsw
beq L10007
move 8(R14),R0
asl #5,R0
ext.l R0
move R6,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_varmode,R9
move 0(R8,R9.l),R0
bra L10009
L10007:move R6,R8
add.l R8,R8
move.l #_grpmode,R9
move 0(R8,R9.l),R0
L10009:cmp #2,R0
bne L4
*line 81
*line 82
move R6,R5
move 8(R14),R0
asl #4,R0
or R0,R5
*line 83
*line 84
*line 84
move #-1,(sp)
move R5,-(sp)
move #15,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L5
*line 85
*line 86
move.b R7,7(R13)
*line 87
bra L6
L5:
*line 88
*line 88
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L7
*line 89
*line 90
move.b #15,5(R13)
*line 91
move.b R5,6(R13)
*line 92
move.b R7,7(R13)
*line 93
move.l _t_cur,(R13)
*line 94
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
*line 95
move #4,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 96
move #1,_ctrsw
*line 97
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 98
jsr _scupd
*line 99
L7:L6:
*line 100
*line 101
L4:
*line 102
clr R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _rd_res1
.text
_rd_res1:
~~rd_res1:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~grp=R7
~chr=R6
*line 120
tst _angroup
bge L10010
move _angroup,R0
neg R0
bra L10012
L10010:move _angroup,R0
L10012:move R0,R7
sub #1,R7
*line 122
move 8(R14),R0
asl #5,R0
ext.l R0
move R7,R1
asl #1,R1
ext.l R1
add.l R1,R0
add.l #_anrs,R0
move.l R0,R8
move (R8),R6
add #48,R6
*line 124
*line 125
clr R0
move 10+_v_regs,R0
and #384,R0
beq L9
*line 125
clr (sp)
jsr _vbank
*line 126
L9:
*line 127
move #18,(sp)
move R6,-(sp)
move 8(R14),R0
muls #9,R0
move R0,-(sp)
add #6,(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 129
clr R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_res1
.text
_nd_res1:
~~nd_res1:
~n=8
~k=10
link R14,#-4
*line 145
move 10(R14),R0
move.b R0,_ebuf
*line 147
*line 148
clr R0
move 10+_v_regs,R0
and #384,R0
beq L11
*line 148
clr (sp)
jsr _vbank
*line 149
L11:
*line 150
move #98,(sp)
move 10(R14),-(sp)
add #48,(sp)
move _stccol,-(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 152
clr R0
bra L10
L10:unlk R14
rts
.globl _et_aval
.text
_et_aval:
~~et_aval:
~n=8
link R14,#-6
movem.l R4-R7,-(sp)
~val=R7
~grp=R6
~gs=R5
~val1=-2
~val2=-4
~val3=-6
*line 171
tst _angroup
bge L10013
move _angroup,R0
neg R0
bra L10015
L10013:move _angroup,R0
L10015:move R0,R6
sub #1,R6
*line 172
move R6,R5
asl #4,R5
move 8(R14),R8
add.l R8,R8
add.l #_var2src,R8
move (R8),R0
or R0,R5
*line 173
move R5,R0
muls #10,R0
add.l #_valents,R0
move.l R0,R8
move 8(R8),R7
asr #5,R7
*line 175
*line 175
tst R7
bge L13
*line 176
*line 177
move.b #8,_ebuf
*line 178
move R7,R0
neg R0
move R0,R7
*line 179
bra L14
L13:
*line 180
*line 181
*line 182
move.b #9,_ebuf
L14:
*line 185
move R7,R0
ext.l R0
divs #100,R0
move R0,-2(R14)
*line 186
move R7,R0
move -2(R14),R1
muls #100,R1
sub R1,R0
ext.l R0
divs #10,R0
move.b R0,4+_ebuf
*line 187
move -2(R14),R0
ext.l R0
divs #10,R0
move R0,-4(R14)
*line 188
move -2(R14),R0
move -4(R14),R1
muls #10,R1
sub R1,R0
move.b R0,2+_ebuf
*line 189
move -4(R14),R0
move.b R0,1+_ebuf
*line 191
move #1,_ebflag
*line 193
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _ef_aval
.text
_ef_aval:
~~ef_aval:
~n=8
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~val=R7
~grp=R6
~src=R5
~vg=R4
~ep=R13
*line 212
clr _ebflag
*line 213
tst _angroup
bge L10016
move _angroup,R0
neg R0
bra L10018
L10016:move _angroup,R0
L10018:move R0,R6
sub #1,R6
*line 214
move 8(R14),R8
add.l R8,R8
add.l #_var2src,R8
move (R8),R5
*line 215
move.b 1+_ebuf,R7
ext.w R7
muls #100,R7
move.b 2+_ebuf,R0
ext.w R0
muls #10,R0
add R0,R7
move.b 4+_ebuf,R0
ext.w R0
add R0,R7
muls #10,R7
*line 217
*line 218
cmp #1000,R7
ble L16
*line 218
move #-1,R0
bra L15
*line 219
L16:
*line 220
*line 221
cmp.b #8,_ebuf
bne L17
*line 221
move R7,R0
neg R0
move R0,R7
*line 222
L17:
*line 223
asl #5,R7
*line 225
move R7,(sp)
move R5,-(sp)
move R6,-(sp)
jsr _setsv
addq.l #4,sp
*line 227
*line 228
tst _recsw
beq L18
move R6,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L18
tst _ancmsw
beq L10019
move 8(R14),R0
asl #5,R0
ext.l R0
move R6,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_varmode,R9
move 0(R8,R9.l),R0
bra L10021
L10019:move R6,R8
add.l R8,R8
move.l #_grpmode,R9
move 0(R8,R9.l),R0
L10021:cmp #2,R0
bne L18
*line 229
*line 230
move R6,R4
move 8(R14),R0
asl #4,R0
or R0,R4
*line 231
*line 232
*line 232
move #-1,(sp)
move R4,-(sp)
move #14,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L19
*line 233
*line 234
move R7,R0
ext.l R0
move.l #$10,R1
asl.l R1,R0
move.l R0,16(R13)
*line 235
bra L20
L19:
*line 236
*line 236
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L21
*line 237
*line 238
move.b #14,5(R13)
*line 239
move.b R4,6(R13)
*line 240
move R7,R0
ext.l R0
move.l #$10,R1
asl.l R1,R0
move.l R0,16(R13)
*line 241
move.l _t_cur,(R13)
*line 242
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
*line 243
move #1,_ctrsw
*line 244
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 245
jsr _scupd
*line 246
L21:L20:
*line 247
*line 248
L18:
*line 249
clr R0
bra L15
L15:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _rd_aval
.text
_rd_aval:
~~rd_aval:
~n=8
link R14,#-10
movem.l R4-R7,-(sp)
~grp=R7
~val=R6
~gs=R5
~val1=-2
~val2=-4
~buf=-10
*line 269
tst _angroup
bge L10022
move _angroup,R0
neg R0
bra L10024
L10022:move _angroup,R0
L10024:move R0,R7
sub #1,R7
*line 270
move R7,R5
asl #4,R5
move 8(R14),R8
add.l R8,R8
add.l #_var2src,R8
move (R8),R0
or R0,R5
*line 271
move R5,R0
muls #10,R0
add.l #_valents,R0
move.l R0,R8
move 8(R8),R6
asr #5,R6
*line 273
*line 273
tst R6
bge L23
*line 274
*line 275
move.b #45,-10(R14)
*line 276
move R6,R0
neg R0
move R0,R6
*line 277
bra L24
L23:
*line 278
*line 279
*line 280
move.b #43,-10(R14)
L24:
*line 283
move R6,R0
ext.l R0
divs #100,R0
move R0,-2(R14)
*line 284
move R6,R0
move -2(R14),R1
muls #100,R1
sub R1,R0
ext.l R0
divs #10,R0
add #48,R0
move.b R0,-6(R14)
*line 285
move -2(R14),R0
ext.l R0
divs #10,R0
move R0,-4(R14)
*line 286
move -2(R14),R0
move -4(R14),R1
muls #10,R1
sub R1,R0
add #48,R0
move.b R0,-8(R14)
*line 287
move -4(R14),R0
add #48,R0
move.b R0,-9(R14)
*line 288
move.b #46,-7(R14)
*line 289
clr.b -5(R14)
*line 291
*line 292
clr R0
move 10+_v_regs,R0
and #384,R0
beq L25
*line 292
clr (sp)
jsr _vbank
*line 293
L25:
*line 294
move #18,(sp)
move.l R14,-(sp)
add.l #-10,(sp)
move 8(R14),R0
muls #9,R0
move R0,-(sp)
add #8,(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 296
clr R0
bra L22
L22:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _nd_aval
.text
_nd_aval:
~~nd_aval:
~n=R7
~k=R6
link R14,#0
movem.l R4-R7,-(sp)
~ec=R5
*line 314
move 8(R14),R7
*line 314
move 10(R14),R6
*line 314
move _stccol,R5
move.l _cfetp,R8
move 2(R8),R0
sub R0,R5
*line 316
*line 317
cmp #3,R5
bne L27
*line 317
move #-1,R0
bra L26
*line 318
L27:
*line 319
move R6,R0
move R5,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 321
*line 322
tst R5
bne L28
*line 322
cmp #8,R6
bne L10025
move #45,R0
bra L10027
L10025:move #43,R0
L10027:move R0,R6
*line 323
bra L29
L28:
*line 324
add #48,R6
L29:
*line 326
*line 327
clr R0
move 10+_v_regs,R0
and #384,R0
beq L30
*line 327
clr (sp)
jsr _vbank
*line 328
L30:
*line 329
move #98,(sp)
move R6,-(sp)
move _stccol,-(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 331
*line 332
cmp #4,R5
bne L31
*line 332
clr R0
bra L26
*line 333
L31:
*line 334
jsr _advscur
*line 336
*line 337
cmp #2,R5
bne L32
*line 337
jsr _advscur
*line 338
L32:
*line 339
clr R0
bra L26
L26:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _et_agrp
.text
_et_agrp:
~~et_agrp:
~n=8
link R14,#-4
*line 355
tst _angroup
bge L10028
move _angroup,R0
neg R0
move R0,(sp)
bra L10030
L10028:move _angroup,(sp)
L10030:move.l #L34,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 356
move #1,_ebflag
*line 357
clr R0
bra L33
L33:unlk R14
rts
.globl _ef_agrp
.text
_ef_agrp:
~~ef_agrp:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~ival=R7
*line 375
clr _ebflag
*line 376
move.b _ebuf,R7
ext.w R7
add #-48,R7
muls #10,R7
move.b 1+_ebuf,R0
ext.w R0
add R0,R7
add #-48,R7
*line 378
*line 379
cmp #12,R7
bgt L10031
cmp #1,R7
bge L36
L10031:*line 379
move #-1,R0
bra L35
*line 380
L36:
*line 381
tst _angroup
bge L10032
move R7,R0
neg R0
bra L10034
L10032:move R7,R0
L10034:move R0,_angroup
*line 383
jsr _ds_anmd
*line 384
jsr _ds_anrs
*line 385
jsr _ds_anvl
*line 386
clr R0
bra L35
L35:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_agrp
.text
_rd_agrp:
~~rd_agrp:
~n=8
link R14,#-8
~buf=-4
*line 404
tst _angroup
bge L10035
move _angroup,R0
neg R0
move R0,(sp)
bra L10037
L10035:move _angroup,(sp)
L10037:move.l #L38,-(sp)
move.l R14,-(sp)
sub.l #4,(sp)
jsr _sprintf
addq.l #8,sp
*line 406
*line 407
clr R0
move 10+_v_regs,R0
and #384,R0
beq L39
*line 407
clr (sp)
jsr _vbank
*line 408
L39:
*line 409
move #18,(sp)
move.l R14,-(sp)
sub.l #4,(sp)
move #61,-(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 411
clr R0
bra L37
L37:unlk R14
rts
.globl _nd_agrp
.text
_nd_agrp:
~~nd_agrp:
~n=8
~k=10
link R14,#0
movem.l R6-R7,-(sp)
~ec=R7
*line 429
move _stccol,R7
move.l _cfetp,R8
move 2(R8),R0
sub R0,R7
*line 431
move 10(R14),R0
add #48,R0
move R7,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 433
*line 434
clr R0
move 10+_v_regs,R0
and #384,R0
beq L41
*line 434
clr (sp)
jsr _vbank
*line 435
L41:
*line 436
move #98,(sp)
move 10(R14),-(sp)
add #48,(sp)
move _stccol,-(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 437
jsr _advscur
*line 439
clr R0
bra L40
L40:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
L34:.dc.b $25,$30,$32,$2E,$32,$64,$0
L38:.dc.b $25,$30,$32,$2E,$32,$64,$0
