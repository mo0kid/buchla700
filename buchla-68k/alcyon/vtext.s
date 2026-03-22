.data
L1:.dc.w $FF00
.dc.w $FF
.text
.globl _vtext
.text
_vtext:
~~vtext:
~obj=R13
~nc=R7
~row=R6
~col=R5
~ip=R12
link R14,#0
movem.l R4-R7/R11-R13,-(sp)
~op=R11
*line 18
move.l 8(R14),R13
*line 18
move 12(R14),R7
*line 18
move 14(R14),R6
*line 18
move 16(R14),R5
*line 18
move.l 18(R14),R12
*line 18
bra L5
L4:
*line 19
*line 20
move.l R13,R11
clr R0
move R6,R0
clr R1
move R7,R1
lsr #1,R1
mulu R1,R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l R0,R11
clr R0
move R5,R0
lsr #1,R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l R0,R11
*line 21
*line 22
*line 23
clr R0
move R5,R0
and #1,R0
lsl #1,R0
swap R0
clr R0
swap R0
move.l R0,R8
move.l #L1,R9
clr R0
move 0(R8,R9.l),R0
and (R11),R0
move.b (R12)+,R1
ext.w R1
and #255,R1
btst #0,R5
beq L10000
move #8,R2
bra L10002
L10000:clr R2
L10002:asl R2,R1
or R1,R0
move R0,(R11)
*line 24
*line 25
add #1,R5
L5:
*line 26
tst.b (R12)
bne L4
L3:L2:tst.l (sp)+
movem.l (sp)+,R5-R7/R11-R13
unlk R14
rts
.data
