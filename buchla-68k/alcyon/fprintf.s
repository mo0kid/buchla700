.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.bss
L1:.ds.b 4
.text
.globl _fprintf
.text
_fprintf:
~~fprintf:
~stream=8
~fmt=12
~va_alist=16
link R14,#-4
movem.l R6-R7,-(sp)
~count=R7
~aptr=-4
*line 27
move.l 8(R14),L1
*line 28
lea 16(R14),R8
move.l R8,-4(R14)
*line 29
move.l -4(R14),(sp)
move.l 12(R14),-(sp)
move.l #_fpsub,-(sp)
jsr __dofmt
addq.l #8,sp
move R0,R7
*line 31
move R7,R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.text
_fpsub:
~~fpsub:
~c=8
link R14,#-4
*line 38
move.l L1,(sp)
move 8(R14),-(sp)
jsr _aputc
addq.l #2,sp
bra L4
L4:unlk R14
rts
.data
