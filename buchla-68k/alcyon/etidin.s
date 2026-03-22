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
.globl _vtcrow
.globl _vtccol
.globl _stccol
.globl _curinst
.globl _curvce
.globl _idcfsw
.globl _idintmp
.globl _editsw
.globl _curfunc
.globl _submenu
.globl _idbox
.globl _instmod
.globl _vce2grp
.globl _dspbuf
.globl _idefs
.globl _vbufs
.globl _et_idin
.text
_et_idin:
~~et_idin:
~n=8
link R14,#-4
*line 47
move _curinst,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 48
move #1,_ebflag
*line 50
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_idin
.text
_ef_idin:
~~ef_idin:
~n=8
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~i=R7
~tmpval=R6
~j=R5
~ip=R13
*line 67
*line 67
tst _idcfsw
beq L4
*line 68
*line 69
*line 69
cmp #22,_vtcrow
bne L5
*line 70
*line 71
*line 71
cmp #35,_vtccol
bge L6
*line 72
*line 73
move _idintmp,(sp)
jsr _newinst
*line 74
move #1,(sp)
move _curinst,-(sp)
move _curvce,-(sp)
jsr _execins
addq.l #4,sp
*line 75
*line 76
*line 76
tst _editsw
bne L7
*line 77
*line 78
*line 78
move _curvce,R8
add.l R8,R8
add.l #_vce2grp,R8
move (R8),R7
ble L8
*line 79
*line 80
clr R5
bra L11
L12:
*line 81
*line 82
move R5,R8
add.l R8,R8
add.l #_vce2grp,R8
cmp (R8),R7
bne L13
*line 82
move #1,(sp)
move _curinst,-(sp)
move R5,-(sp)
jsr _execins
addq.l #4,sp
L13:L10:
*line 80
add #1,R5
L11:
*line 80
cmp #12,R5
blt L12
L9:
*line 83
L8:
*line 84
L7:
*line 85
*line 86
L6:
*line 87
move #14,(sp)
jsr _objclr
*line 88
jsr _idvlblc
*line 89
clr _idcfsw
*line 90
clr _submenu
*line 91
*line 92
*line 92
cmp #35,_vtccol
bge L14
*line 93
*line 94
jsr _allwins
*line 95
bra L15
L14:
*line 96
*line 97
*line 98
move #22,(sp)
jsr _dswin
*line 99
move #19,(sp)
jsr _dswin
L15:
*line 100
*line 101
*line 102
bra L16
L5:
*line 103
*line 103
cmp #23,_vtcrow
bne L17
*line 104
*line 105
*line 105
tst _idintmp
beq L18
*line 106
*line 107
*line 108
move #1969,(sp)
move _curvce,R0
muls #3938,R0
add.l #_vbufs,R0
move.l R0,-(sp)
move _idintmp,R0
muls #3938,R0
add.l #_idefs,R0
move.l R0,-(sp)
jsr _memcpyw
addq.l #8,sp
*line 109
*line 110
move _idintmp,_curinst
*line 111
move _curvce,R8
add.l R8,R8
add.l #_instmod,R8
clr (R8)
*line 112
*line 113
L18:
*line 114
move #14,(sp)
jsr _objclr
*line 115
jsr _idvlblc
*line 116
clr _idcfsw
*line 117
clr _submenu
*line 118
move #22,(sp)
jsr _dswin
*line 119
move #19,(sp)
jsr _dswin
*line 120
*line 121
*line 122
tst _idintmp
bne L19
*line 122
move #-1,R0
bra L3
*line 123
L19:
*line 124
bra L20
L17:
*line 125
move #-1,R0
bra L3
L20:L16:
*line 126
*line 127
clr R0
bra L3
*line 128
*line 129
bra L21
L4:
*line 130
*line 131
*line 132
clr.b 2+_ebuf
*line 133
clr _ebflag
*line 134
*line 135
clr R6
*line 136
*line 137
clr R7
bra L24
L25:
*line 138
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L23:
*line 137
add #1,R7
L24:
*line 137
cmp #2,R7
blt L25
L22:
*line 138
*line 139
*line 140
*line 141
cmp #41,R6
blt L26
*line 141
move #-1,R0
bra L3
*line 142
L26:
*line 143
move R6,_idintmp
*line 144
jsr _idcpfch
*line 145
move #22,(sp)
jsr _dswin
*line 146
move #14,(sp)
move #2,-(sp)
jsr _SetPri
addq.l #2,sp
*line 147
move #17,(sp)
move #22,-(sp)
jsr _ttcpos
addq.l #2,sp
*line 148
move #1,_idcfsw
*line 149
move #1,_submenu
*line 150
clr R0
bra L3
L21:L3:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl _rd_idin
.text
_rd_idin:
~~rd_idin:
~n=8
link R14,#-4
*line 167
*line 168
tst _idcfsw
beq L28
*line 168
move #-1,R0
bra L27
*line 169
*line 170
*line 171
L28:
*line 172
move _curinst,(sp)
move.l #L29,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 174
clr (sp)
jsr _vbank
*line 176
*line 177
move #14,(sp)
move.l #_dspbuf,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 14(R8,R9.l),-(sp)
add #14,(sp)
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
move _curvce,R8
add.l R8,R8
move.l #_instmod,R9
tst 0(R8,R9.l)
beq L10000
move #3,-(sp)
bra L10002
L10000:move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_idbox,R9
move 8(R8,R9.l),-(sp)
L10002:move #64,-(sp)
move.l _instob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 179
clr R0
bra L27
L27:unlk R14
rts
.globl _nd_idin
.text
_nd_idin:
~~nd_idin:
~k=R7
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~c=R5
*line 198
move 10(R14),R7
*line 198
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 199
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 200
clr.b 2+_ebuf
*line 202
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 203
clr.b 1+_dspbuf
*line 205
clr (sp)
jsr _vbank
*line 207
*line 208
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
*line 210
jsr _advicur
*line 212
clr R0
bra L30
L30:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L29:.dc.b $25,$30,$32,$64,$0
