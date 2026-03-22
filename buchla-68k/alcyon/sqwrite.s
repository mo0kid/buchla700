.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _io_time
.globl _io_lcd
.globl _io_ser
.globl _io_midi
.globl _io_disk
.globl _io_tone
.globl _io_leds
.globl _io_kbrd
.globl _lcd_a0
.globl _lcd_a1
.globl _io_vreg
.globl _io_vraw
.globl _io_vram
.globl _io_fpu
.globl _v_regs
.globl _v_odtab
.globl _v_actab
.globl _v_ct0
.globl _v_gt1
.globl _v_score
.globl _v_cgtab
.globl _v_curs0
.globl _v_curs1
.globl _v_curs2
.globl _v_curs3
.globl _v_curs4
.globl _v_curs5
.globl _v_curs6
.globl _v_curs7
.globl _v_tcur
.globl _v_kbobj
.globl _v_lnobj
.globl _v_win0
.globl _v_cur
.globl _fc_sw
.globl _fc_val
.globl _stmptr
.globl _defptr
.globl _patches
.globl _defents
.globl _seqtab
.globl _seqflag
.globl _seqline
.globl _seqstim
.globl _seqtime
.globl _sregval
.globl _trstate
.globl _filecat
.globl _sqsizer
.text
_sqsizer:
~~sqsizer:
link R14,#0
movem.l R4-R7,-(sp)
~i=R7
~na=R6
~nb=R5
*line 42
clr.l R5
*line 44
clr R7
bra L4
L5:
*line 45
*line 46
clr R6
*line 47
*line 48
*line 49
move R7,R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 0(R8,R9.l)
beq L6
*line 49
add #2,R6
*line 50
L6:
*line 51
*line 52
move R7,R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 2(R8,R9.l)
beq L7
*line 52
add #4,R6
*line 53
L7:
*line 54
*line 55
move R7,R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 6(R8,R9.l)
beq L8
*line 55
add #4,R6
*line 56
L8:
*line 57
*line 58
move R7,R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 10(R8,R9.l)
beq L9
*line 58
add #4,R6
*line 59
L9:
*line 60
*line 61
tst R6
beq L10
*line 61
move R6,R0
add #3,R0
ext.l R0
add.l R0,R5
L10:L3:
*line 44
add #1,R7
L4:
*line 44
cmp #1000,R7
blt L5
L2:
*line 64
*line 65
tst.l R5
beq L11
*line 65
add.l #$1,R5
*line 66
*line 70
*line 71
L11:
*line 72
move.l R5,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _sqwrite
.text
_sqwrite:
~~sqwrite:
~fp=R13
link R14,#-54
movem.l R7-R7/R13-R13,-(sp)
~seq=-2
~cb=-4
~zero=-6
~scid=-54
*line 97
move.l 8(R14),R13
*line 97
clr.b -6(R14)
*line 99
*line 100
move #9,(sp)
move #12,-(sp)
move.l #L14,-(sp)
clr.l -(sp)
move.l #L13,-(sp)
jsr _ldwmsg
adda.l #14,sp
*line 102
clr -2(R14)
bra L17
L18:
*line 103
*line 104
clr.b -4(R14)
*line 105
*line 106
*line 107
move -2(R14),R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 0(R8,R9.l)
beq L19
*line 107
or.b #8,-4(R14)
*line 108
L19:
*line 109
*line 110
move -2(R14),R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 2(R8,R9.l)
beq L20
*line 110
or.b #4,-4(R14)
*line 111
L20:
*line 112
*line 113
move -2(R14),R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 6(R8,R9.l)
beq L21
*line 113
or.b #2,-4(R14)
*line 114
L21:
*line 115
*line 116
move -2(R14),R0
muls #14,R0
move.l R0,R8
move.l #_seqtab,R9
tst 10(R8,R9.l)
beq L22
*line 116
or.b #1,-4(R14)
*line 117
L22:
*line 118
*line 119
tst.b -4(R14)
beq L16
*line 120
*line 121
*line 122
move.l #$1,(sp)
move.l R14,-(sp)
sub.l #4,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L23
*line 122
move #-1,R0
bra L12
*line 123
L23:
*line 124
*line 125
move.l #$2,(sp)
move.l R14,-(sp)
sub.l #2,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L24
*line 125
move #-1,R0
bra L12
*line 126
L24:
*line 127
*line 128
btst #3,-4(R14)
beq L25
*line 128
*line 129
move.l #$2,(sp)
move -2(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L26
*line 129
move #-1,R0
bra L12
*line 130
L26:L25:
*line 131
*line 132
btst #2,-4(R14)
beq L27
*line 132
*line 133
move.l #$4,(sp)
move -2(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
add.l #2,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L28
*line 133
move #-1,R0
bra L12
*line 134
L28:L27:
*line 135
*line 136
btst #1,-4(R14)
beq L29
*line 136
*line 137
move.l #$4,(sp)
move -2(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
add.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L30
*line 137
move #-1,R0
bra L12
*line 138
L30:L29:
*line 139
*line 140
btst #0,-4(R14)
beq L31
*line 140
*line 141
move.l #$4,(sp)
move -2(R14),R0
muls #14,R0
add.l #_seqtab,R0
move.l R0,-(sp)
add.l #10,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L32
*line 141
move #-1,R0
bra L12
L32:L31:L16:
*line 102
add #1,-2(R14)
L17:
*line 102
cmp #1000,-2(R14)
blt L18
L15:
*line 144
*line 145
move.l #$1,(sp)
move.l R14,-(sp)
sub.l #6,(sp)
move.l R13,-(sp)
jsr _wr_ec
addq.l #8,sp
tst R0
beq L33
*line 145
move #-1,R0
bra L12
*line 146
*line 150
*line 151
L33:
*line 152
clr R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
L13:.dc.b $42,$75,$73,$79,$20,$2D,$2D,$20,$50,$6C,$65,$61,$73,$65,$20,$73,$74,$61,$6E,$64,$20,$62,$79,$0
L14:.dc.b $20,$20,$77,$72,$69,$74,$69,$6E,$67,$20,$73,$65,$71,$75,$65,$6E,$63,$65,$73,$0
