| ------------------------------------------------------------------------------
| fsmain.s -- startup code for the Buchla 700 standalone C runtime library
| Version 3 -- 1987-06-29 -- D.N. Lynx Crowe

|	This code clears 'bss' space, sets up some global variables,
|	and calls Croot(), which sets up the file system and calls main().

|	This routine should be entered with the address of the basepage
|	as its parameter.
| ------------------------------------------------------------------------------
		.text

		.xdef	start_

		.xref	Croot

		.xdef	panic
		.xdef	brk

		.xdef	_heap
		.xdef	_break
		.xdef	_pmesg

		.xdef	errno

p_bbase		=	0x18		| bss base
p_blen		=	0x1C		| bss length

		.page

| start_ -- Initial entry point -- Must be first object file in link statement
| ------    ------------------------------------------------------------------

| WARNING:  Hazardous assumptions

| We assume that:

| 	the system has set the stack pointer for us.
| 	the system passed us a pointer to a valid basepage.
| 	the stack is above the heap.
|	BSS is located in RAM.

| If any of these assumptions is in error, we're in for serious trouble.

start_:		movea.l	#0,a6		| Clear frame pointer
		movea.l	4(a7),a1	| Set pointer to base page
		movea.l	p_bbase(a1),a0	| Setup to clear bss space

start1:		clr.w	(a0)+		| Clear a word
		cmpa.l	a0,a7		| See if we're done
		bne	start1		| Loop if not done yet

		move.l	p_bbase(a1),d0	| Calculate break address
		add.l	p_blen(a1),d0	| ...
		move.l	d0,_break	| Set initial break
		move.l	d0,_heap	| Set heap start

		move.l	#0,-(a7)	| Pass NULL to Croot  (no command line)
		jsr	Croot		| call Croot() routine
		addq.l	#4,a7		| ...

		move.l	#pmsg1,-(a7)	| panic(pmsg1);
		jsr	panic		| ...
		addq.l	#4,a7		| ...

hstop:		stop	#0x2000		| "Die, sucker!"
		bra	hstop

		.page

| panic -- hard halt for fatal errors
| -----    --------------------------
panic:		movea.l	4(a7),a0	| Save panic message address
		move.l	a0,_pmesg	| ...

		trap	#15		| Invoke ROMP  (we hope ...)

pstop:		stop	#0x2700		| HARD HALT
		bra	pstop

		.page

| brk -- set break value
| ---    ---------------
| WARNING:  This only works if the stack is above the heap.

brk:		cmpa.l	_break,a7	| compare current break with stack
		bcs	pstop		| actual stack overflow!

		movea.l	4(sp),a0	| get new break
		move.l	a0,d0		| compare with current stack,
		adda.l	#0x100,a0	| ... including 256-byte slop factor
		cmpa.l	a0,a7		| if (sp < a0+256)
		bcs	badbrk		| 	bad break;

		move.l	d0,_break	| OK break: save the break
		clr.l	d0		| Set OK return
		rts			| return

badbrk:		moveq.l	#-1,d0		| Load return reg
		rts			| Return

		.page

|************************************************************************
| 		Data Area						|
|************************************************************************

		.data

pmsg1:		.asciz	"  returned from Croot() "

|************************************************************************
| 		BSS Area						|
|************************************************************************

		.bss
		.even

_pmesg:		.ds.l	1	| panic() message string address
_heap:		.ds.l	1	| Heap start  (initial break)
_break:		.ds.l	1	| Current break location
errno:		.ds.w	1	| System error number

	.end
