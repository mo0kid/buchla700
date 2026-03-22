.globl ___atab
.globl _atol
.text
_atol:
~~atol:
~cp=R13
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~n=R7
~sign=R6
*line 18
move.l 8(R14),R13
*line 18
clr R6
*line 20
*line 20
cmp.b #45,(R13)
bne L2
*line 21
*line 22
add.l #1,R13
*line 23
move #1,R6
*line 24
bra L3
L2:
*line 25
*line 26
*line 27
*line 28
cmp.b #43,(R13)
bne L4
*line 28
add.l #1,R13
L4:L3:
*line 31
clr.l R7
bra L7
L8:
*line 32
move.l #$a,-(sp)
move.l R7,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R7
move.b (R13)+,R0
ext.w R0
ext.l R0
add.l R0,R7
add.l #$ffffffd0,R7
L6:L7:
*line 31
move.b (R13),R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #2,(R8)
bne L8
L5:
*line 34
tst R6
beq L10000
move.l R7,R0
neg.l R0
bra L10002
L10000:move.l R7,R0
L10002:bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.data
