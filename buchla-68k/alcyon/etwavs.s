.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _waveob
.globl _stccol
.globl _curwave
.globl _curvce
.globl _curwslt
.globl _wsnmod
.globl _wdbox
.globl _dspbuf
.globl _et_wavs
.text
_et_wavs:
~~et_wavs:
~n=8
link R14,#-4
*line 42
move _curwave,(sp)
add #1,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 43
move #1,_ebflag
*line 45
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_wavs
.text
_ef_wavs:
~~ef_wavs:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 60
clr.b 2+_ebuf
*line 61
clr _ebflag
*line 63
clr R6
*line 65
clr R7
bra L6
L7:
*line 66
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 65
add #1,R7
L6:
*line 65
cmp #2,R7
blt L7
L4:
*line 68
*line 69
cmp #20,R6
bgt L10000
tst R6
bne L8
L10000:*line 69
move #-1,R0
bra L3
*line 70
L8:
*line 71
move _curvce,R8
add.l R8,R8
add.l R8,R8
move _curwslt,R9
add.l R9,R9
add.l R9,R8
add.l #_wsnmod,R8
move #1,(R8)
*line 72
move R6,R0
sub #1,R0
move R0,_curwave
*line 73
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_wavs
.text
_rd_wavs:
~~rd_wavs:
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R7
~cx=R6
*line 92
move _curvce,R8
add.l R8,R8
add.l R8,R8
move _curwslt,R9
add.l R9,R9
add.l R9,R8
move.l #_wsnmod,R9
tst 0(R8,R9.l)
beq L10001
move #13,(sp)
bra L10003
L10001:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 8(R8,R9.l),(sp)
L10003:jsr _exp_c
move R0,R6
*line 93
move 8(R14),R7
and #255,R7
*line 95
move _curwave,(sp)
add #1,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 97
clr (sp)
jsr _vbank
*line 98
*line 99
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_wdbox,R9
move 14(R8,R9.l),-(sp)
add #9,(sp)
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
move R6,-(sp)
move #64,-(sp)
move.l _waveob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 101
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _nd_wavs
.text
_nd_wavs:
~~nd_wavs:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 117
move 10(R14),R7
*line 117
move 8(R14),R5
and #255,R5
*line 118
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 119
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 120
clr.b 2+_ebuf
*line 122
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 123
clr.b 1+_dspbuf
*line 125
clr (sp)
jsr _vbank
*line 126
*line 127
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
*line 129
jsr _advwcur
*line 130
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$64,$0
