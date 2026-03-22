.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _puts
.text
_puts:
~~puts:
~str=R13
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 15
move.l 8(R14),R13
*line 15
bra L4
L3:
*line 16
*line 17
move.l #18+_Cbuffs,(sp)
move.b (R13)+,R0
ext.w R0
move R0,-(sp) 
jsr _putc
addq.l #2,sp
cmp #-1,R0
bne L5
*line 17
move #-1,R0
bra L1
*line 18
L5:L4:
*line 19
tst.b (R13)
bne L3
L2:
*line 19
move.l #18+_Cbuffs,(sp)
move #10,-(sp)
jsr _putc
addq.l #2,sp
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl _aputc
.text
_aputc:
~~aputc:
~c=R7
~ptr=R13
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
*line 27
move 8(R14),R7
*line 27
move.l 10(R14),R13
*line 27
and #127,R7
*line 29
*line 30
cmp #10,R7
bne L7
*line 30
*line 31
move.l R13,(sp)
move #13,-(sp)
jsr _putc
addq.l #2,sp
cmp #-1,R0
bne L8
*line 31
move #-1,R0
bra L6
*line 32
L8:L7:
*line 33
move.l R13,(sp)
move R7,-(sp)
jsr _putc
addq.l #2,sp
bra L6
L6:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl _fputs
.text
_fputs:
~~fputs:
~s=R13
~fp=12
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 41
move.l 8(R14),R13
*line 41
bra L12
L11:
*line 42
*line 43
move.l 12(R14),(sp)
move.b (R13)+,R0
ext.w R0
move R0,-(sp) 
jsr _aputc
addq.l #2,sp
cmp #-1,R0
bne L13
*line 43
move #-1,R0
bra L9
L13:L12:
*line 44
tst.b (R13)
bne L11
L10:
*line 44
clr R0
bra L9
L9:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
