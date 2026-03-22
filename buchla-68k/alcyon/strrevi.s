.globl _strrevi
.text
_strrevi:
~~strrevi:
~s=8
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~p1=R13
~p2=R12
~i=R7
~c=R6
*line 22
move.l 8(R14),R13
*line 23
move.l 8(R14),R12
*line 24
clr.l R7
*line 26
bra L4
L3:
*line 27
*line 28
add.l #$1,R7
*line 29
add.l #1,R12
L4:
*line 30
tst.b (R12)
bne L3
L2:
*line 32
sub.l #1,R12
*line 33
asr.l #$1,R7
*line 35
bra L7
L6:
*line 36
*line 37
move.b (R12),R6
*line 38
move.l R12,R8
move.b (R13),(R8)
sub.l #1,R12
*line 39
move.b R6,(R13)+
L7:
*line 40
move.l R7,R0
sub.l #$1,R7
tst.l R0
bne L6
L5:
*line 42
move.l 8(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.data
