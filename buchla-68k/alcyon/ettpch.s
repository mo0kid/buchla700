.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _stcrow
.globl _stccol
.globl _cents
.globl _tdbox
.globl _tuntab
.globl _dspbuf
.globl _sfdsp
.globl _tunob
.globl _loc2key
.text
_loc2key:
~~loc2key:
~row=8
~col=10
link R14,#-4
*line 54
*line 54
cmp #24,8(R14)
bne L2
*line 55
*line 56
*line 57
cmp #6,10(R14)
ble L3
cmp #39,10(R14)
bge L3
*line 57
move #-1,R0
bra L1
bra L4
L3:
*line 58
*line 59
cmp #52,10(R14)
ble L5
*line 59
move #-9,R0
bra L1
*line 60
bra L6
L5:
*line 61
move #-10,R0
bra L1
L6:L4:
*line 62
bra L7
L2:
*line 63
*line 64
cmp #12,10(R14)
bge L8
*line 64
move 8(R14),R0
bra L1
bra L9
L8:
*line 65
*line 66
cmp #11,10(R14)
ble L10
cmp #22,10(R14)
bge L10
*line 66
move 8(R14),R0
add #24,R0
bra L1
bra L11
L10:
*line 67
*line 68
cmp #21,10(R14)
ble L12
cmp #32,10(R14)
bge L12
*line 68
move 8(R14),R0
add #48,R0
bra L1
bra L13
L12:
*line 69
*line 70
cmp #31,10(R14)
ble L14
cmp #42,10(R14)
bge L14
*line 70
move 8(R14),R0
add #72,R0
bra L1
bra L15
L14:
*line 71
*line 72
cmp #41,10(R14)
ble L16
cmp #53,10(R14)
bge L16
*line 72
move 8(R14),R0
add #96,R0
bra L1
bra L17
L16:
*line 73
*line 74
cmp #52,10(R14)
ble L18
cmp #8,8(R14)
bge L18
*line 74
move 8(R14),R0
add #120,R0
bra L1
bra L19
L18:
*line 75
*line 75
cmp #52,10(R14)
ble L20
*line 76
*line 77
*line 78
cmp #9,8(R14)
beq L10000
cmp #10,8(R14)
bne L21
L10000:*line 78
move #-2,R0
bra L1
bra L22
L21:
*line 79
*line 80
cmp #12,8(R14)
bne L23
*line 80
move #-3,R0
bra L1
bra L24
L23:
*line 81
*line 82
cmp #14,8(R14)
bne L25
*line 82
move #-4,R0
bra L1
bra L26
L25:
*line 83
*line 84
cmp #16,8(R14)
bne L27
*line 84
move #-5,R0
bra L1
bra L28
L27:
*line 85
*line 86
cmp #18,8(R14)
bne L29
*line 86
move #-6,R0
bra L1
bra L30
L29:
*line 87
*line 88
cmp #20,8(R14)
bne L31
*line 88
move #-7,R0
bra L1
bra L32
L31:
*line 89
*line 90
cmp #22,8(R14)
bne L33
*line 90
move #-8,R0
bra L1
*line 91
bra L34
L33:
*line 92
move #-10,R0
bra L1
L34:L32:L30:L28:L26:L24:L22:
*line 93
L20:L19:L17:L15:L13:L11:L9:L7:L1:unlk R14
rts
.globl _et_tpch
.text
_et_tpch:
~~et_tpch:
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~key=R7
~val=R6
*line 111
move _stccol,(sp)
move _stcrow,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,R7
*line 113
*line 114
tst R7
bge L36
*line 114
move #-1,R0
bra L35
*line 115
L36:
*line 116
move R7,R8
add.l R8,R8
add.l #_tuntab,R8
move (R8),R6
*line 117
move R6,R0
asr #1,R0
move R0,(sp)
move.l #_ebuf,-(sp)
jsr _cnvc2p
addq.l #4,sp
*line 118
move #1,_ebflag
*line 119
clr R0
bra L35
L35:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ef_tpch
.text
_ef_tpch:
~~ef_tpch:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~key=R7
*line 137
clr _ebflag
*line 138
move _stccol,(sp)
move _stcrow,-(sp)
jsr _loc2key
addq.l #2,sp
move R0,R7
*line 140
*line 141
tst R7
bge L38
*line 141
move #-1,R0
bra L37
*line 142
L38:
*line 143
*line 144
jsr _cnvp2c
cmp #-1,R0
bne L39
*line 144
move #-1,R0
bra L37
*line 145
L39:
*line 146
jsr _modtun
*line 147
move _cents,R0
asl #1,R0
move R7,R9
add.l R9,R9
add.l #_tuntab,R9
move R0,(R9)
*line 148
clr R0
bra L37
L37:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_tpch
.text
_rd_tpch:
~~rd_tpch:
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~val=R7
~key=R6
~n=R5
*line 166
move 8(R14),R5
and #255,R5
*line 167
move.l _cfetp,R8
move 2(R8),(sp)
move.l _cfetp,R8
move (R8),-(sp)
jsr _loc2key
addq.l #2,sp
move R0,R6
*line 168
move R6,R8
add.l R8,R8
add.l #_tuntab,R8
move (R8),R7
*line 170
move R7,R0
asr #1,R0
move R0,(sp)
move.l #_dspbuf,-(sp)
jsr _cnvc2p
addq.l #4,sp
*line 172
add.b #48,_dspbuf
*line 173
add.b #65,1+_dspbuf
*line 174
move.b 2+_dspbuf,R0
ext.w R0
ext.l R0
add.l #_sfdsp,R0
move.l R0,R8
move.b -7(R8),2+_dspbuf
*line 175
add.b #48,3+_dspbuf
*line 176
add.b #48,4+_dspbuf
*line 177
clr.b 5+_dspbuf
*line 179
clr (sp)
jsr _vbank
*line 180
*line 181
*line 182
*line 183
move #14,(sp)
move.l #_dspbuf,-(sp)
move.l _cfetp,R8
move 2(R8),-(sp)
move.l _cfetp,R8
move (R8),-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),-(sp)
cmp #320,R7
beq L10002
cmp #21920,R7
bne L10001
L10002:move #10,-(sp)
bra L10004
L10001:move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10004:move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 185
clr R0
bra L40
L40:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _nd_tpch
.text
_nd_tpch:
~~nd_tpch:
~nn=8
~k=10
link R14,#0
movem.l R5-R7,-(sp)
~col=R7
~n=R6
*line 203
move 8(R14),R6
and #255,R6
*line 205
*line 206
cmp #11,_stccol
bge L42
*line 206
move _stccol,R7
sub #6,R7
bra L43
L42:
*line 207
*line 208
cmp #21,_stccol
bge L44
*line 208
move _stccol,R7
add #-16,R7
bra L45
L44:
*line 209
*line 210
cmp #31,_stccol
bge L46
*line 210
move _stccol,R7
add #-26,R7
bra L47
L46:
*line 211
*line 212
cmp #41,_stccol
bge L48
*line 212
move _stccol,R7
add #-36,R7
bra L49
L48:
*line 213
*line 214
cmp #52,_stccol
bge L50
*line 214
move _stccol,R7
add #-47,R7
*line 215
bra L51
L50:
*line 216
move _stccol,R7
add #-58,R7
L51:L49:L47:L45:L43:
*line 218
move R7,R0
bra L53
*line 219
L54:
*line 220
*line 221
*line 222
move 10(R14),R0
move.b R0,_ebuf
*line 223
move 10(R14),R0
add #48,R0
move.b R0,_dspbuf
bra L52
*line 224
*line 225
L55:
*line 226
*line 227
*line 228
*line 229
cmp #6,10(R14)
ble L56
*line 229
move #-1,R0
bra L41
*line 230
L56:
*line 231
move 10(R14),R0
move.b R0,1+_ebuf
*line 232
move 10(R14),R0
add #65,R0
move.b R0,_dspbuf
bra L52
*line 233
*line 234
*line 235
L57:
*line 236
*line 237
*line 238
*line 238
cmp #7,10(R14)
bne L58
*line 239
*line 240
move 10(R14),R0
move.b R0,2+_ebuf
*line 241
move.b _sfdsp,_dspbuf
bra L52
*line 242
*line 243
bra L59
L58:
*line 244
*line 244
cmp #8,10(R14)
bne L60
*line 245
*line 246
move 10(R14),R0
move.b R0,2+_ebuf
*line 247
move.b 1+_sfdsp,_dspbuf
bra L52
*line 248
*line 249
bra L61
L60:
*line 250
*line 250
cmp #9,10(R14)
bne L62
*line 251
*line 252
move 10(R14),R0
move.b R0,2+_ebuf
*line 253
move.b 2+_sfdsp,_dspbuf
bra L52
*line 254
*line 255
*line 256
bra L63
L62:
*line 257
move #-1,R0
bra L41
L63:L61:L59:
*line 258
*line 259
L64:
*line 260
L65:
*line 261
*line 262
*line 263
move 10(R14),R0
move R7,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 264
move 10(R14),R0
add #48,R0
move.b R0,_dspbuf
bra L52
*line 265
bra L52
L53:cmp #4,R0
bhi L52
asl #2,R0
move R0,R8
add.l #L66,R8
move.l (R8),R8
jmp (R8)
.data
L66:.dc.l L54
.dc.l L55
.dc.l L57
.dc.l L64
.dc.l L65
.text
L52:
*line 268
clr.b 1+_dspbuf
*line 270
clr (sp)
jsr _vbank
*line 271
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),-(sp)
move #12,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 273
*line 274
cmp #4,R7
bne L67
*line 274
clr R0
bra L41
*line 275
L67:
*line 276
jsr _advtcur
*line 277
clr R0
bra L41
L41:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
