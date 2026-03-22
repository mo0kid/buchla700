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
.globl _insmode
.globl _ep_adj
.text
_ep_adj:
~~ep_adj:
~sep=R13
~tval=R7
~sdir=12
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~tep=R12
*line 97
move.l 8(R14),R13
*line 97
move.l 14(R14),R7
*line 97
*line 98
tst.l R7
bge L2
*line 98
move _curscor,R8
add.l R8,R8
add.l R8,R8
move.l #_scores,R9
move.l 0(R8,R9.l),R0
bra L1
*line 99
L2:
*line 100
*line 100
tst 12(R14)
beq L3
*line 101
*line 102
*line 102
cmp.l (R13),R7
ble L4
*line 103
*line 104
bra L7
L6:
*line 105
*line 108
*line 109
*line 113
*line 114
*line 115
*line 116
cmp.l (R13),R7
ble L8
*line 116
move.l R12,R13
*line 117
bra L9
L8:bra L5
L9:
*line 118
L7:
*line 119
move.l 12(R13),R12
move.l R12,R0
bne L6
L5:
*line 120
*line 121
L4:
*line 122
bra L12
L11:
*line 123
*line 126
*line 127
*line 131
*line 132
*line 133
*line 134
cmp.l (R12),R7
bgt L10000
cmp.b #1,5(R12)
bne L13
L10000:*line 135
*line 139
*line 140
move.l R13,R0
bra L1
*line 141
*line 142
L13:
*line 143
move.l R12,R13
L12:
*line 144
move.l 8(R13),R12
move.l R12,R0
bne L11
L10:
*line 145
*line 148
*line 149
*line 153
*line 154
move.l R13,R0
bra L1
*line 155
*line 156
*line 157
*line 158
bra L14
L3:
*line 159
*line 160
*line 161
*line 161
cmp.l (R13),R7
bge L15
*line 162
*line 163
bra L18
L17:
*line 164
*line 167
*line 168
*line 172
*line 173
*line 174
*line 175
*line 176
cmp.l (R13),R7
bge L16
cmp.b #1,5(R13)
beq L16
*line 177
*line 178
move.l R12,R13
L18:
*line 179
move.l 8(R13),R12
move.l R12,R0
bne L17
L16:
*line 180
*line 181
L15:
*line 182
bra L21
L20:
*line 183
*line 186
*line 187
*line 191
*line 192
*line 193
*line 193
cmp.l (R12),R7
bge L22
*line 194
*line 198
*line 199
move.l R13,R0
bra L1
*line 200
*line 201
L22:
*line 202
move.l R12,R13
L21:
*line 203
move.l 12(R13),R12
move.l R12,R0
bne L20
L19:
*line 204
*line 207
*line 208
*line 212
*line 213
move.l R13,R0
bra L1
L14:L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.globl _frfind
.text
_frfind:
~~frfind:
~tval=R7
~sdir=12
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~i=R6
~t_min=R5
~dt=R4
~ep=R13
~sep=R12
*line 251
move.l 8(R14),R7
*line 251
*line 251
tst.l _scp
bne L24
*line 252
*line 256
*line 257
clr.l R0
bra L23
*line 258
*line 259
L24:
*line 260
*line 261
tst.l R7
bge L25
*line 261
move.l R7,(sp)
move 12(R14),-(sp)
move.l _scp,-(sp)
jsr _ep_adj
addq.l #6,sp
bra L23
*line 262
L25:
*line 263
*line 263
move.l _p_cur,R8
cmp.l (R8),R7
bne L26
*line 264
*line 268
*line 269
move.l R7,(sp)
move 12(R14),-(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
bra L23
*line 270
*line 271
L26:
*line 272
*line 272
move.l _p_fwd,R8
cmp.l (R8),R7
bne L27
*line 273
*line 277
*line 278
move.l R7,(sp)
move 12(R14),-(sp)
move.l _p_fwd,-(sp)
jsr _ep_adj
addq.l #6,sp
bra L23
*line 279
*line 280
L27:
*line 281
*line 281
move.l _p_bak,R8
cmp.l (R8),R7
bne L28
*line 282
*line 286
*line 287
move.l R7,(sp)
move 12(R14),-(sp)
move.l _p_bak,-(sp)
jsr _ep_adj
addq.l #6,sp
bra L23
*line 288
*line 289
L28:
*line 290
*line 291
*line 292
move.l _p_cur,R8
cmp.l (R8),R7
ble L10001
move.l R7,R0
move.l _p_cur,R9
move.l (R9),R1
sub.l R1,R0
bra L10003
L10001:move.l _p_cur,R8
move.l (R8),R0
sub.l R7,R0
L10003:move.l R0,R5
*line 294
move.l _p_cur,R13
*line 296
*line 297
*line 298
move.l _p_fwd,R8
cmp.l (R8),R7
ble L10004
move.l R7,R0
move.l _p_fwd,R9
move.l (R9),R1
sub.l R1,R0
bra L10006
L10004:move.l _p_fwd,R8
move.l (R8),R0
sub.l R7,R0
L10006:move.l R0,R4
*line 300
*line 300
cmp.l R5,R4
bge L29
*line 301
*line 302
move.l R4,R5
*line 303
move.l _p_fwd,R13
*line 304
*line 308
*line 309
*line 310
*line 311
*line 312
*line 313
L29:
*line 314
*line 315
*line 316
move.l _p_bak,R8
cmp.l (R8),R7
ble L10007
move.l R7,R0
move.l _p_bak,R9
move.l (R9),R1
sub.l R1,R0
bra L10009
L10007:move.l _p_bak,R8
move.l (R8),R0
sub.l R7,R0
L10009:move.l R0,R4
*line 318
*line 318
cmp.l R5,R4
bge L30
*line 319
*line 320
move.l R4,R5
*line 321
move.l _p_bak,R13
*line 322
*line 326
*line 327
*line 328
L30:
*line 329
*line 329
tst _insmode
bne L31
*line 330
*line 331
clr R6
bra L34
L35:
*line 332
*line 333
*line 333
move _curscor,R0
muls #80,R0
move R6,R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_seclist,R0
move.l R0,R8
move.l (R8),R12
move.l R12,R0
beq L36
*line 334
*line 335
*line 336
*line 337
cmp.l (R12),R7
ble L10010
move.l R7,R0
sub.l (R12),R0
bra L10012
L10010:move.l (R12),R0
sub.l R7,R0
L10012:move.l R0,R4
*line 338
*line 339
*line 339
cmp.l R5,R4
bge L37
*line 340
*line 341
move.l R4,R5
*line 342
move.l R12,R13
*line 343
*line 347
*line 348
L37:
*line 349
L36:L33:
*line 331
add #1,R6
L34:
*line 331
cmp #20,R6
blt L35
L32:
*line 350
*line 351
*line 352
*line 355
*line 356
L31:
*line 357
move.l R7,(sp)
move 12(R14),-(sp)
move.l R13,-(sp)
jsr _ep_adj
addq.l #6,sp
bra L23
L23:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _findev
.text
_findev:
~~findev:
~te=R7
~et=R6
~d1=R5
~d2=R4
~ep=8
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~tp=R13
*line 385
move.l 12(R14),R7
*line 385
move 16(R14),R6
*line 385
move 18(R14),R5
*line 385
move 20(R14),R4
*line 385
move.l R7,(sp)
move #1,-(sp)
move.l 8(R14),-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R13
*line 387
bra L41
L40:
*line 388
*line 389
*line 390
*line 391
*line 392
move.b 5(R13),R0
ext.w R0
cmp R0,R6
bne L42
cmp #-1,R5
beq L10013
move.b 6(R13),R0
ext.w R0
cmp R0,R5
bne L42
L10013:cmp #-1,R4
beq L10014
move.b 7(R13),R0
ext.w R0
cmp R0,R4
bne L42
L10014:*line 392
move.l R13,R0
bra L38
*line 393
L42:
*line 394
move.l 12(R13),R13
L41:
*line 395
cmp.l (R13),R7
beq L40
L39:
*line 397
clr.l R0
bra L38
L38:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _ehfind
.text
_ehfind:
~~ehfind:
~eh=R7
~te=R6
~d1=R5
~d2=R4
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~tp=R13
*line 428
move 8(R14),R7
*line 428
move.l 10(R14),R6
*line 428
move 14(R14),R5
*line 428
move 16(R14),R4
*line 428
move _curscor,R0
muls #48,R0
move R7,R1
asl #2,R1
ext.l R1
add.l R1,R0
add.l #_hplist,R0
move.l R0,R8
move.l (R8),R13
*line 430
bra L46
L45:
*line 431
*line 432
*line 433
*line 434
*line 435
cmp.l #$ffffffff,R6
beq L10015
cmp.l (R13),R6
bne L47
L10015:cmp #-1,R5
beq L10016
move.b 6(R13),R0
ext.w R0
cmp R0,R5
bne L47
L10016:cmp #-1,R4
beq L10017
move.b 7(R13),R0
ext.w R0
cmp R0,R4
bne L47
L10017:*line 435
move.l R13,R0
bra L43
*line 436
L47:
*line 437
move.l 20(R13),R13
L46:
*line 438
move.l R13,R0
bne L45
L44:
*line 440
move.l R13,R0
bra L43
L43:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.data
