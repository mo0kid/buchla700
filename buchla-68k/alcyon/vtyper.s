.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
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
.globl _cxrate
.globl _cyrate
.globl _stccol
.globl _stcrow
.globl _vtccol
.globl _vtcrow
.globl _vtdecol
.globl _vtxval
.globl _vtyval
.globl _vtdeptr
.globl _vtdechr
.globl _bfs
.globl _vtwrow
.globl _vtwcol
.globl _vt_adv
.globl _vt_bsp
.globl _vt_cdn
.globl _vt_cup
.globl _vt_stop
.globl _vt_dsp
.globl _vtobj
.globl _vtfgval
.globl _vtbgval
.globl _vtlin1
.data
_vtlin1:
.dc.b $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$20,$20,$7C,$20,$0
.even
.globl _vtlin2
.data
_vtlin2:
.dc.b $61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$20,$2D,$2A,$2D,$0
.even
.globl _vtlin3
.data
_vtlin3:
.dc.b $20,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$2B,$2D,$2F,$23,$28,$29,$2E,$2C,$3A,$3B,$21,$3F,$26,$3C,$3E,$20,$20,$7C,$20,$0
.even
.globl _vtsetup
.text
_vtsetup:
~~vtsetup:
~obj=8
~dsp=12
~col=16
~ptr=18
~tr=22
~tc=24
~adv=26
~bsp=30
~cup=34
~cdn=38
~stop=42
~fg=46
~bg=48
link R14,#-4
*line 89
move.l 8(R14),_vtobj
*line 90
move.l 26(R14),_vt_adv
*line 91
move.l 30(R14),_vt_bsp
*line 92
move.l 34(R14),_vt_cup
*line 93
move.l 38(R14),_vt_cdn
*line 94
move.l 12(R14),_vt_dsp
*line 95
move.l 42(R14),_vt_stop
*line 96
move 22(R14),_vtwrow
*line 97
move 24(R14),_vtwcol
*line 98
move 16(R14),_vtdecol
*line 99
move.l 18(R14),_vtdeptr
*line 100
move 46(R14),(sp)
jsr _exp_c
move R0,_vtfgval
*line 101
move 48(R14),(sp)
jsr _exp_c
move R0,_vtbgval
*line 102
move #14,(sp)
move #2,-(sp)
jsr _SetPri
addq.l #2,sp
*line 103
move 24(R14),R0
asl #3,R0
move R0,_vtxval
*line 104
move 22(R14),R0
ext.l R0
divs #14,R0
move R0,_vtyval
*line 105
move 24(R14),(sp)
move 22(R14),-(sp)
jsr _ttcpos
addq.l #2,sp
L4:unlk R14
rts
.globl _vtcxupd
.text
_vtcxupd:
~~vtcxupd:
link R14,#-4
*line 124
move _cxrate,R0
add R0,_vtxval
move _vtxval,R0
asr #3,R0
move R0,_vtccol
*line 126
*line 127
move _vtwcol,R0
add #29,R0
cmp _vtccol,R0
bge L6
*line 127
move _vtwcol,R0
add #29,R0
move R0,_vtccol
asl #3,R0
move R0,_vtxval
bra L7
L6:
*line 128
*line 129
move _vtccol,R0
cmp _vtwcol,R0
bge L8
*line 129
move _vtwcol,R0
move R0,_vtccol
asl #3,R0
move R0,_vtxval
L8:L7:L5:unlk R14
rts
.globl _vtcyupd
.text
_vtcyupd:
~~vtcyupd:
link R14,#-4
*line 145
move _cyrate,R0
add R0,_vtyval
move _vtyval,R0
ext.l R0
divs #14,R0
move R0,_vtcrow
*line 147
*line 148
move _vtwrow,R0
add #2,R0
cmp _vtcrow,R0
bge L10
*line 148
move _vtwrow,R0
add #2,R0
move R0,_vtcrow
muls #14,R0
move R0,_vtyval
bra L11
L10:
*line 149
*line 150
move _vtcrow,R0
cmp _vtwrow,R0
bge L12
*line 150
move _vtwrow,R0
move R0,_vtcrow
muls #14,R0
move R0,_vtyval
L12:L11:L9:unlk R14
rts
.globl _vtdisp
.text
_vtdisp:
~~vtdisp:
~obj=8
~fg=12
~bg=14
~row=16
~col=18
~buf=20
link R14,#-4
*line 172
*line 173
clr R0
move 10+_v_regs,R0
and #384,R0
beq L14
*line 173
clr (sp)
jsr _vbank
*line 174
L14:
*line 175
move #14,(sp)
move.l 20(R14),-(sp)
move 18(R14),-(sp)
move 16(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move #64,-(sp)
move.l 8(R14),-(sp)
jsr _vcputsv
adda.l #18,sp
L13:unlk R14
rts
.globl _vtyper
.text
_vtyper:
~~vtyper:
link R14,#-4
*line 194
*line 194
move _vtwcol,R0
add #26,R0
cmp _vtccol,R0
ble L16
*line 195
*line 196
*line 197
*line 198
*line 199
move _vtcrow,R0
cmp _vtwrow,R0
bne L17
*line 199
move _vtccol,R8
sub _vtwcol,R8
add.l #_vtlin1,R8
move.b (R8),_vtdechr
bra L18
L17:
*line 200
*line 201
move _vtwrow,R0
add #1,R0
cmp _vtcrow,R0
bne L19
*line 201
move _vtccol,R8
sub _vtwcol,R8
add.l #_vtlin2,R8
move.b (R8),_vtdechr
bra L20
L19:
*line 202
*line 203
move _vtwrow,R0
add #2,R0
cmp _vtcrow,R0
bne L21
*line 203
move _vtccol,R8
sub _vtwcol,R8
add.l #_vtlin3,R8
move.b (R8),_vtdechr
bra L22
L21:
*line 204
*line 205
*line 206
move.b #42,_vtdechr
*line 207
clr R0
bra L15
L22:L20:L18:
*line 208
*line 209
*line 210
move _stccol,R8
sub _vtdecol,R8
add.l _vtdeptr,R8
move.b _vtdechr,(R8)
*line 211
*line 212
*line 213
*line 214
move.b _vtdechr,_bfs
*line 215
clr.b 1+_bfs
*line 216
*line 217
move.l #_bfs,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move _vtbgval,-(sp)
move _vtfgval,-(sp)
move.l _vtobj,-(sp)
move.l _vt_dsp,R8
jsr (R8)
adda.l #16,sp
*line 218
*line 219
move.l _vt_adv,R8
jsr (R8)
*line 220
move #1,R0
bra L15
*line 221
*line 222
*line 223
*line 224
bra L23
L16:
*line 225
*line 226
move _vtwrow,R0
add #1,R0
cmp _vtcrow,R0
bne L24
move _vtwcol,R0
add #28,R0
cmp _vtccol,R0
bne L24
*line 227
*line 228
move #14,(sp)
jsr _objclr
*line 229
move.l _vt_stop,R8
jsr (R8)
*line 230
clr R0
bra L15
*line 231
bra L25
L24:
*line 232
*line 233
move _vtcrow,R0
cmp _vtwrow,R0
bne L26
move _vtwcol,R0
add #28,R0
cmp _vtccol,R0
bne L26
*line 234
*line 235
move.l _vt_cup,R8
jsr (R8)
*line 236
clr R0
bra L15
*line 237
bra L27
L26:
*line 238
*line 239
move _vtwrow,R0
add #2,R0
cmp _vtcrow,R0
bne L28
move _vtwcol,R0
add #28,R0
cmp _vtccol,R0
bne L28
*line 240
*line 241
move.l _vt_cdn,R8
jsr (R8)
*line 242
clr R0
bra L15
*line 243
bra L29
L28:
*line 244
*line 245
move _vtwrow,R0
add #1,R0
cmp _vtcrow,R0
bne L30
move _vtwcol,R0
add #27,R0
cmp _vtccol,R0
bne L30
*line 246
*line 247
move.l _vt_bsp,R8
jsr (R8)
*line 248
clr R0
bra L15
*line 249
bra L31
L30:
*line 250
*line 251
move _vtwrow,R0
add #1,R0
cmp _vtcrow,R0
bne L32
move _vtwcol,R0
add #29,R0
cmp _vtccol,R0
bne L32
*line 252
*line 253
move.l _vt_adv,R8
jsr (R8)
*line 254
clr R0
bra L15
*line 255
L32:L31:L29:L27:L25:L23:L15:unlk R14
rts
.data
