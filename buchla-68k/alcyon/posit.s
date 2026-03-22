.globl _chantab
.globl _Wrkbuf
.globl _errno
.globl _posit
.text
_posit:
~~posit:
~fd=8
~pos=10
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~fp=R13
*line 28
*line 28
tst 8(R14)
blt L10000
cmp #11,8(R14)
ble L2
L10000:*line 29
*line 30
move #9,_errno
*line 31
move #-1,R0
bra L1
*line 32
*line 33
L2:
*line 34
move 8(R14),R0
muls #12,R0
add.l #_chantab,R0
move.l R0,R8
move.l 8(R8),R13
*line 36
*line 37
move 8(R14),R0
muls #12,R0
add.l #_chantab,R0
move.l R0,R8
tst.b 3(R8)
beq L10001
clr R0
move 10(R14),R0
move #9,R1
lsl R1,R0
swap R0
clr R0
swap R0
cmp.l 48(R13),R0
ble L3
L10001:*line 38
*line 39
move #22,_errno
*line 40
or #8192,32(R13)
*line 41
move #-1,R0
bra L1
*line 42
*line 43
L3:
*line 44
clr.l R0
move 10(R14),R0
move.l R0,40(R13)
*line 45
clr 38(R13)
*line 47
*line 47
move.l R13,(sp)
jsr __seek
tst R0
bge L4
*line 48
*line 49
move #5,_errno
*line 50
or #8192,32(R13)
*line 51
move #-1,R0
bra L1
*line 52
*line 53
L4:
*line 54
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
