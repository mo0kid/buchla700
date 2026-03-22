.globl _errno
.globl __berrno
.globl __thefat
.globl __thebpb
.globl __b_tbuf
.globl __b_trak
.globl __b_side
.globl __b_sect
.globl __b_tsec
.globl __secrd
.text
__secrd:
~~_secrd:
~buf=R13
~rec=R7
link R14,#-4
movem.l R3-R7/R13-R13,-(sp)
~track=R6
~side=R5
~sector=R4
~brc=-4
*line 81
move.l 8(R14),R13
*line 81
move 12(R14),R7
*line 81
*line 82
move.l __thebpb,R8
cmp #9,24(R8)
beq L2
*line 82
move.l #$fffffff9,R0
bra L1
*line 83
L2:
*line 84
*line 85
move.l __thebpb,R8
cmp #512,(R8)
beq L3
*line 85
move.l #$fffffff9,R0
bra L1
*line 86
L3:
*line 87
move R7,R6
move.l __thebpb,R8
move 22(R8),-(sp)
move R6,R0
ext.l R0
divu (sp)+,R0
move R0,R6
*line 88
move R6,R0
move.l __thebpb,R9
mulu 22(R9),R0
move R0,__b_tsec
*line 89
move R7,R4
sub __b_tsec,R4
*line 91
*line 91
move.l __thebpb,R8
cmp 24(R8),R4
blo L4
*line 92
*line 93
move.l __thebpb,R8
move 24(R8),R0
sub R0,R4
*line 94
move #1,R5
*line 95
move.l __thebpb,R8
move 24(R8),R0
add R0,__b_tsec
*line 96
bra L5
L4:
*line 97
*line 98
*line 99
clr R5
L5:
*line 108
*line 108
cmp __b_trak,R6
bne L10000
cmp __b_side,R5
beq L6
L10000:*line 109
*line 110
*line 110
clr (sp)
move __b_tsec,-(sp)
move.l __thebpb,R8
move 24(R8),-(sp)
move.l #__b_tbuf,-(sp)
clr -(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
move.l R0,-4(R14)
beq L7
*line 111
*line 112
move #-1,__b_trak
*line 113
move #-1,__b_side
*line 114
move.l -4(R14),R0
bra L1
*line 115
*line 116
L7:
*line 117
move R6,__b_trak
*line 118
move R5,__b_side
*line 119
*line 120
L6:
*line 121
move #512,(sp)
move R4,R0
move #9,R1
asl R1,R0
ext.l R0
add.l #__b_tbuf,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _memcpy
addq.l #8,sp
*line 122
clr.l R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R4-R7/R13-R13
unlk R14
rts
.globl _blkrd
.text
_blkrd:
~~blkrd:
~fcp=R13
~buf=R12
~ns=R7
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~brc=R6
~rb=R5
*line 146
move.l 8(R14),R13
*line 146
move.l 12(R14),R12
*line 146
move 16(R14),R7
*line 146
*line 147
tst R7
bge L9
*line 147
move R7,R0
bra L8
*line 148
L9:
*line 149
bra L12
L11:
*line 150
*line 155
*line 156
*line 157
*line 158
*line 158
move.l 44(R13),R0
move R0,(sp)
move.l R12,-(sp)
jsr __secrd
addq.l #4,sp
move.l R0,R6
beq L13
*line 161
*line 162
*line 163
move.l R6,__berrno
*line 164
move #5,_errno
*line 165
move R7,R0
bra L8
*line 166
*line 167
L13:
*line 168
*line 168
move.l #__thefat,(sp)
move.l __thebpb,-(sp)
move.l R13,-(sp)
jsr __nsic
addq.l #8,sp
move R0,R5
beq L14
*line 169
*line 170
*line 171
cmp #-1,R5
bne L15
*line 171
move #5,_errno
*line 172
L15:
*line 173
move R7,R0
bra L8
*line 174
*line 175
L14:
*line 176
move.l __thebpb,R8
clr R0
move (R8),R0
swap R0
clr R0
swap R0
add.l R0,R12
L12:
*line 177
move R7,R0
sub #1,R7
tst R0
bne L11
L10:
*line 179
clr R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.data
