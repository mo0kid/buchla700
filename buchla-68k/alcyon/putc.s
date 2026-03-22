.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl __clsall
.bss
L1:.ds.b 4
.text
.globl __ClFlag
.comm __ClFlag,2
.text
_closall:
~~closall:
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~fp=R13
*line 32
move.l #_Cbuffs,R13
bra L6
L7:
*line 33
move.l R13,(sp)
jsr _fclose
add.l #18,R13
L5:L6:
*line 32
cmp.l #198+_Cbuffs,R13
blo L7
L4:
*line 35
move.l L1,R8
jsr (R8)
L3:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _flush_
.text
_flush_:
~~flush_:
~ptr=R13
~data=12
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~size=R7
*line 54
move.l 8(R14),R13
*line 54
*line 54
tst __ClFlag
bne L9
*line 55
*line 56
move.l __clsall,L1
*line 57
move.l #_closall,__clsall
*line 58
move #1,__ClFlag
*line 59
*line 60
L9:
*line 61
*line 61
btst #2,12(R13)
beq L10
*line 62
*line 63
move.l (R13),R0
sub.l 8(R13),R0
move R0,R7
*line 64
*line 65
*line 65
move R7,(sp)
move.l 8(R13),-(sp)
move.b 13(R13),R0
ext.w R0
move R0,-(sp) 
jsr _write
addq.l #6,sp
cmp #-1,R0
bne L11
*line 66
L12:
*line 67
*line 68
or.b #16,12(R13)
*line 69
move #-1,R0
bra L8
*line 70
L11:
*line 71
*line 72
L10:
*line 73
*line 73
cmp #-1,12(R14)
bne L13
*line 74
*line 75
and.b #-5,12(R13)
*line 76
clr R0
ext.l R0
move.l R0,(R13)
move.l R0,4(R13)
*line 77
clr R0
bra L8
*line 78
*line 79
L13:
*line 80
*line 81
tst.l 8(R13)
bne L14
*line 81
move.l R13,(sp)
jsr _getbuff
*line 82
L14:
*line 83
*line 83
cmp #1,16(R13)
bne L15
*line 84
*line 85
*line 86
move #1,(sp)
move.l R14,-(sp)
add.l #12,(sp)
move.b 13(R13),R0
ext.w R0
move R0,-(sp) 
jsr _write
addq.l #6,sp
cmp #-1,R0
beq L12
*line 87
*line 88
move 12(R14),R0
bra L8
*line 89
*line 90
L15:
*line 91
move.l 8(R13),(R13)
*line 92
move.l 8(R13),R0
move 16(R13),R1
ext.l R1
add.l R1,R0
move.l R0,4(R13)
*line 93
or.b #4,12(R13)
*line 95
move.l (R13),R8
move 12(R14),R0
move.b R0,(R8)
and #255,R0
add.l #1,(R13)
bra L8
L8:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _fflush
.text
_fflush:
~~fflush:
~ptr=8
link R14,#-4
*line 111
move #-1,(sp)
move.l 8(R14),-(sp)
jsr _flush_
addq.l #4,sp
bra L16
L16:unlk R14
rts
.globl _fclose
.text
_fclose:
~~fclose:
~ptr=R13
link R14,#-2
movem.l R7-R7/R13-R13,-(sp)
~err=-2
*line 126
move.l 8(R14),R13
*line 126
clr -2(R14)
*line 128
*line 128
tst.b 12(R13)
beq L18
*line 129
*line 130
*line 131
btst #2,12(R13)
beq L19
*line 131
move #-1,(sp)
move.l R13,-(sp)
jsr _flush_
addq.l #4,sp
move R0,-2(R14)
*line 132
L19:
*line 133
move.b 13(R13),R0
ext.w R0
move R0,(sp) 
jsr _close
or R0,-2(R14)
*line 134
*line 135
*line 135
btst #1,12(R13)
beq L20
*line 136
*line 137
move.l 8(R13),R8
move.l _Stdbufs,(R8)
*line 138
move.l 8(R13),_Stdbufs
*line 139
L20:
*line 140
*line 141
L18:
*line 142
clr.b 12(R13)
*line 143
move -2(R14),R0
bra L17
L17:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _putc
.text
_putc:
~~putc:
~ptr=R13
~c=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 160
move.l 10(R14),R13
*line 160
*line 161
move.l (R13),R0
cmp.l 4(R13),R0
blo L22
*line 161
move 8(R14),(sp)
and #255,(sp)
move.l R13,-(sp)
jsr _flush_
addq.l #4,sp
bra L21
*line 162
L22:
*line 163
move.l (R13),R8
move 8(R14),R0
move.b R0,(R8)
and #255,R0
add.l #1,(R13)
bra L21
L21:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _puterr
.text
_puterr:
~~puterr:
~c=8
link R14,#-4
*line 175
move.l #36+_Cbuffs,(sp)
move 8(R14),-(sp)
jsr _putc
addq.l #2,sp
bra L23
L23:unlk R14
rts
.data
