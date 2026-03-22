.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _putl
.text
_putl:
~~putl:
~w=R7
~stream=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
*line 17
move.l 8(R14),R7
*line 17
move.l 12(R14),R13
*line 17
*line 18
move.l R13,(sp)
move.l R7,R0
move.l #$18,R1
asr.l R1,R0
move.l R0,-(sp)
and.l #$ff,(sp)
jsr _putc
addq.l #4,sp
tst R0
blt L1
*line 19
*line 20
*line 21
move.l R13,(sp)
move.l R7,R0
move.l #$10,R1
asr.l R1,R0
move.l R0,-(sp)
and.l #$ff,(sp)
jsr _putc
addq.l #4,sp
tst R0
blt L1
*line 22
*line 23
*line 24
move.l R13,(sp)
move.l R7,R0
asr.l #$8,R0
move.l R0,-(sp)
and.l #$ff,(sp)
jsr _putc
addq.l #4,sp
tst R0
blt L1
*line 25
*line 26
move.l R13,(sp)
move.l R7,-(sp)
and.l #$ff,(sp)
jsr _putc
addq.l #4,sp
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
