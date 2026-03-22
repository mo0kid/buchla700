.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _cxval
.globl _cyval
.globl _astat
.globl _cursbox
.globl _hitbox
.globl _hitcx
.globl _hitcy
.globl _csbp
.globl _curboxp
.globl _whatbox
.text
_whatbox:
~~whatbox:
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~sb=R13
*line 42
move.l _csbp,R13
*line 43
move #-1,_hitbox
*line 51
*line 52
move.l R13,R0
bne L2
*line 52
clr R0
bra L1
*line 53
L2:
*line 54
bra L5
L4:
*line 55
*line 56
add #1,_hitbox
*line 57
*line 58
*line 59
*line 60
*line 61
move (R13),R0
cmp _cxval,R0
bgt L6
move 4(R13),R0
cmp _cxval,R0
blt L6
move 2(R13),R0
cmp _cyval,R0
bgt L6
move 6(R13),R0
cmp _cyval,R0
blt L6
*line 62
*line 63
move _cxval,_hitcx
*line 64
move _cyval,_hitcy
*line 65
move.l R13,_curboxp
*line 66
*line 71
*line 72
*line 73
move #1,R0
bra L1
*line 74
*line 75
L6:
*line 76
add.l #14,R13
L5:
*line 77
tst.l 10(R13)
bne L4
L3:
*line 84
move #-1,_hitbox
*line 85
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _select
.text
_select:
~~select:
link R14,#-4
*line 99
*line 99
tst _astat
beq L8
*line 100
*line 104
*line 105
*line 106
*line 106
jsr _whatbox
tst R0
beq L9
*line 107
*line 112
*line 113
*line 114
move.l _curboxp,R8
move 8(R8),-(sp)
move.l _curboxp,R8
move.l 10(R8),R8
jsr (R8)
addq.l #2,sp
*line 115
move _hitbox,_cursbox
*line 116
bra L10
L9:
*line 117
*line 118
*line 122
*line 123
L10:
*line 124
*line 125
L8:L7:unlk R14
rts
.data
