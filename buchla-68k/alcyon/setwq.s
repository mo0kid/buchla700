.globl _setwq
.text
_setwq:
~~setwq:
~qp=R13
~qadr=12
~qsiz=16
~hi=18
~lo=20
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 37
move.l 8(R14),R13
*line 37
*line 38
tst.l 12(R14)
bne L2
*line 38
clr 16(R14)
*line 39
L2:
*line 40
move.l 12(R14),12(R13)
*line 41
move 16(R14),(R13)
*line 42
clr 2(R13)
*line 43
clr 4(R13)
*line 44
clr 6(R13)
*line 45
move 18(R14),8(R13)
*line 46
move 20(R14),10(R13)
*line 48
clr R0
move 16(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _putwq
.text
_putwq:
~~putwq:
~qp=R13
~c=R7
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
*line 77
move.l 8(R14),R13
*line 77
move 12(R14),R7
*line 77
*line 77
tst (R13)
beq L4
*line 78
*line 79
*line 80
clr R0
move 2(R13),R0
cmp (R13),R0
bne L5
*line 80
move #-1,R0
bra L3
*line 81
L5:
*line 82
clr R0
move 4(R13),R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l 12(R13),R0
move.l R0,R8
move R7,(R8)
add #1,4(R13)
*line 83
*line 84
*line 85
clr R0
move 4(R13),R0
cmp (R13),R0
blo L6
*line 85
clr 4(R13)
*line 86
L6:
*line 87
*line 88
add #1,2(R13)
clr R0
move 2(R13),R0
cmp 8(R13),R0
bne L7
*line 88
move #1,R0
bra L3
*line 89
bra L8
L7:
*line 90
clr R0
bra L3
L8:
*line 91
bra L9
L4:
*line 92
*line 93
*line 94
move #-2,R0
bra L3
L9:L3:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _getwq
.text
_getwq:
~~getwq:
~qp=R13
~p=R12
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
*line 124
move.l 8(R14),R13
*line 124
move.l 12(R14),R12
*line 124
*line 124
tst (R13)
beq L11
*line 125
*line 126
*line 126
tst 2(R13)
beq L12
*line 127
*line 128
clr R0
move 6(R13),R0
lsl #1,R0
swap R0
clr R0
swap R0
add.l 12(R13),R0
move.l R0,R8
move (R8),(R12)
add #1,6(R13)
*line 129
*line 130
*line 131
clr R0
move 6(R13),R0
cmp (R13),R0
blo L13
*line 131
clr 6(R13)
*line 132
L13:
*line 133
*line 134
sub #1,2(R13)
clr R0
move 2(R13),R0
cmp 10(R13),R0
bne L14
*line 134
move #1,R0
bra L10
*line 135
bra L15
L14:
*line 136
clr R0
bra L10
L15:
*line 137
bra L16
L12:
*line 138
*line 139
*line 140
move #-1,R0
bra L10
L16:
*line 141
*line 142
bra L17
L11:
*line 143
*line 144
*line 145
move #-2,R0
bra L10
L17:L10:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.data
