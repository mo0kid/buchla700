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
.globl _recsw
.globl _stccol
.globl _grpmode
.globl _grpstat
.globl _lastvel
.globl _et_vel
.text
_et_vel:
~~et_vel:
~n=8
link R14,#-4
*line 43
move 8(R14),R8
add.l R8,R8
move.l #_lastvel,R9
move 0(R8,R9.l),R0
ext.l R0
divs #252,R0
move R0,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 45
move #1,_ebflag
*line 46
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_vel
.text
_ef_vel:
~~ef_vel:
~n=8
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~ival=R7
~i=R6
~ep=R13
*line 65
clr R7
*line 67
clr R6
bra L6
L7:
*line 68
muls #10,R7
move.l #_ebuf,R8
move.b 0(R8,R6),R0
ext.w R0
add R0,R7
add #-48,R7
L5:
*line 67
add #1,R6
L6:
*line 67
cmp #3,R6
blt L7
L4:
*line 70
clr _ebflag
*line 72
*line 73
cmp #127,R7
ble L8
*line 73
move #-1,R0
bra L3
*line 74
L8:
*line 75
muls #252,R7
and #32736,R7
*line 77
*line 77
tst _recsw
beq L9
move 8(R14),R8
add.l R8,R8
move.l #_grpstat,R9
tst 0(R8,R9.l)
beq L9
move 8(R14),R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L9
*line 78
*line 79
move 8(R14),R8
add.l R8,R8
add.l #_lastvel,R8
move R7,(R8)
*line 80
move.l _t_cur,(sp)
move #1,-(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R13
*line 81
*line 82
bra L12
L11:
*line 83
*line 84
*line 85
move.b 5(R13),R0
ext.w R0
and #127,R0
cmp #5,R0
bne L13
move.b 7(R13),R0
ext.w R0
cmp 8(R14),R0
bne L13
*line 86
*line 87
move R7,16(R13)
*line 88
*line 89
L13:
*line 90
move.l 12(R13),R13
L12:
*line 91
move.l (R13),R0
cmp.l _t_cur,R0
beq L11
L10:
*line 92
*line 93
L9:
*line 94
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _rd_vel
.text
_rd_vel:
~~rd_vel:
~n=8
link R14,#-10
~buf=-6
*line 112
move 8(R14),R8
add.l R8,R8
move.l #_lastvel,R9
move 0(R8,R9.l),R0
ext.l R0
divs #252,R0
move R0,(sp)
move.l #L15,-(sp)
move.l R14,-(sp)
sub.l #6,(sp)
jsr _sprintf
addq.l #8,sp
*line 114
*line 115
clr R0
move 10+_v_regs,R0
and #384,R0
beq L16
*line 115
clr (sp)
jsr _vbank
*line 116
L16:
*line 117
move #18,(sp)
move.l R14,-(sp)
sub.l #6,(sp)
move 8(R14),R0
muls #5,R0
move R0,-(sp)
add #6,(sp)
move #5,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 119
clr R0
bra L14
L14:unlk R14
rts
.globl _nd_vel
.text
_nd_vel:
~~nd_vel:
~n=R7
~k=R6
link R14,#0
movem.l R4-R7,-(sp)
~ec=R5
*line 137
move 8(R14),R7
*line 137
move 10(R14),R6
*line 137
move _stccol,R5
move.l _cfetp,R8
move 2(R8),R0
sub R0,R5
*line 138
move R6,R0
add #48,R0
move R5,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 140
*line 141
clr R0
move 10+_v_regs,R0
and #384,R0
beq L18
*line 141
clr (sp)
jsr _vbank
*line 142
L18:
*line 143
move #98,(sp)
move R6,-(sp)
add #48,(sp)
move _stccol,-(sp)
move #5,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 144
jsr _advscur
*line 146
clr R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$33,$64,$0
L15:.dc.b $25,$30,$33,$64,$0
