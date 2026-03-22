.globl _errno
.globl __clsall
.comm __clsall,4
.bss
L1:.ds.b 2
.text
.bss
L2:.ds.b 120
.text
.globl _exit
.text
_exit:
~~exit:
~code=8
link R14,#-4
*line 54
move.l __clsall,R8
jsr (R8)
*line 55
move 8(R14),(sp)
jsr _xtrap15
L3:unlk R14
rts
.globl _Croot
.text
_Croot:
~~Croot:
~cp=R13
link R14,#0
movem.l R6-R7/R12-R13,-(sp)
~fname=R12
~k=R7
*line 97
move.l 8(R14),R13
*line 97
move.l #L5,L2
*line 98
move #1,L1
*line 100
move.l #__fd_cls,__clsall
*line 101
jsr _InitFS
*line 159
move.l #L2,(sp)
move L1,-(sp)
jsr _main
addq.l #2,sp
*line 160
clr (sp)
jsr _exit
L4:tst.l (sp)+
movem.l (sp)+,R7-R7/R12-R13
unlk R14
rts
.data
L5:.dc.b $7B,$42,$75,$63,$68,$6C,$61,$20,$37,$30,$30,$20,$43,$72,$6F,$6F,$74,$20,$2D,$20,$56,$65,$72,$73,$69,$6F,$6E,$20,$38,$20
.dc.b $2D,$20,$31,$39,$38,$37,$2D,$30,$36,$2D,$32,$39,$7D,$0
