.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _asgob
.globl _stcrow
.globl _stccol
.globl _prgchan
.globl _adbox
.globl _dspbuf
.globl _et_aprg
.text
_et_aprg:
~~et_aprg:
~n=8
link R14,#-4
*line 45
move _prgchan,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 46
move #1,_ebflag
*line 48
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_aprg
.text
_ef_aprg:
~~ef_aprg:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 63
clr.b 2+_ebuf
*line 64
clr _ebflag
*line 65
clr R6
*line 67
clr R7
bra L6
L7:
*line 68
muls #10,R6
move.l #_ebuf,R8
move.b 0(R8,R7),R0
ext.w R0
add R0,R6
add #-48,R6
L5:
*line 67
add #1,R7
L6:
*line 67
cmp #2,R7
blt L7
L4:
*line 76
*line 77
tst R6
beq L10000
cmp #16,R6
ble L8
L10000:*line 77
move #-1,R0
bra L3
*line 78
L8:
*line 79
move R6,_prgchan
*line 80
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_aprg
.text
_rd_aprg:
~~rd_aprg:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 98
move 8(R14),R7
and #255,R7
*line 99
move _prgchan,(sp)
move.l #L10,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 101
clr (sp)
jsr _vbank
*line 102
*line 103
move #14,(sp)
move.l #_dspbuf,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 14(R8,R9.l),-(sp)
add #8,(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_adbox,R9
move 12(R8,R9.l),-(sp)
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
*line 105
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_aprg
.text
_nd_aprg:
~~nd_aprg:
~k=R7
~nn=8
link R14,#0
movem.l R4-R7,-(sp)
~ec=R6
~n=R5
*line 121
move 10(R14),R7
*line 121
move 8(R14),R5
and #255,R5
*line 123
move _stccol,R6
move.l _cfetp,R8
move 2(R8),R0
sub R0,R6
*line 125
move R7,R0
add #48,R0
move R6,R9
add.l #_ebuf,R9
move.b R0,(R9)
*line 126
clr.b 2+_ebuf
*line 128
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 129
clr.b 1+_dspbuf
*line 131
clr (sp)
jsr _vbank
*line 132
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R5,R0
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
*line 134
jsr _advacur
*line 135
clr R0
bra L11
L11:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L2:.dc.b $25,$30,$32,$64,$0
L10:.dc.b $25,$30,$32,$2E,$32,$64,$0
