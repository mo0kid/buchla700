.globl _vputsv
.text
_vputsv:
~~vputsv:
~sbase=8
~row=12
~col=14
~str=16
~attrib=20
~len=22
link R14,#-6
~c=-2
*line 36
bra L4
L3:
*line 37
*line 38
move 22(R14),(sp)
move 20(R14),-(sp)
move -2(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _vputcv
adda.l #12,sp
*line 39
*line 40
*line 40
add #1,14(R14)
clr R0
move 14(R14),R0
cmp #64,R0
blo L5
*line 41
*line 42
clr 14(R14)
*line 43
*line 44
*line 45
add #1,12(R14)
clr R0
move 12(R14),R0
cmp #25,R0
blo L6
*line 45
clr 12(R14)
L6:
*line 46
L5:L4:
*line 47
move.l 16(R14),R8
move.b (R8),R0
ext.w R0
move R0,-2(R14)
add.l #1,16(R14)
tst R0
bne L3
L2:L1:unlk R14
rts
.globl _vputsav
.text
_vputsav:
~~vputsav:
~sbase=8
~row=12
~col=14
~str=16
~attrib=20
~len=24
link R14,#-6
~c=-2
*line 69
bra L10
L9:
*line 70
*line 71
move 24(R14),(sp)
move.l 20(R14),R8
move (R8),-(sp)
move -2(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _vputcv
adda.l #12,sp
add.l #2,20(R14)
*line 72
*line 73
*line 73
add #1,14(R14)
clr R0
move 14(R14),R0
cmp #64,R0
blo L11
*line 74
*line 75
clr 14(R14)
*line 76
*line 77
*line 78
add #1,12(R14)
clr R0
move 12(R14),R0
cmp #25,R0
blo L12
*line 78
clr 12(R14)
L12:
*line 79
L11:L10:
*line 80
move.l 16(R14),R8
move.b (R8),R0
ext.w R0
move R0,-2(R14)
add.l #1,16(R14)
tst R0
bne L9
L8:L7:unlk R14
rts
.data
