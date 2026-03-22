.globl _addfpu
.text
_addfpu:
~~addfpu:
~t=8
~k=10
link R14,#0
movem.l R4-R7,-(sp)
~x=R7
~z=R6
~y=R5
*line 31
move 8(R14),(sp)
jsr _fromfpu
move R0,R7
*line 33
*line 34
cmp #32767,R7
bne L2
*line 34
clr R0
move 8(R14),R0
bra L1
*line 35
L2:
*line 36
move 8(R14),R5
*line 37
move R7,R6
add 10(R14),R6
*line 39
*line 40
cmp #32767,R6
blt L3
*line 40
move #32767,(sp)
jsr _tofpu
bra L1
*line 41
L3:
*line 42
bra L6
L5:
*line 43
add #1,R7
move R7,(sp)
jsr _tofpu
move R0,R5
L6:
*line 43
cmp 8(R14),R5
beq L5
cmp R7,R6
bgt L5
L4:
*line 45
clr R0
move R5,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _subfpu
.text
_subfpu:
~~subfpu:
~t=8
~k=10
link R14,#0
movem.l R4-R7,-(sp)
~x=R7
~z=R6
~y=R5
*line 65
move 8(R14),(sp)
jsr _fromfpu
move R0,R7
*line 67
*line 68
cmp #1,R7
bne L8
*line 68
clr R0
move 8(R14),R0
bra L7
*line 69
L8:
*line 70
move 8(R14),R5
*line 71
move R7,R6
sub 10(R14),R6
*line 73
*line 74
cmp #1,R6
bgt L9
*line 74
move #1,(sp)
jsr _tofpu
bra L7
*line 75
L9:
*line 76
bra L12
L11:
*line 77
sub #1,R7
move R7,(sp)
jsr _tofpu
move R0,R5
L12:
*line 77
cmp 8(R14),R5
beq L11
cmp R7,R6
blt L11
L10:
*line 79
clr R0
move R5,R0
bra L7
L7:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
