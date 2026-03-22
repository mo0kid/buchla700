| ------------------------------------------------------------------------------
| ptcl12.s -- store a cluster entry into the FAT
| Version 2 -- 1987-10-27 -- D.N. Lynx Crowe
| ------------------------------------------------------------------------------
		.text
		.xdef	_ptcl12

CL		=	12
VAL		=	14
CLA		=	d7
CLP		=	d6
CLT		=	d5
FAT		=	a5

_ptcl12:	link	A6,#0
		movem.l	CLT-CLA/FAT-FAT,-(sp)
		move.l	8(A6),FAT
		move.w	CL(A6),CLA
		lsr.w	#1,CLA
		add.w	CL(A6),CLA
		move.b	1(FAT,CLA.W),CLP
		lsl.w	#8,CLP
		move.b	0(FAT,CLA.W),CLP
		btst	#0,CL+1(A6)
		beq	L2

		move.w	CLP,CLT
		and.w	#0x000F,CLT
		move.w	VAL(A6),D0
		lsl.w	#4,D0
		or.w	D0,CLT
		bra	L3

L2:		move.w	CLP,CLT
		and.w	#0xF000,CLT
		move.w	VAL(A6),D0
		and.w	#0x0FFF,D0
		or.w	D0,CLT

L3:		move.b	CLT,0(FAT,CLA.W)
		move.w	CLT,D0
		lsr.w	#8,D0
		move.b	D0,1(FAT,CLA.W)

L1:		movem.l	(sp)+,CLT-CLA/FAT-FAT
		unlk	A6
		rts

		.end
