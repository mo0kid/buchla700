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
.globl _lcdbase
.comm _lcdbase,2
.globl _lcdbit
.comm _lcdbit,2
.globl _lcdcol
.comm _lcdcol,2
.globl _lcdctl1
.comm _lcdctl1,2
.globl _lcdctl2
.comm _lcdctl2,2
.globl _lcdcurs
.comm _lcdcurs,2
.globl _lcdrow
.comm _lcdrow,2
.globl _lcdx
.comm _lcdx,2
.globl _lcdy
.comm _lcdy,2
.globl _glc_is1
.data
_glc_is1:
.dc.b $12
.dc.b $5
.dc.b $7
.dc.b $54
.dc.b $58
.dc.b $3F
.dc.b $55
.dc.b $0
.globl _glc_is2
.data
_glc_is2:
.dc.b $0
.dc.b $0
.dc.b $3F
.dc.b $0
.dc.b $20
.dc.b $3F
.dc.b $0
.dc.b $0
.globl _GLCdisp
.text
_GLCdisp:
~~GLCdisp:
~dsp=8
~crs=10
~blk1=12
~blk2=14
~blk3=16
link R14,#0
movem.l R6-R7,-(sp)
~val=R7
*line 93
*line 94
move 16(R14),R7
and #3,R7
asl #6,R7
move 14(R14),R0
and #3,R0
asl #4,R0
or R0,R7
move 12(R14),R0
and #3,R0
asl #2,R0
or R0,R7
move 10(R14),R0
and #3,R0
or R0,R7
*line 96
move #88,R0
ext.w R0
move 8(R14),R1
and #1,R1
or R1,R0
move R0,_lcdctl1
*line 97
move R7,_lcdctl2
*line 99
clr R0
move _lcdctl1,R0
move.b R0,_lcd_a1
*line 100
clr R0
move _lcdctl2,R0
move.b R0,_lcd_a0
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _GLCcurs
.text
_GLCcurs:
~~GLCcurs:
~crs=8
link R14,#-4
*line 113
move 8(R14),R0
and #3,R0
clr R1
move _lcdctl2,R1
and #-4,R1
or R1,R0
move R0,_lcdctl2
*line 115
clr R0
move _lcdctl1,R0
move.b R0,_lcd_a1
*line 116
clr R0
move _lcdctl2,R0
move.b R0,_lcd_a0
L2:unlk R14
rts
.globl _GLCinit
.text
_GLCinit:
~~GLCinit:
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~i=R7
~ic=R6
~gp=R13
*line 135
move #8192,_lcdbase
*line 136
clr _lcdx
*line 137
clr _lcdy
*line 138
move #1,_lcdbit
*line 140
clr _lcdrow
*line 141
clr _lcdcol
*line 143
move #88,R0
ext.w R0
move R0,_lcdctl1
*line 144
clr _lcdctl2
*line 146
move #64,R0
ext.w R0
move.b R0,_lcd_a1
*line 147
move.l #_glc_is1,R13
*line 149
clr R7
bra L6
L7:
*line 150
move.b (R13)+,_lcd_a0
L5:
*line 149
add #1,R7
L6:
*line 149
cmp #8,R7
blt L7
L4:
*line 152
move #68,R0
ext.w R0
move.b R0,_lcd_a1
*line 153
move.l #_glc_is2,R13
*line 155
clr R7
bra L10
L11:
*line 156
move.b (R13)+,_lcd_a0
L9:
*line 155
add #1,R7
L10:
*line 155
cmp #8,R7
blt L11
L8:
*line 158
move #90,R0
ext.w R0
move.b R0,_lcd_a1
*line 159
clr.b _lcd_a0
*line 161
move #91,R0
ext.w R0
move.b R0,_lcd_a1
*line 162
move.b #8,_lcd_a0
*line 164
clr (sp)
move #1,-(sp)
move #1,-(sp)
move #2,-(sp)
clr -(sp)
jsr _GLCdisp
addq.l #8,sp
*line 168
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 169
clr.b _lcd_a0
*line 170
clr.b _lcd_a0
*line 172
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 174
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 176
clr.l R6
bra L14
L15:
*line 177
clr.b _lcd_a0
L13:
*line 176
add.l #$1,R6
L14:
*line 176
cmp.l #$10000,R6
blt L15
L12:
*line 179
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 180
clr.b _lcd_a0
*line 181
clr.b _lcd_a0
*line 183
move #93,R0
ext.w R0
move.b R0,_lcd_a1
*line 184
move.b #4,_lcd_a0
*line 185
move.b #6,_lcd_a0
*line 189
clr (sp)
move #1,-(sp)
move #1,-(sp)
move #2,-(sp)
move #1,-(sp)
jsr _GLCdisp
addq.l #8,sp
L3:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _GLCcrc
.text
_GLCcrc:
~~GLCcrc:
~row=8
~col=10
link R14,#-6
~curad=-2
*line 209
clr R0
move 8(R14),R0
mulu #85,R0
add 10(R14),R0
move R0,-2(R14)
*line 211
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 212
clr R0
move -2(R14),R0
and #255,R0
move.b R0,_lcd_a0
*line 213
clr R0
move -2(R14),R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 215
move 8(R14),_lcdrow
*line 216
move 10(R14),_lcdcol
*line 218
clr R0
move -2(R14),R0
bra L16
L16:unlk R14
rts
.globl _GLCcxy
.text
_GLCcxy:
~~GLCcxy:
~x=R7
~y=R6
link R14,#0
movem.l R3-R7,-(sp)
~curad=R5
~xby6=R4
*line 242
move 8(R14),R7
*line 242
move 10(R14),R6
*line 242
move R7,R4
clr.l R0
move R4,R0
divu #6,R0
swap R0
move R0,R4
*line 243
move #63,R5
sub R6,R5
mulu #85,R5
clr.l R0
move R7,R0
divu #6,R0
add R0,R5
clr R0
move R4,R0
lsr #3,R0
add R0,R5
add _lcdbase,R5
*line 244
move R5,_lcdcurs
*line 248
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 249
clr R0
move R5,R0
and #255,R0
move.b R0,_lcd_a0
*line 250
clr R0
move R5,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 254
move R7,_lcdx
*line 255
move R6,_lcdy
*line 259
move #1,R0
clr R1
move R4,R1
and #7,R1
asl R1,R0
move R0,_lcdbit
*line 261
clr R0
move _lcdbit,R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R4-R7
unlk R14
rts
.globl _GLCwrts
.text
_GLCwrts:
~~GLCwrts:
~s=R13
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 280
move.l 8(R14),R13
*line 280
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 282
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 284
bra L21
L20:
*line 285
*line 286
move.b (R13)+,_lcd_a0
*line 287
add #1,_lcdcol
L21:
*line 288
tst.b (R13)
bne L20
L19:L18:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _GLCtext
.text
_GLCtext:
~~GLCtext:
~row=R7
~col=R6
~s=R13
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~curad=R5
*line 310
move 8(R14),R7
*line 310
move 10(R14),R6
*line 310
move.l 12(R14),R13
*line 310
move R6,R5
clr R0
move R7,R0
mulu #85,R0
add R0,R5
*line 312
move #70,R0
ext.w R0
move.b R0,_lcd_a1
*line 313
clr R0
move R5,R0
and #255,R0
move.b R0,_lcd_a0
*line 314
clr R0
move R5,R0
lsr #8,R0
and #255,R0
move.b R0,_lcd_a0
*line 316
move R7,_lcdrow
*line 317
move R6,_lcdcol
*line 319
move #76,R0
ext.w R0
move.b R0,_lcd_a1
*line 321
move #66,R0
ext.w R0
move.b R0,_lcd_a1
*line 323
bra L25
L24:
*line 324
*line 325
move.b (R13)+,_lcd_a0
*line 326
add #1,_lcdcol
L25:
*line 327
tst.b (R13)
bne L24
L23:L22:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.data
