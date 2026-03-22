.globl _curinst
.globl _curvce
.globl _ins2grp
.globl _s_inst
.globl _vce2grp
.globl _vbufs
.globl _setv2gi
.text
_setv2gi:
~~setv2gi:
~group=8
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~grp=R7
~vce=R6
~ins=R5
~ip=R13
~fp=R12
*line 41
move 8(R14),R8
add.l R8,R8
add.l #_ins2grp,R8
move (R8),R5
and #255,R5
*line 42
move 8(R14),R7
add #1,R7
*line 44
clr R6
bra L4
L5:
*line 45
*line 46
*line 46
move R6,R8
add.l R8,R8
add.l #_vce2grp,R8
cmp (R8),R7
bne L6
*line 47
*line 48
*line 48
cmp _curvce,R6
bne L7
*line 49
*line 50
move R5,_curinst
*line 51
move _curvce,R8
add.l R8,R8
add.l #_s_inst,R8
move R5,(R8)
*line 52
*line 53
L7:
*line 54
move #1,(sp)
move R5,-(sp)
move R6,-(sp)
jsr _execins
addq.l #4,sp
*line 55
L6:L3:
*line 44
add #1,R6
L4:
*line 44
cmp #12,R6
blt L5
L2:L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.data
