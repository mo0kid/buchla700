.globl _chantab
.globl _Wrkbuf
.globl _errno
.globl _lseek
.text
_lseek:
~~lseek:
~pos=R7
~fd=8
~how=14
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~fp=R13
*line 29
move.l 10(R14),R7
*line 29
*line 29
tst 8(R14)
blt L10000
cmp #11,8(R14)
ble L2
L10000:*line 30
*line 34
*line 35
*line 36
move #9,_errno
*line 37
move.l #$ffffffff,R0
bra L1
*line 38
*line 39
L2:
*line 40
*line 40
move 8(R14),R0
muls #12,R0
add.l #_chantab,R0
move.l R0,R8
tst.b 3(R8)
bne L3
*line 41
*line 45
*line 46
*line 47
move #22,_errno
*line 48
move.l #$ffffffff,R0
bra L1
*line 49
*line 50
L3:
*line 51
move 8(R14),R0
muls #12,R0
add.l #_chantab,R0
move.l R0,R8
move.l 8(R8),R13
*line 53
move 14(R14),R0
bra L5
*line 54
L6:
*line 55
*line 56
add.l 48(R13),R7
bra L4
*line 57
*line 58
L7:
*line 59
*line 60
clr.l R0
move 38(R13),R0
move.l 40(R13),R1
move.l #$9,R2
asl.l R2,R1
add.l R1,R0
add.l R0,R7
*line 61
L8:
*line 62
bra L4
*line 63
*line 64
L9:
*line 65
*line 66
move #22,_errno
*line 67
move.l #$ffffffff,R0
bra L1
bra L4
L5:tst R0
beq L8
cmp #1,R0
beq L7
cmp #2,R0
beq L6
bra L9
L4:
*line 71
*line 71
tst.l R7
bge L10
*line 72
*line 73
clr 38(R13)
*line 74
clr.l 40(R13)
*line 75
or #8192,32(R13)
*line 76
*line 80
*line 81
*line 82
move #22,_errno
*line 83
move.l #$ffffffff,R0
bra L1
*line 84
bra L11
L10:
*line 85
*line 85
cmp.l 48(R13),R7
ble L12
*line 86
*line 87
move.l 48(R13),R0
and.l #$1ff,R0
move R0,38(R13)
*line 88
move.l 48(R13),R0
move.l #$9,R1
asr.l R1,R0
move.l R0,40(R13)
*line 89
or #8192,32(R13)
*line 90
*line 95
*line 96
*line 97
move #22,_errno
*line 98
move.l #$ffffffff,R0
bra L1
*line 99
*line 100
L12:L11:
*line 101
move.l R7,R0
and.l #$1ff,R0
move R0,38(R13)
*line 102
move.l R7,R0
move.l #$9,R1
asr.l R1,R0
move.l R0,40(R13)
*line 104
*line 104
move.l R13,(sp)
jsr __seek
tst R0
bge L13
*line 105
*line 106
or #8192,32(R13)
*line 107
move #5,_errno
*line 108
move.l #$ffffffff,R0
bra L1
*line 109
*line 110
L13:
*line 111
*line 112
cmp.l 48(R13),R7
bne L14
*line 112
or #-32768,32(R13)
*line 113
*line 118
*line 119
L14:
*line 120
move.l R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
