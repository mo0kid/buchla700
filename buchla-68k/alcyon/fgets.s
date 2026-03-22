.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _agetc
.text
_agetc:
~~agetc:
~ptr=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~c=R7
*line 19
move.l 8(R14),R13
L2:
*line 20
*line 20
move.l R13,(sp)
jsr _getc
move R0,R7
cmp #-1,R7
beq L3
*line 21
*line 22
and #127,R7
move R7,R0
bra L5
*line 23
L6:
*line 24
*line 25
sub.l #1,(R13)
*line 26
move #-1,R0
bra L1
*line 27
L7:
*line 28
L8:
*line 29
bra L2
*line 30
bra L4
L5:tst R0
beq L8
cmp #10,R0
beq L7
cmp #26,R0
beq L6
bra L4
L4:
*line 31
*line 32
*line 33
L3:
*line 34
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _gets
.text
_gets:
~~gets:
~line=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~cp=R13
~i=R7
*line 44
move.l 8(R14),R13
*line 46
bra L12
L11:
*line 47
move.b R7,(R13)+
L12:
*line 47
move.l #_Cbuffs,(sp)
jsr _getc
move R0,R7
cmp #-1,R7
beq L10000
cmp #10,R7
bne L11
L10000:L10:
*line 49
clr.b (R13)
*line 51
*line 52
cmp #-1,R7
bne L13
cmp.l 8(R14),R13
bne L13
*line 52
clr.l R0
bra L9
*line 53
L13:
*line 54
move.l 8(R14),R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _fgets
.text
_fgets:
~~fgets:
~s=8
~n=12
~fp=14
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~c=R7
~cp=R13
*line 66
move.l 8(R14),R13
*line 68
bra L17
L16:
*line 69
*line 70
move.b R7,(R13)+
*line 71
*line 72
*line 73
cmp #10,R7
beq L15
L17:
*line 74
sub #1,12(R14)
ble L10001
move.l 14(R14),(sp)
jsr _agetc
move R0,R7
cmp #-1,R7
bne L16
L10001:L15:
*line 76
clr.b (R13)
*line 78
*line 79
cmp #-1,R7
bne L18
cmp.l 8(R14),R13
bne L18
*line 79
clr.l R0
bra L14
*line 80
L18:
*line 81
move.l 8(R14),R0
bra L14
L14:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
