.globl _strrtrm
.text
_strrtrm:
~~strrtrm:
~s=8
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~lp=R13
~rp=R12
*line 18
move.l 8(R14),R13
*line 19
move.l 8(R14),R12
*line 21
bra L4
L3:
*line 22
add.l #1,R12
L4:
*line 22
tst.b (R12)
bne L3
L2:
*line 24
bra L7
L6:
*line 25
*line 26
*line 27
cmp.b #32,(R12)
bne L8
*line 27
clr.b (R12)
*line 28
bra L9
L8:bra L5
L9:
*line 29
L7:
*line 30
sub.l #1,R12
move.l R12,R0
cmp.l R0,R13
ble L6
L5:
*line 32
move.l R13,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.data
