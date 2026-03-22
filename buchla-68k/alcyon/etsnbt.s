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
.globl _obj8
.globl _clkrun
.globl _insmode
.globl _stccol
.globl _t_cur
.globl _et_snbt
.text
_et_snbt:
~~et_snbt:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~curfr=R7
~beat=R6
*line 42
*line 42
tst _clkrun
beq L2
*line 43
*line 44
clr _ebflag
*line 45
move #-1,R0
bra L1
*line 46
*line 47
L2:
*line 48
move.l _t_cur,R7
*line 49
move.l #$30,-(sp)
move.l R7,-(sp)
jsr ldiv
addq.l #8,sp
move.l R0,R6
*line 51
move.l R6,(sp)
move.l #L3,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 52
move #1,_ebflag
*line 54
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ef_snbt
.text
_ef_snbt:
~~ef_snbt:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~ival=R7
~i=R6
*line 70
*line 71
tst _clkrun
beq L5
*line 71
move #-1,R0
bra L4
*line 72
L5:
*line 73
clr.l R7
*line 75
clr R6
bra L8
L9:
*line 76
move.l #$a,-(sp)
move.l R7,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R7
move.l #_ebuf,R8
move.b 0(R8,R6),R0
ext.w R0
add #-48,R0
ext.l R0
add.l R0,R7
L7:
*line 75
add #1,R6
L8:
*line 75
cmp #5,R6
blt L9
L6:
*line 78
clr _ebflag
*line 80
*line 80
tst _insmode
beq L10
*line 81
*line 82
jsr _icancel
*line 83
jsr _dsimode
*line 84
*line 85
L10:
*line 86
move.l #$30,-(sp)
move.l R7,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,_fc_val
move.l R0,(sp)
jsr _sc_goto
*line 87
clr R0
bra L4
L4:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_snbt
.text
_rd_snbt:
~~rd_snbt:
~n=8
link R14,#-8
movem.l R5-R7,-(sp)
~curfr=R7
~beat=R6
~buf=-8
*line 106
move.l _t_cur,R7
*line 107
move.l #$30,-(sp)
move.l R7,-(sp)
jsr ldiv
addq.l #8,sp
move.l R0,R6
*line 108
move.l R6,(sp)
move.l #L12,-(sp)
move.l R14,-(sp)
sub.l #8,(sp)
jsr _sprintf
addq.l #8,sp
*line 110
*line 111
clr R0
move 10+_v_regs,R0
and #384,R0
beq L13
*line 111
clr (sp)
jsr _vbank
*line 112
L13:
*line 113
move #19,(sp)
move.l R14,-(sp)
sub.l #8,(sp)
move #11,-(sp)
clr -(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 115
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_snbt
.text
_nd_snbt:
~~nd_snbt:
~n=R7
~k=R6
link R14,#0
movem.l R4-R7,-(sp)
~ec=R5
*line 133
move 8(R14),R7
*line 133
move 10(R14),R6
*line 133
*line 134
tst _clkrun
beq L15
*line 134
move #-1,R0
bra L14
*line 135
L15:
*line 136
move _stccol,R5
move.l _cfetp,R8
move 2(R8),R0
sub R0,R5
*line 137
move R6,R0
add #48,R0
move R5,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 139
*line 140
clr R0
move 10+_v_regs,R0
and #384,R0
beq L16
*line 140
clr (sp)
jsr _vbank
*line 141
L16:
*line 142
move #99,(sp)
move R6,-(sp)
add #48,(sp)
move _stccol,-(sp)
clr -(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 143
jsr _advscur
*line 145
clr R0
bra L14
L14:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L3:.dc.b $25,$30,$35,$6C,$64,$0
L12:.dc.b $25,$30,$35,$6C,$64,$0
