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
.globl _point
.globl _asgob
.globl _asgmod
.globl _curasg
.globl _stccol
.globl _stcrow
.globl _adbox
.globl _dspbuf
.globl _et_atab
.text
_et_atab:
~~et_atab:
~n=8
link R14,#-4
*line 46
move _curasg,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 47
move #1,_ebflag
*line 49
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_atab
.text
_ef_atab:
~~ef_atab:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 64
clr.b 2+_ebuf
*line 65
clr _ebflag
*line 66
clr R6
*line 68
clr R7
bra L6
L7:
*line 69
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 68
add #1,R7
L6:
*line 68
cmp #2,R7
blt L7
L4:
*line 71
*line 72
cmp #100,R6
blt L8
*line 72
move #-1,R0
bra L3
*line 73
L8:
*line 74
move R6,_curasg
*line 75
move #1,_asgmod
*line 76
clr (sp)
jsr _adswin
*line 78
move #6,(sp)
move #2,-(sp)
jsr _settc
addq.l #2,sp
*line 80
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_atab
.text
_rd_atab:
~~rd_atab:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 98
move 8(R14),R7
and #255,R7
*line 99
move _curasg,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 101
move.l #_adpoint,_point
*line 103
*line 104
clr R0
move 10+_v_regs,R0
and #384,R0
beq L11
*line 104
clr (sp)
jsr _vbank
*line 105
L11:
*line 106
*line 107
move #14,(sp)
move.l #_dspbuf,-(sp)
move.l _cfetp,R8
move 2(R8),-(sp)
move.l _cfetp,R8
move (R8),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 10(R8,R9.l),-(sp)
tst _asgmod
beq L10000
move #13,-(sp)
jsr _exp_c
addq.l #2,sp
move R0,-(sp)
bra L10002
L10000:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 8(R8,R9.l),-(sp)
L10002:move #64,-(sp)
move.l _asgob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 109
move #10,(sp)
clr -(sp)
move #128,-(sp)
clr -(sp)
clr -(sp)
jsr _lseg
addq.l #8,sp
*line 111
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_atab
.text
_nd_atab:
~~nd_atab:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 127
move 10(R14),R7
*line 127
move 8(R14),R5
and #255,R5
*line 128
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 130
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 131
clr.b 2+_ebuf
*line 133
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 134
clr.b 1+_dspbuf
*line 136
move.l #_adpoint,_point
*line 138
*line 139
clr R0
move 10+_v_regs,R0
and #384,R0
beq L13
*line 139
clr (sp)
jsr _vbank
*line 140
L13:
*line 141
*line 142
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 10(R8,R9.l),-(sp)
move #12,-(sp)
move #64,-(sp)
move.l _asgob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 144
move #10,(sp)
clr -(sp)
move #128,-(sp)
clr -(sp)
clr -(sp)
jsr _lseg
addq.l #8,sp
*line 146
jsr _advacur
*line 147
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$2E,$32,$64,$0
