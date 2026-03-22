| ------------------------------------------------------------------------------
| fpuint.s -- process FPU interrupts / clear FPU
| Version 63 -- 1988-08-31 -- D.N. Lynx Crowe
| ------------------------------------------------------------------------------
		.text

		.xdef	fpuint		| process an FPU interrupt
		.xdef	fpuclr		| reset the FPU
		.xdef	clrvce		| quiet a voice

		.xdef	fputrap		| a very good debug trap point

		.xdef	fp_resv		| 'spare' function reset value table
		.xdef	fpuifnc		| FPU interrupt code  (voice / function)

		.xref	irand		| ranged random number function
		.xref	scope		| diagnostic scope function
		.xref	xgetran		| random number function

		.xref	expbit
		.xref	funcndx
		.xref	initcfg
		.xref	ndisp
		.xref	pflist
		.xref	pfqhdr
		.xref	prstab
		.xref	ptoftab
		.xref	scopef
		.xref	timemlt
		.xref	trgtab
		.xref	valents
		.xref	vce2grp
		.xref	vce2trg
		.xref	veltab

		.page
| ------------------------------------------------------------------------------
| Register usage
| --------------
|	d0	scratch
|	d1	FPU function index
|	d2	point index from FH_CPT  (idfcpt)
|	d3	scratch
|	d4	jump point number from PT_PAR1  (ippar1)
|	d5	scratch

|	a0	scratch
|	a1	function header base
|	a2	point table base
|	a3	FPU base

| ------------------------------------------------------------------------------
| FPU definitions
| ---------------

UPD_BIT		=	0x0001			| update bit  (1 = update)
INT_BIT		=	0x0002			| int. bit    (0 = disable)
RAT_BIT		=	0x0004			| ratio bit   (0 = ratio)

VSUBNBIT	=	3			| new value select bit number
VAL_BITS	=	0x0018			| new value select bit mask

MSK_RNVB	=	0x000C			| new value / ratio bits
MSK_ONVB	=	0x0010			| old new value bit

FKILL		=	0x0014			| kill value for function
FSEND		=	0x0015			| send new value to function

CLREXP		=	0x8000			| clear value for time exponent
CLRMNT		=	0x8000			| clear value for time mantissa

| ------------------------------------------------------------------------------
| Miscellaneous definitions
| -------------------------

PCHMAX		=	21920			| maximum pitch value
VALMAX		=	32000			| maximum value to send to FPU
VALMIN		=	-32000			| minimum value to send to FPU

LSPCH		=	2			| left shift for sources to freq

VALLEN		=	10			| length of the 'valent' struct
VT_VAL		=	8			| value offset in 'valent'

		.page
| ------------------------------------------------------------------------------
| FPU addresses
| -------------

FPUBASE		=	0x180000		| FPU base address

FPUWST		=	FPUBASE			| FPU waveshape base
FPUFUNC		=	FPUBASE+0x4000		| FPU function base
FPUINT1		=	FPUBASE+0x4000		| FPU int. input address (R/O)
FPUINT2		=	FPUBASE+0x6000		| FPU int. reset address (W/O)
FPUCFG		=	FPUBASE+0x5FE0		| FPU config. data address (W/O)

F_CTL		=	0x00			| control word
F_VAL10		=	0x02			| new value "10"
F_CV1		=	0x08			| control voltage 1
F_SF1		=	0x0A			| scale factor 1
F_CV2		=	0x0C			| control voltage 2
F_SF2		=	0x0E			| scale factor 2
F_CV3		=	0x10			| control voltage 3
F_SF3		=	0x12			| scale factor 3
F_MNT		=	0x14			| time mantissa
F_EXP		=	0x16			| time exponent
F_VAL01		=	0x1C			| new value "01"

P_FREQ1		=	0x0020			| frequency 1
P_FREQ2		=	0x0060			| frequency 2
P_FREQ3		=	0x00A0			| frequency 3
P_FREQ4		=	0x00E0			| frequency 4
P_FILTER	=	0x0140			| filter
P_FILTRQ	=	0x00C0			| filter q

P_INDEX1	=	0x0120			| index 1
P_INDEX2	=	0x0160			| index 2
P_INDEX3	=	0x0180			| index 3
P_INDEX4	=	0x01A0			| index 4
P_INDEX5	=	0x01C0			| index 5
P_INDEX6	=	0x01E0			| index 6

P_LEVEL		=	0x0040			| level

P_LOCN		=	0x0080			| location
P_DYNAM		=	0x0100			| dynamics

		.page
| ------------------------------------------------------------------------------
| Structure definitions
| ------------------------------------------------------------------------------
| The following MUST match the idfnhdr structure definition in instdsp.h:

FH_LEN		=	12		| length of the idfnhdr structure

FH_PCH		=	0		| WORD - pitch offset  (freq1 only)
FH_MLT		=	2		| WORD - overall value multiplier
FH_SRC		=	4		| BYTE - overall value source
FH_PIF		=	5		| BYTE - # of points in the function
FH_PT1		=	6		| BYTE - index of first point
FH_TMD		=	7		| BYTE - trigger mode / control bits
FH_CPT		=	8		| BYTE - current point
FH_PRM		=	9		| BYTE - misc. function parameter
FH_TRG		=	10		| WORD - trigger

I_ACTIVE	=	1		| 'Active' bit number        (in FH_TMD)

MSK_CTL		=	0x001C		| mask for FPU hardware bits (in FH_TMD)

| ------------------------------------------------------------------------------
| The following MUST match the instpnt structure definition in instdsp.h:

PT_LEN		=	12		| length of the instpnt structure

PT_TIM		=	0		| WORD - time (packed)
PT_VAL		=	2		| WORD - value
PT_VMLT		=	4		| WORD - value multiplier
PT_VSRC		=	6		| BYTE - value source
PT_ACT		=	7		| BYTE - action
PT_PAR1		=	8		| BYTE - parameter 1
PT_PAR2		=	9		| BYTE - parameter 2
PT_PAR3		=	10		| BYTE - parameter 3
PT_PAD		=	11		| BYTE - padding for even boundary

MSK_MNT		=	0xFFF0		| mask for mantissa  (in PT_TIM)
MSK_EXP		=	0x000F		| mask for exponent  (in PT_TIM)

MAX_ACT		=	7		| maximum action code value

		.page

| ------------------------------------------------------------------------------
| pflist definitions -- must match those in instdsp.h

PF_NEXT		=	0
PF_TRIG		=	4
PF_FUNC		=	6
PF_D1		=	8
PF_D2		=	12
PF_D4		=	16
PF_A1		=	20
PF_A2		=	24
PF_A3		=	28
| ------------------------------------------------------------------------------
| Source definitions -- must match those in 'smdefs.h'

SM_RAND		=	1		| random
SM_PTCH		=	5		| pitch
SM_KPRS		=	6		| key pressure
SM_KVEL		=	7		| key velocity
SM_FREQ		=	10		| frequency

		.page
| ------------------------------------------------------------------------------
| fpuint() -- process FPU interrupts

|	void
|	fpuint();

|		Processes FPU interrupts.  Must be the target of vector 26,
|		which is Autovector Interrupt level 2.

| ------------------------------------------------------------------------------

fpuint:		movem.l	d0-d5/a0-a3,-(a7)	| preserve registers we use
		move.w	FPUINT1,d0	| read FPU interrupt status
		andi.w	#0x00FF,d0	| mask out garbage in MS bits
		move.w	d0,fpuifnc	| save for later use
		move.w	ndisp,d1	| get display number
		cmpi.w	#11,d1		| see if we display
		bne	nodisp		| jump if not

		tst.w	scopef		| ...
		beq	nodisp		| ...

		move.w	d0,-(a7)	| display value
		jsr	scope		| ...
		tst.w	(a7)+		| ...

		move.w	fpuifnc,d0	| get FPU status

nodisp:		move.w	d0,d1		| save in d1  (becomes function offset)

		lsl.w	#5,d1		| develop FPU function offset
		lea	FPUFUNC,a3	| setup FPU function base address

		lsl.w	#3,d0		| develop funcndx[] index
		lea	funcndx,a0	| setup funcndx[] base address

		tst.l	0(a0,d0.W)	| see if function is defined
		bne	fnok		| jump if so

		move.w	d1,d0		| get function offset in d0
		andi.w	#0x1E00,d0	| mask for voice number
		cmpi.w	#0x1800,d0	| see if it's a real voice  (0..11)
		bge	fpexit		| don't send a kill if not a real voice

		move.w	#FKILL,F_CTL(a3,d1.W)	| kill the undefined function

fpexit:		clr.w	FPUINT2		| reset the FPU interrupt latch
		movem.l	(a7)+,d0-d5/a0-a3	| restore the registers
		rte			| return to interrupted code

		.page
| ------------------------------------------------------------------------------
| set up to process active functions,  stop ones that should be inactive
| ------------------------------------------------------------------------------
fnok:		movea.l	0(a0,d0.W),a1	| get pointer to function header
		movea.l	4(a0,d0.W),a2	| get pointer to point table
		btst	#I_ACTIVE,FH_TMD(a1)	| see if function is active
		bne	doact		| go process action if so

| ------------------------------------------------------------------------------
| stop a function
| ------------------------------------------------------------------------------
stopfn:		move.b	FH_TMD(a1),d0	| get function control bits
		andi.w	#MSK_RNVB,d0	| mask for ratio / new new-value bit
		move.w	d0,d3		| isolate new new-value bit
		add.w	d3,d3		| ... from function header
		andi.w	#MSK_ONVB,d3	| ... shift to old new-value bit
		or.w	d3,d0		| ... and put new bit in old bit
		move.w	d0,F_CTL(a3,d1.W)	| stop the function
		bclr	#I_ACTIVE,FH_TMD(a1)	| reset the active bit
		bra	fpexit		| go restore registers and exit

		.page
| ------------------------------------------------------------------------------
| setup for and dispatch to the proper action handler
| ------------------------------------------------------------------------------
doact:		clr.w	d2		| get current point index in d2
		move.b	FH_CPT(a1),d2	| ...
		lsl.w	#2,d2		| multiply it by the length of a point
		move.w	d2,d0		| ...  (fast multiply by PT_LEN = 12
		add.w	d2,d2		| ...   via shift and add)
		add.w	d0,d2		| ...
		clr.w	d4		| get jump point # into d4
		move.b	PT_PAR1(a2,d2.W),d4	| ...
		clr.w	d3		| get action code in d3
		move.b	PT_ACT(a2,d2.W),d3	| ...
		cmpi.b	#MAX_ACT,d3	| check against the limit
		bgt	stopfn		| stop things if it's a bad action code

		lsl.w	#2,d3		| develop index to action dispatch table
		lea	actab,a0	| get the address of the action handler
		movea.l	0(a0,d3.W),a0	| ...

| ------------------------------------------------------------------------------
| At this point we're ready to do the action associated with the point,
| and the registers are set up,  and will remain,  as follows:

|	d1	FPU function index	a1	function header base
|	d2	point table index	a2	point table base
|					a3	FPU function base
|	d4	jump point number

|	d0, d3, d5, and a0 are used as scratch throughout the code.

| ------------------------------------------------------------------------------

fputrap:	jmp	(a0)		| dispatch to action handler

		.page
| ------------------------------------------------------------------------------
| act0 -- AC_NULL -- no action
| ----    --------------------
act0:		move.b	FH_PT1(a1),d0	| get first point number
		add.b	FH_PIF(a1),d0	| add number of points in function
		subq.b	#1,d0		| make it last point number
		cmp.b	FH_CPT(a1),d0	| see if we're at the last point
		beq	stopfn		| stop function if so

		addq.b	#1,FH_CPT(a1)	| update function header for next point
		addi.w	#PT_LEN,d2	| advance the point index

| ------------------------------------------------------------------------------
| outseg -- output a segment
| ------    ----------------
outseg:		move.w	PT_TIM(a2,d2.w),d3	| get packed time
		move.w	d3,d0			| extract mantissa
		andi.w	#MSK_MNT,d0		| ...
		mulu	timemlt,d0		| multiply by panel time pot value
		lsr.l	#8,d0			| ... and scale it
		lsr.l	#7,d0			| ...
		move.w	d0,F_MNT(a3,d1.W)	| send mantissa to FPU
		andi.w	#MSK_EXP,d3		| extract exponent code
		add.w	d3,d3			| look up decoded exponent
		lea	expbit,a0		| ... in expbit
		move.w	0(a0,d3.W),F_EXP(a3,d1.W)	| send exponent to FPU
		move.w	PT_VAL(a2,d2.W),d3	| get the function value

| ------------------------------------------------------------------------------
| get the point source, if any
| ------------------------------------------------------------------------------
		tst.w	PT_VMLT(a2,d2.W)	| see if we have a point mlt.
		beq	nosrc			| don't do anything for zero

		clr.w	d0			| get the source number
		move.b	PT_VSRC(a2,d2.W),d0	| ...
		beq	nosrc			| don't do anything for zero

| ------------------------------------------------------------------------------
| SM_RAND -- random
| ------------------------------------------------------------------------------
		cmpi.w	#SM_RAND,d0		| is this the random source ?
		bne	srctyp0			| jump if not

		movem.l	d1-d2/a0-a2,-(a7)	| preserve registers around call
		move.w	PT_VMLT(a2,d2.W),-(a7)	| pass multiplier to xgetran()
		jsr	xgetran			| call for a random number
		tst.w	(a7)+			| clean up stack
		movem.l	(a7)+,d1-d2/a0-a2	| restore registers
		move.w	d0,d5			| put random value in the value register
		bra	applym			| go apply the multiplier

		.page
| ------------------------------------------------------------------------------
| SM_FREQ -- frequency
| ------------------------------------------------------------------------------
srctyp0:	cmpi.w	#SM_FREQ,d0	| is this the frequency source ?
		bne	srctyp1		| jump if not

		move.w	(a1),d0		| get the pitch
		lsr.w	#6,d0		| shift to a word index
		andi.w	#0x01FE,d0	| mask out extraneous bits
		lea	ptoftab,a0	| get entry from ptoftab[]
		move.w	0(a0,d0.W),d5	| ...
		bra	applym		| go apply the multiplier

| ------------------------------------------------------------------------------
| SM_PTCH -- pitch
| ------------------------------------------------------------------------------
srctyp1:	cmpi.w	#SM_PTCH,d0	| is this the pitch source ?
		bne	srctyp2		| jump if not

		move.w	(a1),d5		| get the pitch as the value
		bra	applym		| go apply the multiplier

| ------------------------------------------------------------------------------
| SM_KVEL -- velocity
| ------------------------------------------------------------------------------
srctyp2:	cmpi.w	#SM_KVEL,d0	| is this the key velocity source ?
		bne	srctyp3		| jump if not

		move.w	FH_TRG(a1),d0	| get the trigger number
		add.w	d0,d0		| ... as a word index
		lea	veltab,a0	| ... into veltab[]
		move.w	0(a0,d0.W),d5	| get the velocity from veltab[trg]
		bra	applym		| go apply the multiplier

| ------------------------------------------------------------------------------
| SM_KPRS -- pressure
| ------------------------------------------------------------------------------
srctyp3:	cmpi.w	#SM_KPRS,d0	| is this the key pressure source ?
		bne	srctyp4		| jump if not  (must be an analog input)

		move.w	FH_TRG(a1),d0	| get the trigger number
		add.w	d0,d0		| ... as a word index
		lea	prstab,a0	| ... into prstab[]
		move.w	0(a0,d0.W),d5	| get the pressure from prstab[trg]
		bra	applym		| go apply the multiplier

		.page
| ------------------------------------------------------------------------------
| all other sources come out of the valents[] array
| ------------------------------------------------------------------------------
srctyp4:	lea	vce2grp,a0	| point at vce2grp[]
		move.w	fpuifnc,d5	| get voice number in d5
		lsr.w	#3,d5		| ...
		andi.w	#0x001E,d5	| ... as a word index
		move.w	0(a0,d5.W),d5	| get the group number
		subq.w	#1,d5		| ...
		lsl.w	#4,d5		| shift it left a nybble
		or.w	d5,d0		| OR it into the source number
		add.w	d0,d0		| make source number a valents[] index
		move.w	d0,d5		| ... (fast multiply by VALLEN = 10
		lsl.w	#2,d0		| ...  via shift and add)
		add.w	d5,d0		| ...
		lea	valents,a0	| get base of valents[]
		move.w	VT_VAL(a0,d0.W),d5	| get value

| ------------------------------------------------------------------------------
| apply the multiplier to the source, and add it to the function value
| ------------------------------------------------------------------------------
applym:		muls	PT_VMLT(a2,d2.W),d5	| apply the multiplier
		asr.l	#7,d5		| scale the result
		asr.l	#8,d5		| ...
		ext.l	d3		| add the function value
		add.l	d3,d5		| ...
		cmpi.l	#VALMAX,d5	| check for overflow
		ble	srcmlt1		| jump if no overflow

		move.l	#VALMAX,d5	| limit at VALMAX
		bra	srcmlt2		| ...

srcmlt1:	cmpi.l	#VALMIN,d5	| check for underflow
		bge	srcmlt2		| jump if no underflow

		move.l	#VALMIN,d5	| limit at VALMIN

srcmlt2:	move.w	d5,d3		| setup value for output to FPU

		.page
| ------------------------------------------------------------------------------
| adjust the value according to the function type
| ------------------------------------------------------------------------------
nosrc:		move.w	d1,d0		| get function type
		andi.w	#0x01E0,d0	| ...

| ------------------------------------------------------------------------------
| level or location
| ------------------------------------------------------------------------------
		cmpi.w	#P_LEVEL,d0	| see if it's the level
		beq	outsegl		| jump if so

		cmpi.w	#P_LOCN,d0	| see if it's the location
		bne	outsegf		| jump if not

		tst.w	d3		| check sign of value
		bpl	outsegc		| jump if positive

		clr.w	d3		| force negative values to 0

outsegc:	asr.w	#5,d3		| shift value to LS bits
		sub.w	#500,d3		| subtract 5.00 from value
		asl.w	#6,d3		| readjust to MS bits
		bra	outseg3		| go output the value

outsegl:	tst.w	d3		| check sign of value
		bpl	outsegm		| jump if positive

		clr.w	d3		| limit negative values at 0

outsegm:	asr.w	#5,d3		| shift value to LS bits
		sub.w	#500,d3		| subtract 5.00 from value
		asl.w	#6,d3		| readjust to MS bits
		bra	outseg3		| go output the value

		.page
| ------------------------------------------------------------------------------
| filter
| ------------------------------------------------------------------------------
outsegf:	cmpi.w	#P_FILTER,d0	| see if it's filter
		bne	outsegp		| jump if not

		ext.l	d3		| make function value a long
		asr.l	#1,d3		| multiply function value by .75
		move.l	d3,d0		| ...  (fast multiply by .75
		asr.l	#1,d0		| ...   via shift and add)
		add.l	d0,d3		| ...
		move.w	(a1),d0		| add pitch
		ext.l	d0		| ...
		add.l	d0,d3		| ...
		cmpi.l	#VALMAX,d3	| see if it's within limits
		ble	outsega		| ...

		move.w	#VALMAX,d3	| limit at VALMAX
		bra	outseg3		| ...

outsega:	cmpi.l	#VALMIN,d3	| ...
		bge	outseg3		| ...

		move.w	#VALMIN,d3	| limit at VALMIN
		bra	outseg3		| ...

		.page
| ------------------------------------------------------------------------------
| freq 1..4
| ------------------------------------------------------------------------------
outsegp:	cmpi.w	#P_FREQ1,d0	| see if it's freq1
		beq	outseg0		| go process freq1

outsegq:	cmpi.w	#P_FREQ2,d0	| see if it's freq2
		beq	outseg0		| process it if so

		cmpi.w	#P_FREQ3,d0	| see if it's freq3
		beq	outseg0		| process it if so

		cmpi.w	#P_FREQ4,d0	| see if it's freq4
		bne	outseg3		| jump if not

outseg0:	ext.l	d3		| scale the point value to cents offset
		asr.l	#5,d3		| ...
		sub.l	#500,d3		| ... value - 500
		asl.l	#LSPCH,d3	| mult. by 2 and scale for 1/2 cent lsb
		move.w	(a1),d0		| add pitch from function header
		ext.l	d0		| ...
		add.l	d0,d3		| ...
		cmp.l	#PCHMAX,d3	| see if result is valid
		ble	outseg3		| jump if within pitch limits

		move.l	#PCHMAX,d3	| limit at maximum pitch

| ------------------------------------------------------------------------------
| send the value to the FPU
| ------------------------------------------------------------------------------
outseg3:	move.b	FH_TMD(a1),d0	| get hardware bits from function header
		eor.w	#VAL_BITS,d0	| toggle new value select bits
		move.b	d0,FH_TMD(a1)	| store updated word
		btst.l	#VSUBNBIT,d0	| check which value address to use
		beq	outseg1

		move.w	d3,F_VAL01(a3,d1.W)	| send value to FPU
		bra	outseg2

outseg1:	move.w	d3,F_VAL10(a3,d1.W)	| send value to FPU

outseg2:	andi.w	#MSK_CTL,d0		| mask off software bits
		ori.w	#UPD_BIT+INT_BIT,d0	| set the update & !lastseg bits
		move.w	d0,F_CTL(a3,d1.W)	| send control word to FPU
		bra	fpexit			| done -- exit

		.page

| ------------------------------------------------------------------------------
| act1 -- AC_SUST -- pause if key is down  (sustain)
| ----    ------------------------------------------
act1:		move.w	fpuifnc,d0	| get voice as a word index
		lsr.w	#3,d0		| ...
		andi.w	#0x001E,d0	| ...
		lea	vce2trg,a0	| point at voice to trigger table
		move.w	0(a0,d0.W),d0	| get trigger table entry into d0
		cmpi.w	#-1,d0		| see if voice is free
		beq	act0		| continue function if so

		btst	#15,d0		| see if voice is held by a pedal
		bne	act1a		| sustain if so

		btst	#14,d0		| see if voice is sustained by a pedal
		bne	act1a		| sustain if so

		lea	trgtab,a0	| point at trigger table
		tst.b	0(a0,d0.W)	| check trigger status
		beq	act0		| continue function if not active

act1a:		move.l	pfqhdr,d3	| see if any pflist entries remain
		beq	act0		| continue if not  (shouldn't happen!)

		move.b	FH_PT1(a1),d0	| get first point number
		add.b	FH_PIF(a1),d0	| add base to first point
		subq.b	#1,d0		| make d0 last point number
		cmp.b	FH_CPT(a1),d0	| check current point number
		beq	stopfn		| done if this is the last point

		addq.b	#1,FH_CPT(a1)		| update current point number
		addi.w	#PT_LEN,d2		| advance the point index
		movea.l	d3,a0			| acquire a new pflist entry
		move.l	(a0),pfqhdr		| ...
		move.l	pflist,(a0)		| chain it to pflist
		move.l	a0,pflist		| ...
		move.w	FH_TRG(a1),PF_TRIG(a0)		| set trigger number in entry
		move.w	fpuifnc,PF_FUNC(a0)		| set v/p word in entry
		movem.l	d1-d2/d4/a1-a3,PF_D1(a0)	| set registers in entry
		move.b	FH_TMD(a1),d0		| stop the function
		andi.w	#MSK_RNVB,d0		| ...
		move.w	d0,d3			| ...
		add.w	d3,d3			| ...
		andi.w	#MSK_ONVB,d3		| ...
		or.w	d3,d0			| ...
		move.w	d0,F_CTL(a3,d1.W)	| ...
		bra	fpexit			| exit

		.page

| ------------------------------------------------------------------------------
| act2 -- AC_ENBL -- stop if key is up
| ----    ----------------------------
act2:		move.w	fpuifnc,d0	| get voice as a word index
		lsr.w	#3,d0		| ...
		andi.w	#0x001E,d0	| ...
		lea	vce2trg,a0	| check to see if voice is free
		move.w	0(a0,d0.W),d0	| ...
		cmpi.w	#-1,d0		| ...
		beq	stopfn		| if so, stop the function

		btst	#15,d0		| see if voice is held
		bne	act0		| continue if so

		btst	#14,d0		| ...
		bne	act0		| ...

		lea	trgtab,a0	| check trigger table entry
		tst.b	0(a0,d0.W)	| ...
		bne	act0		| if trigger is active, continue

		bra	stopfn		| if not, stop the function

| ------------------------------------------------------------------------------
| act3 -- AC_JUMP -- unconditional jump
| ----    -----------------------------
act3:		cmp.b	FH_PIF(a1),d4	| check jump point against limit
		bcc	stopfn		| stop function if jump point invalid

		clr.w	d2		| get index of first point
		move.b	FH_PT1(a1),d2	| ...
		add.b	d4,d2		| add jump point
		move.b	d2,FH_CPT(a1)	| make it the current point
		lsl.w	#2,d2		| develop new point index in d2
		move.w	d2,d0		| ... (fast multiply by PT_LEN = 12
		add.w	d2,d2		| ...  via shift and add)
		add.w	d0,d2		| ...
		bra	outseg		| output the segment

		.page

| ------------------------------------------------------------------------------
| act4 -- AC_LOOP -- jump to point PT_PAR1 PT_PAR2 times
| ----    ----------------------------------------------
act4:		tst.b	PT_PAR3(a2,d2.W)	| check counter
		bne	act4a			| jump if it's running

		move.b	PT_PAR2(a2,d2.W),d0	| get parameter
		subi.w	#90,d0			| put parameter in random range
		bmi	act4b			| treat as normal if < 90

		movem.l	d1-d2/a0-a2,-(a7)	| get ranged random number
		move.w	d0,-(a7)		| ...
		jsr	irand			| ...
		tst.w	(a7)+			| ...
		movem.l	(a7)+,d1-d2/a0-a2	| ...
		move.b	d0,PT_PAR3(a2,d2.w)	| set counter
		beq	act0			| next segment if cntr set to 0

		bra	act3			| else jump to the point

act4b:		move.b	PT_PAR2(a2,d2.W),PT_PAR3(a2,d2.W)	| set counter
		beq	act0			| next segment if cntr set to 0

		bra	act3			| else jump to the point

act4a:		subq.b	#1,PT_PAR3(a2,d2.W)	| decrement counter
		beq	act0			| next segment if cntr ran out

		bra	act3			| jump if it's still non-zero

| ------------------------------------------------------------------------------
| act5 -- AC_KYUP -- jump if key is up
| ----    ----------------------------
act5:		move.w	fpuifnc,d0	| get voice as a word index
		lsr.w	#3,d0		| ...
		andi.w	#0x001E,d0	| ...
		lea	vce2trg,a0	| check to see if voice is free
		move.w	0(a0,d0.W),d0	| ...
		cmpi.w	#-1,d0		| ...
		beq	act3		| if so (inactive), do the jump

		btst	#15,d0		| see if voice is held
		bne	act0		| continue if so

		btst	#14,d0		| ...
		bne	act0		| ...

		lea	trgtab,a0	| check trigger table entry
		tst.b	0(a0,d0.W)	| see if the trigger is active
		beq	act3		| if not, do the jump

		bra	act0		| if so, do next segment

		.page

| ------------------------------------------------------------------------------
| act6 -- AC_KYDN -- jump if key is down
| ----    ------------------------------
act6:		move.w	fpuifnc,d0	| get voice as a word index
		lsr.w	#3,d0		| ...
		andi.w	#0x001E,d0	| ...
		lea	vce2trg,a0	| check to see if voice is free
		move.w	0(a0,d0.W),d0	| ...
		cmpi.w	#-1,d0		| ...
		beq	act0		| if so (inactive), continue

		btst	#15,d0		| see if voice is held
		bne	act3		| do jump if so

		btst	#14,d0		| ...
		bne	act3		| ...

		lea	trgtab,a0	| check trigger table entry
		tst.b	0(a0,d0.W)	| see if the trigger is active
		bne	act3		| if so, do the jump

		bra	act0		| if not, do next segment

| ------------------------------------------------------------------------------
| Test stub
| ---------
act7:		bra	act0		| AC_HERE: treat act7 as AC_NULL

		.page
| ------------------------------------------------------------------------------

| fpuclr -- clear the FPU
| ------    -------------

|	void
|	fpuclr()

|		Resets the FPU functions to their nominal values.

| ------------------------------------------------------------------------------

fpuclr:		link	a6,#0			| link stack frames
		move.w	sr,-(a7)		| save the interrupt level
		ori.w	#0x0700,sr		| turn off interrupts

		lea	FPUFUNC,a0		| point at the first function
		lea	fp_resv,a2		| point at reset value table
		move.w	#11,d1			| set the outer loop count

		.page
| ------------------------------------------------------------------------------
| reset the 'spare' function for the voice
| ------------------------------------------------------------------------------
clr0:		move.w	#CLREXP,F_EXP(a0)	| set time exponent
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#CLRMNT,F_MNT(a0)	| set time mantissa
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	#0,F_SF3(a0)		| set scale factor 3
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV3(a0)		| set voltage 3
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	#0,F_SF2(a0)		| set scale factor 2
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV2(a0)		| set voltage 2
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	#0,F_SF1(a0)		| set scale factor 1
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV1(a0)		| set voltage 1
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	(a2),F_VAL10(a0)	| set value from variable table
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	(a2)+,F_VAL01(a0)	| ...
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#FSEND,F_CTL(a0)	| set control word
		tst.l	actab			| delay
		tst.l	actab			| ...

		.page
		adda.w	#0x0020,a0		| point at 2nd function
		lea	fprescon,a1		| set reset constant pointer
		move.w	#14,d0			| set inner loop count

| ------------------------------------------------------------------------------
| reset the other functions for the voice
| ------------------------------------------------------------------------------
clr1:		move.w	#CLREXP,F_EXP(a0)	| set time exponent
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#CLRMNT,F_MNT(a0)	| set time mantissa
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	#0,F_SF3(a0)		| set scale factor 3
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV3(a0)		| set voltage 3
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	#0,F_SF2(a0)		| set scale factor 2
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV2(a0)		| set voltage 2
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	#0,F_SF1(a0)		| set scale factor 1
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV1(a0)		| set voltage 1
		tst.l	actab			| delay
		tst.l	actab			| ...

		move.w	(a1),F_VAL10(a0)	| set value from constant table
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	(a1)+,F_VAL01(a0)	| ...
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#FSEND,F_CTL(a0)	| set control word
		tst.l	actab			| delay
		tst.l	actab			| ...

		.page
| ------------------------------------------------------------------------------
| loop through reset for all of the voices and functions
| ------------------------------------------------------------------------------
		adda.w	#0x0020,a0		| point at next function
		dbra	d0,clr1			| loop until all funcs. cleared

		dbra	d1,clr0			| loop until all voices cleared
| ------------------------------------------------------------------------------
| clear the FPU interrupt, and return
| ------------------------------------------------------------------------------
		move.w	#0,FPUINT2		| clear FPU interrupt
		move.w	(a7)+,sr		| restore interrupts
		unlk	a6			| unlink stack frames
		rts				| return to caller

		.page

| clrvce -- quiet a voice
| ------    -------------

|	void
|	clrvce(vce)
|	short vce;

|		Quiet the voice by resetting the FPU functions it uses.

clrvce:		link	a6,#0			| link stack frames
		move.w	sr,-(a7)		| save the interrupt level
		ori.w	#0x0700,sr		| turn off interrupts

		lea	FPUFUNC+0x20,a0		| point at the 2nd function
		move.w	8(a6),d0		| get voice number
		ext.l	d0			| ...
		lsl.l	#8,d0			| shift into position
		add.l	d0,d0			| ...
		adda.l	d0,a0			| add to function base
		lea	fprescon,a1		| set reset constant pointer
		move.w	#14,d0			| set inner loop count

vclr1:		move.l	a0,d1			| see if we reset this function
		and.w	#0x01F0,d1		| ...

		cmpi.w	#0x0100,d1		| dynamics ?
		beq	vclr2			| skip it if so

		move.w	#CLREXP,F_EXP(a0)	| set time exponent
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#CLRMNT,F_MNT(a0)	| set time mantissa
		tst.l	actab			| delay
		tst.l	actab			| ...

		cmpi.w	#0x0020,d1		| freq 1 ?
		beq	vclr3			| don't reset CV3 (fine tune)

		move.w	#0,F_SF3(a0)		| set scale factor 3
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV3(a0)		| set voltage 3
		tst.l	actab			| delay
		tst.l	actab			| ...

vclr3:		move.w	#0,F_SF1(a0)		| set scale factor 1
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#0,F_CV1(a0)		| set voltage 1
		tst.l	actab			| delay
		tst.l	actab			| ...

		.page

		move.w	(a1),F_VAL10(a0)	| set value from constant table
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	(a1),F_VAL01(a0)	| ...
		tst.l	actab			| delay
		tst.l	actab			| ...
		move.w	#FSEND,F_CTL(a0)	| set control word
		tst.l	actab			| delay
		tst.l	actab			| ...

vclr2:		adda.w	#2,a1			| point at next function
		adda.w	#0x0020,a0		|
		dbra	d0,vclr1		| loop until all funcs. cleared

		move.w	(a7)+,sr		| restore interrupts
		unlk	a6			| unlink stack frames
		rts				| return to caller

		.page
| ------------------------------------------------------------------------------
		.data
| ------------------------------------------------------------------------------

| actab -- action code dispatch table
| -----    --------------------------
actab:		.dc.l	act0	| 0 - AC_NULL:  no action
		.dc.l	act1	| 1 - AC_SUST:  sustain
		.dc.l	act2	| 2 - AC_ENBL:  enable
		.dc.l	act3	| 3 - AC_JUMP:  unconditional jump
		.dc.l	act4	| 4 - AC_LOOP:  jump n times      (loop)
		.dc.l	act5	| 5 - AC_KYUP:  jump if key up    (enable jump)
		.dc.l	act6	| 6 - AC_KYDN:  jump if key down  (sustain jump)
		.dc.l	act7	| 7 - AC_HERE:  here on key up

| fprescon -- FPU reset constant table
| --------    ------------------------
fprescon:	.dc.w	0x0000	| frq 1		  0.00
		.dc.w	0x8300	| level		-10.00
		.dc.w	0x0000	| frq 2		  0.00
		.dc.w	0x0000	| locn		  0.00
		.dc.w	0x0000	| frq 3		  0.00
		.dc.w	0x0000	| reson		  0.00
		.dc.w	0x0000	| frq 4		  0.00
		.dc.w	0x7D00	| dyn		+10.00
		.dc.w	0x0000	| ind 1		  0.00
		.dc.w	0x3E80	| filt		 +5.00
		.dc.w	0x0000	| ind 2		  0.00
		.dc.w	0x0000	| ind 3		  0.00
		.dc.w	0x0000	| ind 4		  0.00
		.dc.w	0x0000	| ind 5		  0.00
		.dc.w	0x0000	| ind 6		  0.00

| ------------------------------------------------------------------------------
		.bss
| ------------------------------------------------------------------------------

fp_resv:	.ds.w	12		| fpu spare function reset values
fpuifnc:	.ds.w	1		| interrupting function number from FPU

		.end
