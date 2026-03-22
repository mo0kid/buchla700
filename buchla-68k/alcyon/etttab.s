.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _tunob
.globl _stcrow
.globl _stccol
.globl _curtun
.globl _tunmod
.globl _tdbox
.globl _dspbuf
.globl _et_ttab
.text
_et_ttab:
~~et_ttab:
~n=8
link R14,#-4
*line 39
move _curtun,(sp)
move.l #L2,-(sp)
move.l #_ebuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 40
move #1,_ebflag
*line 42
clr R0
bra L1
L1:unlk R14
rts
.globl _ef_ttab
.text
_ef_ttab:
~~ef_ttab:
~n=8
link R14,#0
movem.l R5-R7,-(sp)
~i=R7
~tmpval=R6
*line 57
clr.b 1+_ebuf
*line 58
clr _ebflag
*line 60
move.b _ebuf,R0
ext.w R0
add #-48,R0
move R0,_curtun
*line 61
jsr _modtun
*line 62
move #54,(sp)
move #22,-(sp)
jsr _settc
addq.l #2,sp
*line 63
clr R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _rd_ttab
.text
_rd_ttab:
~~rd_ttab:
~nn=8
link R14,#0
movem.l R6-R7,-(sp)
~n=R7
*line 81
move 8(R14),R7
and #255,R7
*line 82
move _curtun,(sp)
move.l #L5,-(sp)
move.l #_dspbuf,-(sp)
jsr _sprintf
addq.l #8,sp
*line 84
clr (sp)
jsr _vbank
*line 85
*line 86
move #14,(sp)
move.l #_dspbuf,-(sp)
move #61,-(sp)
move #24,-(sp)
move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 10(R8,R9.l),-(sp)
tst _tunmod
beq L10000
move #14,-(sp)
bra L10002
L10000:move R7,R0
asl #4,R0
ext.l R0
move.l R0,R8
move.l #_tdbox,R9
move 8(R8,R9.l),-(sp)
L10002:move #64,-(sp)
move.l _tunob,-(sp)
jsr _vcputsv
adda.l #18,sp
*line 88
clr R0
bra L4
L4:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _nd_ttab
.text
_nd_ttab:
~~nd_ttab:
~k=R7
~nn=8
link R14,#0
movem.l R5-R7,-(sp)
~n=R6
*line 104
move 10(R14),R7
*line 104
move 8(R14),R6
and #255,R6
*line 106
move R7,R0
add #48,R0
move.b R0,_ebuf
*line 107
clr.b 1+_ebuf
*line 109
move R7,R0
add #48,R0
move.b R0,_dspbuf
*line 110
clr.b 1+_dspbuf
*line 112
clr (sp)
jsr _vbank
*line 113
move #14,(sp)
move.l #_dspbuf,-(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
move R6,R0
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
*line 115
clr R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
L2:.dc.b $25,$64,$0
L5:.dc.b $25,$64,$0
