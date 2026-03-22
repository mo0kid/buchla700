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
.globl _curscor
.globl _insmode
.globl _stccol
.globl _dspbuf
.globl _et_scor
.text
_et_scor:
~~et_scor:
link R14,#-4
*line 36
move _curscor,(sp)
add #1,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 37
move #1,_ebflag
*line 39
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_scor
.text
_ef_scor:
~~ef_scor:
link R14,#0
movem.l R6-R7,-(sp)
~ival=R7
*line 56
clr.b 2+_ebuf
*line 57
move.b _ebuf,R7
ext.w R7
add #-48,R7
muls #10,R7
move.b 1+_ebuf,R0
ext.w R0
add R0,R7
add #-48,R7
*line 59
clr _ebflag
*line 61
*line 62
cmp #20,R7
bgt L10000
tst R7
bne L4
L10000:*line 62
move #-1,R0
bra L3
*line 63
L4:
*line 64
*line 64
tst _insmode
beq L5
*line 65
*line 66
jsr _icancel
*line 67
jsr _dsimode
*line 68
*line 69
L5:
*line 70
move R7,(sp)
sub #1,(sp)
jsr _selscor
*line 71
jsr _sdwins
*line 72
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_scor
.text
_rd_scor:
~~rd_scor:
link R14,#-4
*line 84
move _curscor,(sp)
add #1,(sp)
move.l #L7,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 86
*line 87
clr R0
move 10+_v_regs,R0
and #384,R0
beq L8
*line 87
clr (sp)
jsr _vbank
*line 88
L8:
*line 89
move #19,(sp)
move.l #_dspbuf,-(sp)
move #7,-(sp)
move #8,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 91
clr R0
bra L6
L6:unlk R14
rts
.globl _nd_scor
.text
_nd_scor:
~~nd_scor:
~n=8
~k=10
link R14,#0
movem.l R6-R7,-(sp)
~ec=R7
*line 109
move _stccol,R7
move.l _cfetp,R8
move 2(R8),R0
sub R0,R7
*line 110
move 10(R14),R0
add #48,R0
move R7,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 112
*line 113
clr R0
move 10+_v_regs,R0
and #384,R0
beq L10
*line 113
clr (sp)
jsr _vbank
*line 114
L10:
*line 115
move #99,(sp)
move 10(R14),-(sp)
add #48,(sp)
move _stccol,-(sp)
move #8,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 116
jsr _advscur
*line 118
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$2E,$32,$64,$0
L7:.dc.b $25,$30,$32,$2E,$32,$64,$0
