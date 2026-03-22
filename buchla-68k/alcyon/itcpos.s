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
.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _stcrow
.globl _stccol
.globl _obj0
.data
L1:.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $FFFF
.dc.w $FFFF
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.text
.globl _itcini
.text
_itcini:
~~itcini:
~color=8
link R14,#-4
*line 64
*line 65
clr R0
move 10+_v_regs,R0
and #384,R0
cmp #256,R0
beq L3
*line 65
move #1,(sp)
jsr _vbank
*line 66
L3:
*line 67
move #64,(sp)
move 8(R14),-(sp)
jsr _exp_c
addq.l #2,sp
move R0,-(sp)
move.l #L1,-(sp)
move.l #_v_cur,-(sp)
jsr _andcopy
adda.l #10,sp
L2:unlk R14
rts
.globl _itcpos
.text
_itcpos:
~~itcpos:
~row=R7
~col=R6
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~yrow=R5
~xcol=R4
~op=R13
*line 85
move 8(R14),R7
*line 85
move 10(R14),R6
*line 85
*line 86
clr R0
move 10+_v_regs,R0
and #384,R0
beq L5
*line 86
clr (sp)
jsr _vbank
*line 87
L5:
*line 88
move R7,R5
muls #14,R5
*line 89
move R6,R4
asl #3,R4
*line 91
move.l #_v_obtab,R13
*line 92
move #1,(sp)
jsr _setipl
*line 93
and #-17,120+_v_odtab
*line 94
move #15,(sp)
jsr _objclr
*line 96
move R4,4(R13)
*line 97
move R5,6(R13)
*line 98
move.l #_v_cur,8(R13)
*line 99
move R4,R0
asr #1,R0
and #1023,R0
or #1024,R0
move R0,16(R13)
*line 101
move #15,(sp)
clr -(sp)
jsr _SetPri
addq.l #2,sp
*line 103
move R7,_stcrow
*line 104
move R6,_stccol
L4:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _advicur
.text
_advicur:
~~advicur:
link R14,#0
movem.l R6-R7,-(sp)
~newcol=R7
*line 120
*line 121
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L7
*line 121
move.l _infetp,_cfetp
*line 122
bra L8
L7:bra L6
L8:
*line 125
move _stccol,R7
add #1,R7
*line 127
*line 128
move.l _cfetp,R8
cmp 4(R8),R7
bgt L9
*line 128
move R7,(sp)
move _stcrow,-(sp)
jsr _itcpos
addq.l #2,sp
L9:L6:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _bspicur
.text
_bspicur:
~~bspicur:
link R14,#0
movem.l R6-R7,-(sp)
~newcol=R7
*line 141
*line 142
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L11
*line 142
move.l _infetp,_cfetp
*line 143
bra L12
L11:bra L10
L12:
*line 146
move _stccol,R7
sub #1,R7
*line 148
*line 149
move.l _cfetp,R8
cmp 2(R8),R7
blt L13
*line 149
move R7,(sp)
move _stcrow,-(sp)
jsr _itcpos
addq.l #2,sp
L13:L10:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
