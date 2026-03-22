.globl _readln
.text
_readln:
~~readln:
~unit=8
~nc=10
~ctl=12
~nb=16
~buf=18
link R14,#0
movem.l R4-R7/R12-R13,-(sp)
~cp=R13
~i=R7
~j=R6
~bp=R12
~c=R5
*line 83
*line 84
cmp #1,8(R14)
blt L10000
cmp #4,8(R14)
ble L2
L10000:*line 84
move.l #$fffffff1,R0
bra L1
*line 85
L2:
*line 86
move.l 18(R14),R12
*line 88
clr R7
bra L5
L6:
*line 89
*line 90
move 8(R14),(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$ff,R0
move.b R0,R5
*line 91
*line 92
move.b R5,(R12)+
*line 93
clr.b (R12)
*line 94
*line 95
move.l 12(R14),R13
*line 96
*line 97
clr R6
bra L9
L10:
*line 98
*line 99
move.b R5,R0
ext.w R0
move.l 12(R14),R9
move.b (R9),R1
ext.w R1
cmp R1,R0
move sr,R0
add.l #1,12(R14)
move R0,ccr
bne L11
*line 99
move.b R5,R0
ext.w R0
bra L1
*line 100
L11:L8:
*line 97
add #1,R6
L9:
*line 97
cmp 10(R14),R6
blt L10
L7:
*line 101
move.b R5,R0
ext.w R0
move R0,(sp) 
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L4:
*line 88
add #1,R7
L5:
*line 88
cmp 16(R14),R7
blt L6
L3:
*line 104
move.l #$ffffffff,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R12-R13
unlk R14
rts
.globl _getln
.text
_getln:
~~getln:
~unit=8
~nb=10
~buf=12
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~bp=R13
~c=R7
~bc=R6
*line 119
clr R6
*line 120
move.l 12(R14),R13
*line 121
clr.b (R13)
*line 123
bra L15
L14:
*line 124
*line 125
move 8(R14),(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$ff,R0
move.b R0,R7
*line 126
*line 127
move.b R7,R0
ext.w R0
bra L17
*line 128
L18:
*line 129
L19:
*line 130
*line 131
*line 132
*line 132
tst R6
bne L20
*line 133
*line 134
move #7,(sp)
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
bra L16
*line 135
*line 136
bra L21
L20:
*line 137
*line 138
*line 139
sub #1,R6
*line 140
sub.l #1,R13
*line 141
clr.b (R13)
*line 142
move #8,(sp)
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 143
move #32,(sp)
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 144
move #8,(sp)
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
bra L16
*line 145
L21:
*line 146
*line 147
L22:
*line 148
L23:
*line 149
*line 150
*line 151
move.b R7,(R13)+
*line 152
clr.b (R13)
*line 153
move.b R7,R0
ext.w R0
bra L12
*line 154
*line 155
*line 156
L24:
*line 157
*line 158
*line 159
move.l 12(R14),R8
clr.b (R8)
*line 160
move.b R7,R0
ext.w R0
bra L12
*line 161
L25:
*line 162
*line 163
*line 164
move.b R7,(R13)+
*line 165
clr.b (R13)
*line 166
move.b R7,R0
ext.w R0
move R0,(sp) 
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
*line 167
add #1,R6
bra L16
L17:ext.l R0
move.l #L26,R8
move #5,R1
L27:cmp.l (R8)+,R0
dbeq R1,L27
move.l 20(R8),R8
jmp (R8)
.data
L26:.dc.l 8
.dc.l 10
.dc.l 13
.dc.l 24
.dc.l 127
.dc.l 0
.dc.l L18
.dc.l L23
.dc.l L22
.dc.l L24
.dc.l L19
.dc.l L25
.text
L16:
*line 168
L15:
*line 169
cmp 10(R14),R6
blt L14
L13:
*line 171
move.l #$ffffffff,R0
bra L12
L12:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _getrln
.text
_getrln:
~~getrln:
~unit=8
~nb=10
~buf=12
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~bp=R13
~c=R7
~bc=R6
*line 186
clr R6
*line 187
move.l 12(R14),R13
*line 188
clr.b (R13)
*line 190
bra L31
L30:
*line 191
*line 192
move 8(R14),(sp)
move #2,-(sp)
jsr _trap13
addq.l #2,sp
and.l #$ff,R0
move.b R0,R7
*line 193
*line 194
move.b R7,R0
ext.w R0
bra L33
*line 195
L34:
*line 196
L35:
*line 197
L36:
*line 198
*line 199
*line 200
move.b R7,(R13)+
*line 201
clr.b (R13)
*line 202
move.b R7,R0
ext.w R0
bra L28
*line 203
L37:
*line 204
*line 205
*line 206
move.l 12(R14),R8
clr.b (R8)
*line 207
move.b R7,R0
ext.w R0
bra L28
*line 208
L38:
*line 209
*line 210
*line 211
move.b R7,(R13)+
*line 212
clr.b (R13)
*line 213
add #1,R6
bra L32
L33:cmp #10,R0
beq L35
cmp #13,R0
beq L34
cmp #24,R0
beq L37
cmp #26,R0
beq L36
bra L38
L32:
*line 214
L31:
*line 215
cmp 10(R14),R6
blt L30
L29:
*line 217
move.l #$ffffffff,R0
bra L28
L28:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl _writeln
.text
_writeln:
~~writeln:
~unit=8
~buf=10
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~bp=R13
~c=R7
*line 229
move.l 10(R14),R13
*line 231
bra L42
L41:
*line 232
move.b R7,R0
ext.w R0
move R0,(sp) 
move 8(R14),-(sp)
move #3,-(sp)
jsr _trap13
addq.l #4,sp
L42:
*line 232
move.b (R13)+,R7
bne L41
L40:L39:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.data
