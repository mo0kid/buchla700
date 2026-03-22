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
.globl _dubsw
.globl _ndisp
.globl _recsw
.globl _sbase
.globl _sd
.globl _se
.globl _soffset
.globl _grpmode
.globl _grpstat
.globl _varmode
.globl _gdfsep
.globl _gdstbc
.globl _gdstbn
.globl _gdstbp
.globl _sc_trak
.text
_sc_trak:
~~sc_trak:
~tval=R7
link R14,#-4
movem.l R2-R7/R11-R13,-(sp)
~rpb=R13
~rpc=R12
~rpf=R11
~rtb=R6
~rtc=R5
~rtf=R4
~mod48=R3
*line 63
move #48,R3
~gdsp=-4
*line 66
move.l 8(R14),R7
*line 68
*line 68
cmp #2,_ndisp
beq L2
*line 69
*line 70
*line 71
move #-1,R0
bra L1
*line 72
*line 73
*line 78
*line 79
L2:
*line 80
*line 80
tst.l _p_fwd
beq L10000
tst.l _p_ctr
beq L10000
tst.l _p_bak
bne L3
L10000:*line 81
*line 82
*line 83
move #-1,R0
bra L1
*line 84
*line 85
*line 86
L3:
*line 87
*line 88
clr R0
move 10+_v_regs,R0
and #384,R0
beq L4
*line 88
clr (sp)
jsr _vbank
*line 89
L4:
*line 90
move.l _p_fwd,R11
*line 91
move.l _t_fwd,R4
*line 93
move.l _p_ctr,R12
*line 94
move.l _t_ctr,R5
*line 96
move.l _p_bak,R13
*line 97
move.l _t_bak,R6
*line 120
*line 120
tst _sd
bne L5
*line 121
*line 122
*line 123
*line 124
bra L8
L7:
*line 125
*line 126
jsr _sreset
*line 127
*line 128
add.l #$1,R6
*line 129
add.l #$1,R4
*line 130
*line 131
*line 131
cmp.b #21,5(R13)
beq L9
*line 132
*line 133
bra L12
L11:
*line 134
*line 135
clr (sp)
move.l #_gdstbp,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 136
move.l 12(R13),R13
*line 137
*line 138
*line 139
cmp.b #21,5(R13)
beq L10
L12:
*line 140
cmp.l (R13),R6
beq L11
L10:
*line 141
*line 142
L9:
*line 143
*line 143
move.l R6,R0
divs R3,R0
swap R0
ext.l R0
tst.l R0
bne L13
*line 144
*line 145
*line 145
move.l _gdfsep,-4(R14)
beq L14
*line 146
*line 147
move.l -4(R14),R8
move.l (R8),_gdfsep
*line 148
*line 149
move.l -4(R14),R8
move.l 48+_gdstbp,(R8)
*line 150
move.l -4(R14),R8
move #4369,4(R8)
*line 151
move.l -4(R14),R8
move #1,6(R8)
*line 152
*line 153
move.l -4(R14),48+_gdstbp
*line 154
L14:
*line 155
*line 156
*line 157
L13:
*line 158
*line 158
cmp.b #21,5(R12)
beq L15
*line 159
*line 160
bra L18
L17:
*line 161
*line 162
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R12,-(sp)
jsr _se_disp
adda.l #10,sp
*line 163
move.l 12(R12),R12
*line 164
*line 165
*line 166
cmp.b #21,5(R12)
beq L16
L18:
*line 167
cmp.l (R12),R5
beq L17
L16:
*line 168
*line 169
L15:
*line 170
*line 170
cmp.b #21,5(R11)
beq L19
*line 171
*line 172
bra L22
L21:
*line 173
*line 174
clr (sp)
move.l #_gdstbn,-(sp)
clr -(sp)
move.l R11,-(sp)
jsr _se_disp
adda.l #10,sp
*line 175
move.l 12(R11),R11
*line 176
*line 177
*line 178
cmp.b #21,5(R11)
beq L20
L22:
*line 179
cmp.l (R11),R4
beq L21
L20:
*line 180
*line 181
L19:
*line 182
*line 182
move.l R4,R0
divs R3,R0
swap R0
ext.l R0
tst.l R0
bne L23
*line 183
*line 184
*line 184
move.l _gdfsep,-4(R14)
beq L24
*line 185
*line 186
move.l -4(R14),R8
move.l (R8),_gdfsep
*line 187
*line 188
move.l -4(R14),R8
move.l 48+_gdstbn,(R8)
*line 189
move.l -4(R14),R8
move #4369,4(R8)
*line 190
move.l -4(R14),R8
move #1,6(R8)
*line 191
*line 192
move.l -4(R14),48+_gdstbn
*line 193
L24:
*line 194
*line 195
L23:
*line 196
jsr _sc_adv
L8:
*line 197
cmp.l R5,R7
move sr,R0
add.l #$1,R5
move R0,ccr
bgt L7
L6:
*line 198
*line 199
*line 200
bra L25
L5:
*line 201
*line 202
*line 203
*line 204
*line 205
bra L28
L27:
*line 206
*line 207
jsr _sreset
*line 208
*line 209
sub.l #$1,R6
*line 210
sub.l #$1,R4
*line 211
*line 212
*line 212
cmp.b #1,5(R13)
beq L29
*line 213
*line 214
bra L32
L31:
*line 215
*line 216
clr (sp)
move.l #_gdstbp,-(sp)
move #1,-(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 217
move.l 8(R13),R13
*line 218
*line 219
*line 220
cmp.b #1,5(R13)
beq L30
L32:
*line 221
cmp.l (R13),R6
beq L31
L30:
*line 222
*line 223
L29:
*line 224
*line 224
move.l R6,R0
divs R3,R0
swap R0
ext.l R0
tst.l R0
bne L33
*line 225
*line 226
*line 226
move.l _gdfsep,-4(R14)
beq L34
*line 227
*line 228
move.l -4(R14),R8
move.l (R8),_gdfsep
*line 229
*line 230
move.l -4(R14),R8
move.l 48+_gdstbp,(R8)
*line 231
move.l -4(R14),R8
move #4369,4(R8)
*line 232
move.l -4(R14),R8
move #1,6(R8)
*line 233
*line 234
move.l -4(R14),48+_gdstbp
*line 235
L34:
*line 236
*line 237
*line 238
L33:
*line 239
*line 239
cmp.b #1,5(R12)
beq L35
*line 240
*line 241
bra L38
L37:
*line 242
*line 243
move #1,(sp)
move.l #_gdstbc,-(sp)
move #1,-(sp)
move.l R12,-(sp)
jsr _se_disp
adda.l #10,sp
*line 244
move.l 8(R12),R12
*line 245
*line 246
*line 247
cmp.b #1,5(R12)
beq L36
L38:
*line 248
cmp.l (R12),R5
beq L37
L36:
*line 249
*line 250
L35:
*line 251
*line 251
cmp.b #1,5(R11)
beq L39
*line 252
*line 253
bra L42
L41:
*line 254
*line 255
clr (sp)
move.l #_gdstbn,-(sp)
move #1,-(sp)
move.l R11,-(sp)
jsr _se_disp
adda.l #10,sp
*line 256
move.l 8(R11),R11
*line 257
*line 258
*line 259
cmp.b #1,5(R11)
beq L40
L42:
*line 260
cmp.l (R11),R4
beq L41
L40:
*line 261
*line 262
L39:
*line 263
*line 263
move.l R4,R0
divs R3,R0
swap R0
ext.l R0
tst.l R0
bne L43
*line 264
*line 265
*line 265
move.l _gdfsep,-4(R14)
beq L44
*line 266
*line 267
move.l -4(R14),R8
move.l (R8),_gdfsep
*line 268
*line 269
move.l -4(R14),R8
move.l 48+_gdstbn,(R8)
*line 270
move.l -4(R14),R8
move #4369,4(R8)
*line 271
move.l -4(R14),R8
move #1,6(R8)
*line 272
*line 273
move.l -4(R14),48+_gdstbn
*line 274
L44:
*line 275
*line 276
L43:
*line 277
jsr _sc_adv
L28:
*line 278
cmp.l R5,R7
move sr,R0
sub.l #$1,R5
move R0,ccr
blt L27
L26:L25:
*line 282
move.l R11,_p_fwd
*line 283
move.l R7,R0
add.l #$102,R0
move.l R0,_t_fwd
*line 285
move.l R12,_p_ctr
*line 286
move.l R7,_t_ctr
*line 288
move.l R13,_p_bak
*line 289
move.l R7,R0
add.l #$ffffff10,R0
move.l R0,_t_bak
*line 292
jsr _dslocn
*line 312
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _sc_trek
.text
_sc_trek:
~~sc_trek:
~tval=R7
link R14,#0
movem.l R2-R7/R12-R13,-(sp)
~rp=R13
~ep=R12
~tc=R6
~rt=R5
~et=R4
~grp=R3
*line 332
move.l 8(R14),R7
*line 338
*line 338
tst.l _p_cur
bne L46
*line 339
*line 340
*line 341
move #-1,R0
bra L45
*line 342
*line 343
L46:
*line 344
move.l _p_cur,R13
*line 345
move.l _t_cur,R5
*line 358
bra L49
L48:
*line 359
*line 360
*line 361
tst _se
bne L50
*line 361
add.l #$1,R5
*line 362
bra L51
L50:
*line 363
sub.l #$1,R5
L51:
*line 364
*line 365
*line 365
cmp.b #21,5(R13)
beq L52
*line 366
*line 367
bra L55
L54:
*line 368
*line 369
*line 370
*line 371
*line 371
tst _recsw
beq L56
tst _se
bne L56
*line 372
*line 373
move.b 5(R13),R4
ext.w R4
and #127,R4
*line 374
*line 375
*line 376
tst _dubsw
bne L57
cmp #5,R4
beq L10001
cmp #6,R4
bne L57
L10001:*line 377
*line 378
move.b 7(R13),R3
ext.w R3
*line 379
*line 380
*line 380
move R3,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L58
move R3,R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L58
*line 381
*line 382
*line 383
*line 384
*line 385
*line 386
move.l 12(R13),R12
*line 387
*line 388
*line 389
cmp.l _p_bak,R13
bne L59
*line 389
move.l R12,_p_bak
*line 390
L59:
*line 391
*line 392
cmp.l _p_cur,R13
bne L60
*line 392
move.l R12,_p_cur
*line 393
L60:
*line 394
*line 395
cmp.l _p_ctr,R13
bne L61
*line 395
move.l R12,_p_ctr
*line 396
L61:
*line 397
*line 398
cmp.l _p_fwd,R13
bne L62
*line 398
move.l R12,_p_fwd
*line 399
L62:
*line 400
move.l R13,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 401
move.l R12,R13
bra L63
*line 402
*line 403
*line 404
*line 405
L58:bra L64
L57:
*line 406
*line 406
cmp #14,R4
bne L65
*line 407
*line 408
move.b 6(R13),R3
ext.w R3
and #15,R3
*line 409
*line 410
*line 411
*line 412
move R3,R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L66
tst _ancmsw
beq L10002
move.b 6(R13),R0
ext.w R0
asr #4,R0
and #15,R0
asl #5,R0
ext.l R0
move R3,R1
asl #1,R1
ext.l R1
add.l R1,R0
move.l R0,R8
move.l #_varmode,R9
move 0(R8,R9.l),R0
bra L10004
L10002:move R3,R8
add.l R8,R8
move.l #_grpmode,R9
move 0(R8,R9.l),R0
L10004:cmp #2,R0
bne L66
*line 413
*line 414
*line 415
*line 416
*line 417
*line 418
move.l 12(R13),R12
*line 419
*line 420
*line 421
cmp.l _p_bak,R13
bne L67
*line 421
move.l R12,_p_bak
*line 422
L67:
*line 423
*line 424
cmp.l _p_cur,R13
bne L68
*line 424
move.l R12,_p_cur
*line 425
L68:
*line 426
*line 427
cmp.l _p_ctr,R13
bne L69
*line 427
move.l R12,_p_ctr
*line 428
L69:
*line 429
*line 430
cmp.l _p_fwd,R13
bne L70
*line 430
move.l R12,_p_fwd
*line 431
L70:
*line 432
move.l R13,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 433
move.l R12,R13
bra L63
*line 434
*line 435
L66:
*line 436
L65:L64:
*line 437
*line 438
L56:
*line 439
*line 439
cmp.l (R13),R5
bne L71
*line 440
*line 441
move _se,(sp)
move.l R13,-(sp)
jsr _se_exec
addq.l #4,sp
*line 442
*line 443
*line 444
tst _se
bne L72
*line 444
move.l 12(R13),R13
*line 445
bra L73
L72:
*line 446
move.l 8(R13),R13
L73:
*line 447
*line 448
L71:L63:
*line 449
*line 450
*line 451
*line 452
tst _se
bne L10005
cmp.b #21,5(R13)
beq L53
L10005:cmp #1,_se
bne L10006
cmp.b #1,5(R13)
beq L53
L10006:L55:
*line 453
cmp.l (R13),R5
beq L54
L53:
*line 454
L52:L49:
*line 455
cmp.l R7,R5
bne L48
L47:
*line 458
move.l R13,_p_cur
*line 459
move.l R7,_t_cur
*line 462
clr R0
bra L45
L45:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.data
