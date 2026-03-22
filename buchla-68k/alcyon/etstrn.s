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
.globl _grptran
.globl _sdmctl
.globl _vtccol
.globl _vtcrow
.globl _vtxval
.globl _vtyval
.globl _dspbuf
.globl _et_strn
.text
_et_strn:
~~et_strn:
link R14,#-4
*line 40
tst _grptran
bge L10000
move _grptran,R0
neg R0
move R0,(sp)
bra L10002
L10000:move _grptran,(sp)
L10002:tst _grptran
bge L10003
move #45,-(sp)
bra L10005
L10003:move #43,-(sp)
L10005:move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 42
move #1,_ebflag
*line 44
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_strn
.text
_ef_strn:
~~ef_strn:
link R14,#0
movem.l R6-R7,-(sp)
~ival=R7
*line 61
clr.b 3+_ebuf
*line 62
move.b 1+_ebuf,R7
ext.w R7
add #-48,R7
muls #10,R7
move.b 2+_ebuf,R0
ext.w R0
add R0,R7
add #-48,R7
*line 64
clr _ebflag
*line 66
*line 67
tst R7
beq L4
cmp.b #45,_ebuf
bne L4
*line 67
move R7,R0
neg R0
move R0,R7
*line 68
L4:
*line 69
move R7,_grptran
*line 71
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _rd_strn
.text
_rd_strn:
~~rd_strn:
link R14,#-4
*line 83
tst _grptran
bge L10006
move _grptran,R0
neg R0
move R0,(sp)
bra L10008
L10006:move _grptran,(sp)
L10008:tst _grptran
bge L10009
move #45,-(sp)
bra L10011
L10009:move #43,-(sp)
L10011:move.l #L6,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 85
*line 86
clr R0
move 10+_v_regs,R0
and #384,R0
beq L7
*line 86
clr (sp)
jsr _vbank
*line 87
L7:
*line 88
move #20,(sp)
move.l #_dspbuf,-(sp)
move #22,-(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputs
adda.l #12,sp
*line 90
clr R0
bra L5
L5:unlk R14
rts
.globl _nd_strn
.text
_nd_strn:
~~nd_strn:
~n=8
~k=10
link R14,#0
movem.l R6-R7,-(sp)
~ec=R7
*line 108
*line 109
cmp #4,_sdmctl
beq L9
*line 109
move #-1,R0
bra L8
*line 110
L9:
*line 111
*line 112
cmp #22,_vtccol
blt L10
cmp #24,_vtccol
bgt L10
*line 112
move _vtccol,R7
add #-22,R7
*line 113
bra L11
L10:
*line 114
move #-1,R0
bra L8
L11:
*line 116
*line 116
tst R7
bne L12
*line 117
*line 118
*line 119
cmp #8,10(R14)
bne L13
*line 119
move #45,10(R14)
bra L14
L13:
*line 120
*line 121
cmp #9,10(R14)
bne L15
*line 121
move #43,10(R14)
*line 122
bra L16
L15:
*line 123
move #-1,R0
bra L8
L16:L14:
*line 124
bra L17
L12:
*line 125
add #48,10(R14)
L17:
*line 127
move 10(R14),R0
move R7,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 129
*line 130
clr R0
move 10+_v_regs,R0
and #384,R0
beq L18
*line 130
clr (sp)
jsr _vbank
*line 131
L18:
*line 132
move #100,(sp)
move 10(R14),-(sp)
move _vtccol,-(sp)
move #7,-(sp)
move.l _obj8,-(sp)
jsr _vputc
adda.l #10,sp
*line 134
*line 134
cmp #24,_vtccol
bge L19
*line 135
*line 136
add #1,_vtccol
*line 137
move _vtccol,R0
asl #3,R0
move R0,_vtxval
*line 138
move _vtccol,(sp)
move _vtcrow,-(sp)
jsr _ttcpos
addq.l #2,sp
*line 139
*line 140
L19:
*line 141
clr R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
L2:.dc.b $25,$63,$25,$30,$32,$64,$0
L6:.dc.b $25,$63,$25,$30,$32,$64,$0
