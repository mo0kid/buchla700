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
.globl _eqgaint
.data
_eqgaint:
.dc.b $0
.dc.b $20
.dc.b $10
.dc.b $8
.dc.b $4
.dc.b $2
.dc.b $12
.dc.b $2A
.dc.b $16
.dc.b $1
.dc.b $29
.dc.b $2D
.dc.b $2F
.even
.globl _puteq
.text
_puteq:
~~puteq:
~byte=R7
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~i=R6
~psg=R13
~eqdata=R5
*line 81
move.b 9(R14),R7
*line 81
move.l #_io_tone,R13
*line 83
move.b #7,(R13)
*line 84
move.b #191,2(R13)
*line 86
move.b #15,(R13)
*line 87
move.b (R13),R5
and.b #-29,R5
or.b #20,R5
*line 89
clr R6
bra L4
L5:
*line 90
*line 91
*line 92
btst #0,R7
beq L6
*line 92
or.b #8,R5
*line 93
bra L7
L6:
*line 94
and.b #-9,R5
L7:
*line 95
*line 96
and.b #-17,R5
*line 97
*line 98
move.b #15,(R13)
*line 99
move.b R5,2(R13)
*line 100
*line 101
or.b #16,R5
*line 102
*line 103
move.b #15,(R13)
*line 104
move.b R5,2(R13)
*line 105
*line 106
asr.b #1,R7
L3:
*line 89
add #1,R6
L4:
*line 89
cmp #8,R6
blt L5
L2:
*line 109
and.b #-5,R5
*line 111
move.b #15,(R13)
*line 112
move.b R5,2(R13)
*line 114
or.b #4,R5
*line 116
move.b #15,(R13)
*line 117
move.b R5,2(R13)
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _sendeq
.text
_sendeq:
~~sendeq:
~band=9
~gain=11
link R14,#-4
*line 126
move.b 9(R14),R0
ext.w R0
move R0,(sp) 
jsr _puteq
*line 127
move.b 11(R14),R0
ext.w R0
move R0,(sp) 
jsr _puteq
L8:unlk R14
rts
.globl _gain2eq
.text
_gain2eq:
~~gain2eq:
~gain=8
link R14,#0
movem.l R6-R7,-(sp)
~eqdat=R7
*line 136
*line 137
tst 8(R14)
ble L10
*line 137
move.l #_eqgaint,R8
move 8(R14),R9
add.l R9,R8
move.b (R8),R7
or.b #64,R7
*line 138
bra L11
L10:
*line 139
move 8(R14),R0
neg R0
ext.l R0
add.l #_eqgaint,R0
move.l R0,R8
move.b (R8),R7
L11:
*line 141
move.b R7,R0
ext.w R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
