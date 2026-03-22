.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _errno
.globl __opener
.text
__opener:
~~_opener:
~name=8
~mode=12
~aflag=16
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~fp=R13
~plusopt=R7
*line 23
move.l #_Cbuffs,R13
*line 25
bra L4
L3:
*line 26
*line 27
*line 28
add.l #18,R13
move.l R13,R0
cmp.l #198+_Cbuffs,R0
blo L5
*line 28
clr.l R0
bra L1
L5:L4:
*line 29
tst.b 12(R13)
bne L3
L2:
*line 31
move.l 12(R14),R8
cmp.b #43,1(R8)
beq L10000
clr R0
bra L10001
L10000:move #1,R0
L10001:move R0,R7
*line 33
move.l 12(R14),R8
move.b (R8),R0
ext.w R0
and #127,R0
bra L7
*line 34
L8:
*line 35
*line 36
*line 37
tst R7
beq L10002
move #2,(sp)
bra L10004
L10002:clr (sp)
L10004:move 16(R14),R0
or R0,(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #4,sp
move.b R0,13(R13)
cmp #-1,R0
bne L9
*line 37
clr.l R0
bra L1
L9:bra L6
*line 38
*line 39
L10:
*line 40
*line 41
*line 42
tst R7
beq L10005
move #2,(sp)
bra L10007
L10005:move #1,(sp)
L10007:move 16(R14),R0
or R0,(sp)
or #768,(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #4,sp
move.b R0,13(R13)
cmp #-1,R0
bne L11
*line 42
clr.l R0
bra L1
*line 43
L11:bra L6
*line 44
*line 45
L12:
*line 46
*line 47
*line 48
tst R7
beq L10008
move #2,(sp)
bra L10010
L10008:move #1,(sp)
L10010:move 16(R14),R0
or R0,(sp)
or #256,(sp)
move.l 8(R14),-(sp)
jsr _open
addq.l #4,sp
move.b R0,13(R13)
cmp #-1,R0
bne L13
*line 48
clr.l R0
bra L1
*line 49
L13:
*line 50
*line 50
move #2,(sp)
clr.l -(sp)
move.b 13(R13),R0
ext.w R0
move R0,-(sp) 
jsr _lseek
addq.l #6,sp
tst.l R0
bge L14
*line 51
*line 52
move.b 13(R13),R0
ext.w R0
move R0,(sp) 
jsr _close
*line 53
clr.l R0
bra L1
*line 54
*line 55
L14:bra L6
*line 56
*line 57
L15:
*line 58
*line 59
move #22,_errno
*line 60
clr.l R0
bra L1
bra L6
L7:cmp #97,R0
beq L12
cmp #114,R0
beq L8
cmp #119,R0
beq L10
bra L15
L6:
*line 63
move.b #1,12(R13)
*line 64
move #1024,16(R13)
*line 65
clr.l 8(R13)
*line 66
clr.l 4(R13)
*line 67
clr.l (R13)
*line 68
move.l R13,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _fopen
.text
_fopen:
~~fopen:
~name=8
~mode=12
link R14,#-4
*line 78
clr (sp)
move.l 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr __opener
addq.l #8,sp
bra L16
L16:unlk R14
rts
.globl _fopena
.text
_fopena:
~~fopena:
~name=8
~mode=12
link R14,#-4
*line 85
clr (sp)
move.l 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr __opener
addq.l #8,sp
bra L17
L17:unlk R14
rts
.globl _fopenb
.text
_fopenb:
~~fopenb:
~name=8
~mode=12
link R14,#-4
*line 92
move #-32768,(sp)
move.l 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr __opener
addq.l #8,sp
bra L18
L18:unlk R14
rts
.data
