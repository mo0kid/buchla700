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
.globl _foot1
.globl _foot2
.globl _pulse1
.globl _pulse2
.globl _end
.globl _etext
.globl _edata
.globl _clkrun
.globl _clksrc
.globl _initcfg
.globl _ndisp
.globl _verbose
.globl _lcdontm
.globl _lcdtime
.globl _fp_resv
.globl _script0
.globl _VerDate
.globl _ptefifo
.globl _m7verms
.comm _m7verms,32
.globl _clkdiv
.comm _clkdiv,2
.globl _dopls1
.text
_dopls1:
~~dopls1:
link R14,#-4
*line 61
move #4480,(sp)
move.l #_ptefifo,-(sp)
jsr _putwq
addq.l #4,sp
*line 63
*line 64
tst _clkrun
beq L1
*line 65
*line 66
*line 66
cmp #3,_clksrc
bne L2
*line 67
*line 68
add.l #$2,_fc_val
*line 69
*line 70
*line 71
move.l _fc_val,R0
cmp.l #$ffffff,R0
ble L3
*line 71
move.l #$ffffff,_fc_val
*line 72
L3:bra L4
L2:
*line 73
*line 73
cmp #4,_clksrc
bne L5
*line 74
*line 75
add.l #$1,_fc_val
*line 76
*line 77
*line 78
move.l _fc_val,R0
cmp.l #$ffffff,R0
ble L6
*line 78
move.l #$ffffff,_fc_val
*line 79
L6:bra L7
L5:
*line 80
*line 80
cmp #5,_clksrc
bne L8
*line 81
*line 82
*line 82
move _clkdiv,R0
add #1,_clkdiv
tst R0
beq L9
*line 83
*line 84
clr _clkdiv
*line 85
add.l #$1,_fc_val
*line 86
*line 87
*line 88
move.l _fc_val,R0
cmp.l #$ffffff,R0
ble L10
*line 88
move.l #$ffffff,_fc_val
L10:
*line 89
L9:
*line 90
L8:L7:L4:L1:unlk R14
rts
.globl _dopls2
.text
_dopls2:
~~dopls2:
link R14,#-4
*line 101
move #4481,(sp)
move.l #_ptefifo,-(sp)
jsr _putwq
addq.l #4,sp
L11:unlk R14
rts
.globl _mpcupd
.text
_mpcupd:
~~mpcupd:
link R14,#-4
*line 115
move _ndisp,R0
bra L14
*line 116
L15:
*line 117
*line 118
bra L13
*line 119
*line 120
L16:
*line 121
*line 122
bra L13
*line 123
*line 124
L17:
*line 125
*line 126
*line 127
jsr _sdwins
bra L13
*line 128
*line 129
L18:
*line 130
*line 131
bra L13
*line 132
*line 133
L19:
*line 134
*line 135
*line 136
jsr _setinst
*line 137
jsr _allwins
bra L13
*line 138
*line 139
L20:
*line 140
*line 141
bra L13
*line 142
*line 143
L21:
*line 144
*line 145
*line 146
jsr _newws
*line 147
jsr _wwins
bra L13
*line 148
*line 149
L22:
*line 150
*line 151
bra L13
*line 152
*line 153
L23:
*line 154
*line 155
*line 156
jsr _twins
bra L13
*line 157
*line 158
L24:
*line 159
*line 160
bra L13
*line 161
*line 162
L25:
*line 163
*line 164
*line 165
jsr _awins
bra L13
*line 166
bra L13
L14:cmp #10,R0
bhi L13
asl #2,R0
move R0,R8
add.l #L26,R8
move.l (R8),R8
jmp (R8)
.data
L26:.dc.l L15
.dc.l L16
.dc.l L17
.dc.l L18
.dc.l L19
.dc.l L20
.dc.l L21
.dc.l L22
.dc.l L23
.dc.l L24
.dc.l L25
.text
L13:L12:unlk R14
rts
.globl _main
.text
_main:
~~main:
link R14,#-4
*line 181
move #2,(sp)
jsr _setipl
*line 185
move.l #_fpuint,(sp)
move #26,-(sp)
move #5,-(sp)
jsr _trap13
addq.l #4,sp
*line 187
clr _initcfg
*line 188
move #-32000,_fp_resv
*line 190
jsr _fpuclr
*line 192
jsr _tsetup
*line 193
jsr _setsio
*line 195
move.l #_clk_ped,_foot1
*line 196
move.l #_pch_ped,_foot2
*line 198
move.l #_dopls1,_pulse1
*line 199
move.l #_dopls2,_pulse2
*line 201
move.l #$2ee00,_lcdontm
*line 202
jsr _lcd_on
*line 204
move.l #2+_VerDate,(sp)
move.l #_m7verms,-(sp)
jsr _strcpy
addq.l #4,sp
*line 206
jsr _im700
*line 207
jsr _settune
*line 209
move #-1,_ndisp
*line 210
clr _verbose
*line 211
move.l #_script0,(sp)
jsr _rscript
*line 212
clr.l (sp)
jsr _sc_goto
*line 214
jsr _MouseWK
bra L28
L29:
*line 221
*line 222
*line 223
jsr _msl
L28:
*line 225
*line 226
*line 230
*line 231
*line 232
jsr _m7menu
*line 233
jsr _msl
*line 240
move _ndisp,R0
bra L31
*line 241
L32:
*line 242
*line 243
*line 244
jsr _ldfield
*line 245
jsr _libdsp
bra L30
*line 246
*line 247
L33:
*line 248
*line 249
*line 250
jsr _ptfield
*line 251
jsr _ptdisp
bra L30
*line 252
*line 253
L34:
*line 254
*line 255
*line 256
jsr _scfield
*line 257
jsr _sdsetup
bra L30
*line 258
*line 259
L35:
*line 260
*line 261
*line 262
jsr _sqfield
*line 263
jsr _sqdisp
bra L30
*line 264
*line 265
*line 266
L36:
*line 267
*line 268
*line 269
jsr _idfield
*line 270
jsr _instdsp
bra L30
*line 271
*line 272
L37:
*line 273
*line 274
*line 275
jsr _wdfield
*line 276
jsr _wsdsp
bra L30
*line 277
*line 278
L38:
*line 279
*line 280
*line 281
jsr _tdfield
*line 282
jsr _tundsp
bra L30
*line 283
*line 284
L39:
*line 285
*line 286
*line 287
jsr _adfield
*line 288
jsr _asgdsp
bra L30
*line 289
*line 290
L40:
*line 291
*line 292
*line 293
jsr _scopeon
bra L30
*line 294
*line 295
L41:
*line 296
*line 297
*line 301
*line 302
*line 303
move #-1,_ndisp
bra L28
*line 304
bra L30
L31:cmp #11,R0
bhi L41
asl #2,R0
move R0,R8
add.l #L42,R8
move.l (R8),R8
jmp (R8)
.data
L42:.dc.l L32
.dc.l L33
.dc.l L34
.dc.l L35
.dc.l L36
.dc.l L41
.dc.l L37
.dc.l L41
.dc.l L38
.dc.l L41
.dc.l L39
.dc.l L40
.text
L30:bra L29
L27:unlk R14
rts
.data
