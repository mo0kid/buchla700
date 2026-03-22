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
.globl _instob
.globl _stccol
.globl _curvce
.globl _idbox
.globl _dspbuf
.globl _vbufs
.globl _et_icnf
.text
_et_icnf:
~~et_icnf:
~n=8
link R14,#-4
*line 43
move _curvce,R0
muls #3938,R0
move.l R0,R8
move.l #_vbufs,R9
move.b 70(R8,R9.l),R0
ext.w R0
move R0,(sp) 
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
.globl _ef_icnf
.text
_ef_icnf:
~~ef_icnf:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 64
clr.b 2+_ebuf
*line 65
clr _ebflag
*line 67
clr R6
*line 69
clr R7
bra L6
L7:
*line 70
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 69
add #1,R7
L6:
*line 69
cmp #2,R7
blt L7
L4:
*line 72
*line 73
cmp #12,R6
blt L8
*line 73
move #-1,R0
bra L3
*line 74
L8:
*line 75
move R6,R0
move _curvce,R1
muls #3938,R1
add.l #_vbufs,R1
move.l R1,R9
move.b R0,70(R9)
*line 76
move _curvce,(sp)
jsr _dosync
*line 77
move R6,(sp)
jsr _showcfg
*line 78
jsr _modinst
*line 79
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_icnf
.text
_rd_icnf:
~~rd_icnf:
~n=8
link R14,#-4
*line 95
move _curvce,R0
muls #3938,R0
move.l R0,R8
move.l #_vbufs,R9
move.b 70(R8,R9.l),R0
ext.w R0
move R0,(sp) 
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 97
*line 98
clr R0
move 10+_v_regs,R0
and #384,R0
beq L11
*line 98
clr (sp)
jsr _vbank
*line 99
L11:
*line 100
*line 101
move #14,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
add #10,(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 10(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 103
clr R0
bra L9
L9:unlk R14
rts
.globl _nd_icnf
.text
_nd_icnf:
~~nd_icnf:
~k=R7
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~c=R5
*line 122
move 10(R14),R7
*line 122
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 123
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 124
clr.b 2+_ebuf
*line 126
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 127
clr.b 1+_dspbuf
*line 129
*line 130
clr R0
move 10+_v_regs,R0
and #384,R0
beq L13
*line 130
clr (sp)
jsr _vbank
*line 131
*line 132
*line 133
L13:
*line 134
*line 135
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 12(R8,R9.l),-(sp)
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
*line 137
jsr _advicur
*line 139
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$64,$0
