.globl _errno
.globl __bpbin
.globl __dirin
.globl __fatin
.globl __dirmod
.globl __fatmod
.globl _Stdbufs
.comm _Stdbufs,4
.globl _Wrkbuf
.comm _Wrkbuf,512
.globl _Stdbuf
.comm _Stdbuf,8192
.globl _Cbuffs
.comm _Cbuffs,198
.globl __fcbtab
.comm __fcbtab,448
.globl _chantab
.comm _chantab,132
.globl __b_tbuf
.comm __b_tbuf,4608
.globl __b_trak
.comm __b_trak,2
.globl __b_side
.comm __b_side,2
.globl __b_sect
.comm __b_sect,2
.globl __b_tsec
.comm __b_tsec,2
.globl __badfd
.text
__badfd:
~~_badfd:
link R14,#-4
*line 57
move #9,_errno
*line 58
move #-1,R0
bra L1
L1:unlk R14
rts
.globl __noper
.text
__noper:
~~_noper:
link R14,#-4
*line 70
clr R0
bra L2
L2:unlk R14
rts
.globl _InitCH
.text
_InitCH:
~~InitCH:
~cp=R13
~rdi=13
~wri=15
~ioi=17
~ski=19
~cfp=20
~charg=24
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 88
move.l 8(R14),R13
*line 88
move.b 13(R14),(R13)
*line 89
move.b 15(R14),1(R13)
*line 90
move.b 17(R14),2(R13)
*line 91
move.b 19(R14),3(R13)
*line 92
move.l 20(R14),4(R13)
*line 93
move.l 24(R14),8(R13)
L3:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _Init_CB
.text
_Init_CB:
~~Init_CB:
~fp=R13
~flags=13
~unit=15
~bufad=16
~bufsize=20
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 108
move.l 8(R14),R13
*line 108
clr.l (R13)
*line 109
clr.l 4(R13)
*line 110
move.l 16(R14),8(R13)
*line 111
move.b 13(R14),12(R13)
*line 112
move.b 15(R14),13(R13)
*line 113
clr.b 14(R13)
*line 114
move 20(R14),16(R13)
L4:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _InitFS
.text
_InitFS:
~~InitFS:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 130
move #448,(sp)
clr -(sp)
move.l #__fcbtab,-(sp)
jsr _memset
addq.l #6,sp
*line 131
move #4096,(sp)
clr -(sp)
move.l #_Stdbuf,-(sp)
jsr _memsetw
addq.l #6,sp
*line 133
move #1024,(sp)
clr.l -(sp)
clr -(sp)
move #1,-(sp)
move.l #_Cbuffs,-(sp)
jsr _Init_CB
adda.l #12,sp
*line 134
move #1,(sp)
clr.l -(sp)
move #1,-(sp)
move #1,-(sp)
move.l #18+_Cbuffs,-(sp)
jsr _Init_CB
adda.l #12,sp
*line 135
move #1,(sp)
clr.l -(sp)
move #2,-(sp)
move #1,-(sp)
move.l #36+_Cbuffs,-(sp)
jsr _Init_CB
adda.l #12,sp
*line 137
move #3,R7
bra L8
L9:
*line 138
clr (sp)
clr.l -(sp)
clr -(sp)
clr -(sp)
move R7,R0
muls #18,R0
add.l #_Cbuffs,R0
move.l R0,-(sp)
jsr _Init_CB
adda.l #12,sp
L7:
*line 137
add #1,R7
L8:
*line 137
cmp #11,R7
blt L9
L6:
*line 140
clr.l _Stdbuf
*line 142
move #1,R7
bra L12
L13:
*line 143
move R7,R0
sub #1,R0
move #10,R1
asl R1,R0
ext.l R0
add.l #_Stdbuf,R0
move R7,R1
move #10,R2
asl R2,R1
ext.l R1
add.l #_Stdbuf,R1
move.l R1,R9
move.l R0,(R9)
L11:
*line 142
add #1,R7
L12:
*line 142
cmp #8,R7
blt L13
L10:
*line 145
move.l #7168+_Stdbuf,_Stdbufs
*line 147
move.l #$2,(sp)
move.l #__noper,-(sp)
clr -(sp)
move #1,-(sp)
clr -(sp)
move #2,-(sp)
move.l #_chantab,-(sp)
jsr _InitCH
adda.l #16,sp
*line 148
move.l #$2,(sp)
move.l #__noper,-(sp)
clr -(sp)
move #1,-(sp)
move #2,-(sp)
clr -(sp)
move.l #12+_chantab,-(sp)
jsr _InitCH
adda.l #16,sp
*line 149
move.l #$2,(sp)
move.l #__noper,-(sp)
clr -(sp)
move #1,-(sp)
move #2,-(sp)
clr -(sp)
move.l #24+_chantab,-(sp)
jsr _InitCH
adda.l #16,sp
*line 151
move #3,R7
bra L16
L17:
*line 152
clr.l (sp)
move.l #__badfd,-(sp)
clr -(sp)
clr -(sp)
clr -(sp)
clr -(sp)
move R7,R0
muls #12,R0
add.l #_chantab,R0
move.l R0,-(sp)
jsr _InitCH
adda.l #16,sp
L15:
*line 151
add #1,R7
L16:
*line 151
cmp #11,R7
blt L17
L14:
*line 154
clr __bpbin
*line 155
clr __dirin
*line 156
clr __fatin
*line 157
clr __fatmod
*line 158
clr __dirmod
*line 161
move #-1,__b_trak
*line 162
move #-1,__b_side
L5:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
