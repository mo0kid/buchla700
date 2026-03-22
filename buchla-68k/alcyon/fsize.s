.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _chantab
.globl _Wrkbuf
.globl __thefat
.globl __thebpb
.globl _fsize
.text
_fsize:
~~fsize:
~fp=8
~how=12
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~chp=R13
~fcp=R12
*line 35
*line 36
tst.l 8(R14)
bne L2
*line 36
move.l #$ffffffff,R0
bra L1
*line 37
L2:
*line 38
*line 38
move.l 8(R14),R8
btst #0,12(R8)
beq L3
*line 39
*line 40
move.l 8(R14),R8
move.b 13(R8),R0
ext.w R0
muls #12,R0
move.l R0,R13
add.l #_chantab,R13
*line 41
*line 42
*line 43
move.l 4(R13),R0
cmp.l #__filecl,R0
beq L4
*line 43
move.l #$ffffffff,R0
bra L1
*line 44
L4:
*line 45
move.l 8(R13),R12
*line 46
*line 47
*line 47
btst #4,32(R12)
beq L5
*line 48
*line 49
*line 50
tst 12(R14)
beq L6
*line 50
move.l 52(R12),R0
bra L1
*line 51
bra L7
L6:
*line 52
move.l 48(R12),R0
bra L1
L7:
*line 53
*line 54
bra L8
L5:
*line 55
move.l #$ffffffff,R0
bra L1
L8:
*line 56
*line 57
bra L9
L3:
*line 58
move.l #$ffffffff,R0
bra L1
L9:L1:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _dspace
.text
_dspace:
~~dspace:
~which=8
link R14,#0
movem.l R4-R7,-(sp)
~maxcl=R7
~clcount=R6
~nc=R5
*line 78
*line 79
jsr __opnvol
tst R0
beq L11
*line 79
move.l #$ffffffff,R0
bra L10
*line 80
L11:
*line 81
move.l __thebpb,R8
move 14(R8),R7
*line 83
*line 83
tst 8(R14)
beq L12
*line 84
*line 85
clr R6
*line 86
*line 87
move #2,R5
bra L15
L16:
*line 88
*line 89
move R5,(sp)
move.l #__thefat,-(sp)
jsr __gtcl12
addq.l #4,sp
tst R0
bne L17
*line 89
add #1,R6
*line 90
L17:L14:
*line 87
add #1,R5
L15:
*line 87
cmp R7,R5
blt L16
L13:
*line 91
move R6,R0
bra L10
*line 92
bra L18
L12:
*line 93
*line 94
*line 95
move R7,R0
bra L10
L18:L10:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
