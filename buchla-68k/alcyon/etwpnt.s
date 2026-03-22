.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _waveob
.globl _stccol
.globl _curwpnt
.globl _wdbox
.globl _dspbuf
.globl _et_wpnt
.text
_et_wpnt:
~~et_wpnt:
~n=8
link R14,#-4
*line 40
move _curwpnt,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 41
move #1,_ebflag
*line 43
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_wpnt
.text
_ef_wpnt:
~~ef_wpnt:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 61
clr.b 3+_ebuf
*line 62
clr _ebflag
*line 64
clr R6
*line 66
clr R7
bra L6
L7:
*line 67
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 66
add #1,R7
L6:
*line 66
cmp #3,R7
blt L7
L4:
*line 69
*line 70
cmp #254,R6
blt L8
*line 70
move #-1,R0
bra L3
*line 71
L8:
*line 72
move R6,_curwpnt
*line 73
jsr _newws
*line 74
move #4,(sp)
jsr _wdswin
*line 75
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_wpnt
.text
_rd_wpnt:
~~rd_wpnt:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 93
move 8(R14),R7
and #255,R7
*line 94
move _curwpnt,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 96
clr (sp)
jsr _vbank
*line 97
*line 98
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 14(R8,R9.l),-(sp)
add #4,(sp)
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
*line 100
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_wpnt
.text
_nd_wpnt:
~~nd_wpnt:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 119
move 10(R14),R7
*line 119
move 8(R14),R5
and #255,R5
*line 120
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 121
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 122
clr.b 3+_ebuf
*line 124
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 125
clr.b 1+_dspbuf
*line 127
clr (sp)
jsr _vbank
*line 129
*line 130
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
*line 132
jsr _advwcur
*line 134
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$33,$64,$0
L10:.dc.b $25,$30,$33,$64,$0
