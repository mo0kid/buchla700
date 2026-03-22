.globl _chantab
.globl _Wrkbuf
.globl _errno
.globl __fatmod
.globl __thefat
.globl __thebpb
.data
L1:
*line 37
.dc.l __badfd
*line 38
.dc.l __filewr
*line 40
.dc.l __conwr
.text
.globl __putsec
.text
__putsec:
~~_putsec:
~fp=R13
~buf=12
~len=16
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 63
move.l 8(R14),R13
*line 63
*line 63
move.l #_Wrkbuf,(sp)
move.l R13,-(sp)
jsr _ReadRN
addq.l #4,sp
move R0,_errno
cmp #1,R0
bne L3
*line 64
*line 69
*line 70
*line 71
clr _errno
*line 72
move #512,(sp)
move #26,-(sp)
move.l #_Wrkbuf,-(sp)
jsr _memset
addq.l #6,sp
*line 73
bra L4
L3:
*line 74
*line 75
tst _errno
beq L5
*line 75
move #-1,R0
bra L2
*line 76
L5:L4:
*line 77
move 16(R14),(sp)
move.l 12(R14),-(sp)
clr R0
move 38(R13),R0
swap R0
clr R0
swap R0
add.l #_Wrkbuf,R0
move.l R0,-(sp)
jsr _memcpy
addq.l #8,sp
*line 79
*line 79
move.l #_Wrkbuf,(sp)
move.l R13,-(sp)
jsr _WriteRN
addq.l #4,sp
move R0,_errno
beq L6
*line 80
*line 85
*line 86
*line 87
move #-1,R0
bra L2
*line 88
*line 89
L6:
*line 90
*line 90
clr R0
move 38(R13),R0
add 16(R14),R0
and #511,R0
move R0,38(R13)
bne L7
*line 91
*line 92
add.l #$1,40(R13)
*line 93
*line 94
*line 94
move.l R13,(sp)
jsr __seek
tst R0
bge L8
*line 95
*line 100
*line 101
*line 102
move #-1,R0
bra L2
*line 103
L8:
*line 104
*line 105
*line 110
*line 111
L7:
*line 112
clr R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __filewr
.text
__filewr:
~~_filewr:
~fp=R13
~buffer=R12
~len=R7
link R14,#-2
movem.l R2-R7/R12-R13,-(sp)
~j=R6
~k=R5
~l=R4
~clustr=-2
~curpos=R3
*line 135
move.l 8(R14),R13
*line 135
move.l 12(R14),R12
*line 135
move 16(R14),R7
*line 135
clr.l R3
move 38(R13),R3
move.l 40(R13),R0
move.l #$9,R1
asl.l R1,R0
add.l R0,R3
*line 137
*line 137
tst 26(R13)
bne L10
*line 138
*line 144
*line 145
*line 146
*line 146
jsr __newcls
move R0,-2(R14)
bne L11
*line 147
*line 148
move #5,_errno
*line 149
clr R0
move R7,R0
bra L9
*line 150
*line 151
L11:
*line 152
move -2(R14),(sp)
jsr _micons
move R0,26(R13)
*line 153
move #4088,(sp)
move -2(R14),-(sp)
move.l #__thefat,-(sp)
jsr __ptcl12
addq.l #6,sp
*line 154
move #1,__fatmod
*line 155
move -2(R14),(sp)
move.l __thebpb,-(sp)
jsr __cl2lsn
addq.l #4,sp
ext.l R0
move.l R0,44(R13)
*line 156
move -2(R14),36(R13)
*line 157
clr 34(R13)
*line 158
move.l __thebpb,R8
clr R0
move 2(R8),R0
swap R0
clr R0
swap R0
move.l R0,52(R13)
*line 166
*line 167
*line 168
L10:
*line 169
clr R4
*line 177
*line 177
tst 38(R13)
beq L12
*line 178
*line 179
*line 180
move #512,R4
sub 38(R13),R4
clr R0
move R4,R0
cmp R0,R7
bcc L13
*line 180
move R7,R4
*line 181
L13:
*line 182
*line 183
move R4,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr __putsec
addq.l #8,sp
tst R0
beq L14
*line 183
move #-1,R0
bra L9
L14:
*line 184
*line 185
L12:
*line 186
*line 186
move R7,R5
sub R4,R5
move #9,R0
lsr R0,R5
beq L15
*line 187
*line 188
*line 188
move R5,(sp)
move.l R12,R0
clr.l R1
move R4,R1
add.l R1,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _blkwr
addq.l #8,sp
move R0,R6
tst R6
beq L16
*line 189
*line 190
clr R0
move R5,R0
sub R6,R0
move #9,R1
lsl R1,R0
add R0,R4
*line 191
*line 192
*line 193
move.l R3,R0
clr.l R1
move R4,R1
add.l R1,R0
cmp.l 48(R13),R0
ble L17
*line 193
move.l R3,R0
clr.l R1
move R4,R1
add.l R1,R0
move.l R0,48(R13)
move.l R0,(sp)
jsr _miconl
move.l R0,28(R13)
*line 194
*line 199
*line 200
L17:
*line 201
clr R0
move R4,R0
bra L9
*line 202
*line 203
L16:
*line 204
clr R0
move R5,R0
move #9,R1
lsl R1,R0
add R0,R4
*line 205
*line 206
*line 207
L15:
*line 208
*line 208
cmp R7,R4
bcc L18
*line 209
*line 210
*line 210
move R7,(sp)
clr R0
move R4,R0
sub R0,(sp)
move.l R12,R0
clr.l R1
move R4,R1
add.l R1,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr __putsec
addq.l #8,sp
tst R0
beq L19
*line 211
*line 212
*line 213
move.l R3,R0
clr.l R1
move R4,R1
add.l R1,R0
cmp.l 48(R13),R0
ble L20
*line 213
move.l R3,R0
clr.l R1
move R4,R1
add.l R1,R0
move.l R0,48(R13)
move.l R0,(sp)
jsr _miconl
move.l R0,28(R13)
*line 214
*line 219
*line 220
L20:
*line 221
clr R0
move R4,R0
bra L9
*line 222
L19:
*line 223
*line 224
L18:
*line 225
*line 226
move.l R3,R0
clr.l R1
move R7,R1
add.l R1,R0
cmp.l 48(R13),R0
ble L21
*line 226
move.l R3,R0
clr.l R1
move R7,R1
add.l R1,R0
move.l R0,48(R13)
move.l R0,(sp)
jsr _miconl
move.l R0,28(R13)
*line 227
*line 232
*line 233
L21:
*line 234
clr R0
move R7,R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.globl _write
.text
_write:
~~write:
~fd=8
~buff=10
~len=14
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~chp=R13
*line 254
*line 254
tst 8(R14)
blt L10000
cmp #11,8(R14)
ble L23
L10000:*line 255
*line 256
move #9,_errno
*line 257
move #-1,R0
bra L22
*line 258
*line 259
L23:
*line 260
move 8(R14),R0
muls #12,R0
move.l R0,R13
add.l #_chantab,R13
*line 262
move 14(R14),-(sp)
move.l 10(R14),-(sp)
move.l 8(R13),-(sp)
move.b 1(R13),R0
ext.w R0
move R0,R8
add.l R8,R8
add.l R8,R8
move.l #L1,R9
move.l 0(R8,R9.l),R8
jsr (R8)
adda.l #10,sp
bra L22
L22:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
