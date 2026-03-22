.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _waveob
.globl _stccol
.globl _curwhrm
.globl _wdbox
.globl _dspbuf
.globl _et_whar
.text
_et_whar:
~~et_whar:
~n=8
link R14,#-4
*line 40
move _curwhrm,(sp)
add #1,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 41
move #1,_ebflag
*line 42
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_whar
.text
_ef_whar:
~~ef_whar:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 57
clr.b 2+_ebuf
*line 58
clr _ebflag
*line 60
clr R6
*line 62
clr R7
bra L6
L7:
*line 63
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 62
add #1,R7
L6:
*line 62
cmp #2,R7
blt L7
L4:
*line 65
*line 66
cmp #32,R6
bgt L10000
tst R6
bne L8
L10000:*line 66
move #-1,R0
bra L3
*line 67
L8:
*line 68
move R6,R0
sub #1,R0
move R0,_curwhrm
*line 69
jsr _newws
*line 70
move #5,(sp)
jsr _wdswin
*line 71
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_whar
.text
_rd_whar:
~~rd_whar:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 89
move 8(R14),R7
and #255,R7
*line 90
move _curwhrm,(sp)
add #1,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 92
clr (sp)
jsr _vbank
*line 93
*line 94
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 14(R8,R9.l),-(sp)
add #10,(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 12(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 10(R8,R9.l),-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 8(R8,R9.l),-(sp)
move #64,-(sp)
move.l _waveob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 96
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_whar
.text
_nd_whar:
~~nd_whar:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 112
move 10(R14),R7
*line 112
move 8(R14),R5
and #255,R5
*line 113
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 114
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 115
clr.b 2+_ebuf
*line 117
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 118
clr.b 1+_dspbuf
*line 120
clr (sp)
jsr _vbank
*line 121
*line 122
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move R5,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 12(R8,R9.l),-(sp)
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
*line 124
jsr _advwcur
*line 125
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$64,$0
