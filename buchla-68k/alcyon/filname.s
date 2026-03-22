.globl _FilName
.text
_FilName:
~~FilName:
~s=R13
~p=R12
link R14,#0
movem.l R6-R7/R11-R13,-(sp)
~tp=R11
~i=R7
*line 29
move.l 8(R14),R13
*line 29
move.l 12(R14),R12
*line 29
move.l R12,R11
*line 31
clr R7
bra L4
L5:
*line 32
*line 33
*line 33
tst.b (R13)
beq L6
*line 34
*line 35
*line 36
cmp.b #46,(R13)
beq L2
*line 37
*line 38
move.b (R13)+,(R12)+
*line 39
bra L7
L6:
*line 40
*line 41
*line 42
clr.b (R12)
*line 43
move.l R11,R0
bra L1
L7:
*line 44
L3:
*line 31
add #1,R7
L4:
*line 31
cmp #8,R7
blt L5
L2:
*line 47
clr.b (R12)
*line 48
move.l R11,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R11-R13
unlk R14
rts
.globl _FilExt
.text
_FilExt:
~~FilExt:
~s=R13
~p=R12
link R14,#0
movem.l R5-R7/R11-R13,-(sp)
~c=R7
~tp=R11
~i=R6
*line 69
move.l 8(R14),R13
*line 69
move.l 12(R14),R12
*line 69
move.l R12,R11
*line 71
bra L11
L10:
*line 72
*line 73
*line 73
cmp.b #46,R7
bne L12
*line 74
*line 75
add.l #1,R13
*line 76
*line 77
clr R6
bra L15
L16:
*line 78
*line 79
*line 79
tst.b (R13)
beq L17
*line 80
*line 81
move.b (R13)+,(R12)+
*line 82
bra L18
L17:
*line 83
*line 84
*line 85
clr.b (R12)
*line 86
move.l R11,R0
bra L8
L18:
*line 87
L14:
*line 77
add #1,R6
L15:
*line 77
cmp #3,R6
blt L16
L13:
*line 88
*line 89
*line 90
clr.b (R12)
*line 91
move.l R11,R0
bra L8
*line 92
bra L19
L12:
*line 93
*line 94
*line 95
add.l #1,R13
L19:
*line 96
L11:
*line 97
move.b (R13),R7
bne L10
L9:
*line 99
clr.b (R12)
*line 100
move.l R11,R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R6-R7/R11-R13
unlk R14
rts
.data
