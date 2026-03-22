.bss
L1:.ds.b 4
.text
.globl _sprintf
.text
_sprintf:
~~sprintf:
~str=8
~fmt=12
~va_alist=16
link R14,#-4
movem.l R6-R7,-(sp)
~count=R7
~aptr=-4
*line 30
lea 16(R14),R8
move.l R8,-4(R14)
*line 31
move.l 8(R14),L1
*line 32
move.l -4(R14),(sp)
move.l 12(R14),-(sp)
move.l #_spsub,-(sp)
jsr _dofmt_
addq.l #8,sp
move.l R0,R7
*line 33
move.l L1,R8
clr.b (R8)
*line 34
move.l R7,R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.text
_spsub:
~~spsub:
~c=8
link R14,#-4
*line 47
move.l L1,R8
move 8(R14),R0
move.b R0,(R8)
and #255,R0
add.l #1,L1
bra L4
L4:unlk R14
rts
.data
