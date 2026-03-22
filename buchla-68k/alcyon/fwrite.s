.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _fwrite
.text
_fwrite:
~~fwrite:
~buffer=R13
~size=R7
~number=R6
~stream=R12
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~i=R5
~j=R4
*line 30
move.l 8(R14),R13
*line 30
move 12(R14),R7
*line 30
move 14(R14),R6
*line 30
move.l 16(R14),R12
*line 30
*line 31
tst R7
bge L2
*line 31
clr R0
bra L1
*line 32
L2:
*line 33
*line 34
tst R6
bge L3
*line 34
clr R0
bra L1
*line 35
L3:
*line 36
clr R5
bra L6
L7:
*line 37
clr R4
bra L10
L11:
*line 38
*line 39
move.l R12,(sp)
move.b (R13)+,R0
ext.w R0
move R0,-(sp) 
jsr _putc
addq.l #2,sp
cmp #-1,R0
bne L12
*line 39
move R5,R0
bra L1
*line 40
L12:L9:
*line 37
add #1,R4
L10:
*line 37
cmp R7,R4
blt L11
L8:L5:
*line 36
add #1,R5
L6:
*line 36
cmp R6,R5
blt L7
L4:
*line 41
move R6,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.data
