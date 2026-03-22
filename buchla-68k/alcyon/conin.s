.globl _errno
.globl __ConBuf
.comm __ConBuf,258
.globl __CBused
.comm __CBused,2
.globl __conin
.text
__conin:
~~_conin:
~x=8
~buff=10
~len=14
link R14,#-2
movem.l R6-R7,-(sp)
~nbp=-2
~l=R7
*line 29
*line 29
tst.b 1+__ConBuf
bne L2
*line 30
*line 31
move.b #255,__ConBuf
*line 32
clr R0
move.b R0,2+__ConBuf
move.b R0,1+__ConBuf
*line 33
*line 34
move.l #__ConBuf,(sp)
move #2,-(sp)
jsr _readbuf
addq.l #2,sp
*line 35
move.l #L3,(sp)
move #2,-(sp)
jsr _writeln
addq.l #2,sp
*line 36
*line 37
*line 37
cmp.b #26,2+__ConBuf
bne L4
*line 38
*line 39
clr.b 1+__ConBuf
*line 40
clr R0
bra L1
*line 41
*line 42
L4:
*line 43
move.b 1+__ConBuf,R0
ext.w R0
add #1,R0
move.b R0,1+__ConBuf
move R0,-2(R14)
*line 44
move -2(R14),R8
add.l #__ConBuf,R8
move.b #13,1(R8)
add #1,-2(R14)
*line 45
move.l #__ConBuf,R8
move -2(R14),R9
add.l R9,R8
move.b #10,1(R8)
*line 46
move #2,__CBused
*line 47
*line 48
L2:
*line 49
*line 50
move.b 1+__ConBuf,R7
ext.w R7
move R7,R0
cmp 14(R14),R0
ble L5
*line 50
move 14(R14),R7
*line 51
L5:
*line 52
move R7,(sp)
move.l #__ConBuf,R0
move __CBused,R1
ext.l R1
add.l R1,R0
move.l R0,-(sp)
move.l 10(R14),-(sp)
jsr _memcpy
addq.l #8,sp
*line 53
add R7,__CBused
*line 54
move R7,R0
move.b 1+__ConBuf,R1
sub.b R0,R1
move.b R1,1+__ConBuf
*line 55
move R7,R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.data
L3:.dc.b $D,$A,$0
