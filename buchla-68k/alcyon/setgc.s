.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _cmtype
.globl _cxval
.globl _cyval
.globl _sgcsw
.globl _stccol
.globl _stcrow
.globl _setgc
.text
_setgc:
~~setgc:
~xv=R7
~yv=R6
link R14,#0
movem.l R5-R7,-(sp)
*line 30
move 8(R14),R7
*line 30
move 10(R14),R6
*line 30
move R6,(sp)
move R7,-(sp)
jsr _gcurpos
addq.l #2,sp
*line 32
move R7,_cxval
*line 33
move R6,_cyval
*line 35
move R6,R0
ext.l R0
divs #14,R0
move R0,_stcrow
*line 36
move R7,R0
asr #3,R0
move R0,_stccol
*line 38
move #1,_sgcsw
*line 39
clr _cmtype
*line 41
*line 42
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L2
*line 42
move.l _infetp,_cfetp
*line 43
bra L3
L2:
*line 44
clr.l _cfetp
L3:L1:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _settc
.text
_settc:
~~settc:
~rv=R7
~cv=R6
link R14,#0
movem.l R5-R7,-(sp)
*line 59
move 8(R14),R7
*line 59
move 10(R14),R6
*line 59
move R6,(sp)
move R7,-(sp)
jsr _itcpos
addq.l #2,sp
*line 61
move R7,_stcrow
*line 62
move R6,_stccol
*line 64
move R7,R0
muls #14,R0
move R0,_cyval
*line 65
move R6,R0
asl #3,R0
move R0,_cxval
*line 67
clr _sgcsw
*line 68
move #1,_cmtype
*line 70
*line 71
move.l _curfet,(sp)
move _stccol,-(sp)
move _stcrow,-(sp)
jsr _infield
addq.l #4,sp
tst R0
beq L5
*line 71
move.l _infetp,_cfetp
*line 72
bra L6
L5:
*line 73
clr.l _cfetp
L6:L4:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.data
