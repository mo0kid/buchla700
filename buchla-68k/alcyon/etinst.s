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
.globl _ctrsw
.globl _recsw
.globl _stccol
.globl _grpmode
.globl _grpstat
.globl _ins2grp
.globl _gdstbc
.globl _et_inst
.text
_et_inst:
~~et_inst:
~n=8
link R14,#-4
*line 43
move 8(R14),R8
add.l R8,R8
move.l #_ins2grp,R9
move 0(R8,R9.l),(sp)
and #255,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 44
move #1,_ebflag
*line 46
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_inst
.text
_ef_inst:
~~ef_inst:
~n=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ival=R7
~ep=R13
*line 65
clr.b 2+_ebuf
*line 66
move.b _ebuf,R7
ext.w R7
add #-48,R7
muls #10,R7
move.b 1+_ebuf,R0
ext.w R0
add R0,R7
add #-48,R7
*line 67
clr _ebflag
*line 69
*line 70
cmp #41,R7
blt L4
*line 70
move #-1,R0
bra L3
*line 71
L4:
*line 72
move R7,R0
move 8(R14),R9
add.l R9,R9
add.l #_ins2grp,R9
move (R9),R1
and #-256,R1
or R1,R0
move 8(R14),R9
add.l R9,R9
add.l #_ins2grp,R9
move R0,(R9)
*line 73
move 8(R14),(sp)
jsr _setv2gi
*line 74
jsr _setinst
*line 76
*line 76
tst _recsw
beq L5
move 8(R14),R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L5
move 8(R14),R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L5
*line 77
*line 78
*line 78
move #-1,(sp)
move 8(R14),-(sp)
move #4,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L6
*line 79
*line 80
move.b R7,7(R13)
*line 81
bra L7
L6:
*line 82
*line 82
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L8
*line 83
*line 84
move.b #4,5(R13)
*line 85
move 8(R14),R0
move.b R0,6(R13)
*line 86
move.b R7,7(R13)
*line 87
move.l _t_cur,(R13)
*line 88
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
*line 89
clr (sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 90
move #1,_ctrsw
*line 91
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 92
jsr _scupd
*line 93
L8:L7:
*line 94
*line 95
L5:
*line 96
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _rd_inst
.text
_rd_inst:
~~rd_inst:
~n=8
link R14,#-8
~buf=-4
*line 114
move 8(R14),R8
add.l R8,R8
move.l #_ins2grp,R9
move 0(R8,R9.l),(sp)
and #255,(sp)
move.l #L10,-(sp)
move.l R14,-(sp)
sub.l #4,(sp)
jsr _sprintf
addq.l #8,sp
*line 116
*line 117
clr R0
move 10+_v_regs,R0
and #384,R0
beq L11
*line 117
clr (sp)
jsr _vbank
*line 118
L11:
*line 119
move #18,(sp)
move.l R14,-(sp)
sub.l #4,(sp)
move 8(R14),R0
muls #5,R0
move R0,-(sp)
add #7,(sp)
move #2,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 121
clr R0
bra L9
L9:unlk R14
rts
.globl _ds_inst
.text
_ds_inst:
~~ds_inst:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 134
clr R7
bra L15
L16:
*line 135
move R7,(sp)
jsr _rd_inst
L14:
*line 134
add #1,R7
L15:
*line 134
cmp #12,R7
blt L16
L13:L12:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_inst
.text
_nd_inst:
~~nd_inst:
~n=R7
~k=R6
link R14,#0
movem.l R4-R7,-(sp)
~ec=R5
*line 153
move 8(R14),R7
*line 153
move 10(R14),R6
*line 153
move _stccol,R5
move.l _cfetp,R8
move 2(R8),R0
sub R0,R5
*line 154
move R6,R0
add #48,R0
move R5,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 156
*line 157
clr R0
move 10+_v_regs,R0
and #384,R0
beq L18
*line 157
clr (sp)
jsr _vbank
*line 158
L18:
*line 159
move #98,(sp)
move R6,-(sp)
add #48,(sp)
move _stccol,-(sp)
move #2,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 160
jsr _advscur
*line 162
clr R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$2E,$32,$64,$0
L10:.dc.b $25,$30,$32,$2E,$32,$64,$0
