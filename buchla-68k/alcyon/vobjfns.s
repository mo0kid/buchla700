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
.globl _v_obtab
.globl _v_curob
.globl _v_nobj
.globl _v_obpri
.globl _wsize
.comm _wsize,2
.globl _vi_dis
.comm _vi_dis,2
.globl _vi_ctl
.comm _vi_ctl,2
.globl _SelObj
.text
_SelObj:
~~SelObj:
~obj=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~op=R13
~newbank=R7
*line 83
move 8(R14),R0
muls #18,R0
move.l R0,R13
add.l #_v_obtab,R13
*line 85
move.b 13(R13),R7
ext.w R7
and #1,R7
lsl #8,R7
move.b 13(R13),R0
ext.w R0
and #2,R0
asl #6,R0
or R0,R7
*line 87
move 8(R14),_v_nobj
*line 88
move.l R13,_v_curob
*line 89
move.b 12(R13),R0
ext.w R0
move R0,_v_obpri
*line 91
*line 92
clr R0
move 10+_v_regs,R0
and #384,R0
cmp R0,R7
beq L2
*line 92
move.b 13(R13),R0
ext.w R0
move R0,(sp) 
and #3,(sp)
jsr _vbank
L2:L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _SetPri
.text
_SetPri:
~~SetPri:
~obj=R7
~pri=R6
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~op=R13
*line 113
move 8(R14),R7
*line 113
move 10(R14),R6
*line 113
*line 114
clr R0
move 10+_v_regs,R0
and #384,R0
beq L4
*line 114
clr (sp)
jsr _vbank
*line 115
L4:
*line 116
move R7,R0
muls #18,R0
move.l R0,R13
add.l #_v_obtab,R13
*line 117
move.b R6,12(R13)
*line 119
clr R0
move 14(R13),R0
or #16,R0
move R6,R1
asl #3,R1
ext.l R1
add.l #_v_odtab,R1
move.l R1,R9
move R0,(R9)
*line 120
move R6,R0
asl #3,R0
ext.l R0
add.l #_v_odtab,R0
move.l R0,R8
move 16(R13),2(R8)
*line 121
move.l 8(R13),R0
asr.l #1,R0
move R6,R1
asl #3,R1
ext.l R1
add.l #_v_odtab,R1
move.l R1,R9
move R0,4(R9)
*line 123
move (R13),(sp)
move 6(R13),-(sp)
move R6,-(sp)
jsr _objon
addq.l #4,sp
*line 125
*line 126
tst _vi_dis
bne L3
*line 127
*line 128
move #7,(sp)
jsr _setipl
*line 130
move #1,R0
move R6,R1
asl R1,R0
or R0,_vi_ctl
*line 132
*line 133
move.l $64,R0
cmp.l #_VIint,R0
beq L5
*line 133
move.l #_VIint,(sp)
move #25,-(sp)
move #5,-(sp)
jsr _trap13
addq.l #4,sp
*line 134
L5:
*line 135
clr (sp)
jsr _setipl
L3:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _SetObj
.text
_SetObj:
~~SetObj:
~obj=8
~type=10
~bank=12
~base=14
~xpix=18
~ypix=20
~x0=22
~y0=24
~flags=26
~pri=28
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~op=R13
*line 154
*line 155
clr R0
move 10+_v_regs,R0
and #384,R0
beq L7
*line 155
clr (sp)
jsr _vbank
*line 156
L7:
*line 157
move 8(R14),R0
muls #18,R0
move.l R0,R13
add.l #_v_obtab,R13
*line 159
move.l R13,_v_curob
*line 160
move 8(R14),_v_nobj
*line 161
move 28(R14),_v_obpri
*line 163
move 20(R14),(R13)
*line 164
move 18(R14),2(R13)
*line 165
move 22(R14),4(R13)
*line 166
move 24(R14),6(R13)
*line 167
move.l 14(R14),8(R13)
*line 168
move 28(R14),R0
move.b R0,12(R13)
*line 169
move 12(R14),R0
and #3,R0
move.b R0,13(R13)
*line 173
*line 173
tst 10(R14)
beq L8
*line 174
*line 175
move 26(R14),R0
and #-1537,R0
or #-17408,R0
move R0,14(R13)
*line 176
*line 177
clr R0
move 14(R13),R0
and #1536,R0
bra L10
*line 178
L11:
*line 179
*line 180
*line 181
move 18(R14),R0
ext.l R0
divs #128,R0
move R0,_wsize
bra L9
*line 182
*line 183
L12:
*line 184
*line 185
*line 186
move 18(R14),R0
ext.l R0
divs #48,R0
move R0,_wsize
bra L9
*line 187
*line 188
L13:
*line 189
*line 190
*line 191
move 18(R14),R0
ext.l R0
divs #64,R0
move R0,_wsize
bra L9
*line 192
*line 193
L14:
*line 194
*line 195
*line 196
move 18(R14),R0
ext.l R0
divs #96,R0
move R0,_wsize
bra L9
*line 197
bra L9
L10:tst R0
beq L11
cmp #512,R0
beq L12
cmp #1024,R0
beq L13
cmp #1536,R0
beq L14
bra L9
L9:
*line 198
*line 199
*line 200
*line 201
btst #6,15(R13)
beq L15
*line 201
move _wsize,R0
asl #1,R0
add _wsize,R0
move R0,_wsize
*line 202
*line 203
*line 204
L15:bra L16
L8:
*line 205
*line 206
*line 207
move 26(R14),R0
and #3639,R0
move 12(R14),R1
and #3,R1
asl #6,R1
or R1,R0
move R0,14(R13)
*line 208
*line 209
clr R0
move 14(R13),R0
and #1536,R0
bra L18
*line 210
L19:
*line 211
L20:
*line 212
*line 213
*line 214
clr _wsize
bra L17
*line 215
*line 216
L21:
*line 217
*line 218
*line 219
move 18(R14),R0
ext.l R0
divs #32,R0
move R0,_wsize
bra L17
*line 220
*line 221
L22:
*line 222
*line 223
*line 224
move 18(R14),R0
ext.l R0
divs #16,R0
move R0,_wsize
bra L17
*line 225
bra L17
L18:tst R0
beq L19
cmp #512,R0
beq L20
cmp #1024,R0
beq L21
cmp #1536,R0
beq L22
bra L17
L17:
*line 226
L16:
*line 229
move 22(R14),R0
asr #1,R0
and #1023,R0
move _wsize,R1
move #10,R2
asl R2,R1
and #-1024,R1
or R1,R0
move R0,16(R13)
*line 231
*line 232
tst 28(R14)
blt L6
*line 233
*line 234
move 28(R14),(sp)
move 8(R14),-(sp)
jsr _SetPri
addq.l #2,sp
L6:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _CpyObj
.text
_CpyObj:
~~CpyObj:
~from=R13
~to=R12
~w=R7
~h=R6
~sw=R5
link R14,#0
movem.l R2-R7/R11-R13,-(sp)
~tp=R11
~i=R4
~j=R3
*line 257
move.l 8(R14),R13
*line 257
move.l 12(R14),R12
*line 257
move 16(R14),R7
*line 257
move 18(R14),R6
*line 257
move 20(R14),R5
*line 257
move R6,R4
bra L26
L27:
*line 258
*line 259
move.l R12,R11
*line 260
*line 261
move R7,R3
bra L30
L31:
*line 262
move (R13)+,(R11)+
L29:L30:
*line 261
clr R0
move R3,R0
sub #1,R3
tst R0
bne L31
L28:
*line 262
*line 263
*line 264
clr R0
move R5,R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l R0,R12
L25:L26:
*line 257
clr R0
move R4,R0
sub #1,R4
tst R0
bne L27
L24:L23:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.data
