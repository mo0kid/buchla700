.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _hitbox
.globl _cxval
.globl _cyval
.globl _hitcx
.globl _hitcy
.globl _submenu
.globl _tunmod
.globl _curtun
.globl _tdnamsw
.globl _ttcmdsv
.globl _ttsel1
.globl _ttsel2
.globl _ttsel3
.globl _tdbox
.globl _csbp
.globl _curboxp
.globl _tunob
.globl _tuntab
.globl _oldtun
.globl _tuncurn
.globl _vtlin1
.globl _vtlin2
.globl _vtlin3
.globl _tdboxes
.data
_tdboxes:
.dc.w $0
.dc.w $0
.dc.w $5F
.dc.w $14F
.dc.w $0
*line 45
.dc.l _tdfnbox
.dc.w $60
.dc.w $0
.dc.w $AF
.dc.w $14F
.dc.w $1
*line 46
.dc.l _tdfnbox
.dc.w $B0
.dc.w $0
.dc.w $FF
.dc.w $14F
.dc.w $2
*line 47
.dc.l _tdfnbox
.dc.w $100
.dc.w $0
.dc.w $14F
.dc.w $14F
.dc.w $3
*line 48
.dc.l _tdfnbox
.dc.w $150
.dc.w $0
.dc.w $1A7
.dc.w $14F
.dc.w $4
*line 49
.dc.l _tdfnbox
.dc.w $1A8
.dc.w $0
.dc.w $1FF
.dc.w $76
.dc.w $5
*line 50
.dc.l _tdfnbox
.dc.w $1A8
.dc.w $77
.dc.w $1FF
.dc.w $15D
.dc.w $6
*line 51
.dc.l _tdfnbox
.dc.w $0
.dc.w $150
.dc.w $1A7
.dc.w $15D
.dc.w $7
*line 52
.dc.l _tdfnbox
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.l $0
.globl _endttyp
.text
_endttyp:
~~endttyp:
link R14,#-4
*line 68
clr _tdnamsw
*line 69
clr _submenu
*line 70
clr (sp)
jsr _tdswin
*line 71
move #1,(sp)
jsr _tdswin
*line 72
move #2,(sp)
jsr _tdswin
*line 73
move #6,(sp)
jsr _tdswin
L1:unlk R14
rts
.globl _tcoladj
.text
_tcoladj:
~~tcoladj:
~icol=8
link R14,#-4
*line 86
*line 87
cmp #12,8(R14)
bge L3
*line 87
move #6,R0
bra L2
bra L4
L3:
*line 88
*line 89
cmp #22,8(R14)
bge L5
*line 89
move #16,R0
bra L2
bra L6
L5:
*line 90
*line 91
cmp #32,8(R14)
bge L7
*line 91
move #26,R0
bra L2
bra L8
L7:
*line 92
*line 93
cmp #42,8(R14)
bge L9
*line 93
move #36,R0
bra L2
bra L10
L9:
*line 94
*line 95
cmp #53,8(R14)
bge L11
*line 95
move #47,R0
bra L2
*line 96
bra L12
L11:
*line 97
move #58,R0
bra L2
L12:L10:L8:L6:L4:L2:unlk R14
rts
.globl _tdhilit
.text
_tdhilit:
~~tdhilit:
~from=8
~to=10
link R14,#0
movem.l R3-R7,-(sp)
~i=R7
~row=R6
~col=R5
~box=R4
*line 114
*line 114
move 10(R14),R0
cmp 8(R14),R0
bge L14
*line 115
*line 116
move 10(R14),R7
*line 117
move 8(R14),10(R14)
*line 118
move R7,8(R14)
*line 119
*line 120
*line 121
L14:
*line 122
move 8(R14),R7
bra L17
L18:
*line 123
*line 124
*line 124
cmp #24,R7
bge L19
*line 125
*line 126
move R7,R6
*line 127
move #6,R5
*line 128
clr R4
*line 129
bra L20
L19:
*line 130
*line 130
cmp #48,R7
bge L21
*line 131
*line 132
move R7,R6
add #-24,R6
*line 133
move #16,R5
*line 134
move #1,R4
*line 135
bra L22
L21:
*line 136
*line 136
cmp #72,R7
bge L23
*line 137
*line 138
move R7,R6
add #-48,R6
*line 139
move #26,R5
*line 140
move #2,R4
*line 141
bra L24
L23:
*line 142
*line 142
cmp #96,R7
bge L25
*line 143
*line 144
move R7,R6
add #-72,R6
*line 145
move #36,R5
*line 146
move #3,R4
*line 147
bra L26
L25:
*line 148
*line 148
cmp #120,R7
bge L27
*line 149
*line 150
move R7,R6
add #-96,R6
*line 151
move #47,R5
*line 152
move #4,R4
*line 153
bra L28
L27:
*line 154
*line 155
*line 156
move R7,R6
add #-120,R6
*line 157
move #58,R5
*line 158
move #5,R4
L28:L26:L24:L22:L20:
*line 159
*line 160
*line 161
move R4,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move #13,-(sp)
move R7,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move R5,-(sp)
move R6,-(sp)
jsr _dsttval
addq.l #8,sp
L16:
*line 122
add #1,R7
L17:
*line 122
cmp 10(R14),R7
ble L18
L15:L13:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _tdfnbox
.text
_tdfnbox:
~~tdfnbox:
~n=8
link R14,#0
movem.l R2-R7,-(sp)
~i=R7
~key=R6
~dcol=R5
~row=R4
~col=R3
*line 180
move _hitcy,R4
ext.l R4
divs #14,R4
*line 181
move _hitcx,R3
asr #3,R3
*line 183
move _hitbox,R0
bra L31
*line 184
L32:
*line 185
L33:
*line 186
L34:
*line 187
L35:
*line 188
L36:
*line 189
L37:
*line 190
*line 191
*line 192
move _ttcmdsv,R0
bra L39
*line 193
L40:
*line 194
*line 195
*line 196
jsr _enterit
*line 197
clr R0
bra L29
*line 198
*line 199
L41:
*line 200
*line 201
*line 202
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel1
*line 203
*line 204
*line 204
tst _ttsel1
bge L42
*line 205
*line 206
clr _ttcmdsv
*line 207
move #6,(sp)
jsr _tdswin
*line 208
clr R0
bra L29
*line 209
*line 210
L42:
*line 211
move #2,_ttcmdsv
*line 212
move R3,(sp)
jsr _tcoladj
move R0,R5
*line 213
*line 214
move _hitbox,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move #13,-(sp)
move _ttsel1,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dsttval
addq.l #8,sp
*line 215
*line 216
clr R0
bra L29
*line 217
L43:
*line 218
*line 219
*line 220
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel2
*line 221
*line 222
*line 222
tst _ttsel2
bge L44
*line 223
*line 224
clr _ttcmdsv
*line 225
move #6,(sp)
jsr _tdswin
*line 226
clr R0
bra L29
*line 227
*line 228
L44:
*line 229
move #3,_ttcmdsv
*line 230
move _ttsel2,(sp)
move _ttsel1,-(sp)
jsr _tdhilit
addq.l #2,sp
*line 231
clr R0
bra L29
*line 232
L45:
*line 233
*line 234
*line 235
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel3
*line 236
*line 237
*line 238
tst _ttsel3
blt L46
*line 238
move _ttsel3,(sp)
move _ttsel2,-(sp)
move _ttsel1,-(sp)
jsr _tt_trcp
addq.l #4,sp
*line 239
L46:
*line 240
clr _ttcmdsv
*line 241
*line 242
clr R7
bra L49
L50:
*line 243
move R7,(sp)
jsr _tdswin
L48:
*line 242
add #1,R7
L49:
*line 242
cmp #7,R7
blt L50
L47:
*line 243
*line 244
*line 245
clr R0
bra L29
*line 246
*line 247
L51:
*line 248
*line 249
*line 250
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel1
*line 251
*line 252
*line 252
tst _ttsel1
bge L52
*line 253
*line 254
clr _ttcmdsv
*line 255
move #6,(sp)
jsr _tdswin
*line 256
clr R0
bra L29
*line 257
*line 258
L52:
*line 259
move #5,_ttcmdsv
*line 260
move R3,(sp)
jsr _tcoladj
move R0,R5
*line 261
*line 262
move _hitbox,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move #13,-(sp)
move _ttsel1,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dsttval
addq.l #8,sp
*line 263
*line 264
clr R0
bra L29
*line 265
L53:
*line 266
*line 267
*line 268
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel2
*line 269
*line 270
*line 271
tst _ttsel2
blt L54
*line 271
move _ttsel2,(sp)
move _ttsel1,-(sp)
jsr _tt_incr
addq.l #2,sp
*line 272
L54:
*line 273
clr _ttcmdsv
*line 274
*line 275
clr R7
bra L57
L58:
*line 276
move R7,(sp)
jsr _tdswin
L56:
*line 275
add #1,R7
L57:
*line 275
cmp #7,R7
blt L58
L55:
*line 276
*line 277
*line 278
clr R0
bra L29
*line 279
*line 280
L59:
*line 281
*line 282
*line 283
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel1
*line 284
*line 285
*line 285
tst _ttsel1
bge L60
*line 286
*line 287
clr _ttcmdsv
*line 288
move #6,(sp)
jsr _tdswin
*line 289
clr R0
bra L29
*line 290
*line 291
L60:
*line 292
move #7,_ttcmdsv
*line 293
move R3,(sp)
jsr _tcoladj
move R0,R5
*line 294
*line 295
move _hitbox,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move #13,-(sp)
move _ttsel1,R8
add.l R8,R8
move.l #_tuntab,R9
move 0(R8,R9.l),-(sp)
move R5,-(sp)
move R4,-(sp)
jsr _dsttval
addq.l #8,sp
*line 296
*line 297
clr R0
bra L29
*line 298
L61:
*line 299
*line 300
*line 301
move R3,(sp)
move R4,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,_ttsel2
*line 302
*line 303
*line 304
tst _ttsel2
blt L62
*line 304
move _ttsel2,(sp)
move _ttsel1,-(sp)
jsr _tt_intp
addq.l #2,sp
*line 305
L62:
*line 306
clr _ttcmdsv
*line 307
*line 308
clr R7
bra L65
L66:
*line 309
move R7,(sp)
jsr _tdswin
L64:
*line 308
add #1,R7
L65:
*line 308
cmp #7,R7
blt L66
L63:
*line 309
*line 310
*line 311
clr R0
bra L29
bra L38
L39:cmp #7,R0
bhi L38
asl #2,R0
move R0,R8
add.l #L67,R8
move.l (R8),R8
jmp (R8)
.data
L67:.dc.l L40
.dc.l L41
.dc.l L43
.dc.l L45
.dc.l L51
.dc.l L53
.dc.l L59
.dc.l L61
.text
L38:
*line 312
*line 313
*line 314
move #-1,R0
bra L29
*line 315
*line 316
L68:
*line 317
*line 318
*line 319
move R4,R0
bra L70
*line 320
L71:
*line 321
L72:
*line 322
*line 323
*line 324
move #1,_ttcmdsv
*line 325
move #1,(sp)
jsr _td_trcp
*line 326
clr R0
bra L29
*line 327
L73:
*line 328
*line 329
*line 330
move #4,_ttcmdsv
*line 331
move #1,(sp)
jsr _td_incr
*line 332
clr R0
bra L29
*line 333
L74:
*line 334
*line 335
*line 336
move #6,_ttcmdsv
*line 337
move #1,(sp)
jsr _td_intp
*line 338
clr R0
bra L29
*line 339
L75:
*line 340
*line 341
*line 342
clr _ttcmdsv
*line 343
move #128,(sp)
move.l #_oldtun,-(sp)
move.l #_tuntab,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 344
jsr _twins
*line 345
clr R0
bra L29
*line 346
*line 347
L76:
*line 348
L77:
*line 349
*line 350
*line 351
jsr _enterit
*line 352
clr R0
bra L29
*line 353
L78:
*line 354
*line 355
*line 356
*line 357
tst _curtun
bne L79
*line 357
move #-1,R0
bra L29
*line 358
L79:
*line 359
move _curtun,(sp)
jsr _puttun
*line 360
move #128,(sp)
move.l #_tuntab,-(sp)
move.l #_oldtun,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 361
move #6,(sp)
jsr _tdswin
*line 362
clr R0
bra L29
*line 363
L80:
*line 364
*line 365
*line 366
move _curtun,(sp)
jsr _gettun
*line 367
move #128,(sp)
move.l #_tuntab,-(sp)
move.l #_oldtun,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 368
jsr _twins
*line 369
clr R0
bra L29
bra L69
L70:sub #9,R0
cmp #15,R0
bhi L69
asl #2,R0
move R0,R8
add.l #L81,R8
move.l (R8),R8
jmp (R8)
.data
L81:.dc.l L71
.dc.l L72
.dc.l L69
.dc.l L73
.dc.l L69
.dc.l L74
.dc.l L69
.dc.l L75
.dc.l L69
.dc.l L76
.dc.l L69
.dc.l L78
.dc.l L69
.dc.l L80
.dc.l L69
.dc.l L77
.text
L69:
*line 370
*line 371
*line 372
move #-1,R0
bra L29
*line 373
*line 374
*line 375
L82:
*line 376
*line 377
*line 378
*line 379
cmp #7,R3
blt L10000
cmp #38,R3
ble L83
L10000:*line 379
move #-1,R0
bra L29
*line 380
L83:
*line 381
*line 381
tst _tdnamsw
beq L84
*line 382
*line 383
jsr _vtyper
*line 384
move #1,_tunmod
*line 385
bra L85
L84:
*line 386
*line 387
*line 388
clr (sp)
jsr _vbank
*line 389
*line 390
move #7,(sp)
jsr _exp_c
move R0,(sp)
move #335,-(sp)
move #247,-(sp)
move #294,-(sp)
move #8,-(sp)
move #128,-(sp)
move.l _tunob,-(sp)
jsr _vbfill4
adda.l #14,sp
*line 391
*line 392
move #14,(sp)
move.l #_vtlin1,-(sp)
move #1,-(sp)
move #21,-(sp)
move #11,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 393
move #14,(sp)
move.l #_vtlin2,-(sp)
move #1,-(sp)
move #22,-(sp)
move #11,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 394
move #14,(sp)
move.l #_vtlin3,-(sp)
move #1,-(sp)
move #23,-(sp)
move #11,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _tsplot4
adda.l #16,sp
*line 395
*line 396
*line 397
*line 398
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move.l #_endttyp,-(sp)
move.l #_nokey,-(sp)
move.l #_nokey,-(sp)
move.l #_bsptcur,-(sp)
move.l #_advtcur,-(sp)
move #1,-(sp)
move #21,-(sp)
move.l #_tuncurn,-(sp)
move #7,-(sp)
move.l #_vtdisp,-(sp)
move.l _tunob,-(sp)
jsr _vtsetup
adda.l #40,sp
*line 399
*line 400
move #1,_tdnamsw
*line 401
move #1,_submenu
L85:
*line 402
*line 403
*line 404
clr R0
bra L29
bra L30
L31:cmp #7,R0
bhi L30
asl #2,R0
move R0,R8
add.l #L86,R8
move.l (R8),R8
jmp (R8)
.data
L86:.dc.l L32
.dc.l L33
.dc.l L34
.dc.l L35
.dc.l L36
.dc.l L37
.dc.l L68
.dc.l L82
.text
L30:
*line 407
move #-1,R0
bra L29
L29:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.data
