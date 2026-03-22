.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _v_obtab
.globl _v_curob
.globl _v_nobj
.globl _v_obpri
.globl _instob
.globl _stcrow
.globl _stccol
.globl _curvce
.globl _curfunc
.globl _idsrcsw
.globl _vtcrow
.globl _vtccol
.globl _submenu
.globl _idbox
.globl _dspbuf
.globl _srctbl
.globl _pntptr
.globl _vbufs
.globl _dsimlt
.text
_dsimlt:
~~dsimlt:
~mltval=R7
~buf=8
~src=12
link R14,#-12
movem.l R6-R7,-(sp)
~mltstr=-6
~mlttmp=-12
*line 62
move 14(R14),R7
*line 62
move.l R14,(sp)
add.l #-12,(sp)
move R7,-(sp)
jsr _fr2dec
addq.l #2,sp
*line 64
move.b -9(R14),-6(R14)
*line 66
*line 67
cmp.b #48,-12(R14)
bne L2
*line 67
move.b #46,-5(R14)
*line 68
bra L3
L2:
*line 69
move.b #164,-5(R14)
L3:
*line 71
move.b -11(R14),-4(R14)
*line 72
move.b -10(R14),-3(R14)
*line 73
clr.b -2(R14)
*line 75
move.l R14,(sp)
sub.l #6,(sp)
move 12(R14),R8
add.l R8,R8
add.l R8,R8
move.l #_srctbl,R9
move.l 0(R8,R9.l),-(sp)
move.l #L4,-(sp)
move.l 8(R14),-(sp)
jsr _sprintf
adda.l #12,sp
*line 83
move.l 8(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _et_imlt
.text
_et_imlt:
~~et_imlt:
~n=8
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~ip=R13
~fp=R12
*line 102
move _curvce,R0
muls #3938,R0
move.l R0,R13
add.l #_vbufs,R13
*line 103
move.l R13,R12
move _curfunc,R0
muls #12,R0
add.l R0,R12
add.l #86,R12
*line 105
move.b 4(R12),R0
ext.w R0
add #48,R0
move.b R0,_ebuf
*line 106
move.l #1+_ebuf,(sp)
move 2(R12),-(sp)
jsr _fr2dec
addq.l #2,sp
*line 107
clr.b 5+_ebuf
*line 109
move #1,_ebflag
*line 116
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _ef_imlt
.text
_ef_imlt:
~~ef_imlt:
~n=8
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~i=R7
~tmpval=R6
~srctmp=R5
~ip=R13
~fp=R12
*line 136
move _curvce,R0
muls #3938,R0
move.l R0,R13
add.l #_vbufs,R13
*line 137
move.l R13,R12
move _curfunc,R0
muls #12,R0
add.l R0,R12
add.l #86,R12
*line 139
clr.b 5+_ebuf
*line 140
clr _ebflag
*line 149
*line 149
tst _idsrcsw
beq L7
*line 150
*line 151
clr _idsrcsw
*line 152
clr _submenu
*line 153
*line 154
*line 154
cmp #22,_vtcrow
bne L8
*line 155
*line 156
*line 157
*line 158
*line 159
cmp #24,_vtccol
bge L9
*line 159
move #11,R5
bra L10
L9:
*line 160
*line 161
cmp #24,_vtccol
ble L11
cmp #28,_vtccol
bge L11
*line 161
move #5,R5
bra L12
L11:
*line 162
*line 163
cmp #28,_vtccol
ble L13
cmp #32,_vtccol
bge L13
*line 163
move #10,R5
bra L14
L13:
*line 164
*line 165
cmp #32,_vtccol
ble L15
cmp #40,_vtccol
bge L15
*line 165
move #1,R5
*line 166
bra L16
L15:
*line 167
move #2,R5
L16:L14:L12:L10:
*line 168
bra L17
L8:
*line 169
*line 169
cmp #23,_vtcrow
bne L18
*line 170
*line 171
*line 172
*line 173
*line 174
cmp #24,_vtccol
bge L19
*line 174
move #12,R5
bra L20
L19:
*line 175
*line 176
cmp #24,_vtccol
ble L21
cmp #32,_vtccol
bge L21
*line 176
move #7,R5
bra L22
L21:
*line 177
*line 178
cmp #32,_vtccol
ble L23
cmp #40,_vtccol
bge L23
*line 178
move #8,R5
*line 179
bra L24
L23:
*line 180
clr R5
L24:L22:L20:
*line 181
bra L25
L18:
*line 182
*line 183
*line 184
*line 185
*line 186
*line 187
cmp #24,_vtccol
bge L26
*line 187
move #13,R5
bra L27
L26:
*line 188
*line 189
cmp #24,_vtccol
ble L28
cmp #32,_vtccol
bge L28
*line 189
move #6,R5
*line 190
bra L29
L28:
*line 191
clr R5
L29:L27:L25:L17:
*line 192
*line 193
*line 194
move.b R5,4(R12)
*line 195
move #14,(sp)
jsr _objclr
*line 196
jsr _idvlblc
*line 197
jsr _modinst
*line 198
move #22,(sp)
jsr _dswin
*line 199
*line 200
bra L30
L7:
*line 201
*line 201
cmp #8,_stccol
bge L31
*line 202
*line 203
move #1,_idsrcsw
*line 204
move #1,_submenu
*line 205
jsr _idvlbld
*line 206
move #22,(sp)
jsr _dswin
*line 207
move #14,(sp)
move #2,-(sp)
jsr _SetPri
addq.l #2,sp
*line 208
move #17,(sp)
move #22,-(sp)
jsr _ttcpos
addq.l #2,sp
*line 209
bra L32
L31:
*line 210
*line 210
cmp #8,_stccol
ble L33
*line 211
*line 212
move.l #1+_ebuf,(sp)
jsr _dec2fr
move R0,R6
*line 213
*line 214
*line 215
cmp #-1,R6
bne L34
*line 215
move #-1,R0
bra L6
*line 216
bra L35
L34:
*line 217
move R6,2(R12)
L35:
*line 218
*line 219
jsr _modinst
*line 220
*line 221
bra L36
L33:
*line 222
move #-1,R0
bra L6
L36:L32:L30:
*line 229
clr R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _rd_imlt
.text
_rd_imlt:
~~rd_imlt:
~n=8
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~ip=R13
~fp=R12
*line 248
move _curvce,R0
muls #3938,R0
move.l R0,R13
add.l #_vbufs,R13
*line 249
move.l R13,R12
move _curfunc,R0
muls #12,R0
add.l R0,R12
add.l #86,R12
*line 251
move 2(R12),(sp)
move.b 4(R12),R0
ext.w R0
move R0,-(sp) 
move.l #_dspbuf,-(sp)
jsr _dsimlt
addq.l #6,sp
*line 253
*line 254
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
*line 256
clr R0
bra L37
L37:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _nd_imlt
.text
_nd_imlt:
~~nd_imlt:
~k=R7
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~ec=R6
*line 275
move 10(R14),R7
*line 275
*line 276
tst _idsrcsw
beq L39
*line 276
move #-1,R0
bra L38
*line 277
L39:
*line 278
*line 279
cmp #9,_stccol
bge L40
*line 279
move #-1,R0
bra L38
*line 280
L40:
*line 281
move _stccol,R6
add #-9,R6
*line 283
move R6,R0
bra L42
*line 284
L43:
*line 285
*line 286
*line 287
*line 287
cmp #8,R7
bne L44
*line 288
*line 289
move.b #45,4+_ebuf
*line 290
move.b #45,_dspbuf
*line 291
bra L45
L44:
*line 292
*line 292
cmp #9,R7
bne L46
*line 293
*line 294
move.b #43,4+_ebuf
*line 295
move.b #43,_dspbuf
*line 296
*line 297
bra L47
L46:
*line 298
move #-1,R0
bra L38
L47:L45:
*line 299
bra L41
*line 300
*line 301
L48:
*line 302
*line 303
*line 304
*line 304
tst R7
bne L49
*line 305
*line 306
move.b #48,1+_ebuf
*line 307
move.b #46,_dspbuf
*line 308
bra L50
L49:
*line 309
*line 309
cmp #1,R7
bne L51
*line 310
*line 311
move.b #49,1+_ebuf
*line 312
move.b #164,_dspbuf
*line 313
*line 314
bra L52
L51:
*line 315
move #-1,R0
bra L38
L52:L50:
*line 316
bra L41
*line 317
*line 318
L53:
*line 319
L54:
*line 320
*line 321
*line 322
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 323
move R7,R0
add #48,R0
move.b R0,_dspbuf
bra L41
*line 324
*line 325
L55:
*line 326
*line 327
move #-1,R0
bra L38
bra L41
L42:tst R0
beq L43
cmp #1,R0
beq L48
cmp #2,R0
beq L53
cmp #3,R0
beq L54
bra L55
L41:
*line 330
clr.b 5+_ebuf
*line 331
clr.b 1+_dspbuf
*line 338
clr (sp)
jsr _vbank
*line 340
*line 341
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
*line 343
*line 344
cmp #4,R6
bne L56
*line 344
clr R0
bra L38
*line 345
L56:
*line 346
jsr _advicur
*line 348
clr R0
bra L38
L38:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L4:.dc.b $25,$37,$2E,$37,$73,$20,$25,$73,$0
