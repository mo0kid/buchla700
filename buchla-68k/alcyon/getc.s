.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _getc
.text
_getc:
~~getc:
~ptr=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~len=R7
*line 17
move.l 8(R14),R13
*line 17
*line 17
move.l (R13),R0
cmp.l 4(R13),R0
blo L2
*line 18
*line 19
*line 20
btst #3,12(R13)
beq L3
*line 20
move #-1,R0
bra L1
*line 21
L3:
*line 22
and.b #-5,12(R13)
*line 23
*line 24
*line 25
tst.l 8(R13)
bne L4
*line 25
move.l R13,(sp)
jsr _getbuff
*line 26
L4:
*line 27
*line 27
move 16(R13),(sp)
move.l 8(R13),-(sp)
move.b 13(R13),R0
ext.w R0
move R0,-(sp) 
jsr _read
addq.l #6,sp
move R0,R7
bgt L5
*line 28
*line 29
tst R7
bne L10000
move #8,R0
bra L10002
L10000:move #16,R0
L10002:move.b 12(R13),R1
or.b R0,R1
move.b R1,12(R13)
*line 30
move #-1,R0
bra L1
*line 31
*line 32
L5:
*line 33
move R7,R0
ext.l R0
move.l 8(R13),R1
move.l R1,(R13)
add.l R1,R0
move.l R0,4(R13)
*line 34
*line 35
L2:
*line 36
move.l (R13),R8
move.b (R8),R0
ext.w R0
and #255,R0
add.l #1,(R13)
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
