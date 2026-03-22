.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _getw
.text
_getw:
~~getw:
~stream=R13
link R14,#-2
movem.l R7-R7/R12-R13,-(sp)
~temp=-2
~t=R12
*line 28
move.l 8(R14),R13
*line 28
lea -2(R14),R12
*line 30
move.l R13,(sp)
jsr _getc
move.b R0,(R12)+
*line 31
move.l R13,(sp)
jsr _getc
move.b R0,(R12)
*line 33
move -2(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.data
