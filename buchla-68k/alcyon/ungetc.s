.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _ungetc
.text
_ungetc:
~~ungetc:
~c=R7
~ptr=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
*line 16
move 8(R14),R7
*line 16
move.l 10(R14),R13
*line 16
*line 17
cmp #-1,R7
beq L10000
move.l (R13),R0
cmp.l 8(R13),R0
bhi L2
L10000:*line 17
move #-1,R0
bra L1
*line 18
L2:
*line 19
sub.l #1,(R13)
move R7,R0
move.l (R13),R9
move.b R0,(R9)
*line 21
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
