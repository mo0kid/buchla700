.globl ___atab
.globl _strtol
.text
_strtol:
~~strtol:
~str=R13
~base=R7
~ptr=12
link R14,#-4
movem.l R4-R7/R13-R13,-(sp)
~val=R6
~c=R5
~xx=-2
~neg=-4
*line 22
clr -4(R14)
*line 24
move.l 8(R14),R13
*line 24
move 16(R14),R7
*line 24
*line 25
tst.l 12(R14)
beq L2
*line 25
move.l 12(R14),R8
move.l R13,(R8)
*line 26
L2:
*line 27
*line 28
tst R7
blt L10000
cmp #36,R7
ble L3
L10000:*line 28
clr.l R0
bra L1
*line 29
L3:
*line 30
*line 30
move.b (R13),R5
ext.w R5
move.l #___atab,R8
move.b 0(R8,R5),R0
ext.w R0
and #28,R0
bne L4
*line 31
*line 32
bra L7
L6:
*line 33
add.l #1,R13
move.b (R13),R5
ext.w R5
L7:
*line 33
move R5,R8
add.l #___atab,R8
btst #5,(R8)
bne L6
L5:
*line 34
*line 35
move R5,R0
bra L9
*line 36
L10:
*line 37
*line 38
add #1,-4(R14)
*line 39
L11:
*line 40
*line 41
add.l #1,R13
move.b (R13),R5
ext.w R5
bra L8
L9:cmp #43,R0
beq L11
cmp #45,R0
beq L10
bra L8
L8:
*line 42
*line 43
*line 44
L4:
*line 45
*line 46
tst R7
bne L12
*line 46
*line 47
cmp #48,R5
beq L13
*line 47
move #10,R7
bra L14
L13:
*line 48
*line 49
cmp.b #120,1(R13)
beq L10001
cmp.b #88,1(R13)
bne L15
L10001:*line 49
move #16,R7
*line 50
bra L16
L15:
*line 51
move #8,R7
L16:L14:
*line 52
*line 53
*line 54
*line 55
*line 56
L12:
*line 57
*line 58
move.l #___atab,R8
move.b 0(R8,R5),R0
ext.w R0
and #28,R0
beq L10002
move R5,R8
add.l #___atab,R8
btst #2,(R8)
beq L10003
move R5,R0
add #-48,R0
bra L10005
L10003:move R5,R8
add.l #___atab,R8
btst #4,(R8)
beq L10006
move R5,R0
add #-87,R0
bra L10008
L10006:move R5,R0
add #-55,R0
L10008:L10005:move R0,-2(R14)
cmp R0,R7
bgt L17
L10002:*line 58
clr.l R0
bra L1
*line 59
L17:
*line 60
*line 61
*line 62
cmp #16,R7
bne L18
cmp #48,R5
bne L18
move.b 2(R13),R0
ext.w R0
ext.l R0
add.l #___atab,R0
move.l R0,R8
btst #7,(R8)
beq L18
cmp.b #120,1(R13)
beq L10009
cmp.b #88,1(R13)
bne L18
L10009:*line 62
add.l #2,R13
move.b (R13),R5
ext.w R5
*line 63
L18:
*line 64
move R5,R8
add.l #___atab,R8
btst #2,(R8)
beq L10010
move R5,R0
add #-48,R0
bra L10012
L10010:move R5,R8
add.l #___atab,R8
btst #4,(R8)
beq L10013
move R5,R0
add #-87,R0
bra L10015
L10013:move R5,R0
add #-55,R0
L10015:L10012:neg R0
ext.l R0
move.l R0,R6
bra L21
L22:
*line 65
*line 66
move R7,R0
ext.l R0
move.l R0,-(sp)
move.l R6,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,R6
move -2(R14),R0
ext.l R0
sub.l R0,R6
L20:L21:
*line 64
add.l #1,R13
move.b (R13),R0
ext.w R0
move R0,R5
move.l #___atab,R8
move.b 0(R8,R5),R0
ext.w R0
and #28,R0
beq L10016
move R5,R8
add.l #___atab,R8
btst #2,(R8)
beq L10017
move R5,R0
add #-48,R0
bra L10019
L10017:move R5,R8
add.l #___atab,R8
btst #4,(R8)
beq L10020
move R5,R0
add #-87,R0
bra L10022
L10020:move R5,R0
add #-55,R0
L10022:L10019:move R0,-2(R14)
cmp R0,R7
bgt L22
L10016:L19:
*line 68
*line 69
tst.l 12(R14)
beq L23
*line 69
move.l 12(R14),R8
move.l R13,(R8)
*line 70
L23:
*line 71
tst -4(R14)
beq L10023
move.l R6,R0
bra L10025
L10023:move.l R6,R0
neg.l R0
L10025:bra L1
L1:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.data
