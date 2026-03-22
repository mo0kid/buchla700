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
.globl _cflag
.globl _cnote
.globl _cxval
.globl _cyval
.globl _lstflag
.globl _recsw
.globl _ctime
.globl _grpmode
.globl _grpstat
.globl _delnote
.text
_delnote:
~~delnote:
link R14,#-2
movem.l R2-R7/R11-R13,-(sp)
~bp=R13
~cp=R12
~ep=R11
~t_left=R7
~tnote=R6
~grp=R5
~runtag=R4
~scantag=R3
~disptag=-2
*line 48
clr -2(R14)
*line 50
*line 51
tst _recsw
bne L2
*line 51
move #-1,R0
bra L1
*line 52
*line 53
*line 54
L2:
*line 55
*line 56
move _cyval,(sp)
move _cxval,-(sp)
jsr _pix2mid
addq.l #2,sp
tst R0
bne L3
*line 57
*line 58
add #1,_cflag
*line 59
move _cnote,R6
*line 60
move.l _t_cur,R7
add.l #$ffffff0f,R7
*line 61
clr (sp)
move.l _ctime,-(sp)
jsr _frfind
addq.l #4,sp
move.l R0,R12
*line 65
bra L6
L5:
*line 66
*line 67
clr R5
bra L9
L10:
*line 68
*line 69
*line 70
*line 71
move R5,R8
add.l R8,R8
add.l #_grpstat,R8
tst (R8)
beq L8
move R5,R8
add.l R8,R8
add.l #_grpmode,R8
cmp #2,(R8)
bne L8
*line 72
*line 73
move #1,R4
*line 74
move.l R12,R13
*line 75
*line 76
bra L13
L12:
*line 77
*line 78
*line 79
cmp.l (R13),R7
bgt L10000
cmp.b #1,5(R13)
bne L14
L10000:*line 80
*line 81
*line 82
*line 83
clr R4
bra L13
*line 84
*line 85
*line 86
bra L15
L14:
*line 87
*line 88
*line 89
cmp.b #6,5(R13)
bne L16
move.b 6(R13),R0
ext.w R0
cmp R0,R6
bne L16
move.b 7(R13),R0
ext.w R0
cmp R0,R5
bne L16
*line 90
*line 91
*line 92
*line 93
clr R4
bra L13
*line 94
*line 95
*line 96
*line 97
bra L17
L16:
*line 98
*line 99
*line 100
cmp.b #5,5(R13)
bne L18
move.b 6(R13),R0
ext.w R0
cmp R0,R6
bne L18
move.b 7(R13),R0
ext.w R0
cmp R0,R5
bne L18
*line 101
*line 102
*line 103
*line 104
*line 105
*line 106
move.l 12(R13),R11
*line 107
move #1,R3
*line 108
*line 109
bra L21
L20:
*line 110
*line 111
*line 112
*line 113
*line 114
*line 115
cmp.b #5,5(R11)
bne L22
move.b 6(R11),R0
ext.w R0
cmp R0,R6
bne L22
move.b 7(R11),R0
ext.w R0
cmp R0,R5
bne L22
*line 116
*line 117
clr R3
*line 118
clr R4
bra L21
*line 119
*line 120
*line 121
*line 122
bra L23
L22:
*line 123
*line 124
*line 125
cmp.b #6,5(R11)
bne L24
move.b 6(R11),R0
ext.w R0
cmp R0,R6
bne L24
move.b 7(R11),R0
ext.w R0
cmp R0,R5
bne L24
*line 126
*line 127
*line 128
*line 129
*line 130
*line 131
*line 132
cmp.l R11,R12
bne L25
*line 132
move.l 8(R12),R12
*line 133
L25:
*line 134
*line 135
cmp.l _p_ctr,R11
bne L26
*line 135
move.l _p_ctr,R8
move.l 8(R8),_p_ctr
*line 136
L26:
*line 137
*line 138
cmp.l _p_bak,R11
bne L27
*line 138
move.l _p_bak,R8
move.l 8(R8),_p_bak
*line 139
L27:
*line 140
*line 141
cmp.l _p_fwd,R11
bne L28
*line 141
move.l _p_fwd,R8
move.l 8(R8),_p_fwd
*line 142
L28:
*line 143
*line 144
cmp.l _p_cur,R11
bne L29
*line 144
move.l _p_cur,R8
move.l 8(R8),_p_cur
*line 145
L29:
*line 146
move.l R11,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 147
*line 148
*line 149
*line 150
*line 151
*line 152
*line 153
cmp.l R13,R12
bne L30
*line 153
move.l 8(R12),R12
*line 154
L30:
*line 155
*line 156
cmp.l _p_ctr,R13
bne L31
*line 156
move.l _p_ctr,R8
move.l 8(R8),_p_ctr
*line 157
L31:
*line 158
*line 159
cmp.l _p_bak,R13
bne L32
*line 159
move.l _p_bak,R8
move.l 8(R8),_p_bak
*line 160
L32:
*line 161
*line 162
cmp.l _p_fwd,R13
bne L33
*line 162
move.l _p_fwd,R8
move.l 8(R8),_p_fwd
*line 163
L33:
*line 164
*line 165
cmp.l _p_cur,R13
bne L34
*line 165
move.l _p_cur,R8
move.l 8(R8),_p_cur
*line 166
L34:
*line 167
move.l R13,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 168
*line 169
move #1,-2(R14)
*line 170
clr R4
*line 171
clr R3
bra L21
*line 172
*line 173
*line 174
*line 175
bra L35
L24:
*line 176
*line 176
cmp.b #21,5(R11)
bne L36
*line 177
*line 178
*line 179
*line 180
*line 181
*line 182
*line 183
cmp.l R13,R12
bne L37
*line 183
move.l 8(R12),R12
*line 184
L37:
*line 185
*line 186
cmp.l _p_ctr,R13
bne L38
*line 186
move.l _p_ctr,R8
move.l 8(R8),_p_ctr
*line 187
L38:
*line 188
*line 189
cmp.l _p_bak,R13
bne L39
*line 189
move.l _p_bak,R8
move.l 8(R8),_p_bak
*line 190
L39:
*line 191
*line 192
cmp.l _p_fwd,R13
bne L40
*line 192
move.l _p_fwd,R8
move.l 8(R8),_p_fwd
*line 193
L40:
*line 194
*line 195
cmp.l _p_cur,R13
bne L41
*line 195
move.l _p_cur,R8
move.l 8(R8),_p_cur
*line 196
L41:
*line 197
move.l R13,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 198
*line 199
move #1,-2(R14)
*line 200
clr R4
*line 201
clr R3
bra L21
*line 202
*line 203
*line 204
*line 205
*line 206
L36:L35:L23:
*line 207
move.l 12(R11),R11
*line 208
L21:
*line 209
tst R3
bne L20
L19:
*line 210
*line 211
*line 212
*line 213
*line 214
*line 215
*line 216
L18:L17:L15:
*line 217
move.l 8(R13),R13
*line 218
L13:
*line 219
tst R4
bne L12
L11:
*line 220
L8:
*line 67
add #1,R5
L9:
*line 67
cmp #12,R5
blt L10
L7:
*line 221
*line 222
*line 223
*line 224
*line 225
*line 226
cmp.b #4,_ac_code
bne L42
*line 226
add #1,R6
*line 227
bra L43
L42:
*line 228
sub #1,R6
L43:
*line 229
L6:
*line 230
move _cflag,R0
sub #1,_cflag
tst R0
bne L5
L4:L3:
*line 236
*line 237
*line 238
*line 239
*line 240
*line 240
tst -2(R14)
bne L44
*line 241
*line 242
*line 243
tst.l _ctime
bge L45
*line 243
move #-1,R0
bra L1
*line 244
*line 245
*line 246
L45:
*line 247
move.l _ctime,(sp)
move #1,-(sp)
move.l _p_cur,-(sp)
jsr _ep_adj
addq.l #6,sp
move.l R0,R11
*line 248
*line 249
bra L48
L47:
*line 250
*line 251
move.l 12(R11),R13
*line 252
*line 253
*line 253
cmp.b #23,5(R11)
bne L49
*line 254
*line 255
*line 256
cmp.l _p_bak,R11
bne L50
*line 256
move.l _p_bak,R8
move.l 8(R8),_p_bak
*line 257
L50:
*line 258
*line 259
cmp.l _p_ctr,R11
bne L51
*line 259
move.l _p_ctr,R8
move.l 8(R8),_p_ctr
*line 260
L51:
*line 261
*line 262
cmp.l _p_cur,R11
bne L52
*line 262
move.l _p_cur,R8
move.l 8(R8),_p_cur
*line 263
L52:
*line 264
*line 265
cmp.l _p_fwd,R11
bne L53
*line 265
move.l _p_fwd,R8
move.l 8(R8),_p_fwd
*line 266
L53:
*line 267
move.l R11,(sp)
jsr _e_rmv
move.l R0,(sp)
jsr _e_del
*line 268
move #1,-2(R14)
*line 269
*line 270
L49:
*line 271
move.l R13,R11
L48:
*line 272
move.l (R11),R0
cmp.l _ctime,R0
beq L47
L46:
*line 273
*line 274
L44:
*line 275
*line 276
tst -2(R14)
beq L54
*line 276
move.l _t_cur,(sp)
jsr _sc_refr
*line 277
L54:
*line 278
tst -2(R14)
beq L10001
clr R0
bra L10003
L10001:move #-1,R0
L10003:bra L1
L1:tst.l (sp)+
movem.l (sp)+,R3-R7/R11-R13
unlk R14
rts
.data
