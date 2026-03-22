.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _waveob
.globl _stcrow
.globl _stccol
.globl _curwslt
.globl _wdbox
.globl _dspbuf
.globl _et_wslt
.text
_et_wslt:
~~et_wslt:
~n=8
link R14,#-4
*line 44
move _curwslt,(sp)
add #65,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 45
move #1,_ebflag
*line 47
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_wslt
.text
_ef_wslt:
~~ef_wslt:
~n=8
link R14,#-4
*line 60
clr.b 1+_ebuf
*line 61
clr _ebflag
*line 63
move.b _ebuf,R0
ext.w R0
add #-65,R0
move R0,_curwslt
*line 69
jsr _newws
*line 70
jsr _dsnewws
*line 71
clr R0
bra L3
L3:unlk R14
rts
.globl _rd_wslt
.text
_rd_wslt:
~~rd_wslt:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 89
move 8(R14),R7
and #255,R7
*line 90
move _curwslt,(sp)
add #65,(sp)
move.l #L5,-(sp)
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
add #19,(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 12(R8,R9.l),-(sp)
add #1,(sp)
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
bra L4
L4:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_wslt
.text
_nd_wslt:
~~nd_wslt:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 112
move 10(R14),R7
*line 112
move 8(R14),R6
and #255,R6
*line 118
*line 119
cmp #1,R7
ble L7
*line 119
move #-1,R0
bra L6
*line 120
L7:
*line 121
move R7,R0
add #65,R0
move.b R0,_ebuf
*line 122
clr.b 1+_ebuf
*line 124
move R7,R0
add #65,R0
move.b R0,_dspbuf
*line 125
clr.b 1+_dspbuf
*line 131
clr (sp)
jsr _vbank
*line 132
*line 133
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R6,R0
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
*line 135
jsr _advwcur
*line 136
clr R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$63,$0
L5:.dc.b $25,$63,$0
