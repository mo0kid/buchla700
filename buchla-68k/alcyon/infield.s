.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _stcrow
.globl _stccol
.globl _infield
.text
_infield:
~~infield:
~row=R7
~col=R6
~fetp=R13
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
*line 26
move 8(R14),R7
*line 26
move 10(R14),R6
*line 26
move.l 12(R14),R13
*line 26
clr.l _infetp
*line 28
*line 29
move.l R13,R0
bne L2
*line 29
clr R0
bra L1
*line 30
L2:
*line 31
bra L5
L4:
*line 32
*line 33
*line 34
*line 35
cmp (R13),R7
bne L6
cmp 2(R13),R6
blt L6
cmp 4(R13),R6
bgt L6
*line 36
*line 37
move.l R13,_infetp
*line 38
move #1,R0
bra L1
*line 39
*line 40
L6:
*line 41
add.l #24,R13
L5:
*line 42
tst.l 16(R13)
bne L4
L3:
*line 44
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.data
