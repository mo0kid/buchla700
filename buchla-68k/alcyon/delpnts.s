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
.globl _curfunc
.globl _curvce
.globl _pntsv
.globl _subj
.globl _finival
.globl _fnoff
.globl _vbufs
.globl _delpnts
.text
_delpnts:
~~delpnts:
link R14,#-18
movem.l R2-R7/R11-R13,-(sp)
~pp=R13
~pp1=R12
~pp2=R11
~np=R7
~pt1=R6
~i=R5
~pif=R4
~cf=R3
~fp=-4
~vp=-8
~fpu=-12
~pt2=-14
~nmv=-16
~oldi=-18
*line 61
move _curvce,R0
muls #3938,R0
add.l #_vbufs,R0
move.l R0,-8(R14)
*line 62
move _curfunc,R0
muls #12,R0
add.l -8(R14),R0
add.l #86,R0
move.l R0,-4(R14)
*line 64
move.l -4(R14),R8
move.b 5(R8),R0
ext.w R0
move R0,R4
and #255,R4
*line 65
move R4,R7
sub _subj,R7
*line 66
move.l -4(R14),R8
move.b 6(R8),R0
ext.w R0
move R0,R6
and #255,R6
add _subj,R6
*line 79
*line 80
tst R7
bgt L2
*line 80
move #-1,R0
bra L1
*line 81
L2:
*line 82
*line 83
cmp _subj,R4
bgt L3
*line 83
move #-1,R0
bra L1
*line 84
L3:
*line 85
*line 86
move R4,R0
sub R7,R0
bge L4
*line 86
move #-1,R0
bra L1
*line 87
L4:
*line 88
*line 89
move R7,R0
add _subj,R0
move R4,R1
add #1,R1
cmp R1,R0
blt L5
*line 89
move #-1,R0
bra L1
*line 90
L5:
*line 91
move R6,R0
add R7,R0
move R0,-14(R14)
*line 92
move #128,R0
sub -14(R14),R0
move R0,-16(R14)
*line 112
move #2,(sp)
jsr _setipl
move R0,-18(R14)
*line 114
move _curvce,R0
asl #8,R0
asl #1,R0
ext.l R0
add.l #_io_fpu,R0
add.l #$4000,R0
move.l R0,-12(R14)
*line 116
clr R5
bra L8
L9:
*line 117
*line 118
move R5,R0
muls #12,R0
add.l -8(R14),R0
add.l #86,R0
move.l R0,-4(R14)
*line 119
*line 120
*line 121
move.l -4(R14),R8
move.b 7(R8),R0
ext.w R0
and #-4,R0
or #1,R0
move.l -4(R14),R9
move.b R0,7(R9)
move R5,R9
add.l R9,R9
add.l #_fnoff,R9
move (R9),R1
asl #4,R1
move R1,R9
add.l R9,R9
add.l -12(R14),R9
move R0,(R9)
L7:
*line 116
add #1,R5
L8:
*line 116
cmp #13,R5
blt L9
L6:
*line 124
move _curfunc,R0
muls #12,R0
add.l -8(R14),R0
add.l #86,R0
move.l R0,-4(R14)
*line 126
*line 126
tst _subj
beq L10
*line 127
*line 128
*line 129
*line 130
move R6,R0
muls #12,R0
move.l R0,R12
add.l -8(R14),R12
add.l #242,R12
*line 131
move -14(R14),R0
muls #12,R0
move.l R0,R11
add.l -8(R14),R11
add.l #242,R11
*line 132
*line 133
move -16(R14),R5
muls #12,R5
bra L13
L14:
*line 134
move.b (R11)+,(R12)+
L12:
*line 133
sub #1,R5
L13:
*line 133
tst R5
bgt L14
L11:
*line 134
*line 135
*line 136
*line 137
*line 138
move R7,-(sp)
move.l -8(R14),R8
move.b 71(R8),R0
add (sp)+,R0
move.b R0,71(R8)
*line 139
*line 140
*line 141
*line 142
move R7,-(sp)
move _curfunc,R0
muls #12,R0
add.l -8(R14),R0
move.l R0,R8
move.b 91(R8),R0
sub (sp)+,R0
move.b R0,91(R8)
*line 143
*line 144
*line 145
*line 146
move _curfunc,R3
add #1,R3
bra L17
L18:
*line 147
move R7,-(sp)
move R3,R0
muls #12,R0
add.l -8(R14),R0
move.l R0,R8
move.b 92(R8),R0
sub (sp)+,R0
move.b R0,92(R8)
L16:
*line 146
add #1,R3
L17:
*line 146
cmp #13,R3
blt L18
L15:
*line 147
*line 148
*line 149
move -18(R14),(sp)
jsr _setipl
*line 150
*line 151
move _curfunc,(sp)
jsr _edfunc
*line 152
sub #1,_subj
*line 153
*line 154
bra L19
L10:
*line 155
*line 156
*line 157
*line 158
*line 159
move.l -4(R14),R8
move.b 6(R8),R0
ext.w R0
muls #12,R0
move.l R0,R13
add.l -8(R14),R13
add.l #242,R13
*line 160
*line 161
move #-32753,(R13)
*line 162
move _curfunc,R8
add.l R8,R8
add.l #_finival,R8
move (R8),2(R13)
*line 163
clr 4(R13)
*line 164
clr.b 6(R13)
*line 165
clr.b 7(R13)
*line 166
clr.b 8(R13)
*line 167
clr.b 9(R13)
*line 168
clr.b 10(R13)
*line 169
*line 170
*line 171
*line 172
*line 172
cmp #1,R7
ble L20
*line 173
*line 174
sub #1,-16(R14)
*line 175
add #1,R6
*line 176
*line 177
*line 178
*line 179
move R6,R0
muls #12,R0
move.l R0,R12
add.l -8(R14),R12
add.l #242,R12
*line 180
move -14(R14),R0
muls #12,R0
move.l R0,R11
add.l -8(R14),R11
add.l #242,R11
*line 181
*line 182
move -16(R14),R5
muls #12,R5
bra L23
L24:
*line 183
move.b (R11)+,(R12)+
L22:
*line 182
sub #1,R5
L23:
*line 182
tst R5
bgt L24
L21:
*line 183
*line 184
*line 185
*line 186
*line 187
move R7,-(sp)
sub #1,(sp)
move.l -8(R14),R8
move.b 71(R8),R0
add (sp)+,R0
move.b R0,71(R8)
*line 188
*line 189
*line 190
*line 191
move R7,-(sp)
sub #1,(sp)
move _curfunc,R0
muls #12,R0
add.l -8(R14),R0
move.l R0,R8
move.b 91(R8),R0
sub (sp)+,R0
move.b R0,91(R8)
*line 192
*line 193
*line 194
*line 195
move _curfunc,R3
add #1,R3
bra L27
L28:
*line 196
move R7,-(sp)
sub #1,(sp)
move R3,R0
muls #12,R0
add.l -8(R14),R0
move.l R0,R8
move.b 92(R8),R0
sub (sp)+,R0
move.b R0,92(R8)
L26:
*line 195
add #1,R3
L27:
*line 195
cmp #13,R3
blt L28
L25:
*line 196
*line 197
*line 198
L20:
*line 199
move -18(R14),(sp)
jsr _setipl
*line 200
*line 201
move _curfunc,(sp)
jsr _edfunc
*line 202
clr _subj
L19:
*line 224
jsr _pntsel
*line 225
clr _pntsv
*line 226
move #1,(sp)
jsr _showpt
*line 227
jsr _modinst
*line 229
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.globl _inspnt
.text
_inspnt:
~~inspnt:
~ip=R13
~fn=12
~inpnt=14
link R14,#-6
movem.l R2-R7/R11-R13,-(sp)
~fp1=R12
~fp2=R11
~i=R7
~j=R6
~k=R5
~l=R4
~npts=R3
~topnt=-2
~frompt=-4
~oldi=-6
*line 250
move.l 8(R14),R13
*line 250
*line 251
tst.b 71(R13)
bne L30
*line 251
clr R0
bra L29
*line 252
L30:
*line 253
*line 254
move.l R13,R8
move 12(R14),R1
muls #12,R1
add.l R1,R8
cmp.b #99,91(R8)
bne L31
*line 254
clr R0
bra L29
*line 255
L31:
*line 256
move #128,R0
move.b 71(R13),R1
ext.w R1
sub R1,R0
move R0,-2(R14)
*line 257
move -2(R14),R0
sub #1,R0
move R0,-4(R14)
*line 258
move -4(R14),R3
sub 14(R14),R3
*line 259
move -2(R14),R7
*line 260
move -4(R14),R6
*line 270
move #2,(sp)
jsr _setipl
move R0,-6(R14)
*line 274
clr R5
bra L34
L35:
*line 275
*line 276
move.l R13,R12
move R7,R0
muls #12,R0
add.l R0,R12
add.l #242,R12
sub #1,R7
*line 277
move.l R13,R11
move R6,R0
muls #12,R0
add.l R0,R11
add.l #242,R11
sub #1,R6
*line 278
*line 279
clr R4
bra L38
L39:
*line 280
move.b (R11)+,(R12)+
L37:
*line 279
add #1,R4
L38:
*line 279
cmp #12,R4
blt L39
L36:
*line 280
L33:
*line 274
add #1,R5
L34:
*line 274
cmp R3,R5
blt L35
L32:
*line 283
move 12(R14),R7
add #1,R7
bra L42
L43:
*line 284
*line 285
move.l R13,R8
move R7,R1
muls #12,R1
add.l R1,R8
add.b #1,92(R8)
*line 286
move.l R13,R8
move R7,R1
muls #12,R1
add.l R1,R8
add.b #1,94(R8)
L41:
*line 283
add #1,R7
L42:
*line 283
cmp #13,R7
blt L43
L40:
*line 289
move -6(R14),(sp)
jsr _setipl
*line 293
move.l R13,R8
move 12(R14),R1
muls #12,R1
add.l R1,R8
add.b #1,91(R8)
*line 294
sub.b #1,71(R13)
*line 302
move #1,R0
bra L29
L29:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.data
