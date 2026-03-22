.globl _rename
.text
_rename:
~~rename:
~old=8
~new=12
link R14,#-64
~buff=-60
*line 13
move #-1,R0
bra L1
L1:unlk R14
rts
.data
