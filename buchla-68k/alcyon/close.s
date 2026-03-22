.globl _errno
.globl _chantab
.globl _Wrkbuf
.globl __fatmod
.globl __dirmod
.globl __thebpb
.globl __thedir
.globl __thefat
.globl __clsfat
.text
__clsfat:
~~_clsfat:
link R14,#-4
*line 34
*line 35
clr (sp)
move.l __thebpb,R8
move 10(R8),-(sp)
move.l __thebpb,R8
move 8(R8),-(sp)
move.l #__thefat,-(sp)
move #1,-(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
*line 39
*line 40
clr (sp)
move.l __thebpb,R8
move 10(R8),-(sp)
move.l __thebpb,R8
clr R0
move 8(R8),R0
sub R0,(sp)
move.l __thebpb,R8
move 8(R8),-(sp)
move.l #__thefat,-(sp)
move #1,-(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
*line 42
clr __fatmod
L1:unlk R14
rts
.globl __clsdir
.text
__clsdir:
~~_clsdir:
link R14,#-4
*line 55
*line 56
clr (sp)
move.l __thebpb,R8
move 10(R8),-(sp)
move.l __thebpb,R8
clr R0
move 8(R8),R0
add R0,(sp)
move.l __thebpb,R8
move 6(R8),-(sp)
move.l #__thedir,-(sp)
move #1,-(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
*line 58
clr __dirmod
L2:unlk R14
rts
.globl _close
.text
_close:
~~close:
~fd=8
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~chp=R13
~rc=R7
*line 77
*line 77
tst 8(R14)
blt L10000
cmp #11,8(R14)
ble L4
L10000:*line 78
*line 79
move #9,_errno
*line 80
move #-1,R0
bra L3
*line 81
*line 82
L4:
*line 83
move 8(R14),R0
muls #12,R0
move.l R0,R13
add.l #_chantab,R13
*line 85
move.l 8(R13),-(sp)
move.l 4(R13),R8
jsr (R8)
addq.l #4,sp
move R0,R7
*line 87
clr.b (R13)
*line 88
clr.b 1(R13)
*line 89
clr.b 2(R13)
*line 90
clr.b 3(R13)
*line 91
move.l #__badfd,4(R13)
*line 93
*line 94
tst __fatmod
beq L5
*line 94
jsr __clsfat
*line 95
L5:
*line 96
*line 97
tst __dirmod
beq L6
*line 97
jsr __clsdir
*line 98
L6:
*line 99
move R7,R0
bra L3
L3:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl __filecl
.text
__filecl:
~~_filecl:
~fp=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~rc=R7
*line 117
move.l 8(R14),R13
*line 117
move.l R13,(sp)
jsr _ClsFile
move R0,R7
*line 118
clr 32(R13)
*line 119
move R7,R0
bra L7
L7:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl __fd_cls
.text
__fd_cls:
~~_fd_cls:
link R14,#0
movem.l R6-R7,-(sp)
~fd=R7
*line 132
clr R7
bra L11
L12:
*line 133
*line 134
move R7,R0
muls #12,R0
move.l R0,R8
move.l #_chantab,R9
move.l 4(R8,R9.l),R0
cmp.l #__badfd,R0
beq L13
*line 134
move R7,(sp)
jsr _close
*line 135
L13:L10:
*line 132
add #1,R7
L11:
*line 132
cmp #11,R7
blt L12
L9:
*line 136
jsr __clsvol
L8:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
