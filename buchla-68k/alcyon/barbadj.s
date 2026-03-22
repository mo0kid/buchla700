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
.globl _lcdx
.globl _lcdy
.globl _lcdbit
.globl _lcdrow
.globl _lcdcol
.globl _lcdbase
.globl _lcdctl1
.globl _lcdctl2
.globl _BarBcur
.globl _BarCcur
.globl _BarCols
.data
_BarCols:
.dc.w $2
.dc.w $8
.dc.w $E
.dc.w $14
.dc.w $1A
.dc.w $20
.dc.w $26
.dc.w $2C
.dc.w $32
.dc.w $38
.dc.w $3E
.dc.w $44
.dc.w $4A
.dc.w $50
.globl _BarDots
.data
_BarDots:
.dc.w $1C
.dc.w $FC
.dc.w $E0
.globl _BBase
.data
_BBase:
.dc.w $9
.globl _BCenter
.data
_BCenter:
.dc.w $20
.globl _BTop
.data
_BTop:
.dc.w $35
.globl _BOffset
.data
_BOffset:
.dc.w $80
.globl _BarBLn
.data
_BarBLn:
.dc.w $9
.dc.w $A
.dc.w $A
.dc.w $B
.dc.w $B
.dc.w $B
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $F
.dc.w $F
.dc.w $F
.dc.w $10
.dc.w $10
.dc.w $10
.dc.w $11
.dc.w $11
.dc.w $11
.dc.w $12
.dc.w $12
.dc.w $12
.dc.w $13
.dc.w $13
.dc.w $13
.dc.w $14
.dc.w $14
.dc.w $14
.dc.w $15
.dc.w $15
.dc.w $16
.dc.w $16
.dc.w $16
.dc.w $17
.dc.w $17
.dc.w $17
.dc.w $18
.dc.w $18
.dc.w $18
.dc.w $19
.dc.w $19
.dc.w $19
.dc.w $1A
.dc.w $1A
.dc.w $1A
.dc.w $1B
.dc.w $1B
.dc.w $1B
.dc.w $1C
.dc.w $1C
.dc.w $1C
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1F
.dc.w $1F
.dc.w $1F
.dc.w $20
.dc.w $20
.dc.w $20
.dc.w $21
.dc.w $21
.dc.w $22
.dc.w $22
.dc.w $22
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $24
.dc.w $24
.dc.w $24
.dc.w $25
.dc.w $25
.dc.w $25
.dc.w $26
.dc.w $26
.dc.w $26
.dc.w $27
.dc.w $27
.dc.w $27
.dc.w $28
.dc.w $28
.dc.w $28
.dc.w $29
.dc.w $29
.dc.w $29
.dc.w $2A
.dc.w $2A
.dc.w $2A
.dc.w $2B
.dc.w $2B
.dc.w $2B
.dc.w $2C
.dc.w $2C
.dc.w $2C
.dc.w $2D
.dc.w $2D
.dc.w $2E
.dc.w $2E
.dc.w $2E
.dc.w $2F
.dc.w $2F
.dc.w $2F
.dc.w $30
.dc.w $30
.dc.w $30
.dc.w $31
.dc.w $31
.dc.w $31
.dc.w $32
.dc.w $32
.dc.w $32
.dc.w $33
.dc.w $33
.dc.w $33
.dc.w $34
.dc.w $34
.dc.w $34
.dc.w $35
.dc.w $35
.globl _BarCLn
.data
_BarCLn:
.dc.w $9
.dc.w $9
.dc.w $9
.dc.w $9
.dc.w $9
.dc.w $A
.dc.w $A
.dc.w $A
.dc.w $A
.dc.w $A
.dc.w $B
.dc.w $B
.dc.w $B
.dc.w $B
.dc.w $B
.dc.w $B
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $C
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $D
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $E
.dc.w $F
.dc.w $F
.dc.w $F
.dc.w $F
.dc.w $F
.dc.w $10
.dc.w $10
.dc.w $10
.dc.w $10
.dc.w $10
.dc.w $10
.dc.w $11
.dc.w $11
.dc.w $11
.dc.w $11
.dc.w $11
.dc.w $12
.dc.w $12
.dc.w $12
.dc.w $12
.dc.w $12
.dc.w $12
.dc.w $13
.dc.w $13
.dc.w $13
.dc.w $13
.dc.w $13
.dc.w $14
.dc.w $14
.dc.w $14
.dc.w $14
.dc.w $14
.dc.w $14
.dc.w $15
.dc.w $15
.dc.w $15
.dc.w $15
.dc.w $15
.dc.w $15
.dc.w $16
.dc.w $16
.dc.w $16
.dc.w $16
.dc.w $16
.dc.w $17
.dc.w $17
.dc.w $17
.dc.w $17
.dc.w $17
.dc.w $17
.dc.w $18
.dc.w $18
.dc.w $18
.dc.w $18
.dc.w $18
.dc.w $19
.dc.w $19
.dc.w $19
.dc.w $19
.dc.w $19
.dc.w $19
.dc.w $1A
.dc.w $1A
.dc.w $1A
.dc.w $1A
.dc.w $1A
.dc.w $1A
.dc.w $1B
.dc.w $1B
.dc.w $1B
.dc.w $1B
.dc.w $1B
.dc.w $1C
.dc.w $1C
.dc.w $1C
.dc.w $1C
.dc.w $1C
.dc.w $1C
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1D
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1E
.dc.w $1F
.dc.w $1F
.dc.w $1F
.dc.w $1F
.dc.w $1F
.dc.w $1F
.dc.w $20
.dc.w $21
.dc.w $21
.dc.w $21
.dc.w $21
.dc.w $21
.dc.w $21
.dc.w $22
.dc.w $22
.dc.w $22
.dc.w $22
.dc.w $22
.dc.w $22
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $23
.dc.w $24
.dc.w $24
.dc.w $24
.dc.w $24
.dc.w $24
.dc.w $24
.dc.w $25
.dc.w $25
.dc.w $25
.dc.w $25
.dc.w $25
.dc.w $25
.dc.w $26
.dc.w $26
.dc.w $26
.dc.w $26
.dc.w $26
.dc.w $26
.dc.w $27
.dc.w $27
.dc.w $27
.dc.w $27
.dc.w $27
.dc.w $27
.dc.w $28
.dc.w $28
.dc.w $28
.dc.w $28
.dc.w $28
.dc.w $28
.dc.w $29
.dc.w $29
.dc.w $29
.dc.w $29
.dc.w $29
.dc.w $29
.dc.w $2A
.dc.w $2A
.dc.w $2A
.dc.w $2A
.dc.w $2A
.dc.w $2A
.dc.w $2B
.dc.w $2B
.dc.w $2B
.dc.w $2B
.dc.w $2B
.dc.w $2B
.dc.w $2B
.dc.w $2C
.dc.w $2C
.dc.w $2C
.dc.w $2C
.dc.w $2C
.dc.w $2C
.dc.w $2D
.dc.w $2D
.dc.w $2D
.dc.w $2D
.dc.w $2D
.dc.w $2D
.dc.w $2E
.dc.w $2E
.dc.w $2E
.dc.w $2E
.dc.w $2E
.dc.w $2E
.dc.w $2F
.dc.w $2F
.dc.w $2F
.dc.w $2F
.dc.w $2F
.dc.w $2F
.dc.w $30
.dc.w $30
.dc.w $30
.dc.w $30
.dc.w $30
.dc.w $30
.dc.w $31
.dc.w $31
.dc.w $31
.dc.w $31
.dc.w $31
.dc.w $31
.dc.w $32
.dc.w $32
.dc.w $32
.dc.w $32
.dc.w $32
.dc.w $32
.dc.w $33
.dc.w $33
.dc.w $33
.dc.w $33
.dc.w $33
.dc.w $33
.dc.w $34
.dc.w $34
.dc.w $34
.dc.w $34
.dc.w $34
.dc.w $34
.dc.w $35
.dc.w $35
.dc.w $35
.dc.w $35
.dc.w $35
.dc.w $35
.globl _BarBadj
.text
_BarBadj:
~~BarBadj:
~bar=8
~val=10
link R14,#-10
movem.l R3-R7,-(sp)
~bardot=R7
~barpos=R6
~curdif=R5
~baradr=R4
~barcol=-2
~bardif=-4
~curbar=-6
~i=-8
~newbar=-10
*line 66
move 10(R14),R8
add.l R8,R8
add.l #_BarBLn,R8
move (R8),-10(R14)
*line 67
move 8(R14),R8
add.l R8,R8
add.l #_BarBcur,R8
move (R8),-6(R14)
*line 68
move -10(R14),R0
sub -6(R14),R0
move R0,-4(R14)
*line 70
*line 71
tst -4(R14)
beq L1
*line 72
*line 73
move #1,(sp)
jsr _GLCcurs
*line 74
move 8(R14),R8
add.l R8,R8
add.l #_BarCols,R8
move (R8),-2(R14)
*line 76
*line 76
tst -4(R14)
ble L2
*line 77
*line 78
*line 79
*line 80
move #63,R4
move -6(R14),R0
add #1,R0
sub R0,R4
mulu #85,R4
add -2(R14),R4
add #8192,R4
*line 81
*line 82
move #78,R0
ext.w R0
move.b R0,_lcd_a1
*line 83
*line 84
clr -8(R14)
bra L5
L6:
*line 85
*line 86
move -4(R14),R5
*line 87
move -8(R14),R8
add.l R8,R8
add.l #_BarDots,R8
move (R8),R7
*line 88
*line 89
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 90
clr R0
move R4,R0
and #255,R0
move.b R0,_lcd_a0
*line 91
clr R0
move R4,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 92
*line 93
add #1,R4
*line 94
*line 95
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 96
*line 97
bra L9
L8:
*line 98
move.b R7,_lcd_a0
L9:
*line 98
move R5,R0
sub #1,R5
tst R0
bne L8
L7:L4:
*line 84
add #1,-8(R14)
L5:
*line 84
cmp #3,-8(R14)
blt L6
L3:
*line 99
*line 100
*line 101
bra L10
L2:
*line 102
*line 103
*line 104
*line 105
*line 106
move #63,R4
sub -6(R14),R4
mulu #85,R4
add -2(R14),R4
add #8192,R4
*line 107
*line 108
move #79,R0
ext.w R0
move.b R0,_lcd_a1
*line 109
*line 110
clr -8(R14)
bra L13
L14:
*line 111
*line 112
move -4(R14),R0
neg R0
move R0,R5
*line 113
*line 114
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 115
clr R0
move R4,R0
and #255,R0
move.b R0,_lcd_a0
*line 116
clr R0
move R4,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 117
*line 118
add #1,R4
*line 119
*line 120
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 121
*line 122
bra L17
L16:
*line 123
clr.b _lcd_a0
L17:
*line 123
move R5,R0
sub #1,R5
tst R0
bne L16
L15:L12:
*line 110
add #1,-8(R14)
L13:
*line 110
cmp #3,-8(R14)
blt L14
L11:
*line 124
L10:
*line 127
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 128
clr (sp)
jsr _GLCcurs
*line 130
move 8(R14),R8
add.l R8,R8
add.l #_BarBcur,R8
move -10(R14),(R8)
L1:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _BarBset
.text
_BarBset:
~~BarBset:
~bar=8
~val=10
link R14,#-4
movem.l R3-R7,-(sp)
~bardot=R7
~barpos=R6
~newbar=R5
~baradr=R4
~barcol=-2
~i=-4
*line 149
move 10(R14),R8
add.l R8,R8
add.l #_BarBLn,R8
move (R8),R5
*line 150
move 8(R14),R8
add.l R8,R8
add.l #_BarCols,R8
move (R8),-2(R14)
*line 152
move #1,(sp)
jsr _GLCcurs
*line 156
move #63,R4
sub _BBase,R4
mulu #85,R4
add -2(R14),R4
add #8192,R4
*line 158
move #78,R0
ext.w R0
move.b R0,_lcd_a1
*line 160
clr -4(R14)
bra L21
L22:
*line 161
*line 162
move -4(R14),R8
add.l R8,R8
add.l #_BarDots,R8
move (R8),R7
*line 163
move _BBase,R6
*line 164
*line 165
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 166
clr R0
move R4,R0
and #255,R0
move.b R0,_lcd_a0
*line 167
clr R0
move R4,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 168
*line 169
add #1,R4
*line 170
*line 171
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 172
*line 173
bra L25
L24:
*line 174
move.b R7,_lcd_a0
L25:
*line 174
cmp R6,R5
move sr,R0
add #1,R6
move R0,ccr
bge L24
L23:
*line 175
*line 176
bra L28
L27:
*line 177
clr.b _lcd_a0
L28:
*line 177
cmp _BTop,R6
move sr,R0
add #1,R6
move R0,ccr
blt L27
L26:L20:
*line 160
add #1,-4(R14)
L21:
*line 160
cmp #3,-4(R14)
blt L22
L19:
*line 180
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 181
clr (sp)
jsr _GLCcurs
*line 183
move 8(R14),R8
add.l R8,R8
add.l #_BarBcur,R8
move R5,(R8)
L18:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _BarCadj
.text
_BarCadj:
~~BarCadj:
~bar=8
~val=10
link R14,#-8
movem.l R3-R7,-(sp)
~bardot=R7
~barpos=R6
~newbar=R5
~baradr=R4
~barcol=-2
~bardif=-4
~curbar=-6
~i=-8
*line 202
move 10(R14),R8
add _BOffset,R8
add.l R8,R8
add.l #_BarCLn,R8
move (R8),R5
*line 203
move 8(R14),R8
add.l R8,R8
add.l #_BarCcur,R8
move (R8),-6(R14)
*line 204
move R5,R0
sub -6(R14),R0
move R0,-4(R14)
*line 206
*line 207
tst -4(R14)
beq L29
*line 208
*line 209
move #1,(sp)
jsr _GLCcurs
*line 211
move 8(R14),R8
add.l R8,R8
add.l #_BarCols,R8
move (R8),-2(R14)
*line 215
move #63,R4
sub -6(R14),R4
mulu #85,R4
add -2(R14),R4
add #8192,R4
*line 219
*line 219
cmp -6(R14),R5
ble L30
*line 220
*line 221
move #78,R0
ext.w R0
move.b R0,_lcd_a1
*line 222
*line 223
clr -8(R14)
bra L33
L34:
*line 224
*line 225
move -8(R14),R8
add.l R8,R8
add.l #_BarDots,R8
move (R8),R7
*line 226
move -6(R14),R6
*line 227
*line 228
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 229
clr R0
move R4,R0
and #255,R0
move.b R0,_lcd_a0
*line 230
clr R0
move R4,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 231
*line 232
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 233
*line 234
bra L37
L36:
*line 235
*line 236
cmp _BCenter,R6
move sr,R0
add #1,R6
move R0,ccr
bge L38
*line 236
clr.b _lcd_a0
*line 237
bra L39
L38:
*line 238
move.b R7,_lcd_a0
L39:L37:
*line 238
cmp R5,R6
bne L36
L35:
*line 239
*line 240
add #1,R4
L32:
*line 223
add #1,-8(R14)
L33:
*line 223
cmp #3,-8(R14)
blt L34
L31:
*line 241
*line 242
*line 243
bra L40
L30:
*line 244
*line 245
*line 246
move #79,R0
ext.w R0
move.b R0,_lcd_a1
*line 247
*line 248
clr -8(R14)
bra L43
L44:
*line 249
*line 250
move -8(R14),R8
add.l R8,R8
add.l #_BarDots,R8
move (R8),R7
*line 251
move -6(R14),R6
*line 252
*line 253
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 254
clr R0
move R4,R0
and #255,R0
move.b R0,_lcd_a0
*line 255
clr R0
move R4,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 256
*line 257
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 258
*line 259
bra L47
L46:
*line 260
*line 261
cmp _BCenter,R6
move sr,R0
sub #1,R6
move R0,ccr
ble L48
*line 261
clr.b _lcd_a0
*line 262
bra L49
L48:
*line 263
move.b R7,_lcd_a0
L49:L47:
*line 263
cmp R5,R6
bne L46
L45:
*line 264
*line 265
add #1,R4
L42:
*line 248
add #1,-8(R14)
L43:
*line 248
cmp #3,-8(R14)
blt L44
L41:
*line 266
L40:
*line 269
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 270
clr (sp)
jsr _GLCcurs
*line 272
move 8(R14),R8
add.l R8,R8
add.l #_BarCcur,R8
move R5,(R8)
L29:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _BarCset
.text
_BarCset:
~~BarCset:
~bar=8
~val=10
link R14,#-6
movem.l R2-R7,-(sp)
~bardot=R7
~barpos=R6
~barloc1=R5
~barloc2=R4
~baradr=R3
~barcol=-2
~i=-4
~newbar=-6
*line 291
move #1,(sp)
jsr _GLCcurs
*line 293
move 10(R14),R8
add _BOffset,R8
add.l R8,R8
add.l #_BarCLn,R8
move (R8),-6(R14)
*line 294
move 8(R14),R8
add.l R8,R8
add.l #_BarCols,R8
move (R8),-2(R14)
*line 298
move #63,R3
sub _BBase,R3
mulu #85,R3
add -2(R14),R3
add #8192,R3
*line 300
*line 300
move -6(R14),R0
cmp _BCenter,R0
bge L51
*line 301
*line 302
move -6(R14),R5
*line 303
move _BCenter,R4
*line 304
bra L52
L51:
*line 305
*line 306
*line 307
move _BCenter,R5
*line 308
move -6(R14),R4
L52:
*line 311
move #78,R0
ext.w R0
move.b R0,_lcd_a1
*line 315
clr -4(R14)
bra L55
L56:
*line 316
*line 317
move -4(R14),R8
add.l R8,R8
add.l #_BarDots,R8
move (R8),R7
*line 318
move _BBase,R6
*line 319
*line 320
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 321
clr R0
move R3,R0
and #255,R0
move.b R0,_lcd_a0
*line 322
clr R0
move R3,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 323
*line 324
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 325
*line 326
bra L59
L58:
*line 327
*line 328
clr.b _lcd_a0
*line 329
add #1,R6
L59:
*line 330
cmp R5,R6
blt L58
L57:
*line 331
*line 332
bra L62
L61:
*line 333
*line 334
move.b R7,_lcd_a0
*line 335
add #1,R6
L62:
*line 336
cmp R4,R6
ble L61
L60:
*line 337
*line 338
bra L65
L64:
*line 339
*line 340
clr.b _lcd_a0
*line 341
add #1,R6
L65:
*line 342
cmp _BTop,R6
ble L64
L63:
*line 343
*line 344
add #1,R3
L54:
*line 315
add #1,-4(R14)
L55:
*line 315
cmp #3,-4(R14)
blt L56
L53:
*line 347
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 348
clr (sp)
jsr _GLCcurs
*line 350
move 8(R14),R8
add.l R8,R8
add.l #_BarCcur,R8
move -6(R14),(R8)
L50:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.data
