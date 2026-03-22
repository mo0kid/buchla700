.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _stmptr
.globl _defptr
.globl _patches
.globl _defents
.globl _seqtab
.globl _seqflag
.globl _seqline
.globl _seqstim
.globl _seqtime
.globl _sregval
.globl _trstate
.globl _filecat
.globl _errno
.globl _sqioerr
.text
_sqioerr:
~~sqioerr:
link R14,#-44
~erms=-40
*line 30
jsr _clrlsel
*line 32
move _errno,(sp)
move.l #L2,-(sp)
move.l R14,-(sp)
add.l #-40,(sp)
jsr _sprintf
addq.l #8,sp
*line 34
*line 35
move #9,(sp)
move #14,-(sp)
move.l R14,-(sp)
add.l #-40,(sp)
move.l #L4,-(sp)
move.l #L3,-(sp)
jsr _ldermsg
adda.l #14,sp
L1:unlk R14
rts
.globl _sqread
.text
_sqread:
~~sqread:
~fp=R13
link R14,#-4
movem.l R7-R7/R13-R13,-(sp)
~cb=-2
~seq=-4
*line 54
move.l 8(R14),R13
*line 55
move #9,(sp)
move #12,-(sp)
move.l #L7,-(sp)
clr.l -(sp)
move.l #L6,-(sp)
jsr _ldwmsg
adda.l #14,sp
L10:
*line 57
*line 58
*line 59
*line 59
move.l #$1,(sp)
move.l R14,-(sp)
sub.l #2,(sp)
move.l R13,-(sp)
jsr _rd_ec
addq.l #8,sp
tst R0
beq L11
*line 60
*line 61
jsr _sqioerr
*line 62
move #-1,R0
bra L5
*line 63
*line 64
L11:
*line 65
*line 66
tst.b -2(R14)
bne L12
*line 66
clr R0
bra L5
*line 67
L12:
*line 68
*line 68
move.l #$2,(sp)
move.l R14,-(sp)
sub.l #4,(sp)
move.l R13,-(sp)
jsr _rd_ec
addq.l #8,sp
tst R0
beq L13
*line 69
*line 70
jsr _sqioerr
*line 71
move #-1,R0
bra L5
*line 72
*line 73
L13:
*line 74
*line 74
btst #3,-2(R14)
beq L14
*line 75
*line 76
*line 76
move.l #$2,(sp)
move -4(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _rd_ec
addq.l #8,sp
tst R0
beq L15
*line 77
*line 78
jsr _sqioerr
*line 79
move #-1,R0
bra L5
*line 80
L15:
*line 81
*line 82
*line 83
L14:
*line 84
*line 84
btst #2,-2(R14)
beq L16
*line 85
*line 86
*line 86
move.l #$4,(sp)
move -4(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
add.l #2,(sp)
move.l R13,-(sp)
jsr _rd_ec
addq.l #8,sp
tst R0
beq L17
*line 87
*line 88
jsr _sqioerr
*line 89
move #-1,R0
bra L5
*line 90
L17:
*line 91
*line 92
L16:
*line 93
*line 93
btst #1,-2(R14)
beq L18
*line 94
*line 95
*line 95
move.l #$4,(sp)
move -4(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _rd_ec
addq.l #8,sp
tst R0
beq L19
*line 96
*line 97
jsr _sqioerr
*line 98
move #-1,R0
bra L5
*line 99
L19:
*line 100
*line 101
L18:
*line 102
*line 102
btst #0,-2(R14)
beq L20
*line 103
*line 104
*line 104
move.l #$4,(sp)
move -4(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
add.l #10,(sp)
move.l R13,-(sp)
jsr _rd_ec
addq.l #8,sp
tst R0
beq L21
*line 105
*line 106
jsr _sqioerr
*line 107
move #-1,R0
bra L5
*line 108
L21:
*line 109
L20:L9:bra L10
L8:L5:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
L2:.dc.b $20,$20,$65,$72,$72,$6E,$6F,$20,$3D,$20,$25,$64,$0
L3:.dc.b $43,$6F,$75,$6C,$64,$6E,$27,$74,$20,$72,$65,$61,$64,$0
L4:.dc.b $20,$74,$68,$65,$20,$73,$65,$71,$75,$65,$6E,$63,$65,$20,$74,$61,$62,$6C,$65,$0
L6:.dc.b $20,$42,$75,$73,$79,$20,$2D,$2D,$20,$70,$6C,$65,$61,$73,$65,$20,$73,$74,$61,$6E,$64,$20,$62,$79,$0
L7:.dc.b $20,$20,$52,$65,$61,$64,$69,$6E,$67,$20,$73,$65,$71,$75,$65,$6E,$63,$65,$73,$0
