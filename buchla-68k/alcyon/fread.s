.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _fread
.text
_fread:
~~fread:
~buffer=R13
~size=12
~number=14
~stream=16
link R14,#-2
movem.l R5-R7/R13-R13,-(sp)
~total=-2
~c=R7
~i=R6
*line 28
move.l 8(R14),R13
*line 28
clr -2(R14)
bra L4
L5:
*line 29
*line 30
move 12(R14),R6
bra L8
L9:
*line 31
*line 32
*line 33
move.l 16(R14),(sp)
jsr _getc
move R0,R7
cmp #-1,R7
bne L10
*line 33
move -2(R14),R0
bra L1
*line 34
L10:
*line 35
move.b R7,(R13)+
L7:
*line 30
sub #1,R6
L8:
*line 30
tst R6
bne L9
L6:
*line 36
L3:
*line 28
add #1,-2(R14)
L4:
*line 28
move -2(R14),R0
cmp 14(R14),R0
blt L5
L2:
*line 38
move -2(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.data
