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
.globl _consl
.globl _cursl
.globl _nxtsl
.globl _prvsl
.globl _saddr
.globl _scrl
.globl _vi_sadr
.globl _vi_scrl
.globl _ctrsw
.globl _ndisp
.globl _sbase
.globl _sd
.globl _soffset
.globl _gdstbc
.globl _gdstbn
.globl _gdstbp
.globl _nbmoff
.data
_nbmoff:
.dc.w $3
.globl _wrdoff
.data
_wrdoff:
.dc.w $3
.globl _nbmasks
.data
_nbmasks:
.dc.w $F
.dc.w $F0
.dc.w $F00
.dc.w $F000
.globl _sc_adv
.text
_sc_adv:
~~sc_adv:
link R14,#-6
movem.l R2-R7/R11-R13,-(sp)
~masksl=R7
~maskpx=R6
~i=R5
~sword=R4
~tl=R3
~optr=R13
~pptr=R12
~fsl=R11
~qptr=-4
~pscrl=-6
*line 101
*line 102
clr R0
move 10+_v_regs,R0
and #384,R0
beq L2
*line 102
clr (sp)
jsr _vbank
*line 103
L2:
*line 104
move.l #$80,R3
*line 108
jsr _ucslice
*line 114
*line 114
cmp #2,_ndisp
bne L3
cmp #1,_sd
bne L10000
clr R0
bra L10002
L10000:move #3,R0
L10002:cmp _soffset,R0
bne L3
*line 115
*line 116
*line 116
cmp #1,_sd
bne L4
*line 117
*line 118
move.l _prvsl,R11
*line 119
move _wrdoff,R0
asl #1,R0
ext.l R0
move.l R0,R13
add.l _saddr,R13
*line 120
bra L5
L4:
*line 121
*line 122
*line 123
move.l _nxtsl,R11
*line 124
move.l R3,R0
asl.l #1,R0
move.l R0,R13
add.l _saddr,R13
L5:
*line 125
*line 126
*line 127
*line 127
cmp #28544,_sbase
ble L6
*line 128
*line 129
*line 130
*line 131
move.l _saddr,R12
cmp #1,_sd
bne L10003
move.l #$6f7e,R0
bra L10005
L10003:move.l #$6f81,R0
L10005:asl.l #1,R0
sub.l R0,R12
*line 132
*line 133
*line 133
cmp #28672,_sbase
bge L7
*line 134
*line 135
*line 136
*line 137
move #224,R5
bra L10
L11:
*line 138
*line 139
move (R11)+,R4
*line 140
move R4,(R13)
*line 141
move R4,(R12)
*line 142
move.l R3,R0
asl.l #1,R0
add.l R0,R13
*line 143
move.l R3,R0
asl.l #1,R0
add.l R0,R12
L9:L10:
*line 137
move R5,R0
sub #1,R5
tst R0
bne L11
L8:
*line 144
*line 145
bra L12
L7:
*line 146
*line 147
*line 148
*line 149
*line 150
move #224,R5
bra L15
L16:
*line 151
*line 152
move (R11)+,(R12)
*line 153
move.l R3,R0
asl.l #1,R0
add.l R0,R12
L14:L15:
*line 150
move R5,R0
sub #1,R5
tst R0
bne L16
L13:
*line 154
L12:
*line 155
*line 156
*line 157
bra L17
L6:
*line 158
*line 159
*line 160
*line 161
*line 162
move #224,R5
bra L20
L21:
*line 163
*line 164
move (R11)+,(R13)
*line 165
move.l R3,R0
asl.l #1,R0
add.l R0,R13
L19:L20:
*line 162
move R5,R0
sub #1,R5
tst R0
bne L21
L18:
*line 166
L17:
*line 167
*line 168
*line 169
move.l _nxtsl,R13
*line 170
move.l _cursl,R12
*line 171
move.l _prvsl,-4(R14)
*line 172
move.l _consl,R11
*line 173
*line 174
move #224,R5
bra L24
L25:
*line 175
*line 176
move (R11)+,R4
*line 177
move R4,(R13)+
*line 178
move R4,(R12)+
*line 179
move.l -4(R14),R8
move R4,(R8)
add.l #2,-4(R14)
L23:L24:
*line 174
move R5,R0
sub #1,R5
tst R0
bne L25
L22:
*line 180
*line 181
*line 182
*line 183
*line 184
*line 185
*line 186
L3:
*line 187
*line 187
tst _sd
bne L26
*line 188
*line 189
*line 189
add #1,_soffset
move _soffset,R0
cmp #3,R0
ble L27
*line 190
*line 191
clr _soffset
*line 192
add.l #2,_saddr
*line 193
*line 194
*line 194
add #1,_sbase
move _sbase,R0
cmp #28672,R0
ble L28
*line 195
*line 196
move.l #_v_score,_saddr
*line 197
clr _sbase
*line 198
L28:
*line 199
*line 200
L27:bra L29
L26:
*line 201
*line 202
*line 203
*line 203
sub #1,_soffset
bge L30
*line 204
*line 205
move #3,_soffset
*line 206
sub.l #2,_saddr
*line 207
*line 208
*line 208
sub #1,_sbase
bge L31
*line 209
*line 210
move.l #57344+_v_score,_saddr
*line 211
move #28672,_sbase
*line 212
L31:
*line 213
L30:L29:
*line 217
move _scrl,-6(R14)
*line 221
move _soffset,R8
add.l R8,R8
add.l #_nbmasks,R8
move (R8),R6
*line 222
move R6,R0
not R0
move R0,R7
*line 224
move.l #_gdstbp,(sp)
move R7,-(sp)
move R6,-(sp)
move.l _prvsl,-(sp)
jsr _uslice
addq.l #8,sp
*line 226
move.l #_gdstbn,(sp)
move R7,-(sp)
move R6,-(sp)
move.l _nxtsl,-(sp)
jsr _uslice
addq.l #8,sp
*line 228
move _soffset,R0
asr #1,R0
move #1,R1
eor R1,R0
or #-32768,R0
move R0,_scrl
*line 232
*line 232
cmp #2,_ndisp
bne L32
clr R0
move _scrl,R0
cmp -6(R14),R0
beq L32
*line 233
*line 234
move.l _saddr,R0
asr.l #1,R0
move R0,R4
*line 235
*line 236
move #1,(sp)
jsr _setipl
*line 237
*line 238
move _scrl,_vi_scrl
*line 239
move R4,_vi_sadr
*line 240
*line 241
clr (sp)
jsr _setipl
*line 242
*line 243
L32:
*line 244
clr _ctrsw
L1:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _scupd
.text
_scupd:
~~scupd:
link R14,#-2
movem.l R2-R7/R11-R13,-(sp)
~masksl=R7
~maskpx=R6
~i=R5
~sword=R4
~tl=R3
~optr=R13
~qptr=R12
~fsl=R11
~soff=-2
*line 275
*line 276
clr R0
move 10+_v_regs,R0
and #384,R0
beq L34
*line 276
clr (sp)
jsr _vbank
*line 277
L34:
*line 278
move _nbmoff,R0
add _soffset,R0
and #3,R0
move R0,-2(R14)
*line 279
move -2(R14),R0
add #2,R0
and #3,R0
move R0,R8
add.l R8,R8
add.l #_nbmasks,R8
move (R8),R6
*line 280
move R6,R0
not R0
move R0,R7
*line 281
move.l #$80,R3
*line 285
*line 285
move.l #_gdstbc,(sp)
move R7,-(sp)
move R6,-(sp)
move.l _cursl,-(sp)
jsr _cslice
addq.l #8,sp
tst R0
beq L35
cmp #2,_ndisp
bne L35
*line 286
*line 287
*line 288
*line 289
move.l _cursl,R11
*line 290
cmp #1,-2(R14)
ble L10006
move.l #$40,R0
bra L10008
L10006:move.l #$3f,R0
L10008:asl.l #1,R0
move.l R0,R13
add.l _saddr,R13
*line 291
move.l _consl,R12
*line 292
*line 293
move #224,R5
bra L38
L39:
*line 294
*line 295
*line 296
move R6,R4
and (R11),R4
beq L40
*line 296
clr R0
move R4,R0
move R7,R1
and (R13),R1
or R1,R0
move R0,(R13)
*line 297
L40:
*line 298
move (R12)+,(R11)+
*line 299
move.l R3,R0
asl.l #1,R0
add.l R0,R13
L37:L38:
*line 293
move R5,R0
sub #1,R5
tst R0
bne L39
L36:
*line 300
*line 301
*line 302
*line 303
*line 304
L35:
*line 305
clr _ctrsw
L33:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.data
