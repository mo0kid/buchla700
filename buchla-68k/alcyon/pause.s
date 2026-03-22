.globl _pause
.text
_pause:
~~pause:
~s=8
link R14,#-4
*line 15
move.l 8(R14),(sp)
move #2,-(sp)
jsr _writeln
addq.l #2,sp
*line 16
move.l #L2,(sp)
move #2,-(sp)
jsr _writeln
addq.l #2,sp
*line 17
jsr _waitcr
L1:unlk R14
rts
.data
L2:.dc.b $D,$A,$0
