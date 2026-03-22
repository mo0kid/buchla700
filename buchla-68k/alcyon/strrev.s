.globl _strrev
.text
_strrev:
~~strrev:
~s2=R13
~s1=8
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~s3=R12
~i=R7
*line 24
move.l 12(R14),R13
*line 24
clr.l R7
*line 25
move.l 8(R14),R12
*line 27
bra L4
L3:
*line 28
*line 29
add.l #1,R13
*line 30
add.l #$1,R7
L4:
*line 31
tst.b (R13)
bne L3
L2:
*line 33
sub.l #1,R13
*line 35
bra L7
L6:
*line 36
move.l R13,R8
move.b (R8),(R12)+
sub.l #1,R13
L7:
*line 36
move.l R7,R0
sub.l #$1,R7
tst.l R0
bne L6
L5:
*line 38
clr.b (R12)
*line 39
move.l 8(R14),R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
