.bss
L1:.ds.b 82
.text
.globl _vspray4
.text
_vspray4:
~~vspray4:
~vobj=8
~vwid=12
~fg=14
~ml=16
~vb=20
~pitch=22
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~cp=R13
~lp=R12
~c=R7
~j=R6
~k=R5
~row=R4
*line 39
clr R4
*line 41
and #15,14(R14)
*line 42
move 14(R14),R0
asl #4,R0
or R0,14(R14)
*line 43
move 14(R14),R0
asl #8,R0
or R0,14(R14)
*line 45
*line 46
cmp #-1,20(R14)
beq L3
*line 46
move 20(R14),(sp)
jsr _vbank
*line 47
L3:
*line 48
bra L6
L5:
*line 49
*line 50
move.l #L1,R12
*line 51
*line 52
bra L9
L8:
*line 53
*line 54
and #255,R6
*line 55
move.b (R13)+,R7
*line 56
*line 57
clr R5
bra L12
L13:
*line 58
move.b R7,(R12)+
L11:
*line 57
add #1,R5
L12:
*line 57
cmp R6,R5
blt L13
L10:
*line 58
L9:
*line 59
move.b (R13)+,R6
ext.w R6
cmp #-1,R6
bne L8
L7:
*line 60
*line 61
clr.b (R12)
*line 62
*line 63
move 22(R14),(sp)
move.l #L1,-(sp)
clr -(sp)
move R4,-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _tsplot4
adda.l #16,sp
add #1,R4
L6:
*line 64
move.l 16(R14),R8
move.l (R8),R13
move.l R13,R0
add.l #4,16(R14)
tst.l R0
bne L5
L4:L2:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.data
