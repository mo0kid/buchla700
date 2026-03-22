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
.globl _asgob
.globl _curintp
.globl _stccol
.globl _stcrow
.globl _timemlt
.globl _dspbuf
.globl _vce2grp
.globl _grpdyn
.globl _dyntab
.globl _expbit
.globl _adbox
.globl _vbufs
.globl _et_adyn
.text
_et_adyn:
~~et_adyn:
~n=8
link R14,#0
movem.l R6-R7,-(sp)
~grp=R7
*line 57
move 8(R14),R7
asr #8,R7
and #255,R7
*line 59
move R7,R8
add.l R8,R8
move.l #_grpdyn,R9
move 0(R8,R9.l),R0
add #48,R0
move.b R0,_ebuf
*line 60
clr.b 1+_ebuf
*line 62
move #1,_ebflag
*line 64
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _setdyn
.text
_setdyn:
~~setdyn:
~grp=8
~dyn=10
link R14,#-8
movem.l R3-R7/R12-R13,-(sp)
~g=R7
~i=R6
~val=R5
~ltmp=R4
~fpu=R13
~fp=R12
~fpmant=-2
~fpexp=-4
~oldsr=-6
~nop=-8
*line 87
move 8(R14),R8
add.l R8,R8
add.l #_grpdyn,R8
move 10(R14),(R8)
*line 88
move 10(R14),R8
add.l R8,R8
add.l #_dyntab,R8
move (R8),R5
*line 89
move 8(R14),R7
add #1,R7
*line 91
*line 92
move _timemlt,R0
ext.l R0
and.l #$ffff,R0
move.l R0,-(sp)
clr.l R0
move _curintp,R0
and.l #$fff0,R0
move.l R0,-(sp)
jsr lmul
addq.l #8,sp
move.l #$f,R1
asr.l R1,R0
move R0,-2(R14)
*line 94
clr R0
move _curintp,R0
and #15,R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l #_expbit,R0
move.l R0,R8
move (R8),-4(R14)
*line 98
clr R6
bra L5
L6:
*line 99
*line 99
move R6,R8
add.l R8,R8
add.l #_vce2grp,R8
cmp (R8),R7
bne L7
*line 100
*line 101
move R6,R0
muls #3938,R0
move.l R0,R12
add.l #_vbufs,R12
add.l #182,R12
*line 102
move R6,R0
asl #8,R0
asl #1,R0
ext.l R0
move.l R0,R13
add.l #_io_fpu,R13
add.l #$4100,R13
*line 103
*line 104
move #8704,(sp)
jsr _setsr
move R0,-6(R14)
*line 105
*line 106
*line 107
*line 108
eor.b #24,7(R12)
*line 109
move.l R13,R8
add.l #$14,R8
move -2(R14),(R8)
*line 110
add #1,-8(R14)
*line 110
add #1,-8(R14)
*line 110
add #1,-8(R14)
*line 111
move.l R13,R8
add.l #$16,R8
move -4(R14),(R8)
*line 112
add #1,-8(R14)
*line 112
add #1,-8(R14)
*line 112
add #1,-8(R14)
*line 113
*line 114
*line 115
btst #3,7(R12)
beq L8
*line 115
move.l R13,R8
add.l #$1c,R8
move R5,(R8)
*line 116
bra L9
L8:
*line 117
move.l R13,R8
add.l #$2,R8
move R5,(R8)
L9:
*line 118
*line 119
add #1,-8(R14)
*line 119
add #1,-8(R14)
*line 119
add #1,-8(R14)
*line 120
*line 121
*line 122
move.b 7(R12),R0
ext.w R0
and #28,R0
or #1,R0
move R0,(R13)
*line 123
*line 124
move -6(R14),(sp)
jsr _setsr
*line 125
*line 126
*line 127
*line 128
L7:L4:
*line 98
add #1,R6
L5:
*line 98
cmp #12,R6
blt L6
L3:L2:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.globl _ef_adyn
.text
_ef_adyn:
~~ef_adyn:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~dyn=R7
~grp=R6
*line 146
move 8(R14),R6
asr #8,R6
and #255,R6
*line 148
clr.b 1+_ebuf
*line 149
clr _ebflag
*line 151
move.b _ebuf,R7
ext.w R7
add #-48,R7
*line 153
move R7,(sp)
move R6,-(sp)
jsr _setdyn
addq.l #2,sp
*line 154
jsr _modasg
*line 155
clr R0
bra L10
L10:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_adyn
.text
_rd_adyn:
~~rd_adyn:
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R7
~grp=R6
*line 173
move 8(R14),R7
and #255,R7
*line 174
move 8(R14),R6
asr #8,R6
and #255,R6
*line 176
move R6,R8
add.l R8,R8
move.l #_grpdyn,R9
move 0(R8,R9.l),R0
add #48,R0
move.b R0,_dspbuf
*line 177
clr.b 1+_dspbuf
*line 179
clr (sp)
jsr _vbank
*line 180
*line 181
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
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _asgob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 183
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_adyn
.text
_nd_adyn:
~~nd_adyn:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 199
move 10(R14),R7
*line 199
move 8(R14),R6
and #255,R6
*line 201
move R7,R0
add #48,R0
move.b R0,_ebuf
move.b R0,_dspbuf
*line 202
clr R0
move.b R0,1+_ebuf
move.b R0,1+_dspbuf
*line 204
clr (sp)
jsr _vbank
*line 205
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R6,R0
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
*line 207
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
