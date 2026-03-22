.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _et_rel
.text
_et_rel:
~~et_rel:
link R14,#-4
*line 14
move #-1,R0
bra L1
L1:unlk R14
rts
.globl _ef_rel
.text
_ef_rel:
~~ef_rel:
link R14,#-4
*line 20
move #-1,R0
bra L2
L2:unlk R14
rts
.globl _rd_rel
.text
_rd_rel:
~~rd_rel:
link R14,#-4
*line 26
move #-1,R0
bra L3
L3:unlk R14
rts
.globl _nd_rel
.text
_nd_rel:
~~nd_rel:
link R14,#-4
*line 32
move #-1,R0
bra L4
L4:unlk R14
rts
.data
