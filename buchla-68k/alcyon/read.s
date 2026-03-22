.globl _chantab
.globl _Wrkbuf
.globl _errno
.data
L1:
*line 56
.dc.l __badfd
*line 57
.dc.l __filerd
*line 59
.dc.l __conin
.text
.globl _read
.text
_read:
~~read:
~fd=8
~buff=10
~len=14
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~chp=R13
*line 79
*line 79
tst 8(R14)
blt L10000
cmp #11,8(R14)
ble L3
L10000:*line 80
*line 81
move #9,_errno
*line 82
move #-1,R0
bra L2
*line 83
*line 84
L3:
*line 85
move 8(R14),R0
muls #12,R0
move.l R0,R13
add.l #_chantab,R13
*line 86
move 14(R14),-(sp)
move.l 10(R14),-(sp)
move.l 8(R13),-(sp)
move.b (R13),R0
ext.w R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #L1,R9
move.l 0(R8,R9.l),R8
jsr (R8)
adda.l #10,sp
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __getsec
.text
__getsec:
~~_getsec:
~fp=R13
~buf=12
~len=16
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 105
move.l 8(R14),R13
*line 105
*line 106
move.l #_Wrkbuf,(sp)
move.l R13,-(sp)
jsr _ReadRN
addq.l #4,sp
move R0,_errno
beq L5
*line 106
move #-1,R0
bra L4
*line 107
L5:
*line 108
move 16(R14),(sp)
clr R0
move 38(R13),R0
swap R0
clr R0
swap R0
add.l #_Wrkbuf,R0
move.l R0,-(sp)
move.l 12(R14),-(sp)
jsr _memcpy
addq.l #8,sp
*line 110
*line 110
clr R0
move 38(R13),R0
add 16(R14),R0
and #511,R0
move R0,38(R13)
bne L6
*line 111
*line 112
add.l #$1,40(R13)
*line 113
*line 114
*line 115
move.l R13,(sp)
jsr __seek
tst R0
bge L7
*line 115
move #-1,R0
bra L4
L7:
*line 116
*line 117
L6:
*line 118
clr R0
bra L4
L4:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __filerd
.text
__filerd:
~~_filerd:
~fp=R13
~buffer=12
~len=16
link R14,#0
movem.l R2-R7/R13-R13,-(sp)
~l=R7
~j=R6
~k=R5
~curpos=R4
~newpos=R3
*line 141
move.l 8(R14),R13
*line 141
clr R7
*line 142
clr.l R4
move 38(R13),R4
move.l 40(R13),R0
move.l #$9,R1
asl.l R1,R0
add.l R0,R4
*line 143
move.l R4,R3
clr.l R0
move 16(R14),R0
add.l R0,R3
*line 151
*line 151
cmp.l 48(R13),R3
ble L9
*line 152
*line 153
move.l 48(R13),R0
sub.l R4,R0
move R0,16(R14)
*line 154
*line 158
*line 159
*line 160
L9:
*line 161
*line 161
tst 38(R13)
beq L10
*line 162
*line 163
*line 164
move #512,R7
sub 38(R13),R7
clr R0
move R7,R0
cmp 16(R14),R0
bls L11
*line 164
move 16(R14),R7
*line 165
L11:
*line 166
*line 167
move R7,(sp)
move.l 12(R14),-(sp)
move.l R13,-(sp)
jsr __getsec
addq.l #8,sp
tst R0
beq L12
*line 167
clr R0
move 16(R14),R0
bra L8
L12:
*line 168
*line 169
L10:
*line 170
*line 171
move 16(R14),R5
sub R7,R5
move #9,R0
lsr R0,R5
beq L13
*line 171
*line 172
move R5,(sp)
clr R0
move R7,R0
swap R0
clr R0
swap R0
add.l 12(R14),R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _blkrd
addq.l #8,sp
move R0,R6
tst R6
beq L14
*line 172
clr R0
move R7,R0
clr R1
move R5,R1
sub R6,R1
move #9,R2
lsl R2,R1
add R1,R0
bra L8
*line 173
L14:L13:
*line 174
clr R0
move R5,R0
move #9,R1
lsl R1,R0
add R0,R7
*line 176
*line 177
cmp 16(R14),R7
bcc L15
*line 177
*line 178
move 16(R14),(sp)
clr R0
move R7,R0
sub R0,(sp)
clr R0
move R7,R0
swap R0
clr R0
swap R0
add.l 12(R14),R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr __getsec
addq.l #8,sp
tst R0
beq L16
*line 178
clr R0
move R7,R0
bra L8
*line 179
L16:L15:
*line 180
clr R0
move 16(R14),R0
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R3-R7/R13-R13
unlk R14
rts
.data
