.globl _errno
.globl _Cbuffs
.globl _Stdbufs
.globl _Stdbuf
.globl _chantab
.globl _Wrkbuf
.globl _readbuf
.text
_readbuf:
~~readbuf:
~dev=8
~buf=10
link R14,#-4
*line 47
jsr _xtrap15
*line 48
move #1,R0
bra L1
L1:unlk R14
rts
.data
