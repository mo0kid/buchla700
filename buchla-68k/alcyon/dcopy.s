.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _defect
.globl _end
.globl _edata
.globl _etext
.globl _p_dlen
.globl _mphead
.globl _dcopy
.text
_dcopy:
~~dcopy:
link R14,#0
movem.l R3-R7/R12-R13,-(sp)
~fp=R13
~from=R12
~wrtlen=R7
~loadlen=R6
~bsslen=R5
~txtlen=R4
*line 40
clr _defect
*line 42
move.l #_etext,R4
sub.l #_Lo_RAM,R4
*line 43
move.l #_end,R5
sub.l #_edata,R5
*line 45
move.l #_edata,R6
sub.l #_Lo_RAM,R6
*line 49
move #24602,_mphead
*line 50
move.l R4,2+_mphead
*line 51
move.l _p_dlen,6+_mphead
*line 52
move.l R5,10+_mphead
*line 53
clr.l 14+_mphead
*line 54
clr.l 18+_mphead
*line 55
move.l #_Lo_RAM,22+_mphead
*line 56
move #-1,26+_mphead
*line 62
jsr _preio
*line 64
*line 64
move.l #L3,(sp)
move.l #L2,-(sp)
jsr _fopenb
addq.l #4,sp
move.l R0,R13
move.l R13,R0
bne L4
*line 65
*line 66
move #1,_defect
*line 67
jsr _postio
*line 68
move #-1,R0
bra L1
*line 69
*line 70
*line 71
*line 72
*line 73
*line 74
L4:
*line 75
move.l #_mphead,R12
*line 77
move.l #$1c,R7
bra L7
L8:
*line 78
*line 78
move.l R13,(sp)
move.b (R12)+,R0
ext.w R0
move R0,-(sp) 
jsr _putc
addq.l #2,sp
cmp #-1,R0
bne L9
*line 79
*line 80
move #2,_defect
*line 81
move.l R13,(sp)
jsr _fclose
*line 82
jsr _postio
*line 83
move #-1,R0
bra L1
*line 84
*line 85
*line 86
*line 87
L9:L6:L7:
*line 77
move.l R7,R0
sub.l #$1,R7
tst.l R0
bne L8
L5:
*line 88
move.l #_Lo_RAM,R12
*line 90
move.l R6,R7
bra L12
L13:
*line 91
*line 91
move.l R13,(sp)
move.b (R12)+,R0
ext.w R0
move R0,-(sp) 
jsr _putc
addq.l #2,sp
cmp #-1,R0
bne L14
*line 92
*line 93
move #3,_defect
*line 94
move.l R13,(sp)
jsr _fclose
*line 95
jsr _postio
*line 96
move #-1,R0
bra L1
*line 97
*line 98
*line 99
*line 100
L14:L11:L12:
*line 90
move.l R7,R0
sub.l #$1,R7
tst.l R0
bne L13
L10:
*line 101
move.l R13,(sp)
jsr _fflush
*line 102
move.l R13,(sp)
jsr _fclose
*line 103
jsr _postio
*line 104
clr R0
bra L1
L1:tst.l (sp)+
movem.l (sp)+,R4-R7/R12-R13
unlk R14
rts
.data
L2:.dc.b $6D,$69,$64,$61,$73,$2E,$61,$62,$73,$0
L3:.dc.b $77,$0
