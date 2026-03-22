.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _waveob
.globl _stcrow
.globl _stccol
.globl _curwhrv
.globl _curvce
.globl _curwslt
.globl _curwhrm
.globl _wdbox
.globl _dspbuf
.globl _vbufs
.globl _wsnmod
.globl _vmtab
.globl _et_whrv
.text
_et_whrv:
~~et_whrv:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~harv=R7
~hvsgn=R6
*line 51
*line 51
tst _curwhrv
bge L2
*line 52
*line 53
move.b #45,R6
*line 54
move _curwhrv,R0
neg R0
move R0,R7
*line 55
bra L3
L2:
*line 56
*line 57
*line 58
move.b #43,R6
*line 59
move _curwhrv,R7
L3:
*line 62
move R7,(sp)
move.b R6,R0
ext.w R0
move R0,-(sp) 
move.l #L4,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 63
move #1,_ebflag
*line 65
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ef_whrv
.text
_ef_whrv:
~~ef_whrv:
~n=8
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~hv=R13
~i=R7
~tmpval=R6
*line 84
clr.b 4+_ebuf
*line 85
clr _ebflag
*line 87
clr R6
*line 89
move #1,R7
bra L8
L9:
*line 90
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L7:
*line 89
add #1,R7
L8:
*line 89
cmp #4,R7
blt L9
L6:
*line 92
*line 93
cmp #100,R6
ble L10
*line 93
move #-1,R0
bra L5
*line 94
L10:
*line 95
*line 96
cmp.b #45,_ebuf
bne L11
*line 96
move R6,R0
neg R0
move R0,_curwhrv
*line 97
bra L12
L11:
*line 98
move R6,_curwhrv
L12:
*line 100
tst _curwslt
beq L10000
move _curvce,R0
muls #3938,R0
add.l #_vbufs,R0
add.l #3874,R0
bra L10002
L10000:move _curvce,R0
muls #3938,R0
add.l #_vbufs,R0
add.l #2794,R0
L10002:move.l R0,R13
*line 101
move.l R13,R8
move _curwhrm,R9
add.l R9,R9
add.l R9,R8
move _curwhrv,(R8)
*line 102
move _curwhrm,R8
add.l R8,R8
add.l #_vmtab,R8
move _curwhrv,(R8)
*line 103
move _curwhrm,(sp)
jsr _adj
*line 104
jsr _wscalc
*line 105
jsr _whupd
*line 106
move _curvce,R8
add.l R8,R8
add.l R8,R8
move _curwslt,R9
add.l R9,R9
add.l R9,R8
add.l #_wsnmod,R8
move #1,(R8)
*line 107
clr (sp)
jsr _wdswin
*line 108
move #2,(sp)
jsr _wdswin
*line 109
move #4,(sp)
jsr _wdswin
*line 110
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _rd_whrv
.text
_rd_whrv:
~~rd_whrv:
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~harv=R7
~n=R6
~hvsgn=R5
*line 129
move 8(R14),R6
and #255,R6
*line 131
*line 131
tst _curwhrv
bge L14
*line 132
*line 133
move.b #45,R5
*line 134
move _curwhrv,R0
neg R0
move R0,R7
*line 135
bra L15
L14:
*line 136
*line 137
*line 138
move.b #43,R5
*line 139
move _curwhrv,R7
L15:
*line 142
move R7,(sp)
move.b R5,R0
ext.w R0
move R0,-(sp) 
move.l #L16,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 144
clr (sp)
jsr _vbank
*line 145
*line 146
move #14,(sp)
move.l #_dspbuf,-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 14(R8,R9.l),-(sp)
add #6,(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
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
*line 148
clr R0
bra L13
L13:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _nd_whrv
.text
_nd_whrv:
~~nd_whrv:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 167
move 10(R14),R7
*line 167
move 8(R14),R5
and #255,R5
*line 168
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 170
*line 170
tst R6
bne L18
*line 171
*line 172
*line 172
cmp #8,R7
bne L19
*line 173
*line 174
move #45,R0
move.b R0,_dspbuf
move.b R0,_ebuf
*line 175
clr R0
move.b R0,1+_dspbuf
move.b R0,4+_ebuf
*line 176
bra L20
L19:
*line 177
*line 177
cmp #9,R7
bne L21
*line 178
*line 179
move #43,R0
move.b R0,_dspbuf
move.b R0,_ebuf
*line 180
clr R0
move.b R0,1+_dspbuf
move.b R0,4+_ebuf
*line 181
bra L22
L21:
*line 182
*line 183
*line 184
move #-1,R0
bra L17
L22:L20:
*line 185
*line 186
bra L23
L18:
*line 187
*line 188
*line 189
move R7,R0
add #48,R0
move.b R0,_dspbuf
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 190
clr R0
move.b R0,1+_dspbuf
move.b R0,4+_ebuf
L23:
*line 193
clr (sp)
jsr _vbank
*line 194
*line 195
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
*line 197
jsr _advwcur
*line 198
clr R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L4:.dc.b $25,$63,$25,$30,$33,$64,$0
L16:.dc.b $25,$63,$25,$30,$33,$64,$0
