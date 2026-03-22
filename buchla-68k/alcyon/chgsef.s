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
.globl _ac_code
.globl _scname
.globl _se_chg
.globl _curscor
.globl _cursect
.globl _se1_cnt
.globl _se2_cnt
.globl _se3_cnt
.globl _spool
.globl _pspool
.globl _spcount
.globl _frags
.globl _t_bak
.globl _t_cur
.globl _t_ctr
.globl _t_fwd
.globl _size1
.globl _size2
.globl _size3
.globl _scores
.globl _scp
.globl _seclist
.globl _hplist
.globl _p_bak
.globl _p_cur
.globl _p_ctr
.globl _p_fwd
.globl _sd
.globl _se
.globl _gdstbc
.globl _gdstbn
.globl _gdstbp
.globl _chgsef
.text
_chgsef:
~~chgsef:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ep=R13
~rt=R7
*line 41
clr _se
*line 43
move.l _p_cur,R13
*line 44
move.l _t_cur,R7
*line 46
*line 46
cmp.b #21,5(R13)
beq L2
*line 47
*line 48
move.l 12(R13),R13
*line 49
*line 50
bra L5
L4:
*line 51
*line 52
*line 53
cmp.b #21,5(R13)
beq L3
*line 54
*line 55
move _se,(sp)
move.l R13,-(sp)
jsr _se_exec
addq.l #4,sp
*line 56
move.l 12(R13),R13
L5:
*line 57
cmp.l (R13),R7
beq L4
L3:
*line 58
*line 59
move.l R13,_p_cur
*line 60
L2:L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _chgseb
.text
_chgseb:
~~chgseb:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ep=R13
~rt=R7
*line 74
move #1,_se
*line 76
move.l _p_cur,R13
*line 77
move.l _t_cur,R7
*line 79
*line 79
cmp.b #1,5(R13)
beq L7
*line 80
*line 81
move.l 8(R13),R13
*line 82
*line 83
bra L10
L9:
*line 84
*line 85
*line 86
cmp.b #1,5(R13)
beq L8
*line 87
*line 88
move _se,(sp)
move.l R13,-(sp)
jsr _se_exec
addq.l #4,sp
*line 89
move.l 8(R13),R13
L10:
*line 90
cmp.l (R13),R7
beq L9
L8:
*line 91
*line 92
move.l R13,_p_cur
*line 93
L7:L6:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _chgsdf
.text
_chgsdf:
~~chgsdf:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ep=R13
~rt=R7
*line 107
clr _sd
*line 109
move.l #_gdstbc,(sp)
jsr _rslice
*line 110
move.l #_gdstbn,(sp)
jsr _rslice
*line 111
move.l #_gdstbp,(sp)
jsr _rslice
*line 113
move.l _p_ctr,R13
*line 114
move.l _t_ctr,R7
*line 116
*line 116
cmp.b #21,5(R13)
beq L12
*line 117
*line 118
move.l 12(R13),R13
*line 119
*line 120
bra L15
L14:
*line 121
*line 122
*line 123
cmp.b #21,5(R13)
beq L13
*line 124
*line 125
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 126
move.l 12(R13),R13
L15:
*line 127
cmp.l (R13),R7
beq L14
L13:
*line 128
*line 129
move.l R13,_p_ctr
*line 130
*line 131
L12:
*line 132
move.l _p_bak,R13
*line 133
move.l _t_bak,R7
*line 135
*line 135
cmp.b #21,5(R13)
beq L16
*line 136
*line 137
move.l 12(R13),R13
*line 138
*line 139
bra L19
L18:
*line 140
*line 141
*line 142
cmp.b #21,5(R13)
beq L17
*line 143
*line 144
clr (sp)
move.l #_gdstbp,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 145
move.l 12(R13),R13
L19:
*line 146
cmp.l (R13),R7
beq L18
L17:
*line 147
*line 148
move.l R13,_p_bak
*line 149
*line 150
L16:
*line 151
move.l _p_fwd,R13
*line 152
move.l _t_fwd,R7
*line 154
*line 154
cmp.b #21,5(R13)
beq L20
*line 155
*line 156
move.l 12(R13),R13
*line 157
*line 158
bra L23
L22:
*line 159
*line 160
*line 161
cmp.b #21,5(R13)
beq L21
*line 162
*line 163
clr (sp)
move.l #_gdstbn,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 164
move.l 12(R13),R13
L23:
*line 165
cmp.l (R13),R7
beq L22
L21:
*line 166
*line 167
move.l R13,_p_fwd
*line 168
L20:L11:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _chgsdb
.text
_chgsdb:
~~chgsdb:
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ep=R13
~rt=R7
*line 182
move #1,_sd
*line 184
move.l #_gdstbc,(sp)
jsr _rslice
*line 185
move.l #_gdstbn,(sp)
jsr _rslice
*line 186
move.l #_gdstbp,(sp)
jsr _rslice
*line 188
move.l _p_ctr,R13
*line 189
move.l _t_ctr,R7
*line 191
*line 191
cmp.b #1,5(R13)
beq L25
*line 192
*line 193
move.l 8(R13),R13
*line 194
*line 195
bra L28
L27:
*line 196
*line 197
*line 198
cmp.b #1,5(R13)
beq L26
*line 199
*line 200
move #1,(sp)
move.l #_gdstbc,-(sp)
move #1,-(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 201
move.l 8(R13),R13
L28:
*line 202
cmp.l (R13),R7
beq L27
L26:
*line 203
*line 204
move.l R13,_p_ctr
*line 205
*line 206
L25:
*line 207
move.l _p_bak,R13
*line 208
move.l _t_bak,R7
*line 210
*line 210
cmp.b #1,5(R13)
beq L29
*line 211
*line 212
move.l 8(R13),R13
*line 213
*line 214
bra L32
L31:
*line 215
*line 216
*line 217
cmp.b #1,5(R13)
beq L30
*line 218
*line 219
clr (sp)
move.l #_gdstbp,-(sp)
move #1,-(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 220
move.l 8(R13),R13
L32:
*line 221
cmp.l (R13),R7
beq L31
L30:
*line 222
*line 223
move.l R13,_p_bak
*line 224
*line 225
L29:
*line 226
move.l _p_fwd,R13
*line 227
move.l _t_fwd,R7
*line 229
*line 229
cmp.b #1,5(R13)
beq L33
*line 230
*line 231
move.l 8(R13),R13
*line 232
*line 233
bra L36
L35:
*line 234
*line 235
*line 236
cmp.b #1,5(R13)
beq L34
*line 237
*line 238
clr (sp)
move.l #_gdstbn,-(sp)
move #1,-(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 239
move.l 8(R13),R13
L36:
*line 240
cmp.l (R13),R7
beq L35
L34:
*line 241
*line 242
move.l R13,_p_fwd
*line 243
L33:L24:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
