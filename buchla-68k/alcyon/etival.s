.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _instob
.globl _stccol
.globl _curfunc
.globl _idbox
.globl _dspbuf
.globl _pntptr
.globl _vtcrow
.globl _vtccol
.globl _idsrcsw
.globl _submenu
.globl _et_ival
.text
_et_ival:
~~et_ival:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~vv=R7
~vh=R6
~vl=R5
*line 56
move.l _pntptr,R8
move 2(R8),R7
asr #5,R7
*line 57
move R7,R6
ext.l R6
divs #100,R6
*line 58
move R7,R5
move R6,R0
muls #100,R0
sub R0,R5
*line 60
move R5,(sp)
move R6,-(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 61
move.l _pntptr,R8
move.b 6(R8),R0
ext.w R0
add #48,R0
move.b R0,5+_ebuf
*line 62
move.l #6+_ebuf,(sp)
move.l _pntptr,R8
move 4(R8),-(sp)
jsr _fr2dec
addq.l #2,sp
*line 63
clr.b 10+_ebuf
*line 64
move #1,_ebflag
*line 71
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _ef_ival
.text
_ef_ival:
~~ef_ival:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~i=R7
~tmpval=R6
~srctmp=R5
*line 89
move.b #46,2+_ebuf
*line 90
clr.b 10+_ebuf
*line 91
clr _ebflag
*line 100
*line 100
tst _idsrcsw
beq L4
*line 101
*line 102
clr _idsrcsw
*line 103
clr _submenu
*line 104
*line 105
*line 105
cmp #22,_vtcrow
bne L5
*line 106
*line 107
*line 108
*line 109
*line 110
cmp #24,_vtccol
bge L6
*line 110
move #11,R5
bra L7
L6:
*line 111
*line 112
cmp #24,_vtccol
ble L8
cmp #28,_vtccol
bge L8
*line 112
move #5,R5
bra L9
L8:
*line 113
*line 114
cmp #28,_vtccol
ble L10
cmp #32,_vtccol
bge L10
*line 114
move #10,R5
bra L11
L10:
*line 115
*line 116
cmp #32,_vtccol
ble L12
cmp #40,_vtccol
bge L12
*line 116
move #1,R5
*line 117
bra L13
L12:
*line 118
move #2,R5
L13:L11:L9:L7:
*line 119
bra L14
L5:
*line 120
*line 120
cmp #23,_vtcrow
bne L15
*line 121
*line 122
*line 123
*line 124
*line 125
cmp #24,_vtccol
bge L16
*line 125
move #12,R5
bra L17
L16:
*line 126
*line 127
cmp #24,_vtccol
ble L18
cmp #32,_vtccol
bge L18
*line 127
move #7,R5
bra L19
L18:
*line 128
*line 129
cmp #32,_vtccol
ble L20
cmp #40,_vtccol
bge L20
*line 129
move #8,R5
*line 130
bra L21
L20:
*line 131
clr R5
L21:L19:L17:
*line 132
bra L22
L15:
*line 133
*line 134
*line 135
*line 136
*line 137
*line 138
cmp #24,_vtccol
bge L23
*line 138
move #13,R5
bra L24
L23:
*line 139
*line 140
cmp #24,_vtccol
ble L25
cmp #32,_vtccol
bge L25
*line 140
move #6,R5
*line 141
bra L26
L25:
*line 142
clr R5
L26:L24:L22:L14:
*line 143
*line 144
*line 145
move R5,R0
move.l _pntptr,R9
move.b R0,6(R9)
*line 146
move #14,(sp)
jsr _objclr
*line 147
jsr _idvlblc
*line 148
move #22,(sp)
jsr _dswin
*line 149
jsr _modinst
*line 150
*line 151
bra L27
L4:
*line 152
*line 152
cmp #32,_stccol
bge L28
*line 153
*line 154
clr R6
*line 155
*line 156
clr R7
bra L31
L32:
*line 157
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L30:
*line 156
add #1,R7
L31:
*line 156
cmp #2,R7
blt L32
L29:
*line 157
*line 158
*line 159
move #3,R7
bra L35
L36:
*line 160
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L34:
*line 159
add #1,R7
L35:
*line 159
cmp #5,R7
blt L36
L33:
*line 160
*line 161
*line 162
*line 162
cmp #1000,R6
ble L37
*line 163
*line 167
*line 168
*line 169
move #-1,R0
bra L3
*line 170
*line 171
L37:
*line 172
move R6,R0
asl #5,R0
move.l _pntptr,R9
move R0,2(R9)
*line 173
move _curfunc,(sp)
jsr _edfunc
*line 174
jsr _modinst
*line 175
bra L38
L28:
*line 176
*line 176
cmp #33,_stccol
blt L39
cmp #39,_stccol
bgt L39
*line 177
*line 178
move #1,_idsrcsw
*line 179
move #1,_submenu
*line 180
jsr _idvlbld
*line 181
move #22,(sp)
jsr _dswin
*line 182
move #14,(sp)
move #2,-(sp)
jsr _SetPri
addq.l #2,sp
*line 183
move #17,(sp)
move #22,-(sp)
jsr _ttcpos
addq.l #2,sp
*line 184
bra L40
L39:
*line 185
*line 185
cmp #41,_stccol
blt L41
cmp #44,_stccol
bgt L41
*line 186
*line 187
move.l #6+_ebuf,(sp)
jsr _dec2fr
move R0,R6
*line 188
*line 189
*line 189
cmp #-1,R6
bne L42
*line 190
*line 194
*line 195
*line 196
move #-1,R0
bra L3
*line 197
bra L43
L42:
*line 198
*line 199
*line 200
move.l _pntptr,R8
move R6,4(R8)
*line 201
jsr _modinst
L43:
*line 202
*line 203
*line 204
bra L44
L41:
*line 205
move #-1,R0
bra L3
L44:L40:L38:L27:
*line 212
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _rd_ival
.text
_rd_ival:
~~rd_ival:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~vv=R7
~vh=R6
~vl=R5
*line 230
move.l _pntptr,R8
move 2(R8),R7
asr #5,R7
*line 231
move R7,R6
ext.l R6
divs #100,R6
*line 232
move R7,R5
move R6,R0
muls #100,R0
sub R0,R5
*line 234
move R5,(sp)
move R6,-(sp)
move.l #L46,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 235
move.l _pntptr,R8
move 4(R8),(sp)
move.l _pntptr,R8
move.b 6(R8),R0
ext.w R0
move R0,-(sp) 
move.l #6+_dspbuf,-(sp)
jsr _dsimlt
addq.l #6,sp
*line 237
clr (sp)
jsr _vbank
*line 239
*line 240
move #14,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 242
clr R0
bra L45
L45:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _nd_ival
.text
_nd_ival:
~~nd_ival:
~k=R7
~n=8
link R14,#0
movem.l R6-R7,-(sp)
*line 259
move 10(R14),R7
*line 259
*line 260
tst _idsrcsw
beq L48
*line 260
move #-1,R0
bra L47
*line 261
L48:
*line 262
*line 263
cmp #32,_stccol
blt L49
cmp #40,_stccol
bgt L49
*line 263
move #-1,R0
bra L47
*line 264
L49:
*line 265
*line 266
cmp #29,_stccol
bne L50
*line 266
move #-1,R0
bra L47
*line 267
L50:
*line 268
move.b #46,2+_ebuf
*line 269
clr.b 10+_ebuf
*line 273
*line 273
cmp #32,_stccol
bge L51
*line 274
*line 275
move R7,R0
add #48,R0
move _stccol,R9
add.l #_ebuf,R9
move.b R0,-27(R9)
*line 276
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 277
bra L52
L51:
*line 278
*line 278
cmp #41,_stccol
bne L53
*line 279
*line 280
*line 280
cmp #8,R7
bne L54
*line 281
*line 282
move.b #45,9+_ebuf
*line 283
move.b #45,_dspbuf
*line 284
bra L55
L54:
*line 285
*line 285
cmp #9,R7
bne L56
*line 286
*line 287
move.b #43,9+_ebuf
*line 288
move.b #43,_dspbuf
*line 289
*line 290
bra L57
L56:
*line 291
move #-1,R0
bra L47
L57:L55:
*line 292
bra L58
L53:
*line 293
*line 293
cmp #42,_stccol
bne L59
*line 294
*line 295
*line 295
tst R7
bne L60
*line 296
*line 297
move.b #48,6+_ebuf
*line 298
move.b #46,_dspbuf
*line 299
bra L61
L60:
*line 300
*line 300
cmp #1,R7
bne L62
*line 301
*line 302
move.b #49,6+_ebuf
*line 303
move.b #164,_dspbuf
*line 304
*line 305
bra L63
L62:
*line 306
move #-1,R0
bra L47
L63:L61:
*line 307
bra L64
L59:
*line 308
*line 309
*line 310
move R7,R0
add #48,R0
move _stccol,R9
add.l #_ebuf,R9
move.b R0,-36(R9)
*line 311
move R7,R0
add #48,R0
move.b R0,_dspbuf
L64:L58:L52:
*line 315
clr.b 1+_dspbuf
*line 317
clr (sp)
jsr _vbank
*line 319
*line 320
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 322
*line 323
cmp #31,_stccol
beq L10000
cmp #44,_stccol
bne L65
L10000:*line 323
clr R0
bra L47
*line 324
L65:
*line 325
jsr _advicur
*line 327
*line 328
cmp #29,_stccol
bne L66
*line 328
jsr _advicur
*line 329
L66:
*line 330
clr R0
bra L47
L47:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$2E,$25,$30,$32,$64,$0
L46:.dc.b $25,$30,$32,$64,$2E,$25,$30,$32,$64,$20,$0
