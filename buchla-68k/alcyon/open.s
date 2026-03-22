.globl _errno
.globl _chantab
.globl _Wrkbuf
.data
L1:.dc.b $2
.dc.b $2
.dc.b $1
.dc.b $0
*line 21
.dc.l __noper
.text
.data
L2:.dc.b $1
.dc.b $1
.dc.b $0
.dc.b $1
*line 22
.dc.l __fileop
.text
.globl __fcbtab
.data
L3:
*line 34
.dc.l L4
*line 34
.dc.l L1
.dc.l $2
*line 35
.dc.l L5
*line 35
.dc.l L1
.dc.l $2
.dc.l $0
*line 37
.dc.l L2
.dc.l $0
.text
.globl _open
.text
_open:
~~open:
~name=8
~flag=12
~mode=14
link R14,#-4
movem.l R7-R7/R11-R13,-(sp)
~dp=R13
~chp=R12
~dev=R11
~fd=-2
~mdmask=-4
*line 64
move.l #_chantab,R12
clr -2(R14)
bra L9
L10:
*line 65
*line 66
move.l 4(R12),R0
cmp.l #__badfd,R0
beq L11
*line 67
L8:
*line 64
add.l #12,R12
add #1,-2(R14)
L9:
*line 64
cmp #11,-2(R14)
blt L10
L7:
*line 68
move #24,_errno
*line 69
move #-1,R0
bra L6
L11:
*line 74
*line 75
*line 76
move.l #L3,R13
bra L14
L15:
*line 77
*line 78
move.l 8(R14),(sp)
move.l (R13),-(sp)
jsr _strcmp
addq.l #4,sp
tst R0
beq L12
*line 79
L13:
*line 76
add.l #12,R13
L14:
*line 76
tst.l (R13)
bne L15
L12:
*line 80
move.l 4(R13),R11
*line 81
move 12(R14),R0
and #3,R0
add #1,R0
move R0,-4(R14)
*line 83
*line 83
btst #0,-3(R14)
beq L16
*line 84
*line 85
*line 85
move.b (R11),(R12)
bne L17
*line 86
*line 87
move #13,_errno
*line 88
move #-1,R0
bra L6
*line 89
L17:
*line 90
*line 91
L16:
*line 92
*line 92
btst #1,-3(R14)
beq L18
*line 93
*line 94
*line 94
move.b 1(R11),1(R12)
bne L19
*line 95
*line 96
move #13,_errno
*line 97
move #-1,R0
bra L6
*line 98
L19:
*line 99
*line 100
*line 101
*line 102
L18:
*line 103
move.l 8(R13),8(R12)
*line 104
move.b 2(R11),2(R12)
*line 105
move.b 3(R11),3(R12)
*line 106
move.l #__noper,4(R12)
*line 108
*line 108
move.l R13,-(sp)
move.l R12,-(sp)
move 14(R14),-(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
move.l 4(R11),R8
jsr (R8)
adda.l #16,sp
tst R0
bge L20
*line 109
*line 110
move.l #__badfd,4(R12)
*line 111
move #-1,R0
bra L6
*line 112
*line 113
L20:
*line 114
move -2(R14),R0
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.globl _opena
.text
_opena:
~~opena:
~name=8
~flag=12
~mode=14
link R14,#-4
*line 134
move 14(R14),(sp)
move 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #6,sp
bra L21
L21:unlk R14
rts
.globl _openb
.text
_openb:
~~openb:
~name=8
~flag=12
~mode=14
link R14,#-4
*line 151
move 14(R14),(sp)
move 12(R14),-(sp)
or #-32768,(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #6,sp
bra L22
L22:unlk R14
rts
.globl _creat
.text
_creat:
~~creat:
~name=8
~mode=12
link R14,#-4
*line 172
move 12(R14),(sp)
move #769,-(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #6,sp
bra L23
L23:unlk R14
rts
.globl _creata
.text
_creata:
~~creata:
~name=8
~mode=12
link R14,#-4
*line 193
move 12(R14),(sp)
move #769,-(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #6,sp
bra L24
L24:unlk R14
rts
.globl _creatb
.text
_creatb:
~~creatb:
~name=8
~mode=12
link R14,#-4
*line 211
move 12(R14),(sp)
move #-31999,-(sp)
move.l 8(R14),-(sp)
jsr _creat
addq.l #6,sp
bra L25
L25:unlk R14
rts
.globl __fileop
.text
__fileop:
~~_fileop:
~name=8
~flag=12
~mode=14
~chp=16
~dp=20
link R14,#-14
movem.l R7-R7/R13-R13,-(sp)
~fp=R13
~tmpname=-10
~tmpext=-14
*line 237
move.l #__fcbtab,R13
bra L29
L30:
*line 238
*line 239
tst 32(R13)
beq L31
*line 240
L28:
*line 237
add.l #56,R13
L29:
*line 237
cmp.l #448+__fcbtab,R13
blo L30
L27:
*line 241
move #23,_errno
*line 242
move #-1,R0
bra L26
L31:
*line 244
*line 245
*line 246
*line 247
*line 248
*line 248
move 12(R14),(sp)
move.l R14,-(sp)
add.l #-14,(sp)
move.l 8(R14),-(sp)
jsr _FilExt
addq.l #8,sp
move.l R0,-(sp)
move.l R14,-(sp)
add.l #-10,(sp)
move.l 8(R14),-(sp)
jsr _FilName
addq.l #8,sp
move.l R0,-(sp)
move.l R13,-(sp)
jsr __inifcb
adda.l #12,sp
tst R0
beq L32
*line 249
*line 250
move #22,_errno
*line 251
move #-1,R0
bra L26
*line 252
*line 253
L32:
*line 254
*line 255
move.l R13,(sp)
jsr __opfcb
tst R0
beq L33
*line 255
move #-1,R0
bra L26
*line 256
L33:
*line 257
move.l 16(R14),R8
move.l R13,8(R8)
*line 258
move.l 16(R14),R8
move.l #__filecl,4(R8)
*line 260
clr R0
bra L26
L26:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
L4:.dc.b $63,$6F,$6E,$3A,$0
L5:.dc.b $43,$4F,$4E,$3A,$0
