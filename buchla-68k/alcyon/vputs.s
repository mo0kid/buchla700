.globl _vputs
.text
_vputs:
~~vputs:
~sbase=8
~row=12
~col=14
~str=16
~attrib=20
link R14,#-6
~c=-2
*line 35
bra L4
L3:
*line 36
*line 37
move 20(R14),(sp)
move -2(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _vputc
adda.l #10,sp
*line 38
*line 39
*line 39
add #1,14(R14)
clr R0
move 14(R14),R0
cmp #64,R0
blo L5
*line 40
*line 41
clr 14(R14)
*line 42
*line 43
*line 44
add #1,12(R14)
clr R0
move 12(R14),R0
cmp #25,R0
blo L6
*line 44
clr 12(R14)
L6:
*line 45
L5:L4:
*line 46
move.l 16(R14),R8
move.b (R8),R0
ext.w R0
move R0,-2(R14)
add.l #1,16(R14)
tst R0
bne L3
L2:L1:unlk R14
rts
.globl _vputsa
.text
_vputsa:
~~vputsa:
~sbase=8
~row=12
~col=14
~str=16
~attrib=20
link R14,#-6
~c=-2
*line 66
bra L10
L9:
*line 67
*line 68
move.l 20(R14),R8
move (R8),(sp)
move -2(R14),-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _vputc
adda.l #10,sp
add.l #2,20(R14)
*line 69
*line 70
*line 70
add #1,14(R14)
clr R0
move 14(R14),R0
cmp #64,R0
blo L11
*line 71
*line 72
clr 14(R14)
*line 73
*line 74
*line 75
add #1,12(R14)
clr R0
move 12(R14),R0
cmp #25,R0
blo L12
*line 75
clr 12(R14)
L12:
*line 76
L11:L10:
*line 77
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
