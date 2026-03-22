.globl _v_obtab
.globl _v_curob
.globl _v_nobj
.globl _v_obpri
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
.globl _amplval
.globl _ext_cv1
.globl _ext_cv2
.globl _ext_cv3
.globl _ext_cv4
.globl _ext_mod
.globl _lstbgnc
.globl _lstendc
.globl _ps_intn
.globl _ps_rate
.globl _ps_dpth
.globl _sliders
.globl _lastart
.globl _dyntab
.globl _expbit
.globl _fnoff
.globl _fp_resv
.globl _grpdyn
.globl _grploc
.globl _lastvce
.globl _prstab
.globl _vce2grp
.globl _vce2trg
.globl _veltab
.globl _sigtab
.globl _keystat
.globl _mpsust
.globl _trgtab
.globl _lstbgns
.globl _lstends
.globl _sendval
.text
_sendval:
~~sendval:
~voice=8
~par=10
~ival=12
link R14,#-2
movem.l R4-R7/R13-R13,-(sp)
~fpu=R13
~oldi=R7
~val=R6
~ltmp=R5
~nop=-2
*line 74
move 8(R14),R0
asl #8,R0
asl #1,R0
ext.l R0
move.l R0,R13
move 10(R14),R0
asl #4,R0
asl #1,R0
ext.l R0
add.l R0,R13
add.l #_io_fpu,R13
add.l #$4000,R13
*line 76
move 10(R14),R0
bra L3
*line 77
L4:
*line 78
L5:
*line 79
L6:
*line 80
L7:
*line 81
*line 82
*line 83
clr (sp)
move 12(R14),-(sp)
jsr _addpch
addq.l #2,sp
move R0,R6
bra L2
*line 84
*line 85
L8:
*line 86
*line 87
*line 88
move 12(R14),R6
asl R6
eor #-32768,R6
bra L2
*line 89
*line 90
L9:
*line 91
*line 92
*line 93
move 12(R14),R5
ext.l R5
asr.l #$1,R5
move 12(R14),R0
ext.l R0
asr.l #$2,R0
add.l R0,R5
*line 94
*line 95
*line 96
cmp.l #$7d00,R5
ble L10
*line 96
move.l #$7d00,R5
bra L11
L10:
*line 97
*line 98
cmp.l #$ffff8300,R5
bge L12
*line 98
move.l #$ffff8300,R5
*line 99
L12:L11:
*line 100
move R5,R6
bra L2
*line 101
*line 102
*line 103
L13:
*line 104
*line 105
*line 106
move 12(R14),R6
asr #5,R6
add #-500,R6
asl #6,R6
bra L2
*line 107
*line 108
L14:
*line 109
*line 110
*line 111
move 12(R14),R6
bra L2
L3:sub #1,R0
cmp #9,R0
bhi L14
asl #2,R0
move R0,R8
add.l #L15,R8
move.l (R8),R8
jmp (R8)
.data
L15:.dc.l L4
.dc.l L13
.dc.l L5
.dc.l L8
.dc.l L6
.dc.l L14
.dc.l L7
.dc.l L14
.dc.l L14
.dc.l L9
.text
L2:
*line 114
move #2,(sp)
jsr _setipl
move R0,R7
*line 118
move.l R13,R8
add.l #$2,R8
move R6,(R8)
*line 119
add #1,-2(R14)
*line 119
add #1,-2(R14)
*line 119
add #1,-2(R14)
*line 120
move.l R13,R8
add.l #$1c,R8
move R6,(R8)
*line 121
add #1,-2(R14)
*line 121
add #1,-2(R14)
*line 121
add #1,-2(R14)
*line 122
move #21,(R13)
*line 124
move R7,(sp)
jsr _setipl
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _clearer
.text
_clearer:
~~clearer:
~stat=8
~sig=10
link R14,#-4
movem.l R2-R7/R13-R13,-(sp)
~fpu=R13
~fpexp=R7
~fpmant=R6
~fptime=R5
~oldi=R4
~i=R3
~nop=-2
~olds=-4
*line 147
*line 147
tst 8(R14)
beq L17
*line 148
*line 149
move #-32000,_fp_resv
*line 150
move _ps_intn,R0
muls #10,R0
asl #5,R0
move R0,2+_fp_resv
*line 151
move _ps_rate,R0
muls #10,R0
asl #5,R0
move R0,4+_fp_resv
*line 152
move _ps_dpth,R0
muls #10,R0
asl #5,R0
move R0,6+_fp_resv
*line 153
clr 8+_fp_resv
*line 154
clr 10+_fp_resv
*line 155
move _ext_cv3,12+_fp_resv
*line 156
clr 14+_fp_resv
*line 157
move _ext_cv4,16+_fp_resv
*line 158
move _ext_mod,18+_fp_resv
*line 159
move _ext_cv2,20+_fp_resv
*line 160
move _ext_cv1,22+_fp_resv
*line 161
*line 162
move.l #16384+_io_fpu,R13
*line 163
move #200,(sp)
jsr _tofpu
move R0,R5
*line 164
clr R0
move R5,R0
and #15,R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l #_expbit,R0
move.l R0,R8
move (R8),R7
*line 165
move R5,R6
and #-16,R6
*line 166
*line 167
*line 168
move #2,(sp)
jsr _setipl
move R0,R4
*line 169
*line 170
*line 171
*line 172
jsr _fpuclr
*line 173
*line 174
move R6,20(R13)
*line 175
add #1,-2(R14)
*line 175
add #1,-2(R14)
*line 176
move R7,22(R13)
*line 177
*line 178
*line 179
*line 180
move #6144,(sp)
clr -(sp)
move.l #_trgtab,-(sp)
jsr _memset
addq.l #6,sp
*line 181
move #24,(sp)
clr -(sp)
move.l #_keystat,-(sp)
jsr _memset
addq.l #6,sp
*line 182
*line 183
move #6144,(sp)
clr -(sp)
move.l #_prstab,-(sp)
jsr _memsetw
addq.l #6,sp
*line 184
move #6144,(sp)
move #16128,-(sp)
move.l #_veltab,-(sp)
jsr _memsetw
addq.l #6,sp
*line 185
*line 186
jsr _clrpfl
*line 187
*line 188
clr R3
bra L20
L21:
*line 189
move R3,R8
add.l #_mpsust,R8
clr.b (R8)
L19:
*line 188
add #1,R3
L20:
*line 188
cmp #48,R3
blt L21
L18:
*line 189
*line 190
*line 191
clr R3
bra L24
L25:
*line 192
*line 193
move R3,R8
add.l R8,R8
add.l #_vce2trg,R8
move #-1,(R8)
*line 194
move R3,R8
add.l R8,R8
add.l #_lastvce,R8
clr (R8)
L23:
*line 191
add #1,R3
L24:
*line 191
cmp #12,R3
blt L25
L22:
*line 195
*line 196
*line 197
move _sliders,-4(R14)
*line 198
clr _sliders
*line 199
clr (sp)
move #1,-(sp)
jsr _l_init
addq.l #2,sp
*line 200
move #2,_sliders
*line 201
clr (sp)
move #1,-(sp)
jsr _l_init
addq.l #2,sp
*line 202
move -4(R14),_sliders
*line 203
*line 204
move R4,(sp)
jsr _setipl
*line 205
*line 206
*line 207
*line 208
*line 209
*line 210
clr _lstbgnc
*line 211
clr _lstendc
*line 212
*line 213
move #96,(sp)
clr -(sp)
move.l #_lstbgns,-(sp)
jsr _memsetw
addq.l #6,sp
*line 214
move #96,(sp)
clr -(sp)
move.l #_lstends,-(sp)
jsr _memsetw
addq.l #6,sp
*line 215
*line 216
*line 217
*line 218
clr R3
bra L28
L29:
*line 219
*line 220
move R3,R8
add.l R8,R8
move.l #_grpdyn,R9
move 0(R8,R9.l),(sp)
move R3,-(sp)
jsr _setdyn
addq.l #2,sp
*line 221
move R3,R8
add.l R8,R8
move.l #_grploc,R9
move 0(R8,R9.l),(sp)
move R3,-(sp)
jsr _setloc
addq.l #2,sp
L27:
*line 218
add #1,R3
L28:
*line 218
cmp #12,R3
blt L29
L26:
*line 222
*line 223
*line 224
jsr _settune
*line 225
move _amplval,(sp)
clr -(sp)
clr -(sp)
jsr _sendval
addq.l #4,sp
*line 226
L17:L16:tst.l (sp)+
movem.l (sp)+,R3-R7/R13-R13
unlk R14
rts
.data
