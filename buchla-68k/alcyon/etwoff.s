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
.globl _waveob
.globl _stcrow
.globl _stccol
.globl _lstwoff
.globl _curwoff
.globl _curvce
.globl _curwslt
.globl _curwdth
.globl _wsnmod
.globl _wdbox
.globl _dspbuf
.globl _et_woff
.text
_et_woff:
~~et_woff:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~hoff=R7
~hosgn=R6
*line 48
move _curwoff,_lstwoff
*line 50
*line 50
tst _curwoff
bge L2
*line 51
*line 52
move.b #45,R6
*line 53
move _curwoff,R0
neg R0
move R0,R7
*line 54
bra L3
L2:
*line 55
*line 56
*line 57
move.b #43,R6
*line 58
move _curwoff,R7
L3:
*line 61
move R7,(sp)
move.b R6,R0
ext.w R0
move R0,-(sp) 
move.l #L4,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 62
move #1,_ebflag
*line 64
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ef_woff
.text
_ef_woff:
~~ef_woff:
~n=8
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~ov=R13
~i=R7
~tmpval=R6
*line 83
clr.b 5+_ebuf
*line 84
clr _ebflag
*line 86
clr R6
*line 88
move #1,R7
bra L8
L9:
*line 89
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L7:
*line 88
add #1,R7
L8:
*line 88
cmp #5,R7
blt L9
L6:
*line 91
*line 92
cmp #1023,R6
ble L10
*line 92
move #-1,R0
bra L5
*line 93
L10:
*line 94
*line 95
cmp.b #45,_ebuf
bne L11
*line 95
move R6,R0
neg R0
move R0,_curwoff
*line 96
bra L12
L11:
*line 97
move R6,_curwoff
L12:
*line 99
*line 100
cmp #8,_curwdth
bne L13
*line 100
jsr _wdintp
*line 101
bra L14
L13:
*line 102
jsr _pntsup
L14:
*line 104
clr (sp)
jsr _wdswin
*line 105
move #2,(sp)
jsr _wdswin
*line 106
move #4,(sp)
jsr _wdswin
*line 107
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _rd_woff
.text
_rd_woff:
~~rd_woff:
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~hoff=R7
~n=R6
~hosgn=R5
*line 126
move 8(R14),R6
and #255,R6
*line 127
move _curwoff,_lstwoff
*line 129
*line 129
tst _curwoff
bge L16
*line 130
*line 131
move.b #45,R5
*line 132
move _curwoff,R0
neg R0
move R0,R7
*line 133
bra L17
L16:
*line 134
*line 135
*line 136
move.b #43,R5
*line 137
move _curwoff,R7
L17:
*line 140
move R7,(sp)
move.b R5,R0
ext.w R0
move R0,-(sp) 
move.l #L18,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 144
*line 145
clr R0
move 10+_v_regs,R0
and #384,R0
beq L19
*line 145
clr (sp)
jsr _vbank
*line 146
L19:
*line 147
*line 148
move #14,(sp)
move.l #_dspbuf,-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 14(R8,R9.l),-(sp)
add #14,(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 12(R8,R9.l),-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 10(R8,R9.l),-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _waveob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 150
clr R0
bra L15
L15:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _nd_woff
.text
_nd_woff:
~~nd_woff:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 169
move 10(R14),R7
*line 169
move 8(R14),R5
and #255,R5
*line 170
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 172
*line 172
tst R6
bne L21
*line 173
*line 174
*line 174
cmp #8,R7
bne L22
*line 175
*line 176
move.b #45,_ebuf
*line 177
clr.b 5+_ebuf
*line 178
*line 179
move.b #45,_dspbuf
*line 180
clr.b 1+_dspbuf
*line 181
bra L23
L22:
*line 182
*line 182
cmp #9,R7
bne L24
*line 183
*line 184
move.b #43,_ebuf
*line 185
clr.b 5+_ebuf
*line 186
*line 187
move.b #43,_dspbuf
*line 188
clr.b 1+_dspbuf
*line 189
bra L25
L24:
*line 190
*line 191
*line 192
move #-1,R0
bra L20
L25:L23:
*line 193
*line 194
bra L26
L21:
*line 195
*line 196
*line 197
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 198
clr.b 5+_ebuf
*line 199
*line 200
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 201
clr.b 1+_dspbuf
L26:
*line 205
*line 206
clr R0
move 10+_v_regs,R0
and #384,R0
beq L27
*line 206
clr (sp)
jsr _vbank
*line 207
L27:
*line 208
*line 209
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 10(R8,R9.l),-(sp)
move #12,-(sp)
move #64,-(sp)
move.l _waveob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 211
jsr _advwcur
*line 212
clr R0
bra L20
L20:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L4:.dc.b $25,$63,$25,$30,$34,$64,$0
L18:.dc.b $25,$63,$25,$30,$34,$64,$0
