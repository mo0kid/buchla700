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
.globl _grpdyn
.globl _grpmode
.globl _grpstat
.globl _gdstbc
.globl _et_dyn
.text
_et_dyn:
~~et_dyn:
~n=8
link R14,#-4
*line 39
move 8(R14),R8
add.l R8,R8
move.l #_grpdyn,R9
move 0(R8,R9.l),R0
add #48,R0
move.b R0,_ebuf
*line 40
clr.b 1+_ebuf
*line 41
move #1,_ebflag
*line 42
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_dyn
.text
_ef_dyn:
~~ef_dyn:
~n=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~ival=R7
~ep=R13
*line 61
clr.b 1+_ebuf
*line 62
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 63
clr _ebflag
*line 65
move R7,(sp)
move 8(R14),-(sp)
jsr _setdyn
addq.l #2,sp
*line 67
*line 67
tst _recsw
beq L3
move 8(R14),R8
add.l R8,R8
move.l #_grpmode,R9
tst 0(R8,R9.l)
beq L3
move 8(R14),R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L3
*line 68
*line 69
*line 69
move #-1,(sp)
move 8(R14),-(sp)
move #13,-(sp)
move.l _t_cur,-(sp)
move.l _p_cur,-(sp)
jsr _findev
adda.l #12,sp
move.l R0,R13
move.l R13,R0
beq L4
*line 70
*line 71
move.b R7,7(R13)
*line 72
bra L5
L4:
*line 73
*line 73
move #6,(sp)
jsr _e_alc
move.l R0,R13
move.l R13,R0
beq L6
*line 74
*line 75
move.b #13,5(R13)
*line 76
move 8(R14),R0
move.b R0,6(R13)
*line 77
move.b R7,7(R13)
*line 78
move.l _t_cur,(R13)
*line 79
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
*line 80
move #3,(sp)
move.l R13,-(sp)
jsr _eh_ins
addq.l #4,sp
*line 81
move #1,_ctrsw
*line 82
move #1,(sp)
move.l #_gdstbc,-(sp)
clr -(sp)
move.l R13,-(sp)
jsr _se_disp
adda.l #10,sp
*line 83
jsr _scupd
*line 84
L6:L5:
*line 85
*line 86
L3:
*line 87
clr R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _rd_dyn
.text
_rd_dyn:
~~rd_dyn:
~n=8
link R14,#-4
*line 103
*line 104
clr R0
move 10+_v_regs,R0
and #384,R0
beq L8
*line 104
clr (sp)
jsr _vbank
*line 105
L8:
*line 106
move #18,(sp)
move 8(R14),R8
add.l R8,R8
move.l #_grpdyn,R9
move 0(R8,R9.l),-(sp)
add #48,(sp)
move 8(R14),R0
muls #5,R0
move R0,-(sp)
add #6,(sp)
move #4,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 108
clr R0
bra L7
L7:unlk R14
rts
.globl _ds_dyn
.text
_ds_dyn:
~~ds_dyn:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 121
clr R7
bra L12
L13:
*line 122
move R7,(sp)
jsr _rd_dyn
L11:
*line 121
add #1,R7
L12:
*line 121
cmp #12,R7
blt L13
L10:L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_dyn
.text
_nd_dyn:
~~nd_dyn:
~n=R7
~k=R6
link R14,#0
movem.l R5-R7,-(sp)
*line 138
move 8(R14),R7
*line 138
move 10(R14),R6
*line 138
move R6,R0
add #48,R0
move.b R0,_ebuf
*line 140
*line 141
clr R0
move 10+_v_regs,R0
and #384,R0
beq L15
*line 141
clr (sp)
jsr _vbank
*line 142
L15:
*line 143
move #98,(sp)
move R6,-(sp)
add #48,(sp)
move _stccol,-(sp)
move #4,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 144
jsr _advscur
*line 146
clr R0
bra L14
L14:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
