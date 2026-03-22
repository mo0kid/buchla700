.globl _vmput
.text
_vmput:
~~vmput:
~sbase=8
~row=12
~col=14
~ms=16
~ma=20
link R14,#-4
movem.l R4-R7,-(sp)
~c=R7
~tc=R6
~tr=R5
~cp=-4
*line 39
move 12(R14),R5
*line 41
bra L4
L3:
*line 42
*line 43
move 14(R14),R6
*line 44
*line 45
bra L7
L6:
*line 46
move 20(R14),(sp)
move R7,-(sp)
move R6,-(sp)
move R5,-(sp)
move.l 8(R14),-(sp)
jsr _vputc
adda.l #10,sp
add #1,R6
L7:
*line 46
move.l -4(R14),R8
move.b (R8),R0
ext.w R0
move R0,R7
clr R0
move R7,R0
add.l #1,-4(R14)
tst R0
bne L6
L5:
*line 47
*line 48
add #1,R5
L4:
*line 49
move.l 16(R14),R8
move.l (R8),R0
move.l R0,-4(R14)
add.l #4,16(R14)
tst.l R0
bne L3
L2:L1:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _vmputa
.text
_vmputa:
~~vmputa:
~sbase=8
~row=12
~col=14
~ms=16
~ma=20
link R14,#-8
movem.l R4-R7,-(sp)
~c=R7
~tc=R6
~tr=R5
~tm=-4
~cp=-8
*line 69
move 12(R14),R5
*line 71
bra L11
L10:
*line 72
*line 73
move 14(R14),R6
*line 74
move.l 20(R14),R8
move.l (R8),-4(R14)
add.l #4,20(R14)
*line 75
*line 76
bra L14
L13:
*line 77
move.l -4(R14),R8
move (R8),(sp)
move R7,-(sp)
move R6,-(sp)
move R5,-(sp)
move.l 8(R14),-(sp)
jsr _vputc
adda.l #10,sp
add.l #2,-4(R14)
add #1,R6
L14:
*line 77
move.l -8(R14),R8
move.b (R8),R0
ext.w R0
move R0,R7
clr R0
move R7,R0
add.l #1,-8(R14)
tst R0
bne L13
L12:
*line 78
*line 79
add #1,R5
L11:
*line 80
move.l 16(R14),R8
move.l (R8),R0
move.l R0,-8(R14)
add.l #4,16(R14)
tst.l R0
bne L10
L9:L8:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
