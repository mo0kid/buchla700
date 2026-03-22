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
.globl _scrl
.globl _curfunc
.globl _curvce
.globl _sbase
.globl _sd
.globl _se
.globl _soffset
.globl _subj
.globl _varmode
.globl _gdstbc
.globl _gdstbn
.globl _gdstbp
.globl _gdfsep
.globl _gdfsl
.globl _vbufs
.globl _idbxlbl
.globl _osclbl
.globl _A6PTR
.data
_A6PTR:
.dc.l $0
.globl _A7PTR
.data
_A7PTR:
.dc.l $0
.globl _A7TOP
.data
_A7TOP:
.dc.l $FFFFF
.globl _SCnumv
.data
_SCnumv:
.dc.w $0
.globl _SL_Flag
.comm _SL_Flag,2
.globl _x_unrec
.comm _x_unrec,2
.globl _SCdlim
.data
_SCdlim:
.dc.l $8000
.globl _evkinds
.data
_evkinds:
*line 59
.dc.l L1
*line 59
.dc.l L2
*line 60
.dc.l L3
*line 60
.dc.l L4
*line 61
.dc.l L5
*line 61
.dc.l L6
*line 62
.dc.l L7
*line 62
.dc.l L8
*line 63
.dc.l L9
*line 63
.dc.l L10
*line 64
.dc.l L11
*line 64
.dc.l L12
*line 65
.dc.l L13
*line 65
.dc.l L14
*line 66
.dc.l L15
*line 66
.dc.l L16
*line 67
.dc.l L17
*line 67
.dc.l L18
*line 68
.dc.l L19
*line 68
.dc.l L20
*line 69
.dc.l L21
*line 69
.dc.l L22
*line 70
.dc.l L23
*line 71
.dc.l L24
.ds.b 4
.globl _hpname
.data
_hpname:
*line 75
.dc.l L25
*line 75
.dc.l L26
*line 75
.dc.l L27
*line 75
.dc.l L28
*line 76
.dc.l L29
*line 76
.dc.l L30
*line 76
.dc.l L31
*line 76
.dc.l L32
*line 77
.dc.l L33
*line 77
.dc.l L34
*line 77
.dc.l L35
*line 78
.dc.l L36
.globl _var_lbl
.data
_var_lbl:
*line 82
.dc.l L37
*line 82
.dc.l L38
*line 82
.dc.l L39
*line 82
.dc.l L40
*line 83
.dc.l L41
*line 84
.dc.l L42
.globl _srcname
.data
_srcname:
*line 88
.dc.l L43
*line 88
.dc.l L44
*line 88
.dc.l L45
*line 88
.dc.l L46
*line 88
.dc.l L47
*line 88
.dc.l L48
*line 88
.dc.l L49
*line 88
.dc.l L50
*line 89
.dc.l L51
*line 89
.dc.l L52
*line 89
.dc.l L53
*line 89
.dc.l L54
*line 89
.dc.l L55
*line 90
.dc.l L56
.globl _actname
.data
_actname:
*line 94
.dc.l L57
*line 94
.dc.l L58
*line 94
.dc.l L59
*line 94
.dc.l L60
*line 94
.dc.l L61
*line 94
.dc.l L62
*line 94
.dc.l L63
*line 95
.dc.l L64
.globl _ev_kind
.text
_ev_kind:
~~ev_kind:
~sep=8
link R14,#-4
*line 112
*line 112
move.l 8(R14),R8
move.b 5(R8),R0
ext.w R0
and #255,R0
cmp #25,R0
blt L66
*line 113
*line 114
move #1,_x_unrec
*line 115
clr.l R0
bra L65
*line 116
*line 117
L66:
*line 118
clr _x_unrec
*line 120
move.l 8(R14),R8
move.b 5(R8),R0
ext.w R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_evkinds,R9
move.l 0(R8,R9.l),R0
bra L65
L65:unlk R14
rts
.globl _SEctrl
.text
_SEctrl:
~~SEctrl:
link R14,#-4
*line 134
*line 135
move.l _scp,(sp)
move _cursect,-(sp)
move _curscor,R0
asl #4,R0
ext.l R0
add.l #_scname,R0
move.l R0,-(sp)
move _curscor,-(sp)
move.l #L68,-(sp)
jsr _printf
adda.l #12,sp
*line 138
*line 139
move _fc_sw,(sp)
move.l _fc_val,-(sp)
move.l #L69,-(sp)
jsr _printf
addq.l #8,sp
*line 142
*line 143
move.l _t_fwd,(sp)
move.l _t_ctr,-(sp)
move.l _t_cur,-(sp)
move.l _t_bak,-(sp)
move.l #L70,-(sp)
jsr _printf
adda.l #16,sp
*line 145
*line 146
move.l _p_fwd,(sp)
move.l _p_ctr,-(sp)
move.l _p_cur,-(sp)
move.l _p_bak,-(sp)
move.l #L71,-(sp)
jsr _printf
adda.l #16,sp
L67:unlk R14
rts
.globl _SEsnap
.text
_SEsnap:
~~SEsnap:
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~j=R6
*line 160
move.l #L73,(sp)
jsr _printf
*line 162
*line 163
move.l _frags,(sp)
move.l _spcount,-(sp)
jsr _evleft
move.l R0,-(sp)
move.l #L74,-(sp)
jsr _printf
adda.l #12,sp
*line 165
*line 166
move.l _se3_cnt,(sp)
move.l _se2_cnt,-(sp)
move.l _se1_cnt,-(sp)
move.l #L75,-(sp)
jsr _printf
adda.l #12,sp
*line 168
*line 169
move.l _size3,(sp)
move.l _size2,-(sp)
move.l _size1,-(sp)
move.l _pspool,-(sp)
move.l #L76,-(sp)
jsr _printf
adda.l #16,sp
*line 171
jsr _SEctrl
*line 173
clr R7
bra L79
L80:
*line 174
*line 175
*line 176
cmp _curscor,R7
bne L10000
move.l #L82,(sp)
bra L10002
L10000:move.l #L83,(sp)
L10002:move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_scores,R9
move.l 0(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
add.l #_scname,R0
move.l R0,-(sp)
move R7,-(sp)
add #1,(sp)
move.l #L81,-(sp)
jsr _printf
adda.l #14,sp
L78:
*line 173
add #1,R7
L79:
*line 173
cmp #20,R7
blt L80
L77:
*line 178
move.l #L84,(sp)
jsr _printf
*line 180
move.l #L85,(sp)
jsr _printf
*line 182
move.l #L86,(sp)
jsr _printf
*line 183
move.l #L87,(sp)
jsr _printf
*line 185
clr R7
bra L90
L91:
*line 186
*line 187
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_var_lbl,R9
move.l 0(R8,R9.l),(sp)
move R7,-(sp)
move.l #L92,-(sp)
jsr _printf
addq.l #6,sp
*line 188
*line 189
clr R6
bra L95
L96:
*line 190
move R7,R0
asl #5,R0
ext.l R0
move R6,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_varmode,R9
move 0(R8,R9.l),(sp)
move.l #L97,-(sp)
jsr _printf
addq.l #4,sp
L94:
*line 189
add #1,R6
L95:
*line 189
cmp #12,R6
blt L96
L93:
*line 190
*line 191
*line 192
move.l #L98,(sp)
jsr _printf
L89:
*line 185
add #1,R7
L90:
*line 185
cmp #6,R7
blt L91
L88:
*line 195
move.l #L99,(sp)
jsr _printf
L72:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _SEdump
.text
_SEdump:
~~SEdump:
~sep=8
link R14,#-8
~et=-4
*line 215
move #1,_x_unrec
*line 217
move.l 8(R14),R8
move.b 4(R8),R0
ext.w R0
bra L102
*line 218
L103:
*line 219
L104:
*line 220
L105:
*line 221
*line 222
bra L101
*line 223
*line 224
L106:
*line 225
*line 226
*line 227
*line 228
move.l 8(R14),R8
move.b 4(R8),R0
ext.w R0
move R0,(sp) 
move.l 8(R14),-(sp)
move.l #L107,-(sp)
jsr _printf
addq.l #8,sp
*line 229
*line 230
move.l 8(R14),R0
bra L100
bra L101
L102:cmp #5,R0
beq L103
cmp #6,R0
beq L104
cmp #8,R0
beq L105
bra L106
L101:
*line 233
*line 233
move.l 8(R14),(sp)
jsr _ev_kind
move.l R0,-4(R14)
bne L108
*line 234
*line 235
*line 236
move.l 8(R14),R8
move.b 5(R8),R0
ext.w R0
move R0,(sp) 
move.l 8(R14),-(sp)
move.l #L109,-(sp)
jsr _printf
addq.l #8,sp
*line 237
*line 238
move.l 8(R14),R0
bra L100
*line 239
*line 240
L108:
*line 241
clr _x_unrec
*line 243
*line 244
move.l -4(R14),(sp)
move.l 8(R14),R8
move.l 8(R8),-(sp)
move.l 8(R14),R8
move.l 12(R8),-(sp)
move.l 8(R14),R8
move.l (R8),-(sp)
move.l 8(R14),-(sp)
move.l #L110,-(sp)
jsr _printf
adda.l #20,sp
*line 246
*line 247
move.l 8(R14),R8
move.b 7(R8),R0
ext.w R0
move R0,(sp) 
and #255,(sp)
move.l 8(R14),R8
move.b 6(R8),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.l #L111,-(sp)
jsr _printf
addq.l #6,sp
*line 249
*line 250
move.l 8(R14),R8
cmp.b #5,4(R8)
bne L112
*line 251
*line 252
move.l 8(R14),R8
move 18(R8),R0
ext.l R0
move.l R0,(sp)
move.l 8(R14),R8
move 16(R8),R0
ext.l R0
move.l R0,-(sp)
move.l #L113,-(sp)
jsr _printf
addq.l #8,sp
*line 253
L112:
*line 254
move.l #L114,(sp)
jsr _printf
*line 256
*line 257
move.l 8(R14),R8
cmp.b #5,4(R8)
ble L115
*line 258
move.l 8(R14),R8
move.l 16(R8),(sp)
move.l 8(R14),R8
move.l 20(R8),-(sp)
move.l #L116,-(sp)
jsr _printf
addq.l #8,sp
*line 259
bra L117
L115:
*line 260
move.l 8(R14),R0
bra L100
L117:
*line 262
*line 263
move.l 8(R14),R8
cmp.b #6,4(R8)
ble L118
*line 264
move.l 8(R14),R8
move.l 28(R8),(sp)
move.l 8(R14),R8
move.l 24(R8),-(sp)
move.l #L119,-(sp)
jsr _printf
addq.l #8,sp
*line 265
L118:
*line 266
move.l #L120,(sp)
jsr _printf
*line 268
move.l 8(R14),R0
bra L100
L100:unlk R14
rts
.globl _SEchase
.text
_SEchase:
~~SEchase:
~ep=R13
~n=R7
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~i=R6
~np=R12
*line 289
move.l 8(R14),R13
*line 289
move.l 12(R14),R7
*line 289
move.l #L122,(sp)
jsr _printf
*line 291
*line 291
move.l R13,R0
bne L123
*line 292
*line 293
move.l #L124,(sp)
jsr _printf
*line 294
move.l _scp,R0
bra L121
*line 295
*line 296
L123:
*line 297
*line 298
move.l #L125,(sp)
move.l R13,-(sp)
jsr _Pcheck
addq.l #4,sp
tst R0
beq L126
*line 298
move.l _scp,R0
bra L121
*line 299
L126:
*line 300
clr.l R6
bra L129
L130:
*line 301
*line 302
move.l R13,(sp)
jsr _SEdump
*line 303
*line 304
*line 305
cmp.b #21,5(R13)
beq L10003
tst _x_unrec
beq L131
L10003:*line 305
move.l _scp,R0
bra L121
*line 306
L131:
*line 307
move.l 12(R13),R12
*line 308
*line 309
*line 310
move.l #L132,(sp)
move.l R12,-(sp)
jsr _Pcheck
addq.l #4,sp
tst R0
beq L133
*line 310
move.l _scp,R0
bra L121
*line 311
L133:
*line 312
*line 313
move.l #L134,(sp)
move.l 8(R13),-(sp)
jsr _Pcheck
addq.l #4,sp
tst R0
beq L135
*line 313
move.l _scp,R0
bra L121
*line 314
L135:
*line 315
move.l R12,R13
L128:
*line 300
add.l #$1,R6
L129:
*line 300
cmp.l R7,R6
blt L130
L127:
*line 318
move.l #L136,(sp)
jsr _printf
*line 320
move.l R13,R0
bra L121
L121:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.globl _SLdump
.text
_SLdump:
~~SLdump:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~i=R7
~gp=R13
*line 337
move.l #L138,(sp)
jsr _printf
*line 339
*line 340
move _scrl,(sp)
move _soffset,-(sp)
move _sbase,-(sp)
tst _se
beq L10004
move.l #L142,-(sp)
bra L10006
L10004:move.l #L143,-(sp)
L10006:tst _sd
beq L10007
move.l #L140,-(sp)
bra L10009
L10007:move.l #L141,-(sp)
L10009:move.l #L139,-(sp)
jsr _printf
adda.l #16,sp
*line 342
move.l _gdfsep,(sp)
move.l #L144,-(sp)
jsr _printf
addq.l #4,sp
*line 344
move.l #L145,(sp)
jsr _printf
*line 345
move.l #_gdstbn,(sp)
move.l #_gdstbc,-(sp)
move.l #_gdstbp,-(sp)
move.l #L146,-(sp)
jsr _printf
adda.l #12,sp
*line 346
move.l #L147,(sp)
jsr _printf
*line 348
clr R7
bra L150
L151:
*line 349
*line 350
*line 351
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_gdstbn,R9
move.l 0(R8,R9.l),(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_gdstbc,R9
move.l 0(R8,R9.l),-(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_gdstbp,R9
move.l 0(R8,R9.l),-(sp)
move R7,-(sp)
add #1,(sp)
move.l #L152,-(sp)
jsr _printf
adda.l #14,sp
*line 352
*line 353
*line 354
cmp #11,R7
bne L153
*line 354
move.l #L154,(sp)
jsr _printf
L153:L149:
*line 348
add #1,R7
L150:
*line 348
cmp #17,R7
blt L151
L148:
*line 357
move.l #L155,(sp)
jsr _printf
*line 359
*line 360
tst _SL_Flag
bne L156
*line 360
jsr _xtrap15
*line 361
L156:
*line 362
clr _SL_Flag
L137:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _SECdump
.text
_SECdump:
~~SECdump:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 378
*line 379
move.l _p_send,(sp)
move.l _p_sbgn,-(sp)
move.l #L158,-(sp)
jsr _printf
addq.l #8,sp
*line 381
*line 382
move.l _t_sect,(sp)
move.l _t_send,-(sp)
move.l _t_sbgn,-(sp)
move.l #L159,-(sp)
jsr _printf
adda.l #12,sp
*line 385
*line 386
move.l _p_cend,(sp)
move.l _p_cbgn,-(sp)
move.l #L160,-(sp)
jsr _printf
addq.l #8,sp
*line 388
*line 389
move.l _t_cend,(sp)
move.l _t_cbgn,-(sp)
move.l #L161,-(sp)
jsr _printf
addq.l #8,sp
*line 392
move.l #L162,(sp)
jsr _printf
*line 393
move.l #L163,(sp)
jsr _printf
*line 395
move.l #L164,(sp)
jsr _printf
*line 397
clr R7
bra L167
L168:
*line 398
*line 399
move _curscor,R0
muls #80,R0
move R7,R1
asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_seclist,R9
move.l 0(R8,R9.l),(sp)
move R7,-(sp)
add #1,(sp)
move.l #L169,-(sp)
jsr _printf
addq.l #6,sp
*line 400
*line 401
*line 402
move R7,R0
add #1,R0
cmp #20,R0
bge L170
*line 402
move _curscor,R0
muls #80,R0
move R7,R1
add #1,R1
asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_seclist,R9
move.l 0(R8,R9.l),(sp)
move R7,-(sp)
add #2,(sp)
move.l #L171,-(sp)
jsr _printf
addq.l #6,sp
*line 403
L170:
*line 404
*line 405
move R7,R0
add #2,R0
cmp #20,R0
bge L172
*line 405
move _curscor,R0
muls #80,R0
move R7,R1
add #2,R1
asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_seclist,R9
move.l 0(R8,R9.l),(sp)
move R7,-(sp)
add #3,(sp)
move.l #L173,-(sp)
jsr _printf
addq.l #6,sp
*line 406
L172:
*line 407
*line 408
move R7,R0
add #3,R0
cmp #20,R0
bge L174
*line 408
move _curscor,R0
muls #80,R0
move R7,R1
add #3,R1
asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_seclist,R9
move.l 0(R8,R9.l),(sp)
move R7,-(sp)
add #4,(sp)
move.l #L175,-(sp)
jsr _printf
addq.l #6,sp
*line 409
L174:
*line 410
*line 411
move R7,R0
add #4,R0
cmp #20,R0
bge L176
*line 411
move _curscor,R0
muls #80,R0
move R7,R1
add #4,R1
asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_seclist,R9
move.l 0(R8,R9.l),(sp)
move R7,-(sp)
add #5,(sp)
move.l #L177,-(sp)
jsr _printf
addq.l #6,sp
*line 412
L176:
*line 413
move.l #L178,(sp)
jsr _printf
L166:
*line 397
add #5,R7
L167:
*line 397
cmp #20,R7
blt L168
L165:
*line 416
move.l #L179,(sp)
jsr _printf
*line 418
move.l #L180,(sp)
jsr _printf
*line 419
move.l #L181,(sp)
jsr _printf
*line 420
move.l #L182,(sp)
jsr _printf
*line 422
clr R7
bra L185
L186:
*line 423
move _curscor,R0
muls #48,R0
move R7,R1
asl #2,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_hplist,R9
move.l 0(R8,R9.l),(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_hpname,R9
move.l 0(R8,R9.l),-(sp)
move.l #L187,-(sp)
jsr _printf
addq.l #8,sp
L184:
*line 422
add #1,R7
L185:
*line 422
cmp #12,R7
blt L186
L183:
*line 425
move.l #L188,(sp)
jsr _printf
L157:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _DOA
.text
_DOA:
~~DOA:
link R14,#0
movem.l R6-R7/R11-R13,-(sp)
~olda6=R13
~cura6=R12
~n=R7
~prptr=R11
*line 442
*line 442
tst.l _A6PTR
beq L190
tst.l _A7PTR
beq L190
*line 443
*line 444
move.l _A7TOP,(sp)
move.l _A7PTR,-(sp)
move.l #L191,-(sp)
jsr _printf
addq.l #8,sp
*line 445
move.l _A7PTR,(sp)
move.l _A7TOP,-(sp)
move.l _A7PTR,-(sp)
jsr _mdump
addq.l #8,sp
*line 446
move.l #L192,(sp)
jsr _printf
*line 447
move.l _A6PTR,(sp)
move.l #L193,-(sp)
jsr _printf
addq.l #4,sp
*line 448
move.l #L194,(sp)
jsr _printf
*line 449
bra L195
L190:
*line 450
*line 451
*line 452
*line 453
move.l #_A7PTR,(sp)
move.l #_A6PTR,-(sp)
move.l #L196,-(sp)
jsr _printf
addq.l #8,sp
*line 454
*line 455
jsr _xtrap15
L195:
*line 458
move.l _A6PTR,R12
*line 460
bra L199
L198:
*line 461
*line 462
move.l (R12),R13
*line 463
*line 464
*line 465
move.l #$10,R8
move.l 0(R12,R8.l),(sp)
move.l R13,-(sp)
move.l R12,-(sp)
move.l #L200,-(sp)
jsr _printf
adda.l #12,sp
*line 466
*line 467
move.l R12,R11
add.l #$20,R11
*line 468
move #8,R7
*line 469
*line 470
bra L203
L202:
*line 471
*line 472
*line 473
move (R11),(sp)
move.l R11,-(sp)
move R7,-(sp)
move.l #L204,-(sp)
jsr _printf
adda.l #10,sp
*line 474
*line 475
add #2,R7
*line 476
add.l #2,R11
L203:
*line 477
cmp.l R13,R11
blo L202
L201:
*line 478
*line 479
move.l R13,R12
L199:
*line 480
move.l R12,R0
bne L198
L197:
*line 482
jsr _xtrap15
L189:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.globl _SCPanic
.text
_SCPanic:
~~SCPanic:
link R14,#-4
*line 496
jsr _SEsnap
*line 497
jsr _xtrap15
L205:unlk R14
rts
.globl _SCdump
.text
_SCdump:
~~SCdump:
link R14,#-4
*line 508
jsr _SEsnap
*line 509
jsr _SECdump
*line 510
move.l _SCdlim,(sp)
move.l _scp,-(sp)
jsr _SEchase
addq.l #4,sp
*line 511
jsr _xtrap15
L206:unlk R14
rts
.globl _SCcrash
.text
_SCcrash:
~~SCcrash:
link R14,#-4
*line 522
move #1,_SL_Flag
*line 523
jsr _SLdump
*line 524
jsr _SCdump
L207:unlk R14
rts
.globl _SCtimes
.text
_SCtimes:
~~SCtimes:
link R14,#-4
*line 535
jsr _SEctrl
*line 536
jsr _xtrap15
L208:unlk R14
rts
.globl _SCslice
.text
_SCslice:
~~SCslice:
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~i=R7
~s=R6
~gp=R13
*line 555
clr R6
*line 557
clr R7
bra L212
L213:
*line 558
*line 559
*line 559
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_gdstbp,R8
move.l (R8),R13
move.l R13,R0
beq L214
*line 560
*line 561
*line 561
tst R6
bne L215
*line 562
*line 563
move.l #L216,(sp)
jsr _printf
*line 564
move #1,R6
*line 565
*line 566
L215:
*line 567
bra L219
L218:
*line 568
*line 569
*line 570
move 6(R13),(sp)
move 4(R13),-(sp)
move R7,-(sp)
add #1,(sp)
move.l #L220,-(sp)
jsr _printf
addq.l #8,sp
*line 571
*line 572
move.l (R13),R13
L219:
*line 573
move.l R13,R0
bne L218
L217:
*line 574
L214:L211:
*line 557
add #1,R7
L212:
*line 557
cmp #17,R7
blt L213
L210:
*line 577
*line 578
tst R6
beq L221
*line 578
move.l #L222,(sp)
jsr _printf
*line 579
*line 580
*line 581
*line 582
*line 583
L221:
*line 584
clr R6
*line 586
clr R7
bra L225
L226:
*line 587
*line 588
*line 588
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_gdstbc,R8
move.l (R8),R13
move.l R13,R0
beq L227
*line 589
*line 590
*line 590
tst R6
bne L228
*line 591
*line 592
move.l #L229,(sp)
jsr _printf
*line 593
move #1,R6
*line 594
*line 595
L228:
*line 596
bra L232
L231:
*line 597
*line 598
*line 599
move 6(R13),(sp)
move 4(R13),-(sp)
move R7,-(sp)
add #1,(sp)
move.l #L233,-(sp)
jsr _printf
addq.l #8,sp
*line 600
*line 601
move.l (R13),R13
L232:
*line 602
move.l R13,R0
bne L231
L230:
*line 603
L227:L224:
*line 586
add #1,R7
L225:
*line 586
cmp #17,R7
blt L226
L223:
*line 606
*line 607
tst R6
beq L234
*line 607
move.l #L235,(sp)
jsr _printf
*line 608
*line 609
*line 610
*line 611
L234:
*line 612
clr R6
*line 614
clr R7
bra L238
L239:
*line 615
*line 616
*line 616
move R7,R8
add.l R8,R8
add.l R8,R8
add.l #_gdstbn,R8
move.l (R8),R13
move.l R13,R0
beq L240
*line 617
*line 618
*line 618
tst R6
bne L241
*line 619
*line 620
move.l #L242,(sp)
jsr _printf
*line 621
move #1,R6
*line 622
*line 623
L241:
*line 624
bra L245
L244:
*line 625
*line 626
*line 627
move 6(R13),(sp)
move 4(R13),-(sp)
move R7,-(sp)
add #1,(sp)
move.l #L246,-(sp)
jsr _printf
addq.l #8,sp
*line 628
*line 629
move.l (R13),R13
L245:
*line 630
move.l R13,R0
bne L244
L243:
*line 631
L240:L237:
*line 614
add #1,R7
L238:
*line 614
cmp #17,R7
blt L239
L236:
*line 634
*line 635
tst R6
beq L247
*line 635
move.l #L248,(sp)
jsr _printf
*line 636
L247:L209:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _SCvce
.text
_SCvce:
~~SCvce:
~n=8
link R14,#0
movem.l R3-R7/R11-R13,-(sp)
~i=R7
~j=R6
~pif=R5
~pt1=R4
~ip=R13
~fp=R12
~pp=R11
*line 655
move 8(R14),R0
muls #3938,R0
move.l R0,R13
add.l #_vbufs,R13
*line 659
*line 660
move.l R13,(sp)
add.l #53,(sp)
move.l R13,-(sp)
add.l #36,(sp)
move.l R13,-(sp)
add.l #19,(sp)
move.l R13,-(sp)
add.l #2,(sp)
move 8(R14),-(sp)
add #1,(sp)
move.l #L250,-(sp)
jsr _printf
adda.l #18,sp
*line 662
*line 663
*line 664
move.b 73(R13),R0
ext.w R0
move R0,(sp) 
and #255,(sp)
add #1,(sp)
move.b 72(R13),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
add #1,(sp)
move.b 71(R13),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 70(R13),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move (R13),-(sp)
move.l #L251,-(sp)
jsr _printf
adda.l #12,sp
*line 666
*line 667
*line 668
*line 669
*line 670
*line 671
*line 672
*line 673
*line 674
*line 675
*line 676
*line 677
*line 678
move 84(R13),(sp)
btst #2,77(R13)
beq L10010
move #83,-(sp)
bra L10012
L10010:move #32,-(sp)
L10012:move.b 77(R13),R0
ext.w R0
and #3,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_osclbl,R9
move.l 0(R8,R9.l),-(sp)
move 82(R13),-(sp)
btst #2,76(R13)
beq L10013
move #83,-(sp)
bra L10015
L10013:move #32,-(sp)
L10015:move.b 76(R13),R0
ext.w R0
and #3,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_osclbl,R9
move.l 0(R8,R9.l),-(sp)
move 80(R13),-(sp)
btst #2,75(R13)
beq L10016
move #83,-(sp)
bra L10018
L10016:move #32,-(sp)
L10018:move.b 75(R13),R0
ext.w R0
and #3,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_osclbl,R9
move.l 0(R8,R9.l),-(sp)
move 78(R13),-(sp)
btst #2,74(R13)
beq L10019
move #83,-(sp)
bra L10021
L10019:move #32,-(sp)
L10021:move.b 74(R13),R0
ext.w R0
and #3,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_osclbl,R9
move.l 0(R8,R9.l),-(sp)
move.l #L252,-(sp)
jsr _printf
adda.l #34,sp
*line 682
move.l #L253,(sp)
jsr _printf
*line 684
move.l #L254,(sp)
jsr _printf
*line 685
move.l #L255,(sp)
jsr _printf
*line 687
clr R7
bra L258
L259:
*line 688
*line 689
move.l R13,R12
move R7,R0
muls #12,R0
add.l R0,R12
add.l #86,R12
*line 690
*line 691
*line 692
*line 693
*line 694
*line 695
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_idbxlbl,R9
move.l 0(R8,R9.l),(sp)
move 10(R12),-(sp)
move.b 9(R12),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 7(R12),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 8(R12),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 6(R12),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 5(R12),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 4(R12),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move 2(R12),-(sp)
move (R12),-(sp)
move R7,-(sp)
move.l #L260,-(sp)
jsr _printf
adda.l #24,sp
*line 696
L257:
*line 687
add #1,R7
L258:
*line 687
cmp #13,R7
blt L259
L256:
*line 701
move.l #L261,(sp)
jsr _printf
*line 702
move.l #L262,(sp)
jsr _printf
*line 703
move.l #L263,(sp)
jsr _printf
*line 705
clr R7
bra L266
L267:
*line 706
*line 707
move.l R13,R12
move R7,R0
muls #12,R0
add.l R0,R12
add.l #86,R12
*line 708
move.b 5(R12),R5
ext.w R5
and #255,R5
*line 709
move.b 6(R12),R4
ext.w R4
and #255,R4
*line 710
*line 711
clr R6
bra L270
L271:
*line 712
*line 713
move.l R13,R11
move R4,R0
add R6,R0
muls #12,R0
add.l R0,R11
add.l #242,R11
*line 714
*line 715
*line 716
*line 717
*line 718
*line 719
*line 720
move.b 11(R11),R0
ext.w R0
move R0,(sp) 
and #255,(sp)
move.b 10(R11),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 9(R11),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 8(R11),R0
ext.w R0
move R0,-(sp) 
and #255,(sp)
move.b 7(R11),R0
ext.w R0
and #255,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_actname,R9
move.l 0(R8,R9.l),-(sp)
move.b 6(R11),R0
ext.w R0
and #255,R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #_srcname,R9
move.l 0(R8,R9.l),-(sp)
move 4(R11),-(sp)
move 2(R11),-(sp)
move (R11),-(sp)
move R4,-(sp)
move R6,R0
add R0,(sp)
move R6,-(sp)
move R7,-(sp)
move.l #L272,-(sp)
jsr _printf
adda.l #30,sp
L269:
*line 711
add #1,R6
L270:
*line 711
cmp R5,R6
blt L271
L268:
*line 721
L265:
*line 705
add #1,R7
L266:
*line 705
cmp #13,R7
blt L267
L264:
*line 724
move.l #L273,(sp)
jsr _printf
L249:tst.l (sp)+
movem.l (sp)+,R4-R7/R11-R13
unlk R14
rts
.globl _SCvces
.text
_SCvces:
~~SCvces:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 740
clr R7
bra L277
L278:
*line 741
move R7,(sp)
jsr _SCvce
L276:
*line 740
add #1,R7
L277:
*line 740
cmp #12,R7
blt L278
L275:
*line 743
jsr _xtrap15
L274:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _SCvoice
.text
_SCvoice:
~~SCvoice:
link R14,#-4
*line 754
move _SCnumv,(sp)
jsr _SCvce
*line 755
jsr _xtrap15
L279:unlk R14
rts
.data
L1:.dc.b $30,$30,$3A,$20,$45,$56,$5F,$4E,$55,$4C,$4C,$20,$20,$6E,$75,$6C,$6C,$20,$65,$76,$65,$6E,$74,$20,$20,$20,$0
L2:.dc.b $30,$31,$3A,$20,$45,$56,$5F,$53,$43,$4F,$52,$45,$20,$73,$63,$6F,$72,$65,$20,$62,$65,$67,$69,$6E,$20,$20,$0
L3:.dc.b $30,$32,$3A,$20,$45,$56,$5F,$53,$42,$47,$4E,$20,$20,$73,$65,$63,$74,$69,$6F,$6E,$20,$62,$65,$67,$69,$6E,$0
L4:.dc.b $30,$33,$3A,$20,$45,$56,$5F,$53,$45,$4E,$44,$20,$20,$73,$65,$63,$74,$69,$6F,$6E,$20,$65,$6E,$64,$20,$20,$0
L5:.dc.b $30,$34,$3A,$20,$45,$56,$5F,$49,$4E,$53,$54,$20,$20,$69,$6E,$73,$74,$72,$2E,$20,$63,$68,$61,$6E,$67,$65,$0
L6:.dc.b $30,$35,$3A,$20,$45,$56,$5F,$4E,$42,$45,$47,$20,$20,$6E,$6F,$74,$65,$20,$62,$65,$67,$69,$6E,$20,$20,$20,$0
L7:.dc.b $30,$36,$3A,$20,$45,$56,$5F,$4E,$45,$4E,$44,$20,$20,$6E,$6F,$74,$65,$20,$65,$6E,$64,$20,$20,$20,$20,$20,$0
L8:.dc.b $30,$37,$3A,$20,$45,$56,$5F,$53,$54,$4F,$50,$20,$20,$73,$74,$6F,$70,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0
L9:.dc.b $30,$38,$3A,$20,$45,$56,$5F,$49,$4E,$54,$50,$20,$20,$69,$6E,$74,$65,$72,$70,$6F,$6C,$61,$74,$65,$20,$20,$0
L10:.dc.b $30,$39,$3A,$20,$45,$56,$5F,$54,$4D,$50,$4F,$20,$20,$74,$65,$6D,$70,$6F,$20,$20,$20,$20,$20,$20,$20,$20,$0
L11:.dc.b $30,$41,$3A,$20,$45,$56,$5F,$54,$55,$4E,$45,$20,$20,$74,$75,$6E,$69,$6E,$67,$20,$20,$20,$20,$20,$20,$20,$0
L12:.dc.b $30,$42,$3A,$20,$45,$56,$5F,$47,$52,$50,$20,$20,$20,$67,$72,$6F,$75,$70,$20,$73,$74,$61,$74,$75,$73,$20,$0
L13:.dc.b $30,$43,$3A,$20,$45,$56,$5F,$4C,$4F,$43,$4E,$20,$20,$6C,$6F,$63,$61,$74,$69,$6F,$6E,$20,$20,$20,$20,$20,$0
L14:.dc.b $30,$44,$3A,$20,$45,$56,$5F,$44,$59,$4E,$20,$20,$20,$64,$79,$6E,$61,$6D,$69,$63,$73,$20,$20,$20,$20,$20,$0
L15:.dc.b $30,$45,$3A,$20,$45,$56,$5F,$41,$4E,$56,$4C,$20,$20,$61,$6E,$61,$6C,$6F,$67,$20,$76,$61,$6C,$75,$65,$20,$0
L16:.dc.b $30,$46,$3A,$20,$45,$56,$5F,$41,$4E,$52,$53,$20,$20,$61,$6E,$61,$6C,$6F,$67,$20,$72,$65,$73,$2E,$20,$20,$0
L17:.dc.b $31,$30,$3A,$20,$45,$56,$5F,$41,$53,$47,$4E,$20,$20,$49,$2F,$4F,$20,$61,$73,$73,$69,$67,$6E,$20,$20,$20,$0
L18:.dc.b $31,$31,$3A,$20,$45,$56,$5F,$54,$52,$4E,$53,$20,$20,$74,$72,$61,$6E,$73,$70,$6F,$73,$69,$74,$69,$6F,$6E,$0
L19:.dc.b $31,$32,$3A,$20,$45,$56,$5F,$52,$45,$50,$54,$20,$20,$72,$65,$70,$65,$61,$74,$20,$20,$20,$20,$20,$20,$20,$0
L20:.dc.b $31,$33,$3A,$20,$45,$56,$5F,$50,$4E,$43,$48,$20,$20,$70,$75,$6E,$63,$68,$20,$69,$6E,$2F,$6F,$75,$74,$20,$0
L21:.dc.b $31,$34,$3A,$20,$45,$56,$5F,$50,$52,$45,$53,$20,$20,$70,$6F,$6C,$79,$20,$70,$72,$65,$73,$73,$75,$72,$65,$0
L22:.dc.b $31,$35,$3A,$20,$45,$56,$5F,$46,$49,$4E,$49,$20,$20,$73,$63,$6F,$72,$65,$20,$65,$6E,$64,$20,$20,$20,$20,$0
L23:.dc.b $31,$36,$3A,$20,$45,$56,$5F,$43,$50,$52,$53,$20,$20,$63,$68,$61,$6E,$20,$70,$72,$65,$73,$73,$75,$72,$65,$0
L24:.dc.b $31,$37,$3A,$20,$45,$56,$5F,$42,$41,$52,$20,$20,$20,$62,$61,$72,$20,$6D,$61,$72,$6B,$65,$72,$20,$20,$20,$0
L25:.dc.b $45,$48,$5F,$49,$4E,$53,$54,$0
L26:.dc.b $45,$48,$5F,$47,$52,$50,$20,$0
L27:.dc.b $45,$48,$5F,$4C,$4F,$43,$4E,$0
L28:.dc.b $45,$48,$5F,$44,$59,$4E,$20,$0
L29:.dc.b $45,$48,$5F,$41,$4E,$52,$53,$0
L30:.dc.b $45,$48,$5F,$54,$52,$4E,$53,$0
L31:.dc.b $45,$48,$5F,$49,$4E,$54,$50,$0
L32:.dc.b $45,$48,$5F,$54,$4D,$50,$4F,$0
L33:.dc.b $45,$48,$5F,$54,$55,$4E,$45,$0
L34:.dc.b $45,$48,$5F,$41,$53,$47,$4E,$0
L35:.dc.b $45,$48,$5F,$53,$42,$47,$4E,$0
L36:.dc.b $45,$48,$5F,$53,$45,$4E,$44,$0
L37:.dc.b $50,$63,$68,$2F,$48,$6F,$72,$0
L38:.dc.b $4D,$6F,$64,$2F,$56,$72,$74,$0
L39:.dc.b $42,$72,$74,$68,$2F,$4C,$50,$0
L40:.dc.b $47,$50,$43,$2F,$43,$56,$31,$0
L41:.dc.b $50,$65,$64,$61,$6C,$20,$31,$0
L42:.dc.b $4B,$65,$79,$20,$50,$72,$73,$0
L43:.dc.b $4E,$4F,$4E,$45,$0
L44:.dc.b $52,$41,$4E,$44,$0
L45:.dc.b $43,$54,$4C,$31,$0
L46:.dc.b $3F,$30,$33,$3F,$0
L47:.dc.b $3F,$30,$34,$3F,$0
L48:.dc.b $50,$54,$43,$48,$0
L49:.dc.b $4B,$50,$52,$53,$0
L50:.dc.b $4B,$56,$45,$4C,$0
L51:.dc.b $50,$45,$44,$31,$0
L52:.dc.b $3F,$30,$39,$3F,$0
L53:.dc.b $46,$52,$45,$51,$0
L54:.dc.b $48,$54,$50,$57,$0
L55:.dc.b $56,$54,$4D,$57,$0
L56:.dc.b $4C,$50,$42,$52,$0
L57:.dc.b $4E,$55,$4C,$4C,$0
L58:.dc.b $53,$55,$53,$54,$0
L59:.dc.b $45,$4E,$42,$4C,$0
L60:.dc.b $4A,$55,$4D,$50,$0
L61:.dc.b $4C,$4F,$4F,$50,$0
L62:.dc.b $4B,$59,$55,$50,$0
L63:.dc.b $4B,$59,$44,$4E,$0
L64:.dc.b $48,$45,$52,$45,$0
L68:.dc.b $63,$75,$72,$73,$63,$6F,$72,$3A,$20,$25,$64,$20,$20,$22,$25,$2D,$31,$36,$2E,$31,$36,$73,$22,$20,$20,$63,$75,$72,$73,$65
.dc.b $63,$74,$3A,$20,$25,$64,$20,$20,$73,$63,$70,$3A,$20,$24,$25,$30,$38,$6C,$58,$A,$A,$0
L69:.dc.b $20,$20,$20,$66,$63,$5F,$76,$61,$6C,$3A,$20,$25,$38,$6C,$64,$20,$20,$66,$63,$5F,$73,$77,$3A,$20,$20,$25,$64,$A,$A,$0
L70:.dc.b $20,$20,$20,$74,$5F,$62,$61,$6B,$3A,$20,$20,$25,$38,$6C,$64,$20,$20,$74,$5F,$63,$75,$72,$3A,$20,$20,$25,$38,$6C,$64,$20
.dc.b $20,$74,$5F,$63,$74,$72,$3A,$20,$20,$25,$38,$6C,$64,$20,$20,$74,$5F,$66,$77,$64,$3A,$20,$20,$25,$38,$6C,$64,$A,$0
L71:.dc.b $20,$20,$20,$70,$5F,$62,$61,$6B,$3A,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$70,$5F,$63,$75,$72,$3A,$20,$24,$25,$30,$38,$6C
.dc.b $58,$20,$20,$70,$5F,$63,$74,$72,$3A,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$70,$5F,$66,$77,$64,$3A,$20,$24,$25,$30,$38,$6C
.dc.b $58,$A,$A,$0
L73:.dc.b $A,$0
L74:.dc.b $65,$76,$6C,$65,$66,$74,$3A,$20,$25,$6C,$64,$20,$20,$73,$70,$63,$6F,$75,$6E,$74,$3A,$20,$25,$6C,$64,$20,$20,$66,$72,$61
.dc.b $67,$73,$3A,$20,$25,$6C,$64,$A,$0
L75:.dc.b $20,$20,$20,$73,$65,$31,$5F,$63,$6E,$74,$3D,$25,$6C,$64,$20,$20,$73,$65,$32,$5F,$63,$6E,$74,$3D,$25,$6C,$64,$20,$20,$73
.dc.b $65,$33,$5F,$63,$6E,$74,$3D,$25,$6C,$64,$A,$0
L76:.dc.b $20,$20,$20,$70,$73,$70,$6F,$6F,$6C,$3D,$24,$25,$30,$38,$6C,$58,$20,$20,$73,$69,$7A,$65,$31,$3D,$24,$25,$30,$38,$6C,$58
.dc.b $20,$20,$73,$69,$7A,$65,$32,$3D,$24,$25,$30,$38,$6C,$58,$20,$20,$73,$69,$7A,$65,$33,$3D,$24,$25,$30,$38,$6C,$58,$A,$0
L81:.dc.b $25,$32,$64,$3A,$20,$20,$22,$25,$2D,$31,$36,$2E,$31,$36,$73,$22,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$25,$73,$A,$0
L82:.dc.b $3C,$2D,$2D,$2D,$20,$63,$75,$72,$73,$63,$6F,$72,$0
L83:.dc.b $0
L84:.dc.b $A,$A,$0
L85:.dc.b $56,$61,$72,$69,$61,$62,$6C,$65,$20,$6D,$6F,$64,$65,$73,$20,$66,$6F,$72,$20,$65,$61,$63,$68,$20,$67,$72,$6F,$75,$70,$3A
.dc.b $A,$A,$0
L86:.dc.b $56,$23,$20,$56,$61,$72,$4E,$61,$6D,$65,$20,$20,$30,$31,$20,$30,$32,$20,$30,$33,$20,$30,$34,$20,$30,$35,$20,$30,$36,$20
.dc.b $30,$37,$20,$30,$38,$20,$30,$39,$20,$31,$30,$20,$31,$31,$20,$31,$32,$A,$0
L87:.dc.b $2D,$2D,$20,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20
.dc.b $2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$A,$0
L92:.dc.b $25,$30,$32,$64,$20,$25,$73,$20,$20,$0
L97:.dc.b $20,$25,$64,$20,$0
L98:.dc.b $A,$0
L99:.dc.b $A,$0
L107:.dc.b $5B,$25,$30,$38,$6C,$58,$5D,$3A,$20,$20,$2A,$2A,$20,$42,$61,$64,$20,$65,$76,$65,$6E,$74,$20,$73,$69,$7A,$65,$3A,$20,$24
.dc.b $25,$30,$32,$2E,$32,$58,$20,$2A,$2A,$A,$0
L109:.dc.b $5B,$25,$30,$38,$6C,$58,$5D,$3A,$20,$20,$2A,$2A,$20,$42,$61,$64,$20,$65,$76,$65,$6E,$74,$20,$74,$79,$70,$65,$3A,$20,$24
.dc.b $25,$30,$32,$2E,$32,$58,$20,$2A,$2A,$A,$0
L110:.dc.b $24,$25,$30,$38,$6C,$58,$3A,$20,$74,$3D,$25,$31,$30,$6C,$64,$20,$20,$46,$3A,$24,$25,$30,$38,$6C,$58,$20,$20,$42,$3A,$24
.dc.b $25,$30,$38,$6C,$58,$20,$2A,$20,$25,$73,$A,$0
L111:.dc.b $20,$20,$64,$61,$74,$61,$20,$3D,$20,$24,$25,$30,$32,$2E,$32,$58,$20,$24,$25,$30,$32,$2E,$32,$58,$0
L113:.dc.b $20,$24,$25,$30,$34,$2E,$34,$58,$20,$24,$25,$30,$34,$2E,$34,$58,$0
L114:.dc.b $A,$0
L116:.dc.b $20,$20,$75,$70,$3A,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$64,$6E,$3A,$20,$24,$25,$30,$38,$6C,$58,$0
L119:.dc.b $20,$20,$6C,$66,$74,$3A,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$72,$67,$74,$3A,$20,$24,$25,$30,$38,$6C,$58,$0
L120:.dc.b $A,$0
L122:.dc.b $A,$0
L124:.dc.b $4E,$55,$4C,$4C,$20,$70,$6F,$69,$6E,$74,$65,$72,$A,$0
L125:.dc.b $65,$70,$20,$2D,$20,$53,$45,$63,$68,$61,$73,$65,$28,$29,$0
L132:.dc.b $65,$5F,$66,$77,$64,$20,$2D,$20,$53,$45,$63,$68,$61,$73,$65,$28,$29,$0
L134:.dc.b $65,$5F,$62,$61,$6B,$20,$2D,$20,$53,$45,$63,$68,$61,$73,$65,$28,$29,$0
L136:.dc.b $A,$0
L138:.dc.b $A,$0
L139:.dc.b $73,$64,$20,$3D,$20,$25,$73,$20,$20,$73,$65,$20,$3D,$20,$25,$73,$20,$20,$73,$62,$61,$73,$65,$20,$3D,$20,$25,$64,$20,$20
.dc.b $73,$6F,$66,$66,$73,$65,$74,$20,$3D,$20,$25,$64,$20,$20,$73,$63,$72,$6C,$20,$3D,$20,$24,$25,$30,$34,$2E,$34,$58,$A,$0
L140:.dc.b $42,$41,$4B,$0
L141:.dc.b $46,$57,$44,$0
L142:.dc.b $42,$41,$4B,$0
L143:.dc.b $46,$57,$44,$0
L144:.dc.b $67,$64,$66,$73,$65,$70,$20,$3D,$20,$24,$25,$30,$38,$6C,$58,$A,$A,$0
L145:.dc.b $67,$72,$20,$20,$24,$20,$67,$64,$73,$74,$62,$70,$20,$20,$24,$20,$67,$64,$73,$74,$62,$63,$20,$20,$24,$20,$67,$64,$73,$74
.dc.b $62,$6E,$A,$0
L146:.dc.b $20,$20,$20,$20,$25,$30,$38,$6C,$58,$20,$20,$25,$30,$38,$6C,$58,$20,$20,$25,$30,$38,$6C,$58,$A,$0
L147:.dc.b $2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$20,$20,$2D,$2D,$2D,$2D,$2D,$2D
.dc.b $2D,$2D,$A,$0
L152:.dc.b $25,$32,$64,$20,$20,$25,$30,$38,$6C,$58,$20,$20,$25,$30,$38,$6C,$58,$20,$20,$25,$30,$38,$6C,$58,$A,$0
L154:.dc.b $A,$0
L155:.dc.b $A,$0
L158:.dc.b $70,$5F,$73,$62,$67,$6E,$20,$3D,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$70,$5F,$73,$65,$6E,$64,$20,$3D,$20,$24,$25,$30,$38
.dc.b $6C,$58,$A,$0
L159:.dc.b $74,$5F,$73,$62,$67,$6E,$20,$3D,$20,$20,$25,$38,$6C,$64,$20,$20,$74,$5F,$73,$65,$6E,$64,$20,$3D,$20,$20,$25,$38,$6C,$64
.dc.b $20,$20,$74,$5F,$73,$65,$63,$74,$20,$3D,$20,$20,$25,$38,$6C,$64,$A,$A,$0
L160:.dc.b $70,$5F,$63,$62,$67,$6E,$20,$3D,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$70,$5F,$63,$65,$6E,$64,$20,$3D,$20,$24,$25,$30,$38
.dc.b $6C,$58,$A,$0
L161:.dc.b $74,$5F,$63,$62,$67,$6E,$20,$3D,$20,$20,$25,$38,$6C,$64,$20,$20,$74,$5F,$63,$65,$6E,$64,$20,$3D,$20,$20,$25,$38,$6C,$64
.dc.b $A,$A,$0
L162:.dc.b $73,$65,$63,$6C,$69,$73,$74,$5B,$63,$75,$72,$73,$63,$6F,$72,$5D,$5B,$5D,$A,$0
L163:.dc.b $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$A,$A,$0
L164:.dc.b $53,$65,$63,$20,$41,$64,$64,$72,$5F,$5F,$5F,$5F,$5F,$20,$20,$53,$65,$63,$20,$41,$64,$64,$72,$5F,$5F,$5F,$5F,$5F,$20,$20
.dc.b $53,$65,$63,$20,$41,$64,$64,$72,$5F,$5F,$5F,$5F,$5F,$20,$20,$53,$65,$63,$20,$41,$64,$64,$72,$5F,$5F,$5F,$5F,$5F,$20,$20
.dc.b $53,$65,$63,$20,$41,$64,$64,$72,$5F,$5F,$5F,$5F,$5F,$20,$20,$A,$0
L169:.dc.b $25,$32,$64,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$0
L171:.dc.b $25,$32,$64,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$0
L173:.dc.b $25,$32,$64,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$0
L175:.dc.b $25,$32,$64,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$0
L177:.dc.b $25,$32,$64,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$0
L178:.dc.b $A,$0
L179:.dc.b $A,$0
L180:.dc.b $68,$70,$6C,$69,$73,$74,$5B,$63,$75,$72,$73,$63,$6F,$72,$5D,$5B,$5D,$A,$0
L181:.dc.b $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$A,$0
L182:.dc.b $54,$79,$70,$65,$5F,$5F,$5F,$20,$20,$41,$64,$64,$72,$5F,$5F,$5F,$5F,$5F,$A,$0
L187:.dc.b $25,$73,$20,$20,$24,$25,$30,$38,$6C,$58,$A,$0
L188:.dc.b $A,$0
L191:.dc.b $53,$74,$61,$63,$6B,$20,$64,$75,$6D,$70,$3A,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$74,$6F,$20,$24,$25,$30,$38,$6C,$58,$A
.dc.b $A,$0
L192:.dc.b $A,$A,$0
L193:.dc.b $53,$74,$61,$63,$6B,$20,$74,$72,$61,$63,$65,$62,$61,$63,$6B,$3A,$20,$20,$66,$72,$6F,$6D,$20,$41,$36,$20,$3D,$20,$24,$25
.dc.b $30,$38,$6C,$58,$A,$A,$0
L194:.dc.b $41,$36,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$4F,$6C,$64,$20,$41,$36,$20,$20,$20,$20,$52,$65,$74,$75,$72,$6E,$A,$0
L196:.dc.b $53,$65,$74,$20,$41,$36,$50,$54,$52,$20,$28,$24,$25,$30,$38,$6C,$58,$29,$20,$61,$6E,$64,$20,$41,$37,$50,$54,$52,$20,$28
.dc.b $24,$25,$30,$38,$6C,$58,$29,$20,$66,$69,$72,$73,$74,$A,$0
L200:.dc.b $24,$25,$30,$38,$6C,$58,$3A,$20,$20,$24,$25,$30,$38,$6C,$58,$20,$20,$24,$25,$30,$38,$6C,$58,$A,$0
L204:.dc.b $20,$20,$2B,$25,$2D,$34,$64,$20,$5B,$24,$25,$30,$38,$6C,$58,$5D,$3A,$20,$20,$24,$25,$30,$34,$2E,$34,$58,$A,$0
L216:.dc.b $67,$64,$73,$74,$62,$70,$3A,$0
L220:.dc.b $20,$20,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$3A,$25,$64,$0
L222:.dc.b $A,$0
L229:.dc.b $67,$64,$73,$74,$62,$63,$3A,$0
L233:.dc.b $20,$20,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$3A,$25,$64,$0
L235:.dc.b $A,$0
L242:.dc.b $67,$64,$73,$74,$62,$6E,$3A,$0
L246:.dc.b $20,$20,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$3A,$25,$64,$0
L248:.dc.b $A,$0
L250:.dc.b $56,$4F,$49,$43,$45,$20,$25,$32,$64,$3A,$20,$20,$25,$2D,$31,$36,$2E,$31,$36,$73,$20,$20,$25,$2D,$31,$36,$2E,$31,$36,$73
.dc.b $20,$25,$2D,$31,$36,$2E,$31,$36,$73,$20,$25,$2D,$31,$36,$2E,$31,$36,$73,$A,$0
L251:.dc.b $20,$20,$66,$6C,$61,$67,$3D,$25,$30,$34,$2E,$34,$58,$20,$20,$43,$66,$67,$3D,$25,$64,$20,$20,$23,$70,$6C,$66,$74,$3D,$25
.dc.b $64,$20,$20,$57,$73,$41,$3D,$25,$64,$20,$20,$57,$73,$42,$3D,$25,$64,$A,$0
L252:.dc.b $20,$20,$4F,$73,$63,$20,$31,$3A,$25,$73,$20,$25,$63,$20,$25,$30,$34,$2E,$34,$58,$20,$20,$32,$3A,$25,$73,$20,$25,$63,$20
.dc.b $25,$30,$34,$2E,$34,$58,$20,$20,$33,$3A,$25,$73,$20,$25,$63,$20,$25,$30,$34,$2E,$34,$58,$20,$20,$34,$3A,$25,$73,$20,$25
.dc.b $63,$20,$25,$30,$34,$2E,$34,$58,$A,$0
L253:.dc.b $A,$46,$75,$6E,$63,$74,$69,$6F,$6E,$20,$68,$65,$61,$64,$65,$72,$73,$A,$0
L254:.dc.b $20,$20,$46,$6E,$20,$50,$63,$68,$20,$20,$4D,$75,$6C,$74,$20,$53,$72,$20,$50,$69,$66,$20,$50,$74,$31,$20,$43,$70,$74,$20
.dc.b $4D,$64,$20,$50,$72,$20,$54,$72,$67,$20,$A,$0
L255:.dc.b $20,$20,$2D,$2D,$20,$2D,$2D,$2D,$2D,$20,$2D,$2D,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$2D,$20,$2D,$2D,$2D,$20,$2D,$2D,$2D,$20
.dc.b $2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$2D,$2D,$A,$0
L260:.dc.b $20,$20,$25,$32,$64,$20,$25,$30,$34,$2E,$34,$58,$20,$25,$30,$34,$2E,$34,$58,$20,$25,$30,$32,$58,$20,$25,$33,$64,$20,$25
.dc.b $33,$64,$20,$25,$33,$64,$20,$25,$30,$32,$78,$20,$25,$30,$32,$78,$20,$25,$30,$34,$2E,$34,$78,$20,$20,$25,$73,$A,$0
L261:.dc.b $A,$4F,$63,$63,$75,$70,$69,$65,$64,$20,$70,$6F,$69,$6E,$74,$73,$A,$0
L262:.dc.b $20,$20,$46,$6E,$20,$46,$70,$74,$20,$49,$70,$74,$20,$54,$69,$6D,$65,$20,$56,$61,$6C,$20,$20,$4D,$75,$6C,$74,$20,$53,$72
.dc.b $63,$20,$20,$41,$63,$74,$20,$20,$50,$31,$20,$50,$32,$20,$50,$33,$20,$50,$64,$A,$0
L263:.dc.b $20,$20,$2D,$2D,$20,$2D,$2D,$2D,$20,$2D,$2D,$2D,$20,$2D,$2D,$2D,$2D,$20,$2D,$2D,$2D,$2D,$20,$2D,$2D,$2D,$2D,$20,$2D,$2D
.dc.b $2D,$2D,$20,$2D,$2D,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$20,$2D,$2D,$A,$0
L272:.dc.b $20,$20,$25,$32,$64,$20,$25,$33,$64,$20,$25,$33,$64,$20,$25,$30,$34,$2E,$34,$58,$20,$25,$30,$34,$2E,$34,$58,$20,$25,$30
.dc.b $34,$2E,$34,$58,$20,$25,$34,$73,$20,$25,$34,$73,$20,$25,$32,$58,$20,$25,$32,$58,$20,$25,$32,$58,$20,$25,$32,$58,$A,$0
L273:.dc.b $A,$0
