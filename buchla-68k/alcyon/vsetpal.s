.globl _dfltpal
.data
_dfltpal:
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $1
.dc.w $0
.dc.w $0
.dc.w $0
.dc.w $2
.dc.w $0
.dc.w $0
.dc.w $3
.dc.w $0
.dc.w $2
.dc.w $0
.dc.w $0
.dc.w $3
.dc.w $0
.dc.w $0
.dc.w $2
.dc.w $2
.dc.w $0
.dc.w $3
.dc.w $3
.dc.w $3
.dc.w $0
.dc.w $0
.dc.w $3
.dc.w $1
.dc.w $0
.dc.w $3
.dc.w $0
.dc.w $3
.dc.w $3
.dc.w $1
.dc.w $2
.dc.w $3
.dc.w $2
.dc.w $0
.dc.w $2
.dc.w $3
.dc.w $0
.dc.w $2
.dc.w $2
.dc.w $2
.dc.w $3
.dc.w $3
.dc.w $3
.globl _vsetpal
.text
_vsetpal:
~~vsetpal:
~slot=R7
~red=R6
~grn=R5
~blu=R4
link R14,#-4
movem.l R2-R7,-(sp)
~palval=R3
~pal=-4
*line 52
move 8(R14),R7
*line 52
move 10(R14),R6
*line 52
move 12(R14),R5
*line 52
move 14(R14),R4
*line 52
move.l #$280000,-4(R14)
*line 54
*line 55
*line 56
*line 57
move R7,R3
lsl #6,R3
clr R0
move R6,R0
and #1,R0
lsl #5,R0
or R0,R3
clr R0
move R6,R0
and #2,R0
lsl #1,R0
or R0,R3
clr R0
move R5,R0
and #1,R0
lsl #4,R0
or R0,R3
clr R0
move R5,R0
and #2,R0
or R0,R3
clr R0
move R4,R0
and #1,R0
lsl #3,R0
or R0,R3
clr R0
move R4,R0
and #2,R0
lsr #1,R0
or R0,R3
*line 59
clr R0
move R3,R0
move #63,R1
eor R1,R0
move.l -4(R14),R9
move R0,(R9)
L1:tst.l (sp)+
movem.l (sp)+,R3-R7
unlk R14
rts
.globl _vsndpal
.text
_vsndpal:
~~vsndpal:
~pp=8
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 85
clr R7
bra L5
L6:
*line 86
move.l 8(R14),R8
move R7,R1
muls #6,R1
move 4(R8,R1.l),(sp)
move.l 8(R14),R8
move R7,R1
muls #6,R1
move 2(R8,R1.l),-(sp)
move.l 8(R14),R8
move R7,R1
muls #6,R1
move 0(R8,R1.l),-(sp)
move R7,-(sp)
jsr _vsetpal
addq.l #6,sp
L4:
*line 85
add #1,R7
L5:
*line 85
cmp #16,R7
blt L6
L3:L2:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
