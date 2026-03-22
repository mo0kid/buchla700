.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _asgmod
.globl _stccol
.globl _stcrow
.globl _dspbuf
.globl _ins2grp
.globl _adbox
.globl _modasg
.text
_modasg:
~~modasg:
link R14,#-4
*line 42
*line 42
tst _asgmod
bne L2
*line 43
*line 44
move #1,_asgmod
*line 45
clr (sp)
jsr _adswin
*line 46
L2:L1:unlk R14
rts
.globl _et_ains
.text
_et_ains:
~~et_ains:
~n=8
link R14,#-4
movem.l R6-R7,-(sp)
~grp=R7
~buf=-4
*line 63
move 8(R14),R7
asr #8,R7
and #255,R7
*line 65
move R7,R8
add.l R8,R8
move.l #_ins2grp,R9
move 0(R8,R9.l),(sp)
and #255,(sp)
move.l #L4,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 66
move #1,_ebflag
*line 68
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _ef_ains
.text
_ef_ains:
~~ef_ains:
~n=8
link R14,#0
movem.l R4-R7,-(sp)
~tmpval=R7
~grp=R6
~i=R5
*line 83
move 8(R14),R6
asr #8,R6
and #255,R6
*line 84
clr.b 2+_ebuf
*line 85
clr _ebflag
*line 86
clr R7
*line 88
clr R5
bra L8
L9:
*line 89
muls #10,R7
move.l #_ebuf,R8
move.b 0(R8,R5),R0
ext.w R0
add R0,R7
add #-48,R7
L7:
*line 88
add #1,R5
L8:
*line 88
cmp #2,R5
blt L9
L6:
*line 91
*line 92
cmp #41,R7
blt L10
*line 92
move #-1,R0
bra L5
*line 93
L10:
*line 94
move R7,R0
move R6,R9
add.l R9,R9
add.l #_ins2grp,R9
move (R9),R1
and #-256,R1
or R1,R0
move R6,R9
add.l R9,R9
add.l #_ins2grp,R9
move R0,(R9)
*line 95
jsr _modasg
*line 96
move R6,(sp)
jsr _setv2gi
*line 97
jsr _setinst
*line 98
clr R0
bra L5
L5:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _rd_ains
.text
_rd_ains:
~~rd_ains:
~nn=8
link R14,#-4
movem.l R5-R7,-(sp)
~n=R7
~grp=R6
~buf=-4
*line 117
move 8(R14),R7
and #255,R7
*line 118
move 8(R14),R6
asr #8,R6
and #255,R6
*line 120
move R6,R8
add.l R8,R8
move.l #_ins2grp,R9
move 0(R8,R9.l),(sp)
and #255,(sp)
move.l #L12,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 122
clr (sp)
jsr _vbank
*line 123
*line 124
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
*line 126
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_ains
.text
_nd_ains:
~~nd_ains:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 142
move 10(R14),R7
*line 142
move 8(R14),R6
and #255,R6
*line 143
move R7,R0
add #48,R0
move _stccol,R9
move.l _cfetp,R10
move 2(R10),R10
sub R10,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 144
clr.b 2+_ebuf
*line 146
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 147
clr.b 1+_dspbuf
*line 149
clr (sp)
jsr _vbank
*line 150
*line 151
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
*line 153
jsr _advacur
*line 154
clr R0
bra L13
L13:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L4:.dc.b $25,$30,$32,$2E,$32,$64,$0
L12:.dc.b $25,$30,$32,$2E,$32,$64,$0
