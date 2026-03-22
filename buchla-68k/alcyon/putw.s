.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _putw
.text
_putw:
~~putw:
~w=R7
~stream=10
link R14,#0
movem.l R6-R7,-(sp)
*line 17
move 8(R14),R7
*line 17
*line 18
move.l 10(R14),(sp)
clr R0
move R7,R0
lsr #8,R0
move R0,-(sp)
and #255,(sp)
jsr _putc
addq.l #2,sp
tst R0
blt L1
*line 19
*line 20
move.l 10(R14),(sp)
move R7,-(sp)
and #255,(sp)
jsr _putc
addq.l #2,sp
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
