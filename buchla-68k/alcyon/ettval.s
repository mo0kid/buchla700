.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _tunob
.globl _stcrow
.globl _stccol
.globl _tunval
.globl _tunmod
.globl _tdbox
.globl _dspbuf
.globl _modtun
.text
_modtun:
~~modtun:
link R14,#-4
*line 37
*line 37
tst _tunmod
bne L2
*line 38
*line 39
move #1,_tunmod
*line 40
move #6,(sp)
jsr _tdswin
*line 41
L2:L1:unlk R14
rts
.globl _et_tval
.text
_et_tval:
~~et_tval:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~tv=R7
~ts=R6
*line 60
tst _tunval
bge L10000
move _tunval,R0
neg R0
bra L10002
L10000:move _tunval,R0
L10002:move R0,R7
asr R7
*line 61
tst _tunval
bge L10003
move #45,R0
bra L10005
L10003:move #43,R0
L10005:move.b R0,R6
*line 63
move R7,(sp)
move.b R6,R0
ext.w R0
move R0,-(sp) 
move.l #L4,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 64
move #1,_ebflag
*line 66
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _ef_tval
.text
_ef_tval:
~~ef_tval:
~n=8
link R14,#0
movem.l R3-R7/R13-R13,-(sp)
~ov=R13
~i=R7
~tmpval=R6
~tv=R5
~ts=R4
*line 86
clr.b 5+_ebuf
*line 87
clr _ebflag
*line 89
clr R6
*line 91
move #1,R7
bra L8
L9:
*line 92
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L7:
*line 91
add #1,R7
L8:
*line 91
cmp #5,R7
blt L9
L6:
*line 94
*line 95
cmp.b #45,_ebuf
bne L10
*line 95
move R6,R0
neg R0
asl #1,R0
move R0,_tunval
*line 96
bra L11
L10:
*line 97
move R6,R0
asl #1,R0
move R0,_tunval
L11:
*line 99
tst _tunval
bge L10006
move _tunval,R0
neg R0
bra L10008
L10006:move _tunval,R0
L10008:move R0,R5
asr R5
*line 100
tst _tunval
bge L10009
move #45,R0
bra L10011
L10009:move #43,R0
L10011:move.b R0,R4
*line 101
move R5,(sp)
move.b R4,R0
ext.w R0
move R0,-(sp) 
move.l #L12,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 103
clr (sp)
jsr _vbank
*line 104
move #14,(sp)
move.l #_dspbuf,-(sp)
move #54,-(sp)
move #18,-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),-(sp)
move 8(R14),R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 106
jsr _modtun
*line 107
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _rd_tval
.text
_rd_tval:
~~rd_tval:
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~tv=R7
~n=R6
~ts=R5
*line 126
move 8(R14),R6
and #255,R6
*line 128
tst _tunval
bge L10012
move _tunval,R0
neg R0
bra L10014
L10012:move _tunval,R0
L10014:move R0,R7
asr R7
*line 129
tst _tunval
bge L10015
move #45,R0
bra L10017
L10015:move #43,R0
L10017:move.b R0,R5
*line 131
move R7,(sp)
move.b R5,R0
ext.w R0
move R0,-(sp) 
move.l #L14,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
adda.l #10,sp
*line 133
clr (sp)
jsr _vbank
*line 134
move #14,(sp)
move.l #_dspbuf,-(sp)
move #54,-(sp)
move #18,-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),-(sp)
move R6,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 135
clr R0
bra L13
L13:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _nd_tval
.text
_nd_tval:
~~nd_tval:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 154
move 10(R14),R7
*line 154
move 8(R14),R5
and #255,R5
*line 155
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 157
*line 157
tst R6
bne L16
*line 158
*line 159
*line 159
cmp #8,R7
bne L17
*line 160
*line 161
move.b #45,_ebuf
*line 162
clr.b 5+_ebuf
*line 163
*line 164
move.b #45,_dspbuf
*line 165
clr.b 1+_dspbuf
*line 166
bra L18
L17:
*line 167
*line 167
cmp #9,R7
bne L19
*line 168
*line 169
move.b #43,_ebuf
*line 170
clr.b 5+_ebuf
*line 171
*line 172
move.b #43,_dspbuf
*line 173
clr.b 1+_dspbuf
*line 174
bra L20
L19:
*line 175
*line 176
*line 177
move #-1,R0
bra L15
L20:L18:
*line 178
*line 179
*line 180
bra L21
L16:
*line 181
*line 182
*line 183
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 184
clr.b 5+_ebuf
*line 185
*line 186
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 187
clr.b 1+_dspbuf
L21:
*line 190
clr (sp)
jsr _vbank
*line 191
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),-(sp)
move #12,-(sp)
move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 193
jsr _advtcur
*line 194
clr R0
bra L15
L15:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L4:.dc.b $25,$63,$25,$30,$34,$64,$0
L12:.dc.b $56,$61,$6C,$20,$25,$63,$25,$30,$34,$64,$0
L14:.dc.b $56,$61,$6C,$20,$25,$63,$25,$30,$34,$64,$0
