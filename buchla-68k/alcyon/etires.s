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
.globl _instob
.globl _stcrow
.globl _stccol
.globl _curvce
.globl _curfunc
.globl _idbox
.globl _dspbuf
.globl _vbufs
.globl _pntptr
.globl _rsntab
.data
_rsntab:
.dc.w $0
.dc.w $DC0
.dc.w $1B80
.dc.w $2940
.dc.w $3700
.dc.w $44C0
.dc.w $5280
.dc.w $6040
.dc.w $6E00
.dc.w $7D00
.globl _et_ires
.text
_et_ires:
~~et_ires:
~n=8
link R14,#-4
*line 59
*line 60
cmp #4,_curfunc
beq L2
*line 60
move #-1,R0
bra L1
*line 61
L2:
*line 62
move _curvce,R0
muls #3938,R0
add.l #_vbufs,R0
move.l R0,R8
move.b 143(R8),R0
ext.w R0
add #48,R0
move.b R0,_ebuf
*line 63
clr.b 1+_ebuf
*line 64
move #1,_ebflag
*line 65
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_ires
.text
_ef_ires:
~~ef_ires:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~tmpval=R7
*line 80
*line 81
cmp #4,_curfunc
beq L4
*line 81
move #-1,R0
bra L3
*line 82
L4:
*line 83
clr.b 1+_ebuf
*line 84
clr _ebflag
*line 85
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 86
move R7,R0
move _curvce,R1
muls #3938,R1
add.l #_vbufs,R1
move.l R1,R9
move.b R0,143(R9)
*line 87
move R7,R8
add.l R8,R8
move.l #_rsntab,R9
move 0(R8,R9.l),(sp)
move #6,-(sp)
move _curvce,-(sp)
jsr _sendval
addq.l #4,sp
*line 88
jsr _modinst
*line 89
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_ires
.text
_rd_ires:
~~rd_ires:
~n=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~fp=R13
*line 107
move _curvce,R0
muls #3938,R0
move.l R0,R13
add.l #_vbufs,R13
add.l #134,R13
*line 109
*line 110
cmp #4,_curfunc
beq L6
*line 110
move #-1,R0
bra L5
*line 111
L6:
*line 112
move.b 9(R13),R0
ext.w R0
add #48,R0
move.b R0,_dspbuf
*line 113
clr.b 1+_dspbuf
*line 115
*line 116
clr R0
move 10+_v_regs,R0
and #384,R0
beq L7
*line 116
clr (sp)
jsr _vbank
*line 117
L7:
*line 118
*line 119
move #14,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
add #8,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
btst #0,7(R13)
beq L10000
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 8(R8,R9.l),-(sp)
bra L10002
L10000:move #2,-(sp)
L10002:move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 121
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _nd_ires
.text
_nd_ires:
~~nd_ires:
~k=R7
~n=8
link R14,#0
movem.l R6-R7,-(sp)
*line 138
move 10(R14),R7
*line 138
*line 139
cmp #4,_curfunc
beq L9
*line 139
move #-1,R0
bra L8
*line 140
L9:
*line 141
move R7,R0
add #48,R0
move.b R0,_ebuf
move.b R0,_dspbuf
*line 142
clr R0
move.b R0,1+_ebuf
move.b R0,1+_dspbuf
*line 144
*line 145
clr R0
move 10+_v_regs,R0
and #384,R0
beq L10
*line 145
clr (sp)
jsr _vbank
*line 146
L10:
*line 147
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move #10,-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 148
clr R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
