.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _setbuf
.text
_setbuf:
~~setbuf:
~stream=R13
~buffer=12
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 14
move.l 8(R14),R13
*line 14
*line 15
tst.l 8(R13)
bne L1
*line 16
*line 17
*line 17
tst.l 12(R14)
beq L2
*line 18
*line 19
move.l 12(R14),8(R13)
*line 20
move #1024,16(R13)
*line 21
bra L3
L2:
*line 22
*line 23
*line 24
lea 14(R13),R8
move.l R8,8(R13)
*line 25
move #1,16(R13)
L3:L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
