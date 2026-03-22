.globl _printf
.text
_printf:
~~printf:
~fmt=8
~va_alist=12
link R14,#-4
movem.l R6-R7,-(sp)
~count=R7
~aptr=-4
*line 36
lea 12(R14),R8
move.l R8,-4(R14)
*line 37
move.l -4(R14),(sp)
move.l 8(R14),-(sp)
move.l #_fpsub,-(sp)
jsr _dofmt_
addq.l #8,sp
move.l R0,R7
*line 39
move.l R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.text
_fpsub:
~~fpsub:
~c=8
link R14,#-4
*line 55
*line 56
cmp #10,8(R14)
bne L4
*line 56
move #13,(sp)
move #2,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 57
L4:
*line 58
move 8(R14),(sp)
move #2,-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 59
move 8(R14),R0
bra L3
L3:unlk R14
rts
.data
