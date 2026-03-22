.globl ___atab
.globl _memcmpu
.text
_memcmpu:
~~memcmpu:
~s1=R13
~s2=R12
~n=16
link R14,#0
movem.l R5-R7/R12-R13,-(sp)
~c1=R7
~c2=R6
*line 17
move.l 8(R14),R13
*line 17
move.l 12(R14),R12
*line 17
bra L4
L3:
*line 18
*line 19
move.b (R13)+,R7
*line 20
move.b (R12)+,R6
*line 21
*line 22
*line 23
move.b R7,R0
ext.w R0
and #-128,R0
bne L5
move.b R7,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #4,(R8)
beq L5
*line 23
add.b #-32,R7
*line 24
L5:
*line 25
*line 26
move.b R6,R0
ext.w R0
and #-128,R0
bne L6
move.b R6,R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #4,(R8)
beq L6
*line 26
add.b #-32,R6
*line 27
L6:
*line 28
*line 29
cmp.b R6,R7
bge L7
*line 29
move #-1,R0
bra L1
*line 30
L7:
*line 31
*line 32
cmp.b R6,R7
ble L8
*line 32
move #1,R0
bra L1
*line 33
L8:
*line 34
sub #1,16(R14)
L4:
*line 35
tst 16(R14)
bne L3
L2:
*line 37
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R6-R7/R12-R13
unlk R14
rts
.data
