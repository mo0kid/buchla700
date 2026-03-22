.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _waveob
.globl _stcrow
.globl _stccol
.globl _curvce
.globl _wdbox
.globl _dspbuf
.globl _et_wvce
.text
_et_wvce:
~~et_wvce:
~n=8
link R14,#-4
*line 40
move _curvce,(sp)
add #1,(sp)
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
.globl _ef_wvce
.text
_ef_wvce:
~~ef_wvce:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 58
clr.b 2+_ebuf
*line 59
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
tst R6
beq L10000
cmp #12,R6
ble L8
L10000:*line 66
move #-1,R0
bra L3
*line 67
L8:
*line 68
move R6,(sp)
sub #1,(sp)
jsr _newvce
*line 69
jsr _wwins
*line 70
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_wvce
.text
_rd_wvce:
~~rd_wvce:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 88
move 8(R14),R7
and #255,R7
*line 89
move _curvce,(sp)
add #1,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 91
clr (sp)
jsr _vbank
*line 92
*line 93
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 14(R8,R9.l),-(sp)
add #18,(sp)
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
*line 95
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_wvce
.text
_nd_wvce:
~~nd_wvce:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 111
move 10(R14),R7
*line 111
move 8(R14),R5
and #255,R5
*line 112
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 113
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 114
clr.b 2+_ebuf
*line 116
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 117
clr.b 1+_dspbuf
*line 119
clr (sp)
jsr _vbank
*line 120
*line 121
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
*line 123
jsr _advwcur
*line 124
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$64,$0
