.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.bss
L1:.ds.b 2
.text
.bss
L2:.ds.b 4
.text
.text
_gchar:
~~gchar:
~what=8
link R14,#-4
*line 18
*line 18
tst 8(R14)
bne L5
*line 19
*line 20
*line 21
move.l L2,R8
btst #3,12(R8)
beq L6
*line 21
move #-1,L1
*line 22
bra L7
L6:
*line 23
move.l L2,(sp)
jsr _agetc
move R0,L1
L7:
*line 24
bra L8
L5:
*line 25
move.l L2,(sp)
move L1,-(sp)
jsr _ungetc
addq.l #2,sp
move R0,L1
L8:
*line 27
move L1,R0
bra L4
L4:unlk R14
rts
.globl _scanf
.text
_scanf:
~~scanf:
~fmt=8
~args=12
link R14,#-4
*line 35
move.l #_Cbuffs,L2
*line 36
clr L1
*line 37
move.l R14,(sp)
add.l #12,(sp)
move.l 8(R14),-(sp)
move.l #_gchar,-(sp)
jsr _scanfmt
addq.l #8,sp
bra L9
L9:unlk R14
rts
.globl _fscanf
.text
_fscanf:
~~fscanf:
~fp=8
~fmt=12
~args=16
link R14,#-4
*line 46
move.l 8(R14),L2
*line 47
clr L1
*line 48
move.l R14,(sp)
add.l #16,(sp)
move.l 12(R14),-(sp)
move.l #_gchar,-(sp)
jsr _scanfmt
addq.l #8,sp
bra L10
L10:unlk R14
rts
.data
