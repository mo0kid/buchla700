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
.globl _obj8
.globl _ctrsw
.globl _recsw
.globl _stccol
.globl _stcrow
.globl _s_trns
.globl _dspbuf
.globl _grpdyn
.globl _grpmode
.globl _grpstat
.globl _gdstbc
.globl _et_trns
.text
_et_trns:
~~et_trns:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~trval=R7
~trsign=R6
*line 52
move 8(R14),R8
add.l R8,R8
add.l #_s_trns,R8
move (R8),R7
*line 54
*line 54
tst R7
bge L2
*line 55
*line 56
move R7,R0
neg R0
move R0,R7
*line 57
move.b #45,R6
*line 58
bra L3
L2:
*line 59
*line 60
*line 61
move.b #43,R6
L3:
*line 64
move.b R6,R0
ext.w R0
move R0,(sp) 
move R7,-(sp)
move.l #L4,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 66
move #1,_ebflag
*line 72
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ef_trns
.text
_ef_trns:
~~ef_trns:
~n=8
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~i=R7
~trval=R6
~ep=R13
~trnval=R12
*line 91
clr.b 5+_ebuf
*line 97
clr _ebflag
*line 98
clr R6
*line 100
clr R7
bra L8
L9:
*line 101
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L7:
*line 100
add #1,R7
L8:
*line 100
cmp #4,R7
blt L9
L6:
*line 103
*line 104
cmp #1200,R6
ble L10
*line 104
move #-1,R0
bra L5
*line 105
L10:
*line 106
*line 107
cmp.b #45,4+_ebuf
bne L11
*line 107
move R6,R0
neg R0
move R0,R6
*line 108
L11:
*line 109
move 8(R14),R8
add.l R8,R8
add.l #_s_trns,R8
move R6,(R8)
*line 110
jsr _settune
*line 112
*line 112
tst _recsw
beq L12
move 8(R14),R8
add.l R8,R8
move.l #_grpmode,R9
tst 0(R8,R9.l)
beq L12
move 8(R14),R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L12
*line 113
*line 114
move R6,R0
ext.l R0
move.l #$10,R1
asl.l R1,R0
move.l R0,R12
*line 115
*line 116
*line 116
move #-1,(sp)
move 8(R14),-(sp)
move #17,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L13
*line 117
*line 118
move.l R12,24(R13)
*line 119
bra L14
L13:
*line 120
*line 120
move #8,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L15
*line 121
*line 122
move.b #17,5(R13)
*line 123
move.l _t_cur,(R13)
*line 124
move 8(R14),R0
move.b R0,6(R13)
*line 125
move.l R12,24(R13)
*line 126
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
*line 127
move #5,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 128
move #1,_ctrsw
*line 129
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 130
jsr _scupd
*line 131
L15:L14:
*line 132
*line 133
*line 136
L12:
*line 137
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.globl _rd_trns
.text
_rd_trns:
~~rd_trns:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~trval=R7
~i=R6
~trsign=R5
*line 156
move 8(R14),R8
add.l R8,R8
add.l #_s_trns,R8
move (R8),R7
*line 158
*line 158
tst R7
bge L17
*line 159
*line 160
move.b #45,R5
*line 161
move R7,R0
neg R0
move R0,R7
*line 162
bra L18
L17:
*line 163
*line 164
*line 165
move.b #43,R5
L18:
*line 168
move R7,(sp)
move.l #L19,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 174
*line 174
cmp.b #45,R5
bne L20
*line 175
*line 176
*line 177
cmp.b #49,_dspbuf
bne L21
*line 177
move.b #161,_dspbuf
*line 178
bra L22
L21:
*line 179
move.b #45,_dspbuf
L22:
*line 180
bra L23
L20:
*line 181
*line 182
*line 183
*line 184
cmp.b #49,_dspbuf
bne L24
*line 184
move.b #160,_dspbuf
*line 185
bra L25
L24:
*line 186
move.b #43,_dspbuf
L25:L23:
*line 194
*line 195
clr R0
move 10+_v_regs,R0
and #384,R0
beq L26
*line 195
clr (sp)
jsr _vbank
*line 196
L26:
*line 197
move #18,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
add #1,R0
muls #5,R0
move R0,-(sp)
move #3,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 199
clr R0
bra L16
L16:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _ds_trns
.text
_ds_trns:
~~ds_trns:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 215
clr R7
bra L30
L31:
*line 216
move R7,(sp)
jsr _rd_trns
L29:
*line 215
add #1,R7
L30:
*line 215
cmp #12,R7
blt L31
L28:L27:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_trns
.text
_nd_trns:
~~nd_trns:
~k=R7
~n=8
link R14,#0
movem.l R3-R7,-(sp)
~ec=R6
~c=R5
~advsw=R4
*line 235
move 10(R14),R7
*line 235
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 242
move #1,R4
*line 244
*line 244
tst R6
bne L33
*line 245
*line 246
move R7,R0
bra L35
*line 247
L36:
*line 248
*line 249
*line 250
move.b #48,_ebuf
*line 251
move.b 4+_ebuf,R7
ext.w R7
bra L34
*line 252
*line 253
L37:
*line 254
*line 255
*line 256
*line 257
cmp.b #43,4+_ebuf
bne L38
*line 257
move #160,R7
*line 258
bra L39
L38:
*line 259
move #161,R7
L39:
*line 260
*line 261
move.b #49,_ebuf
bra L34
*line 262
*line 263
L40:
*line 264
*line 265
*line 266
*line 267
cmp.b #48,_ebuf
bne L41
*line 267
move #45,R7
*line 268
bra L42
L41:
*line 269
move #161,R7
L42:
*line 270
*line 271
move.b #45,4+_ebuf
*line 272
clr R4
bra L34
*line 273
*line 274
*line 275
L43:
*line 276
*line 277
*line 278
*line 279
cmp.b #48,_ebuf
bne L44
*line 279
move #43,R7
*line 280
bra L45
L44:
*line 281
move #160,R7
L45:
*line 282
*line 283
move.b #43,4+_ebuf
*line 284
clr R4
bra L34
*line 285
*line 286
L46:
*line 287
*line 288
*line 289
move #-1,R0
bra L32
bra L34
L35:tst R0
beq L36
cmp #1,R0
beq L37
cmp #8,R0
beq L40
cmp #9,R0
beq L43
bra L46
L34:
*line 290
*line 291
bra L47
L33:
*line 292
*line 293
*line 294
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
L47:
*line 297
cmp #9,R7
ble L10000
move R7,R0
bra L10002
L10000:move R7,R0
add #48,R0
L10002:move.b R0,_dspbuf
*line 298
clr.b 1+_dspbuf
*line 300
*line 301
clr R0
move 10+_v_regs,R0
and #384,R0
beq L48
*line 301
clr (sp)
jsr _vbank
*line 302
L48:
*line 303
move #98,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move #3,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 309
*line 310
tst R4
beq L49
*line 310
jsr _advscur
*line 311
L49:
*line 312
clr R0
bra L32
L32:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.data
L4:.dc.b $25,$30,$34,$2E,$34,$64,$25,$63,$0
L19:.dc.b $25,$30,$34,$2E,$34,$64,$0
