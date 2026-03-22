.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _chantab
.globl _Wrkbuf
.globl _ftell
.text
_ftell:
~~ftell:
~fp=R13
link R14,#0
movem.l R4-R7/R11-R13,-(sp)
~fcp=R12
~chp=R11
~dpos=R7
~pos=R6
~diff=R5
*line 35
move.l 8(R14),R13
*line 35
*line 35
move.l R13,R0
bne L2
*line 36
*line 40
*line 41
*line 42
clr.l R0
bra L1
*line 43
*line 44
L2:
*line 45
*line 45
tst.b 12(R13)
beq L10000
clr R0
bra L10001
L10000:move #1,R0
L10001:and #1,R0
beq L3
*line 46
*line 50
*line 51
*line 52
clr.l R0
bra L1
*line 53
*line 54
L3:
*line 55
move.b 13(R13),R0
ext.w R0
muls #12,R0
move.l R0,R11
add.l #_chantab,R11
*line 57
*line 57
move.l 4(R11),R0
cmp.l #__filecl,R0
beq L4
*line 58
*line 63
*line 64
*line 65
clr.l R0
bra L1
*line 66
*line 67
L4:
*line 68
move.l 8(R11),R12
*line 70
clr.l R7
move 38(R12),R7
move.l 40(R12),R0
move.l #$9,R1
asl.l R1,R0
add.l R0,R7
*line 72
*line 73
btst #2,12(R13)
beq L5
*line 73
move.l (R13),R5
sub.l 8(R13),R5
move.l R7,R6
add.l R5,R6
bra L6
L5:
*line 74
*line 75
tst.l (R13)
beq L7
*line 75
move.l 4(R13),R5
sub.l (R13),R5
move.l R7,R6
sub.l R5,R6
*line 76
bra L8
L7:
*line 77
move.l R7,R6
L8:L6:
*line 95
move.l R6,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R11-R13
unlk R14
rts
.data
