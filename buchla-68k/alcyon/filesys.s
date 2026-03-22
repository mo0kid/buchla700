.globl _errno
.globl __thebpb
.comm __thebpb,4
.globl __thedir
.comm __thedir,7168
.globl __dptr
.comm __dptr,4
.globl __thefat
.comm __thefat,3584
.globl __fatin
.comm __fatin,2
.globl __dirin
.comm __dirin,2
.globl __bpbin
.comm __bpbin,2
.globl __fatmod
.comm __fatmod,2
.globl __dirmod
.comm __dirmod,2
.globl __berrno
.comm __berrno,4
.globl __cl2lsn
.text
__cl2lsn:
~~_cl2lsn:
~bpp=8
~clnum=12
link R14,#-4
*line 71
move.l 8(R14),R8
clr R0
move 12(R8),R0
move.l 8(R14),R9
clr R1
move 2(R9),R1
clr R2
move 12(R14),R2
sub #2,R2
mulu R2,R1
add R1,R0
bra L1
L1:unlk R14
rts
.globl __gtcl12
.text
__gtcl12:
~~_gtcl12:
~fat=R13
~cl=12
link R14,#0
movem.l R5-R7/R13-R13,-(sp)
~cla=R7
~clt=R6
*line 88
move.l 8(R14),R13
*line 88
move 12(R14),R7
lsr R7
add 12(R14),R7
*line 89
*line 90
move.b 1(R13,R7),R0
ext.w R0
move R0,R6
lsl #8,R6
and #-256,R6
move.b 0(R13,R7),R0
ext.w R0
and #255,R0
or R0,R6
*line 92
*line 93
btst #0,13(R14)
beq L3
*line 93
lsr #4,R6
*line 94
L3:
*line 95
and #4095,R6
*line 96
clr R0
move R6,R0
bra L2
L2:tst.l (sp)+
movem.l (sp)+,R6-R7/R13-R13
unlk R14
rts
.globl __getfat
.text
__getfat:
~~_getfat:
~bpp=R13
~bufad=8
~nfat=16
link R14,#-2
movem.l R7-R7/R13-R13,-(sp)
~fatsec=-2
*line 116
move.l 12(R14),R13
*line 116
tst 16(R14)
beq L10000
clr R0
move 10(R13),R0
bra L10002
L10000:clr R0
move 10(R13),R0
sub 8(R13),R0
L10002:move R0,-2(R14)
*line 117
clr (sp)
move -2(R14),-(sp)
move 8(R13),-(sp)
move.l 8(R14),-(sp)
clr -(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
bra L4
L4:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __rdfat
.text
__rdfat:
~~_rdfat:
~bufad=8
~bpp=12
link R14,#-4
*line 135
*line 135
clr (sp)
move.l 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr __getfat
addq.l #8,sp
tst R0
beq L6
*line 136
*line 137
*line 138
move #1,(sp)
move.l 12(R14),-(sp)
move.l 8(R14),-(sp)
jsr __getfat
addq.l #8,sp
tst R0
beq L7
*line 138
move #-1,R0
bra L5
*line 139
bra L8
L7:
*line 140
move #1,R0
bra L5
L8:
*line 141
*line 142
bra L9
L6:
*line 143
clr R0
bra L5
L9:L5:unlk R14
rts
.globl __rdroot
.text
__rdroot:
~~_rdroot:
~bpp=R13
~buf=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 158
move.l 12(R14),R13
*line 159
clr (sp)
move 10(R13),-(sp)
clr R0
move 8(R13),R0
add R0,(sp)
move 6(R13),-(sp)
move.l 8(R14),-(sp)
clr -(sp)
move #4,-(sp)
jsr _trap13
adda.l #12,sp
bra L10
L10:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __nsic
.text
__nsic:
~~_nsic:
~fcp=R13
~bpp=12
~fp=16
link R14,#0
movem.l R6-R7/R13-R13,-(sp)
~tfe=R7
*line 184
move.l 8(R14),R13
*line 184
*line 184
btst #4,32(R13)
bne L12
*line 185
*line 186
move #22,_errno
*line 187
move #-1,R0
bra L11
*line 188
*line 189
L12:
*line 190
*line 190
btst #6,32(R13)
beq L13
*line 191
*line 192
move #5,_errno
*line 193
move #-1,R0
bra L11
*line 194
*line 195
L13:
*line 196
*line 196
tst 26(R13)
bne L14
*line 197
*line 198
or #-32768,32(R13)
*line 199
move #1,R0
bra L11
*line 200
*line 201
*line 202
*line 203
*line 204
L14:
*line 205
add.l #$1,40(R13)
*line 207
*line 207
add #1,34(R13)
clr R0
move 34(R13),R0
move.l 12(R14),R9
clr R1
move 2(R9),R1
cmp R1,R0
blo L15
*line 208
*line 209
*line 210
*line 211
clr 34(R13)
*line 212
move 36(R13),(sp)
move.l 16(R14),-(sp)
jsr __gtcl12
addq.l #4,sp
move R0,R7
*line 213
*line 214
*line 214
cmp #4080,R7
bcc L16
*line 215
*line 216
*line 217
move R7,36(R13)
*line 218
move R7,(sp)
move.l 12(R14),-(sp)
jsr __cl2lsn
addq.l #4,sp
swap R0
clr R0
swap R0
move.l R0,44(R13)
*line 219
*line 224
*line 225
*line 226
clr R0
bra L11
*line 227
*line 228
L16:
*line 229
*line 229
cmp #4088,R7
bcc L17
*line 230
*line 231
or #-16384,32(R13)
*line 232
*line 237
*line 238
*line 239
move #-1,R0
bra L11
*line 240
*line 241
L17:
*line 242
or #-32768,32(R13)
*line 243
move #1,R0
bra L11
*line 244
*line 245
*line 246
*line 247
bra L18
L15:
*line 248
*line 249
*line 250
add.l #$1,44(R13)
*line 251
*line 256
*line 257
*line 258
clr R0
bra L11
L18:L11:tst.l (sp)+
movem.l (sp)+,R7-R7/R13-R13
unlk R14
rts
.globl __dsrch
.text
__dsrch:
~~_dsrch:
~de=R13
link R14,#-4
movem.l R7-R7/R12-R13,-(sp)
~i=-2
~dl=-4
~dp=R12
*line 279
move.l 8(R14),R13
*line 279
move.l #__thedir,R12
*line 280
move.l __thebpb,R8
clr R0
move 6(R8),R0
move.l __thebpb,R9
clr R1
move (R9),R1
lsr #5,R1
mulu R1,R0
move R0,-4(R14)
*line 282
clr -2(R14)
bra L22
L23:
*line 283
*line 284
*line 285
*line 286
*line 287
move #11,(sp)
move.l R12,-(sp)
move.l R13,-(sp)
jsr _memcmpu
addq.l #8,sp
tst R0
bne L24
*line 287
move.l R12,R0
bra L19
*line 288
*line 289
*line 290
L24:
*line 291
*line 292
tst.b (R12)
bne L25
*line 292
clr.l R0
bra L19
*line 293
L25:
*line 294
add.l #32,R12
L21:
*line 282
add #1,-2(R14)
L22:
*line 282
clr R0
move -2(R14),R0
cmp -4(R14),R0
blo L23
L20:
*line 297
clr.l R0
bra L19
L19:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl __dsnew
.text
__dsnew:
~~_dsnew:
link R14,#-4
movem.l R7-R7/R13-R13,-(sp)
~i=-2
~dl=-4
~dp=R13
*line 316
move.l #__thedir,R13
*line 317
move.l __thebpb,R8
clr R0
move 6(R8),R0
move.l __thebpb,R9
clr R1
move (R9),R1
lsr #5,R1
mulu R1,R0
move R0,-4(R14)
*line 319
clr -2(R14)
bra L29
L30:
*line 320
*line 321
*line 322
*line 323
*line 324
move.b (R13),R0
ext.w R0
and #255,R0
cmp #229,R0
bne L31
*line 324
move.l R13,R0
bra L26
*line 325
*line 326
*line 327
L31:
*line 328
*line 329
tst.b (R13)
bne L32
*line 329
move.l R13,R0
bra L26
*line 330
L32:
*line 331
add.l #32,R13
L28:
*line 319
add #1,-2(R14)
L29:
*line 319
clr R0
move -2(R14),R0
cmp -4(R14),R0
blo L30
L27:
*line 334
clr.l R0
bra L26
L26:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __deadio
.text
__deadio:
~~_deadio:
~fcp=R13
~err=12
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
*line 350
move.l 8(R14),R13
*line 350
clr 34(R13)
*line 351
clr 36(R13)
*line 352
clr.l 40(R13)
*line 353
clr.l 44(R13)
*line 354
clr.l 48(R13)
*line 355
and #-4097,32(R13)
*line 356
or #8192,32(R13)
*line 357
move 12(R14),_errno
L33:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __seek
.text
__seek:
~~_seek:
~fcp=R13
link R14,#-4
movem.l R4-R7/R13-R13,-(sp)
~acls=R7
~rcls=R6
~nc=R5
~sic=-2
~spc=-4
*line 377
move.l 8(R14),R13
*line 377
*line 377
btst #4,32(R13)
bne L35
*line 378
*line 379
move #22,_errno
*line 380
move #-1,R0
bra L34
*line 381
*line 382
L35:
*line 383
*line 383
move.l 40(R13),R0
cmp.l 52(R13),R0
ble L36
*line 384
*line 389
*line 390
*line 391
move #22,_errno
*line 392
move #-1,R0
bra L34
*line 393
*line 394
L36:
*line 395
move.l __thebpb,R8
move 2(R8),-4(R14)
*line 396
clr R0
move -4(R14),R0
swap R0
clr R0
swap R0
move.l R0,-(sp)
move.l 40(R13),-(sp)
jsr ldiv
addq.l #8,sp
move R0,R6
*line 397
move.l 40(R13),R0
clr R1
move R6,R1
mulu -4(R14),R1
sub.l R1,R0
move R0,-2(R14)
*line 398
move 26(R13),(sp)
jsr _micons
move R0,R7
*line 399
and #32767,32(R13)
*line 411
*line 411
move.l 40(R13),R0
cmp.l 52(R13),R0
bne L37
*line 412
*line 413
or #-32768,32(R13)
*line 414
*line 419
*line 420
*line 421
*line 422
tst R7
bne L38
*line 422
move #2,R0
bra L34
*line 423
L38:
*line 424
*line 425
tst -2(R14)
bne L39
*line 425
move #2,R0
bra L34
L39:
*line 426
*line 427
*line 428
*line 429
L37:
*line 430
clr R5
bra L42
L43:
*line 431
*line 432
move R7,(sp)
move.l #__thefat,-(sp)
jsr __gtcl12
addq.l #4,sp
move R0,R7
*line 433
*line 434
*line 435
cmp #4080,R7
blo L41
*line 436
*line 437
or #8192,32(R13)
*line 438
move #22,_errno
*line 439
*line 440
*line 440
cmp #4088,R7
bcc L44
*line 441
*line 442
move #5,_errno
*line 443
or #16384,32(R13)
*line 444
*line 445
L44:
*line 446
move #-1,R0
bra L34
L41:
*line 430
add #1,R5
L42:
*line 430
cmp R6,R5
blo L43
L40:
*line 449
move R7,36(R13)
*line 450
move -2(R14),34(R13)
*line 452
move R7,(sp)
move.l __thebpb,-(sp)
jsr __cl2lsn
addq.l #4,sp
add -2(R14),R0
swap R0
clr R0
swap R0
move.l R0,44(R13)
*line 460
*line 461
move.l 40(R13),R0
cmp.l 52(R13),R0
bne L45
*line 461
move #1,R0
bra L34
*line 462
L45:
*line 463
clr R0
bra L34
L34:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl __ftrnc
.text
__ftrnc:
~~_ftrnc:
~dp=8
link R14,#0
movem.l R5-R7,-(sp)
~acls=R7
~ncls=R6
*line 487
move.l 8(R14),R8
move 26(R8),(sp)
jsr _micons
move R0,R7
*line 492
bra L49
L48:
*line 493
*line 494
*line 495
move R7,(sp)
move.l #__thefat,-(sp)
jsr __gtcl12
addq.l #4,sp
move R0,R6
*line 496
clr (sp)
move R7,-(sp)
move.l #__thefat,-(sp)
jsr __ptcl12
addq.l #6,sp
*line 497
*line 503
*line 504
*line 505
move R6,R7
L49:
*line 506
cmp #4080,R7
blo L48
L47:
*line 511
move.l 8(R14),R8
move.l #$0,28(R8)
*line 512
move.l 8(R14),R8
clr 26(R8)
*line 513
move #1,__fatmod
*line 514
move #1,__dirmod
*line 527
clr R0
bra L46
L46:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl __newcls
.text
__newcls:
~~_newcls:
link R14,#0
movem.l R5-R7,-(sp)
~tc=R7
~i=R6
*line 544
move.l __thebpb,R8
move 14(R8),R7
*line 546
move #2,R6
bra L53
L54:
*line 547
*line 548
move R6,(sp)
move.l #__thefat,-(sp)
jsr __gtcl12
addq.l #4,sp
tst R0
bne L55
*line 548
move R6,R0
bra L50
*line 549
L55:L52:
*line 546
add #1,R6
L53:
*line 546
cmp R7,R6
blt L54
L51:
*line 550
clr R0
bra L50
L50:tst.l (sp)+
movem.l (sp)+,R6-R7
unlk R14
rts
.globl __alcnew
.text
__alcnew:
~~_alcnew:
~fcp=R13
link R14,#0
movem.l R4-R7/R13-R13,-(sp)
~ac=R7
~nc=R6
~pc=R5
*line 572
move.l 8(R14),R13
*line 572
*line 572
jsr __newcls
move R0,R6
beq L57
*line 573
*line 576
*line 577
*line 578
move #4088,(sp)
move R6,-(sp)
move.l #__thefat,-(sp)
jsr __ptcl12
addq.l #6,sp
*line 579
move 26(R13),(sp)
jsr _micons
move R0,R5
*line 580
*line 588
*line 589
*line 590
*line 591
*line 592
*line 593
bra L60
L59:
*line 594
*line 595
*line 596
move R7,R5
L60:
*line 597
move R5,(sp)
move.l #__thefat,-(sp)
jsr __gtcl12
addq.l #4,sp
move R0,R7
move R7,R0
cmp #4080,R0
blt L59
L58:
*line 598
*line 599
*line 600
*line 601
*line 612
*line 613
*line 614
move R6,(sp)
move R5,-(sp)
move.l #__thefat,-(sp)
jsr __ptcl12
addq.l #6,sp
*line 615
move.l __thebpb,R8
clr R0
move 2(R8),R0
swap R0
clr R0
swap R0
add.l R0,52(R13)
*line 616
move R6,36(R13)
*line 617
clr 34(R13)
*line 618
*line 619
move R6,(sp)
move.l __thebpb,-(sp)
jsr __cl2lsn
addq.l #4,sp
swap R0
clr R0
swap R0
move.l R0,44(R13)
*line 620
*line 629
*line 630
*line 631
clr R0
bra L56
*line 632
bra L61
L57:
*line 633
*line 634
*line 638
*line 639
*line 640
move #-1,R0
bra L56
L61:L56:tst.l (sp)+
movem.l (sp)+,R5-R7/R13-R13
unlk R14
rts
.globl __fmake
.text
__fmake:
~~_fmake:
~fcp=8
link R14,#0
movem.l R7-R7/R13-R13,-(sp)
~dp=R13
*line 659
*line 660
jsr __dsnew
move.l R0,R13
move.l R13,R0
bne L63
*line 660
move #-1,R0
bra L62
*line 661
L63:
*line 662
move.l R13,__dptr
*line 663
move #32,(sp)
clr -(sp)
move.l R13,-(sp)
jsr _memset
addq.l #6,sp
*line 664
move #12,(sp)
move.l 8(R14),-(sp)
move.l R13,-(sp)
jsr _memcpy
addq.l #8,sp
*line 665
or.b #32,11(R13)
*line 666
move #1,__dirmod
*line 667
clr R0
bra L62
L62:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __opnvol
.text
__opnvol:
~~_opnvol:
link R14,#0
movem.l R6-R7,-(sp)
~drc=R7
*line 686
*line 686
tst __bpbin
beq L65
*line 687
*line 688
clr (sp)
move #9,-(sp)
jsr _trap13
addq.l #2,sp
move.l R0,R7
*line 689
*line 696
*line 697
*line 698
*line 699
tst.l R7
beq L66
*line 699
clr __bpbin
L66:bra L67
L65:
*line 700
*line 701
*line 705
*line 706
L67:
*line 709
*line 709
tst __bpbin
bne L68
*line 710
*line 711
clr __fatin
*line 712
clr __dirin
*line 713
*line 714
*line 714
clr (sp)
move #7,-(sp)
jsr _trap13
addq.l #2,sp
move.l R0,__thebpb
bne L69
*line 715
*line 716
move #5,_errno
*line 717
move #-1,R0
bra L64
*line 718
*line 719
L69:
*line 720
move #1,__bpbin
*line 721
*line 722
L68:
*line 723
*line 723
tst __fatin
bne L70
*line 724
*line 725
clr __dirin
*line 726
*line 727
*line 727
move.l __thebpb,(sp)
move.l #__thefat,-(sp)
jsr __rdfat
addq.l #4,sp
tst R0
bge L71
*line 728
*line 729
move #5,_errno
*line 730
move #-1,R0
bra L64
*line 731
*line 732
L71:
*line 733
move #1,__fatin
*line 734
clr __fatmod
*line 735
*line 736
*line 737
L70:
*line 738
*line 738
tst __dirin
bne L72
*line 739
*line 740
*line 740
move.l __thebpb,(sp)
move.l #__thedir,-(sp)
jsr __rdroot
addq.l #4,sp
tst R0
beq L73
*line 741
*line 742
move #5,_errno
*line 743
move #-1,R0
bra L64
*line 744
*line 745
L73:
*line 746
move #1,__dirin
*line 747
clr __dirmod
*line 748
*line 749
L72:
*line 750
clr R0
bra L64
L64:tst.l (sp)+
movem.l (sp)+,R7-R7
unlk R14
rts
.globl __opfcb
.text
__opfcb:
~~_opfcb:
~fcp=R13
link R14,#-2
movem.l R7-R7/R13-R13,-(sp)
~rc=-2
*line 772
move.l 8(R14),R13
*line 772
*line 772
btst #4,32(R13)
beq L75
*line 773
*line 774
move #22,_errno
*line 775
move #-1,R0
bra L74
*line 776
*line 777
L75:
*line 778
*line 778
jsr __opnvol
tst R0
beq L76
*line 779
*line 780
move _errno,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 781
move #-1,R0
bra L74
*line 782
*line 783
*line 784
*line 785
L76:
*line 786
*line 786
move.l R13,(sp)
jsr __dsrch
move.l R0,__dptr
bne L77
*line 787
*line 788
*line 789
*line 790
*line 790
btst #3,32(R13)
bne L78
*line 791
*line 792
move #2,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 793
move #-1,R0
bra L74
*line 794
*line 795
*line 796
*line 797
L78:
*line 798
*line 798
move.l R13,(sp)
jsr __fmake
move R0,-2(R14)
beq L79
*line 799
*line 800
move #5,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 801
move #-1,R0
bra L74
*line 802
*line 803
*line 804
*line 805
*line 806
L79:bra L80
L77:
*line 807
*line 808
*line 809
*line 810
*line 811
*line 812
btst #0,11(R13)
beq L81
clr R0
move 32(R13),R0
and #1600,R0
beq L81
*line 813
*line 814
*line 815
*line 816
move #13,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 817
move #-1,R0
bra L74
*line 818
*line 819
*line 820
*line 821
L81:
*line 822
*line 822
btst #2,32(R13)
beq L82
btst #1,32(R13)
bne L82
*line 823
*line 824
*line 825
*line 826
move #13,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 827
move #-1,R0
bra L74
*line 828
*line 829
*line 830
*line 831
L82:
*line 832
*line 832
btst #3,32(R13)
beq L83
btst #7,33(R13)
beq L83
*line 833
*line 834
*line 835
*line 836
move #17,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 837
move #-1,R0
bra L74
*line 838
*line 839
*line 840
*line 841
*line 842
*line 843
*line 844
L83:
*line 845
*line 845
btst #6,33(R13)
beq L84
*line 846
*line 847
*line 848
*line 849
*line 849
btst #1,32(R13)
beq L85
*line 850
*line 851
*line 852
*line 853
*line 853
move.l __dptr,(sp)
jsr __ftrnc
tst R0
beq L86
*line 854
*line 855
move #5,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 856
move #-1,R0
bra L74
*line 857
*line 858
L86:bra L87
L85:
*line 859
*line 860
*line 861
*line 862
*line 863
move #13,(sp)
move.l R13,-(sp)
jsr __deadio
addq.l #4,sp
*line 864
move #-1,R0
bra L74
L87:
*line 865
*line 866
L84:L80:
*line 871
move #32,(sp)
move.l __dptr,-(sp)
move.l R13,-(sp)
jsr _memcpy
addq.l #8,sp
*line 872
clr 34(R13)
*line 873
move 26(R13),(sp)
jsr _micons
move R0,36(R13)
*line 874
clr 38(R13)
*line 875
clr.l 40(R13)
*line 876
tst 26(R13)
beq L10003
move 36(R13),(sp)
move.l __thebpb,-(sp)
jsr __cl2lsn
addq.l #4,sp
bra L10005
L10003:clr R0
L10005:swap R0
clr R0
swap R0
move.l R0,44(R13)
*line 877
move.l 28(R13),(sp)
jsr _miconl
move.l R0,48(R13)
*line 879
*line 880
*line 881
move.l __thebpb,R8
clr R0
move 2(R8),R0
swap R0
clr R0
swap R0
move.l R0,-(sp)
move.l __thebpb,R8
clr R0
move 4(R8),R0
swap R0
clr R0
swap R0
move.l R0,-(sp)
move.l 48(R13),-(sp)
jsr ldiv
addq.l #8,sp
move.l __thebpb,R9
clr R1
move 4(R9),R1
sub #1,R1
swap R1
clr R1
swap R1
and.l 48(R13),R1
beq L10006
move #1,R1
bra L10008
L10006:clr R1
L10008:ext.l R1
add.l R1,R0
move.l R0,-(sp)
jsr lmul
addq.l #8,sp
move.l R0,52(R13)
*line 883
and #8191,32(R13)
*line 884
or #4096,32(R13)
*line 891
clr R0
bra L74
L74:tst.l (sp)+
movem.l (sp)+,R13-R13
unlk R14
rts
.globl __inifcb
.text
__inifcb:
~~_inifcb:
~fcp=R13
~name=12
~ext=16
~mode=20
link R14,#-2
movem.l R5-R7/R11-R13,-(sp)
~fl=-2
~i=R7
~s1=R12
~s2=R11
~c=R6
*line 917
move.l 8(R14),R13
*line 917
move #56,(sp)
clr -(sp)
move.l R13,-(sp)
jsr _memset
addq.l #6,sp
*line 921
*line 922
move 20(R14),R0
and #30960,R0
beq L89
*line 922
move #-1,R0
bra L88
*line 923
*line 924
*line 925
*line 926
*line 927
L89:
*line 928
move #1,-2(R14)
*line 929
move.l 12(R14),R12
*line 931
clr R7
bra L92
L93:
*line 932
*line 932
tst.b (R12)+
bne L94
*line 933
*line 934
clr -2(R14)
bra L90
*line 935
*line 936
*line 937
L94:L91:
*line 931
add #1,R7
L92:
*line 931
cmp #9,R7
blt L93
L90:
*line 938
*line 939
tst -2(R14)
beq L95
*line 939
move #-1,R0
bra L88
*line 940
*line 941
*line 942
L95:
*line 943
move #1,-2(R14)
*line 944
move.l 16(R14),R12
*line 946
clr R7
bra L98
L99:
*line 947
*line 947
tst.b (R12)+
bne L100
*line 948
*line 949
clr -2(R14)
bra L96
*line 950
*line 951
*line 952
L100:L97:
*line 946
add #1,R7
L98:
*line 946
cmp #4,R7
blt L99
L96:
*line 953
*line 954
tst -2(R14)
beq L101
*line 954
move #-1,R0
bra L88
*line 955
*line 956
*line 957
*line 958
*line 959
L101:
*line 960
move #11,(sp)
move #32,-(sp)
move.l R13,-(sp)
jsr _memset
addq.l #6,sp
*line 964
move.l R13,R12
*line 965
move.l 12(R14),R11
*line 967
clr R7
bra L104
L105:
*line 968
*line 969
move.b (R11)+,R6
*line 970
*line 971
*line 972
tst.b R6
beq L102
cmp.b #32,R6
beq L102
*line 973
*line 974
move.b R6,(R12)+
L103:
*line 967
add #1,R7
L104:
*line 967
cmp #8,R7
blt L105
L102:
*line 979
lea 8(R13),R12
*line 980
move.l 16(R14),R11
*line 982
clr R7
bra L108
L109:
*line 983
*line 984
move.b (R11)+,R6
*line 985
*line 986
*line 987
tst.b R6
beq L106
cmp.b #32,R6
beq L106
*line 988
*line 989
move.b R6,(R12)+
L107:
*line 982
add #1,R7
L108:
*line 982
cmp #3,R7
blt L109
L106:
*line 997
*line 998
move 20(R14),R0
clr R0
beq L110
*line 998
or #256,32(R13)
*line 999
L110:
*line 1000
*line 1001
btst #0,21(R14)
beq L111
*line 1001
or #512,32(R13)
*line 1002
L111:
*line 1003
*line 1004
btst #1,21(R14)
beq L112
*line 1004
or #768,32(R13)
*line 1005
L112:
*line 1006
*line 1007
btst #2,21(R14)
beq L113
*line 1007
or #32,32(R13)
*line 1008
L113:
*line 1009
*line 1010
btst #3,21(R14)
beq L114
*line 1010
or #1024,32(R13)
*line 1011
L114:
*line 1012
*line 1013
btst #0,20(R14)
beq L115
*line 1013
or #2048,32(R13)
*line 1014
L115:
*line 1015
*line 1016
btst #1,20(R14)
beq L116
*line 1016
or #64,32(R13)
*line 1017
L116:
*line 1018
*line 1019
btst #2,20(R14)
beq L117
*line 1019
or #128,32(R13)
*line 1020
L117:
*line 1021
*line 1022
move 20(R14),R0
and #-32768,R0
beq L118
*line 1022
or #16,32(R13)
*line 1023
L118:
*line 1024
clr R0
bra L88
L88:tst.l (sp)+
movem.l (sp)+,R6-R7/R11-R13
unlk R14
rts
.globl _ClsFile
.text
_ClsFile:
~~ClsFile:
~fcp=R13
link R14,#0
movem.l R7-R7/R12-R13,-(sp)
~dp=R12
*line 1051
move.l 8(R14),R13
*line 1051
*line 1051
btst #4,32(R13)
beq L120
*line 1052
*line 1053
*line 1053
clr R0
move 32(R13),R0
and #3584,R0
beq L121
*line 1054
*line 1055
*line 1055
move.l R13,(sp)
jsr __dsrch
move.l R0,R12
move.l R12,R0
beq L122
*line 1056
*line 1057
*line 1058
*line 1059
*line 1059
move #32,(sp)
move.l R13,-(sp)
move.l R12,-(sp)
jsr _memcmp
addq.l #8,sp
tst R0
beq L123
*line 1060
*line 1061
move #32,(sp)
move.l R13,-(sp)
move.l R12,-(sp)
jsr _memcpy
addq.l #8,sp
*line 1062
move #1,__dirmod
*line 1069
*line 1070
*line 1071
*line 1072
*line 1073
*line 1074
*line 1075
L123:bra L124
L122:
*line 1076
*line 1077
*line 1081
*line 1082
*line 1083
move #5,_errno
*line 1084
move #-1,R0
bra L119
L124:
*line 1085
*line 1086
*line 1087
*line 1091
*line 1092
L121:
*line 1093
clr R0
bra L119
*line 1094
bra L125
L120:
*line 1095
*line 1096
*line 1100
*line 1101
*line 1102
move #22,_errno
*line 1103
move #-1,R0
bra L119
L125:L119:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl __clsvol
.text
__clsvol:
~~_clsvol:
link R14,#-4
*line 1118
*line 1118
tst __fatmod
beq L127
*line 1119
*line 1120
jsr __clsfat
*line 1121
*line 1125
*line 1126
*line 1127
L127:
*line 1128
*line 1128
tst __dirmod
beq L128
*line 1129
*line 1130
jsr __clsdir
*line 1131
*line 1135
*line 1136
*line 1137
L128:
*line 1138
clr __bpbin
*line 1139
clr __fatin
*line 1140
clr __dirin
L126:unlk R14
rts
.globl _fcbinit
.text
_fcbinit:
~~fcbinit:
~name=R13
~fcp=R12
link R14,#-14
movem.l R7-R7/R12-R13,-(sp)
~tmpname=-10
~tmpext=-14
*line 1156
move.l 8(R14),R13
*line 1156
move.l 12(R14),R12
*line 1156
clr (sp)
move.l R14,-(sp)
add.l #-14,(sp)
move.l R13,-(sp)
jsr _FilExt
addq.l #8,sp
move.l R0,-(sp)
move.l R14,-(sp)
add.l #-10,(sp)
move.l R13,-(sp)
jsr _FilName
addq.l #8,sp
move.l R0,-(sp)
move.l R12,-(sp)
jsr __inifcb
adda.l #12,sp
bra L129
L129:tst.l (sp)+
movem.l (sp)+,R12-R13
unlk R14
rts
.globl _DelFile
.text
_DelFile:
~~DelFile:
~fcp=8
link R14,#-4
*line 1178
*line 1179
jsr __opnvol
tst R0
beq L131
*line 1179
move #-1,R0
bra L130
*line 1180
L131:
*line 1181
*line 1181
move.l 8(R14),(sp)
jsr __dsrch
move.l R0,__dptr
bne L132
*line 1182
*line 1183
move #2,_errno
*line 1184
move #-1,R0
bra L130
*line 1185
*line 1186
L132:
*line 1187
*line 1187
move.l __dptr,R8
btst #0,11(R8)
beq L133
*line 1188
*line 1189
move #13,_errno
*line 1190
move #-1,R0
bra L130
*line 1191
*line 1192
L133:
*line 1193
*line 1194
move.l __dptr,(sp)
jsr __ftrnc
tst R0
beq L134
*line 1194
move #-1,R0
bra L130
*line 1195
L134:
*line 1196
move.l __dptr,R8
move.b #229,(R8)
*line 1204
clr R0
bra L130
L130:unlk R14
rts
.data
