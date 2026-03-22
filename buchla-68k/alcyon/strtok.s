.globl _strtok
.text
_strtok:
~~strtok:
~string=8
~sepset=12
link R14,#0
movem.l R7-R7/R11-R13,-(sp)
~p=R13
~q=R12
~r=R11
~savept=L2
.bss
L2:.ds.b 4
.text
*line 27
tst.l 8(R14)
bne L10000
move.l L2,R0
bra L10002
L10000:move.l 8(R14),R0
L10002:move.l R0,R13
*line 29
*line 30
move.l R13,R0
bne L3
*line 30
clr.l R0
bra L1
*line 31
L3:
*line 32
move.l 12(R14),(sp)
move.l R13,-(sp)
jsr _strspn
addq.l #4,sp
ext.l R0
move.l R0,R12
move.l R13,R0
add.l R0,R12
*line 34
*line 35
tst.b (R12)
bne L4
*line 35
clr.l R0
bra L1
*line 36
L4:
*line 37
*line 38
move.l 12(R14),(sp)
move.l R12,-(sp)
jsr _strpbrk
addq.l #4,sp
move.l R0,R11
move.l R11,R0
bne L5
*line 38
clr.l L2
bra L6
L5:
*line 39
*line 40
clr.b (R11)
*line 41
add.l #1,R11
move.l R11,L2
L6:
*line 44
move.l R12,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R11-R13
unlk R14
rts
.data
