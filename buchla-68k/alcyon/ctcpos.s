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
.globl _ctcsw
.comm _ctcsw,2
.globl _CurLine
.globl _cxval
.globl _cyval
.globl _stcrow
.globl _stccol
.globl _vtcrow
.globl _vtccol
.globl _obj9
.globl _obj11
.globl _mtcoldc
.comm _mtcoldc,2
.globl _mtcoldr
.comm _mtcoldr,2
.globl _ctcpos
.text
_ctcpos:
~~ctcpos:
~row=R7
~col=R6
link R14,#0
movem.l R4-R7,-(sp)
~nrow=R5
*line 44
move 8(R14),R7
*line 44
move 10(R14),R6
*line 44
*line 44
tst _ctcsw
beq L2
*line 45
*line 46
*line 47
clr R0
move 10+_v_regs,R0
and #384,R0
beq L3
*line 47
clr (sp)
jsr _vbank
*line 48
L3:
*line 49
move _CurLine,R5
add #7,R5
*line 50
*line 51
*line 52
cmp #9,_stcrow
bne L4
*line 52
move #48,(sp)
move #256,-(sp)
move _stccol,-(sp)
move R5,-(sp)
move.l _obj9,-(sp)
jsr _vclrav
adda.l #10,sp
*line 53
L4:
*line 54
*line 55
cmp #9,R7
bne L5
*line 55
move #48,(sp)
move #256,-(sp)
move R6,-(sp)
move R5,-(sp)
move.l _obj9,-(sp)
jsr _vsetav
adda.l #10,sp
L5:
*line 56
*line 57
L2:
*line 58
move R7,_stcrow
*line 59
move R6,_stccol
L1:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.globl _ctcoff
.text
_ctcoff:
~~ctcoff:
link R14,#-4
*line 73
*line 74
clr R0
move 10+_v_regs,R0
and #384,R0
beq L7
*line 74
clr (sp)
jsr _vbank
*line 75
L7:
*line 76
*line 77
cmp #9,_stcrow
bne L8
*line 77
move #48,(sp)
move #256,-(sp)
move _stccol,-(sp)
move _CurLine,-(sp)
add #7,(sp)
move.l _obj9,-(sp)
jsr _vclrav
adda.l #10,sp
*line 78
L8:
*line 79
clr _ctcsw
L6:unlk R14
rts
.globl _ctcon
.text
_ctcon:
~~ctcon:
link R14,#-4
*line 90
*line 91
clr R0
move 10+_v_regs,R0
and #384,R0
beq L10
*line 91
clr (sp)
jsr _vbank
*line 92
L10:
*line 93
*line 93
cmp #9,_stcrow
bne L11
*line 94
*line 95
move #1,_ctcsw
*line 96
move #48,(sp)
move #256,-(sp)
move _stccol,-(sp)
move _CurLine,-(sp)
add #7,(sp)
move.l _obj9,-(sp)
jsr _vsetav
adda.l #10,sp
*line 97
L11:L9:unlk R14
rts
.globl _mtcpos
.text
_mtcpos:
~~mtcpos:
~row=R7
~col=R6
link R14,#0
movem.l R5-R7,-(sp)
*line 112
move 8(R14),R7
*line 112
move 10(R14),R6
*line 112
*line 113
clr R0
move 10+_v_regs,R0
and #384,R0
beq L13
*line 113
clr (sp)
jsr _vbank
*line 114
L13:
*line 115
*line 115
cmp #19,_mtcoldr
blt L14
cmp #23,_mtcoldr
bgt L14
*line 116
*line 117
move #64,(sp)
move #256,-(sp)
move _mtcoldc,-(sp)
move _mtcoldr,-(sp)
add #-18,(sp)
move.l _obj11,-(sp)
jsr _vclrav
adda.l #10,sp
*line 118
*line 119
clr _mtcoldr
*line 120
clr _mtcoldc
*line 121
*line 122
L14:
*line 123
*line 123
cmp #19,R7
blt L15
cmp #23,R7
bgt L15
*line 124
*line 125
move #64,(sp)
move #256,-(sp)
move R6,-(sp)
move R7,-(sp)
add #-18,(sp)
move.l _obj11,-(sp)
jsr _vsetav
adda.l #10,sp
*line 126
*line 127
move R7,_mtcoldr
*line 128
move R6,_mtcoldc
*line 129
*line 130
L15:
*line 131
move R7,_vtcrow
*line 132
move R6,_vtccol
L12:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl _mtcoff
.text
_mtcoff:
~~mtcoff:
link R14,#-4
*line 143
*line 144
clr R0
move 10+_v_regs,R0
and #384,R0
beq L17
*line 144
clr (sp)
jsr _vbank
*line 145
L17:
*line 146
*line 147
cmp #19,_mtcoldr
blt L18
cmp #23,_mtcoldr
bgt L18
*line 147
move #64,(sp)
move #256,-(sp)
move _mtcoldc,-(sp)
move _mtcoldr,-(sp)
add #-18,(sp)
move.l _obj11,-(sp)
jsr _vclrav
adda.l #10,sp
L18:L16:unlk R14
rts
.data
