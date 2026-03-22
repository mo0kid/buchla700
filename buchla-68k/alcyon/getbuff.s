.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _getbuff
.text
_getbuff:
~~getbuff:
~ptr=R13
link R14,#-4
movem.l R7-R7/R13-R13,-(sp)
~buffer=-4
*line 16
move.l 8(R14),R13
*line 16
*line 16
cmp #1,16(R13)
bne L2
*line 17
*line 18
lea 14(R13),R8
move.l R8,8(R13)
bra L1
*line 19
*line 20
*line 21
L2:
*line 22
*line 22
tst.l _Stdbufs
beq L3
*line 23
*line 24
move.l _Stdbufs,-4(R14)
*line 25
move.l _Stdbufs,R8
move.l (R8),_Stdbufs
*line 26
bra L4
L3:
*line 27
*line 28
*line 29
lea 14(R13),R8
move.l R8,8(R13)
*line 30
move #1,16(R13)
bra L1
*line 31
L4:
*line 34
or.b #2,12(R13)
*line 35
move.l -4(R14),8(R13)
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
