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
.globl _recsw
.globl _ndisp
.globl _sd
.globl _swctrl
.globl _swflag
.globl _gdfsep
.globl _gdstbc
.globl _gdstbn
.globl _sc_goto
.text
_sc_goto:
~~sc_goto:
~tval=R7
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~gdsp=R13
~rp=R12
~tf=R6
~rt=R5
~mod48=R4
*line 54
move #48,R4
*line 65
move.l 8(R14),R7
*line 65
*line 66
*line 67
tst.l _p_fwd
beq L10000
tst.l _p_cur
beq L10000
tst.l _p_bak
beq L10000
tst.l _p_ctr
bne L2
L10000:*line 67
move #-1,R0
bra L1
*line 68
L2:
*line 69
*line 70
clr R0
move 10+_v_regs,R0
and #384,R0
beq L3
*line 70
clr (sp)
jsr _vbank
*line 71
L3:
*line 72
clr _sd
*line 73
clr _swctrl
*line 74
clr _swflag
*line 76
clr _recsw
*line 77
jsr _dsrpmod
*line 79
*line 80
cmp #2,_ndisp
bne L4
*line 80
jsr _sreset
*line 81
L4:
*line 82
jsr _quiet
*line 83
jsr _clrnl
*line 84
jsr _clrsctl
*line 86
move.l R7,R0
add.l #$ffffff10,R0
move.l R0,_t_bak
*line 87
move.l _t_bak,_t_fwd
*line 88
move.l R7,_t_ctr
*line 89
move.l R7,_t_cur
*line 91
clr (sp)
move.l _t_bak,-(sp)
jsr _frfind
addq.l #4,sp
move.l R0,_p_bak
*line 92
move #1,(sp)
move.l _t_cur,-(sp)
jsr _frfind
addq.l #4,sp
move.l R0,_p_cur
*line 93
move #1,(sp)
move.l _t_fwd,-(sp)
jsr _frfind
addq.l #4,sp
move.l R0,_p_fwd
*line 99
*line 100
tst.l _t_fwd
bgt L5
move.l _p_fwd,R8
cmp.b #1,5(R8)
bne L5
*line 100
move.l _p_fwd,R8
move.l 12(R8),_p_fwd
*line 101
L5:
*line 102
move.l _p_fwd,R12
*line 103
move.l _t_fwd,R5
*line 104
move.l R7,R6
add.l #$102,R6
*line 122
bra L8
L7:
*line 123
*line 124
*line 124
cmp.b #21,5(R12)
beq L9
*line 125
*line 126
bra L12
L11:
*line 127
*line 128
*line 129
cmp #2,_ndisp
bne L13
*line 129
clr (sp)
move.l #_gdstbn,-(sp)
clr -(sp)
move.l R12,-(sp)
jsr _se_disp
adda.l #10,sp
*line 130
L13:
*line 131
move.l 12(R12),R12
*line 132
*line 133
*line 134
cmp.b #21,5(R12)
beq L10
L12:
*line 135
cmp.l (R12),R5
bge L11
L10:
*line 136
*line 137
L9:
*line 138
*line 138
cmp #2,_ndisp
bne L14
*line 139
*line 140
*line 140
move.l R5,R0
divs R4,R0
swap R0
ext.l R0
tst.l R0
bne L15
*line 141
*line 142
*line 142
move.l _gdfsep,R13
move.l R13,R0
beq L16
*line 143
*line 144
move.l (R13),_gdfsep
*line 145
*line 146
move.l 48+_gdstbn,(R13)
*line 147
move #4369,4(R13)
*line 148
move #1,6(R13)
*line 149
*line 150
move.l R13,48+_gdstbn
*line 151
L16:
*line 152
*line 153
L15:
*line 154
jsr _sc_adv
*line 155
L14:L8:
*line 156
cmp.l R5,R6
move sr,R0
add.l #$1,R5
move R0,ccr
bgt L7
L6:
*line 158
move.l R12,_p_fwd
*line 159
move.l R6,_t_fwd
*line 165
*line 166
cmp #2,_ndisp
bne L17
*line 166
jsr _dssect
*line 167
L17:
*line 168
move.l _p_cur,R12
*line 169
move.l _t_cur,R5
*line 171
*line 172
tst.l R5
bgt L18
cmp.b #1,5(R12)
bne L18
*line 172
move.l 12(R12),R12
*line 173
L18:
*line 174
*line 174
cmp.b #21,5(R12)
beq L19
*line 175
*line 176
bra L22
L21:
*line 177
*line 178
clr (sp)
move.l R12,-(sp)
jsr _se_exec
addq.l #4,sp
*line 179
*line 180
*line 181
cmp #2,_ndisp
bne L23
*line 181
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R12,-(sp)
jsr _se_disp
adda.l #10,sp
*line 182
L23:
*line 183
move.l 12(R12),R12
*line 184
*line 185
*line 186
cmp.b #21,5(R12)
beq L20
L22:
*line 187
cmp.l (R12),R5
beq L21
L20:
*line 188
*line 189
L19:
*line 190
move.l R12,_p_cur
*line 191
move.l R12,_p_ctr
*line 193
*line 193
cmp #2,_ndisp
bne L24
*line 194
*line 195
jsr _scupd
*line 196
jsr _sdwins
*line 197
*line 198
*line 199
*line 200
*line 201
*line 213
*line 214
*line 220
*line 221
L24:
*line 222
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _sc_refr
.text
_sc_refr:
~~sc_refr:
~t=8
link R14,#-8
~oldrs=-2
~rc=-4
*line 240
move _recsw,-2(R14)
*line 241
move.l 8(R14),(sp)
jsr _sc_goto
move R0,-4(R14)
*line 242
move -2(R14),_recsw
*line 243
jsr _dsrpmod
*line 244
move -4(R14),R0
bra L25
L25:unlk R14
rts
.data
