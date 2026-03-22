.globl _ebflag
.globl _ebuf
.globl _curfet
.globl _cfetp
.globl _infetp
.globl _trkonly
.data
_trkonly:
.dc.w $0
.globl _curmove
.globl _curtype
.globl _cx_key
.globl _cx_upd
.globl _cy_key
.globl _cy_upd
.globl _d_key
.globl _e_key
.globl _m_key
.globl _not_fld
.globl _premove
.globl _pstmove
.globl _x_key
.globl _xy_dn
.globl _xy_up
.globl _cratex
.globl _cratey
.globl _chtime
.globl _chwait
.globl _cmfirst
.globl _cmtype
.globl _curhold
.globl _curslim
.globl _cvtime
.globl _cvwait
.globl _cxval
.globl _cyval
.globl _hcwval
.globl _nchwait
.globl _ncvwait
.globl _stccol
.globl _stcrow
.globl _submenu
.globl _syrate
.globl _thcwval
.globl _tvcwval
.globl _vcwval
.globl _infetp
.globl _cfetp
.globl _curfet
.globl _csbp
.globl _stdctp0
.text
_stdctp0:
~~stdctp0:
link R14,#-4
*line 139
tst _submenu
beq L10000
move #2,R0
bra L10002
L10000:move #1,R0
L10002:bra L1
L1:unlk R14
rts
.globl _stdctp1
.text
_stdctp1:
~~stdctp1:
link R14,#-4
*line 151
*line 152
tst _submenu
beq L3
*line 152
move #2,R0
bra L2
*line 153
L3:
*line 154
move _cyval,R0
cmp _curslim,R0
ble L10003
move #1,R0
bra L10005
L10003:clr R0
L10005:bra L2
L2:unlk R14
rts
.globl _stdctp2
.text
_stdctp2:
~~stdctp2:
link R14,#-4
*line 166
clr R0
bra L4
L4:unlk R14
rts
.globl _stdctp3
.text
_stdctp3:
~~stdctp3:
link R14,#-4
*line 181
*line 182
tst _submenu
beq L6
*line 182
move #2,R0
bra L5
*line 183
L6:
*line 184
cmp #14,_cyval
blt L10007
cmp #237,_cyval
ble L10006
L10007:move #3,R0
bra L10009
L10006:clr R0
L10009:bra L5
L5:unlk R14
rts
.globl _stdctp4
.text
_stdctp4:
~~stdctp4:
link R14,#-4
*line 196
*line 197
tst _submenu
beq L8
*line 197
move #2,R0
bra L7
*line 198
L8:
*line 199
move _cyval,R0
cmp _curslim,R0
bge L10010
move #1,R0
bra L10012
L10010:clr R0
L10012:bra L7
L7:unlk R14
rts
.globl _stdctp5
.text
_stdctp5:
~~stdctp5:
link R14,#-4
*line 211
tst _submenu
beq L10013
move #5,R0
bra L10015
L10013:move #4,R0
L10015:bra L9
L9:unlk R14
rts
.globl _curset
.text
_curset:
~~curset:
~s=R13
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 231
move.l 8(R14),R13
*line 231
move.l (R13),_curtype
*line 232
move.l 4(R13),_premove
*line 233
move.l 8(R13),_pstmove
*line 235
move.l #_cmvgen,_curmove
*line 237
*line 237
tst _trkonly
beq L11
*line 238
*line 239
move.l #_txstd,_cx_key
*line 240
move.l #_tystd,_cy_key
*line 241
bra L12
L11:
*line 242
*line 243
*line 244
move.l 12(R13),_cx_key
*line 245
move.l 16(R13),_cy_key
L12:
*line 248
move.l 20(R13),_cx_upd
*line 249
move.l 24(R13),_cy_upd
*line 250
move.l 28(R13),_xy_up
*line 251
move.l 32(R13),_xy_dn
*line 252
move.l 36(R13),_x_key
*line 253
move.l 40(R13),_e_key
*line 254
move.l 44(R13),_m_key
*line 255
move.l 48(R13),_d_key
*line 256
move.l 52(R13),_not_fld
*line 257
move.l 56(R13),_curfet
*line 258
move.l 60(R13),_csbp
*line 259
move.l 64(R13),_cratex
*line 260
move.l 68(R13),_cratey
*line 261
move 72(R13),_cmtype
*line 262
move 74(R13),_cxval
*line 263
move 76(R13),_cyval
*line 272
*line 272
tst _cmtype
bne L13
*line 273
*line 274
move _hcwval,_chtime
*line 275
move _vcwval,_cvtime
*line 276
bra L14
L13:
*line 277
*line 278
*line 279
move _thcwval,_chtime
*line 280
cmp #4,_cmtype
bne L10016
move _syrate,R0
bra L10018
L10016:move _tvcwval,R0
L10018:move R0,_cvtime
L14:
*line 283
move _cxval,R0
asr #3,R0
move R0,_stccol
*line 284
move _cyval,R0
ext.l R0
divs #14,R0
move R0,_stcrow
*line 286
move _chtime,_chwait
*line 287
move _cvtime,_cvwait
*line 289
move _curhold,_nchwait
*line 290
move _curhold,_ncvwait
*line 292
move #1,_cmfirst
*line 294
clr _ebflag
*line 295
move #81,(sp)
clr -(sp)
move.l #_ebuf,-(sp)
jsr _memset
addq.l #6,sp
*line 297
clr.l _cfetp
*line 298
clr.l _infetp
L10:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.data
