.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _flread
.text
_flread:
~~flread:
~buff=R13
~len=R7
~fp=16
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~ilen=R6
*line 29
move.l 8(R14),R13
*line 29
move.l 12(R14),R7
*line 29
bra L4
L3:
*line 30
*line 31
*line 31
cmp.l #$7e00,R7
blt L5
*line 32
*line 33
*line 34
move.l 16(R14),(sp)
move #1,-(sp)
move #32256,-(sp)
move.l R13,-(sp)
jsr _fread
addq.l #8,sp
cmp #1,R0
beq L6
*line 34
move #-1,R0
bra L1
*line 35
L6:
*line 36
add.l #$7e00,R13
*line 37
sub.l #$7e00,R7
*line 38
bra L7
L5:
*line 39
*line 40
*line 41
move R7,R6
*line 42
*line 43
*line 44
move.l 16(R14),(sp)
move #1,-(sp)
move R6,-(sp)
move.l R13,-(sp)
jsr _fread
addq.l #8,sp
cmp #1,R0
beq L8
*line 44
move #-1,R0
bra L1
*line 45
L8:
*line 46
clr.l R7
L7:
*line 47
L4:
*line 48
tst.l R7
bgt L3
L2:
*line 50
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.data
