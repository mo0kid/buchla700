.globl _ac_code
.globl _scname
.globl _se_chg
.globl _curscor
.globl _cursect
.globl _se1_cnt
.globl _se2_cnt
.globl _se3_cnt
.globl _spool
.globl _pspool
.globl _spcount
.globl _frags
.globl _t_bak
.globl _t_cur
.globl _t_ctr
.globl _t_fwd
.globl _size1
.globl _size2
.globl _size3
.globl _scores
.globl _scp
.globl _seclist
.globl _hplist
.globl _p_bak
.globl _p_cur
.globl _p_ctr
.globl _p_fwd
.globl _noteop
.globl _notesel
.globl _t_note
.globl _p_nbeg
.globl _p_nend
.globl _ctime
.globl _fcnote
.text
_fcnote:
~~fcnote:
~grp=R7
~tnote=R6
link R14,#-4
movem.l R2-R7/R12-R13,-(sp)
~bp=R13
~ep=R12
~en=R5
~eg=R4
~et=R3
~t_left=-4
*line 52
move 8(R14),R7
*line 52
move 10(R14),R6
*line 52
move.l _ctime,(sp)
clr -(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R13
*line 53
move.l _t_cur,R0
add.l #$ffffff0f,R0
move.l R0,-4(R14)
*line 54
clr.l _p_nbeg
*line 55
clr.l _p_nend
*line 56
clr.l _t_note
L4:
*line 58
*line 59
*line 60
move.b 5(R13),R3
ext.w R3
and #127,R3
*line 61
move.b 6(R13),R5
ext.w R5
*line 62
move.b 7(R13),R4
ext.w R4
*line 63
*line 64
*line 64
move.l (R13),R0
cmp.l -4(R14),R0
blt L10000
cmp #1,R3
bne L5
L10000:*line 65
*line 66
*line 67
*line 68
clr.l R0
bra L1
*line 69
bra L6
L5:
*line 70
*line 70
cmp #6,R3
bne L7
cmp R6,R5
bne L7
cmp R7,R4
bne L7
*line 71
*line 72
*line 73
*line 74
clr.l R0
bra L1
*line 75
*line 76
bra L8
L7:
*line 77
*line 77
cmp #5,R3
bne L9
cmp R6,R5
bne L9
cmp R7,R4
bne L9
*line 78
*line 79
*line 80
*line 81
move.l 12(R13),R12
*line 82
L12:
*line 83
*line 84
*line 85
move.b 5(R12),R3
ext.w R3
and #127,R3
*line 86
move.b 6(R12),R5
ext.w R5
*line 87
move.b 7(R12),R4
ext.w R4
*line 88
*line 89
*line 90
cmp #5,R3
bne L13
cmp R6,R5
bne L13
cmp R7,R4
bne L13
*line 91
*line 92
*line 93
*line 94
clr.l R0
bra L1
*line 95
*line 96
bra L14
L13:
*line 97
*line 98
cmp #6,R3
bne L15
cmp R6,R5
bne L15
cmp R7,R4
bne L15
*line 99
*line 100
*line 101
*line 102
move.l R13,_p_nbeg
*line 103
move.l R12,_p_nend
*line 104
move.l (R12),R0
sub.l (R13),R0
move.l R0,_t_note
*line 105
move.l R13,R0
bra L1
*line 106
bra L16
L15:
*line 107
*line 107
cmp #21,R3
bne L17
*line 108
*line 109
*line 110
*line 111
clr.l R0
bra L1
*line 112
*line 113
L17:L16:L14:
*line 114
move.l 12(R12),R12
*line 115
L11:bra L12
L10:
*line 116
*line 117
*line 118
*line 119
L9:L8:L6:
*line 120
move.l 8(R13),R13
*line 121
L3:bra L4
L2:L1:tst.l (sp)+
movem.l (sp)+,R3-R7/R12-R13
unlk R14
rts
.data
