.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _chantab
.globl _Wrkbuf
.globl _fseek
.text
_fseek:
~~fseek:
~fp=R13
~pos=12
~mode=16
link R14,#-4
movem.l R5-R7/R13-R13,-(sp)
~i=R7
~lr=R6
~curpos=-4
*line 27
move.l 8(R14),R13
*line 27
*line 27
btst #2,12(R13)
beq L2
*line 28
*line 29
*line 30
move #-1,(sp)
move.l R13,-(sp)
jsr _flush_
addq.l #4,sp
tst R0
beq L3
*line 30
move #-1,R0
bra L1
*line 31
L3:bra L4
L2:
*line 32
*line 33
*line 34
*line 35
cmp #1,16(R14)
bne L5
tst.l (R13)
beq L5
*line 35
move.l 4(R13),R0
sub.l (R13),R0
sub.l R0,12(R14)
L5:L4:
*line 38
clr R0
ext.l R0
move.l R0,4(R13)
move.l R0,(R13)
*line 39
and.b #-9,12(R13)
*line 41
move 16(R14),(sp)
move.l 12(R14),-(sp)
move.b 13(R13),R0
ext.w R0
move R0,-(sp) 
jsr _lseek
addq.l #6,sp
move R0,R6
*line 43
*line 44
move.b 13(R13),R0
ext.w R0
muls #12,R0
move.l R0,R8
move.l #_chantab,R9
move.l 8(R8,R9.l),R8
clr R0
move 32(R8),R0
and #-32768,R0
beq L6
*line 44
or.b #8,12(R13)
*line 45
L6:
*line 46
*line 47
tst R6
bge L7
*line 47
move #-1,R0
bra L1
*line 48
L7:
*line 49
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.data
