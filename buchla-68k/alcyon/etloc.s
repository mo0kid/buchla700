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
.globl _obj8
.globl _curintp
.globl _ctrsw
.globl _timemlt
.globl _recsw
.globl _stccol
.globl _grploc
.globl _grpmode
.globl _grpstat
.globl _loctab
.globl _vce2grp
.globl _expbit
.globl _gdstbc
.globl _vbufs
.globl _et_loc
.text
_et_loc:
~~et_loc:
~n=8
link R14,#-4
*line 58
move 8(R14),R8
add.l R8,R8
move.l #_grploc,R9
move 0(R8,R9.l),R0
add #49,R0
move.b R0,_ebuf
*line 59
clr.b 1+_ebuf
*line 60
move #1,_ebflag
*line 61
clr R0
bra L1
L1:unlk R14
rts
.globl _setloc
.text
_setloc:
~~setloc:
~grp=8
~loc=10
link R14,#-8
movem.l R3-R7/R12-R13,-(sp)
~g=R7
~i=R6
~val=R5
~ltmp=R4
~fpu=R13
~fp=R12
~fpmant=-2
~fpexp=-4
~oldsr=-6
~nop=-8
*line 84
move 8(R14),R8
add.l R8,R8
add.l #_grploc,R8
move 10(R14),(R8)
*line 85
move 10(R14),R8
add.l R8,R8
add.l #_loctab,R8
move (R8),R5
asl R5
eor #-32768,R5
*line 86
move 8(R14),R7
add #1,R7
*line 88
*line 89
move _timemlt,R0
ext.l R0
and.l #$ffff,R0
move.l R0,-(sp)
clr.l R0
move _curintp,R0
and.l #$fff0,R0
move.l R0,-(sp)
jsr lmul
addq.l #8,sp
move.l #$f,R1
asr.l R1,R0
move R0,-2(R14)
*line 91
clr R0
move _curintp,R0
and #15,R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l #_expbit,R0
move.l R0,R8
move (R8),-4(R14)
*line 95
clr R6
bra L5
L6:
*line 96
*line 96
move R6,R8
add.l R8,R8
add.l #_vce2grp,R8
cmp (R8),R7
bne L7
*line 97
*line 98
move R6,R0
muls #3938,R0
move.l R0,R12
add.l #_vbufs,R12
add.l #134,R12
*line 99
move R6,R0
asl #8,R0
asl #1,R0
ext.l R0
move.l R0,R13
add.l #_io_fpu,R13
add.l #$4080,R13
*line 100
*line 101
move #8704,(sp)
jsr _setsr
move R0,-6(R14)
*line 102
*line 103
*line 104
*line 105
eor.b #24,7(R12)
*line 106
*line 107
move.l R13,R8
add.l #$14,R8
move -2(R14),(R8)
*line 108
add #1,-8(R14)
*line 108
add #1,-8(R14)
*line 108
add #1,-8(R14)
*line 109
move.l R13,R8
add.l #$16,R8
move -4(R14),(R8)
*line 110
add #1,-8(R14)
*line 110
add #1,-8(R14)
*line 110
add #1,-8(R14)
*line 111
*line 112
*line 113
btst #3,7(R12)
beq L8
*line 113
move.l R13,R8
add.l #$1c,R8
move R5,(R8)
*line 114
bra L9
L8:
*line 115
move.l R13,R8
add.l #$2,R8
move R5,(R8)
L9:
*line 116
*line 117
add #1,-8(R14)
*line 117
add #1,-8(R14)
*line 117
add #1,-8(R14)
*line 118
*line 119
*line 120
move.b 7(R12),R0
ext.w R0
and #28,R0
or #1,R0
move R0,(R13)
*line 121
*line 122
move -6(R14),(sp)
jsr _setsr
*line 123
*line 124
*line 125
*line 126
L7:L4:
*line 95
add #1,R6
L5:
*line 95
cmp #12,R6
blt L6
L3:L2:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _ef_loc
.text
_ef_loc:
~~ef_loc:
~n=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ival=R7
~ep=R13
*line 145
clr.b 1+_ebuf
*line 146
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 147
clr _ebflag
*line 149
*line 150
tst R7
bne L11
*line 150
move #-1,R0
bra L10
*line 151
L11:
*line 152
sub #1,R7
*line 154
move R7,(sp)
move 8(R14),-(sp)
jsr _setloc
addq.l #2,sp
*line 156
*line 156
tst _recsw
beq L12
move 8(R14),R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L12
move 8(R14),R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L12
*line 157
*line 158
*line 158
move #-1,(sp)
move 8(R14),-(sp)
move #12,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L13
*line 159
*line 160
move.b R7,7(R13)
*line 161
bra L14
L13:
*line 162
*line 162
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L15
*line 163
*line 164
move.b #12,5(R13)
*line 165
move 8(R14),R0
move.b R0,6(R13)
*line 166
move.b R7,7(R13)
*line 167
move.l _t_cur,(R13)
*line 168
move.l _t_cur,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,(sp)
move.l R13,-(sp)
jsr _e_ins
addq.l #4,sp
move.l R0,R8
move.l 12(R8),_p_cur
*line 169
move #2,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 170
move #1,_ctrsw
*line 171
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 172
jsr _scupd
*line 173
L15:L14:
*line 174
*line 175
L12:
*line 176
clr R0
bra L10
L10:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _rd_loc
.text
_rd_loc:
~~rd_loc:
~n=8
link R14,#-4
*line 192
*line 193
clr R0
move 10+_v_regs,R0
and #384,R0
beq L17
*line 193
clr (sp)
jsr _vbank
*line 194
L17:
*line 195
move #18,(sp)
move 8(R14),R8
add.l R8,R8
move.l #_grploc,R9
move 0(R8,R9.l),-(sp)
add #49,(sp)
move 8(R14),R0
muls #5,R0
move R0,-(sp)
add #8,(sp)
move #4,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 197
clr R0
bra L16
L16:unlk R14
rts
.globl _ds_loc
.text
_ds_loc:
~~ds_loc:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 210
clr R7
bra L21
L22:
*line 211
move R7,(sp)
jsr _rd_loc
L20:
*line 210
add #1,R7
L21:
*line 210
cmp #12,R7
blt L22
L19:L18:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_loc
.text
_nd_loc:
~~nd_loc:
~n=R7
~k=R6
link R14,#0
movem.l R5-R7,-(sp)
*line 227
move 8(R14),R7
*line 227
move 10(R14),R6
*line 227
move R6,R0
add #48,R0
move.b R0,_ebuf
*line 229
*line 230
clr R0
move 10+_v_regs,R0
and #384,R0
beq L24
*line 230
clr (sp)
jsr _vbank
*line 231
L24:
*line 232
move #98,(sp)
move R6,-(sp)
add #48,(sp)
move _stccol,-(sp)
move #4,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 233
jsr _advscur
*line 235
clr R0
bra L23
L23:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
