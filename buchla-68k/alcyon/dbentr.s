.globl _DB_In
.comm _DB_In,2
.globl _DB_Out
.comm _DB_Out,2
.globl _DB_Flag
.comm _DB_Flag,2
.globl _DB_Levl
.comm _DB_Levl,4
.globl _DB_Last
.comm _DB_Last,4
.globl _DB_Ents
.comm _DB_Ents,1536
.globl _DB_Type
.data
_DB_Type:
*line 61
.dc.l L1
*line 62
.dc.l L2
*line 64
.dc.l L3
.globl _DB_Entr
.text
_DB_Entr:
~~DB_Entr:
~str=8
link R14,#-4
*line 78
move _DB_In,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
clr 4(R8)
*line 79
move _DB_In,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move.l 8(R14),(R8)
*line 81
move.l 8(R14),_DB_Last
*line 83
add.l #$1,_DB_Levl
*line 85
*line 86
add #1,_DB_In
move _DB_In,R0
cmp #256,R0
blt L5
*line 86
clr _DB_In
*line 87
L5:
*line 88
*line 88
move _DB_In,R0
cmp _DB_Out,R0
bne L6
*line 89
*line 90
*line 91
add #1,_DB_Out
move _DB_Out,R0
cmp #256,R0
blt L7
*line 91
clr _DB_Out
L7:
*line 92
L6:L4:unlk R14
rts
.globl _DB_Exit
.text
_DB_Exit:
~~DB_Exit:
~str=8
link R14,#-4
*line 107
move _DB_In,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move #1,4(R8)
*line 108
move _DB_In,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move.l 8(R14),(R8)
*line 110
move.l 8(R14),_DB_Last
*line 112
*line 113
tst.l _DB_Levl
ble L9
*line 113
sub.l #$1,_DB_Levl
*line 114
bra L10
L9:
*line 115
clr.l _DB_Levl
L10:
*line 117
*line 118
add #1,_DB_In
move _DB_In,R0
cmp #256,R0
blt L11
*line 118
clr _DB_In
*line 119
L11:
*line 120
*line 120
move _DB_In,R0
cmp _DB_Out,R0
bne L12
*line 121
*line 122
*line 123
add #1,_DB_Out
move _DB_Out,R0
cmp #256,R0
blt L13
*line 123
clr _DB_Out
L13:
*line 124
L12:L8:unlk R14
rts
.globl _DB_Cmnt
.text
_DB_Cmnt:
~~DB_Cmnt:
~str=8
link R14,#-4
*line 139
move _DB_In,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move #2,4(R8)
*line 140
move _DB_In,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move.l 8(R14),(R8)
*line 142
move.l 8(R14),_DB_Last
*line 144
*line 145
add #1,_DB_In
move _DB_In,R0
cmp #256,R0
blt L15
*line 145
clr _DB_In
*line 146
L15:
*line 147
*line 147
move _DB_In,R0
cmp _DB_Out,R0
bne L16
*line 148
*line 149
*line 150
add #1,_DB_Out
move _DB_Out,R0
cmp #256,R0
blt L17
*line 150
clr _DB_Out
L17:
*line 151
L16:L14:unlk R14
rts
.globl _DB_Clr
.text
_DB_Clr:
~~DB_Clr:
link R14,#0
movem.l R6-R7,-(sp)
~i=R7
*line 167
clr _DB_In
*line 168
clr _DB_Out
*line 170
clr R7
bra L21
L22:
*line 171
*line 172
move R7,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
clr 4(R8)
*line 173
move R7,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move.l #$0,(R8)
L20:
*line 170
add #1,R7
L21:
*line 170
cmp #256,R7
blt L22
L19:
*line 176
clr.l _DB_Levl
*line 177
clr.l _DB_Last
L18:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl _DB_Dump
.text
_DB_Dump:
~~DB_Dump:
link R14,#0
movem.l R4-R7,-(sp)
~tag=R7
~i=R6
~lev=R5
*line 194
*line 194
cmp #256,_DB_In
bge L10000
tst _DB_In
bge L24
L10000:*line 195
*line 196
move _DB_In,(sp)
move.l #L25,-(sp)
jsr _printf
addq.l #4,sp
*line 197
*line 198
jsr _xtrap15
*line 199
*line 200
jsr _DB_Clr
bra L23
*line 201
*line 202
*line 203
L24:
*line 204
*line 204
cmp #256,_DB_Out
bge L10001
tst _DB_Out
bge L26
L10001:*line 205
*line 206
move _DB_Out,(sp)
move.l #L27,-(sp)
jsr _printf
addq.l #4,sp
*line 207
*line 208
jsr _xtrap15
*line 209
*line 210
jsr _DB_Clr
bra L23
*line 211
*line 212
*line 213
L26:
*line 214
*line 214
move _DB_In,R0
cmp _DB_Out,R0
bne L28
*line 215
*line 216
move _DB_In,(sp)
move.l #L29,-(sp)
jsr _printf
addq.l #4,sp
*line 217
*line 218
*line 219
tst.l _DB_Levl
beq L30
*line 219
move.l _DB_Levl,(sp)
move.l #L31,-(sp)
jsr _printf
addq.l #4,sp
*line 220
L30:
*line 221
*line 222
tst.l _DB_Last
beq L32
*line 222
move.l _DB_Last,(sp)
move.l #L33,-(sp)
jsr _printf
addq.l #4,sp
*line 223
L32:
*line 224
*line 225
tst _DB_Flag
bne L34
*line 225
jsr _xtrap15
*line 226
L34:
*line 227
jsr _DB_Clr
bra L23
*line 228
*line 229
*line 230
*line 231
L28:
*line 232
move.l _DB_Levl,(sp)
move.l #L35,-(sp)
jsr _printf
addq.l #4,sp
*line 234
clr.l R5
*line 236
bra L38
L37:
*line 237
*line 238
clr.l R6
bra L41
L42:
*line 239
move.l #L43,(sp)
jsr _printf
L40:
*line 238
add.l #$1,R6
L41:
*line 238
cmp.l R5,R6
blt L42
L39:
*line 239
*line 240
*line 241
move _DB_Out,R0
muls #6,R0
add.l #_DB_Ents,R0
move.l R0,R8
move 4(R8),R7
*line 242
*line 243
move _DB_Out,R0
muls #6,R0
move.l R0,R8
move.l #_DB_Ents,R9
move.l 0(R8,R9.l),(sp)
move R7,R8
add.l R8,R8
add.l R8,R8
move.l #_DB_Type,R9
move.l 0(R8,R9.l),-(sp)
move.l #L44,-(sp)
jsr _printf
addq.l #8,sp
*line 244
*line 245
move R7,R0
bra L46
*line 246
L47:
*line 247
*line 248
*line 249
add.l #$1,R5
bra L45
*line 250
*line 251
L48:
*line 252
*line 253
*line 254
*line 254
sub.l #$1,R5
bge L49
*line 255
*line 256
clr.l R5
*line 257
move.l #L50,(sp)
jsr _printf
*line 258
*line 259
L49:bra L45
*line 260
bra L45
L46:tst R0
beq L47
cmp #1,R0
beq L48
bra L45
L45:
*line 261
*line 262
*line 263
*line 264
add #1,_DB_Out
move _DB_Out,R0
cmp #256,R0
blt L51
*line 264
clr _DB_Out
L51:L38:
*line 265
move _DB_Out,R0
cmp _DB_In,R0
bne L37
L36:
*line 267
move.l #L52,(sp)
jsr _printf
*line 269
jsr _DB_Clr
*line 271
*line 272
tst _DB_Flag
bne L53
*line 272
jsr _xtrap15
*line 273
L53:bra L23
L23:tst.l (sp)+
movem.l (sp)+,R5-R7
unlk R14
rts
.data
L1:.dc.b $2D,$2D,$3E,$3E,$0
L2:.dc.b $3C,$3C,$2D,$2D,$0
L3:.dc.b $4E,$6F,$74,$65,$0
L25:.dc.b $44,$42,$5F,$49,$6E,$20,$77,$61,$73,$20,$63,$6F,$72,$72,$75,$70,$74,$3A,$20,$20,$25,$64,$A,$0
L27:.dc.b $44,$42,$5F,$4F,$75,$74,$20,$77,$61,$73,$20,$63,$6F,$72,$72,$75,$70,$74,$3A,$20,$20,$25,$64,$A,$0
L29:.dc.b $44,$65,$62,$75,$67,$20,$62,$75,$66,$66,$65,$72,$20,$69,$73,$20,$65,$6D,$70,$74,$79,$3A,$20,$20,$49,$6E,$20,$3D,$20,$4F
.dc.b $75,$74,$20,$3D,$20,$25,$64,$A,$0
L31:.dc.b $44,$65,$62,$75,$67,$20,$74,$72,$61,$63,$65,$20,$6C,$65,$76,$65,$6C,$20,$3D,$20,$25,$6C,$64,$A,$0
L33:.dc.b $4C,$61,$74,$65,$73,$74,$20,$65,$6E,$74,$72,$79,$20,$3D,$20,$22,$25,$73,$22,$A,$0
L35:.dc.b $44,$65,$62,$75,$67,$20,$74,$72,$61,$63,$65,$20,$6C,$65,$76,$65,$6C,$20,$3D,$20,$25,$6C,$64,$A,$A,$0
L43:.dc.b $7C,$0
L44:.dc.b $25,$73,$3A,$20,$20,$25,$73,$A,$0
L50:.dc.b $A,$0
L52:.dc.b $A,$2D,$2D,$2D,$2D,$2D,$20,$45,$6E,$64,$20,$6F,$66,$20,$64,$65,$62,$75,$67,$20,$62,$75,$66,$66,$65,$72,$20,$2D,$2D,$2D
.dc.b $2D,$2D,$A,$A,$0
