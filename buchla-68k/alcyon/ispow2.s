.globl _ispow2
.text
_ispow2:
~~ispow2:
~x=R7
link R14,#0
movem.l R4-R7,-(sp)
~i=R6
~k=R5
*line 22
move.l 8(R14),R7
*line 22
move.l #$1,R5
*line 24
move #32,R6
bra L4
L5:
*line 25
*line 26
*line 26
move.l R7,R0
and.l R5,R0
beq L6
*line 27
*line 28
*line 29
move.l R7,R0
move.l R5,R1
not.l R1
and.l R1,R0
beq L7
*line 29
clr R0
bra L1
bra L8
L7:
*line 30
*line 31
move #1,R0
bra L1
L8:
*line 32
*line 33
L6:
*line 34
asl.l #$1,R5
L3:L4:
*line 24
move R6,R0
sub #1,R6
tst R0
bne L5
L2:
*line 37
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
