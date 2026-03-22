.globl _errno
.globl __conwr
.text
__conwr:
~~_conwr:
~buff=R13
~kind=8
~len=14
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~count=R7
*line 29
move.l 10(R14),R13
*line 29
clr R7
bra L4
L5:
*line 30
move.b (R13)+,R0
ext.w R0
move R0,(sp) 
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L3:
*line 29
add #1,R7
L4:
*line 29
cmp 14(R14),R7
blt L5
L2:
*line 32
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
