| ------------------------------------------------------------------------------
| hwdefs.s --  External definitions of Buchla 700 I/O addresses
| Version 14 -- 1988-08-15 -- D.N. Lynx Crowe
| ------------------------------------------------------------------------------
		.text

		.xdef	io_time,io_lcd,io_ser,io_midi
		.xdef	io_disk,io_tone,io_leds,io_kbrd
		.xdef	io_vreg,io_vraw,io_vram,io_fpu
		.xdef	lcd_a0,lcd_a1

		.xdef	v_regs,v_odtab,v_actab
		.xdef	v_ct0
		.xdef	v_gt1
		.xdef	v_score,v_cgtab

		.xdef	v_curs0,v_curs1,v_curs2,v_curs3
		.xdef	v_curs4,v_curs5,v_curs6,v_curs7
		.xdef	v_kbobj,v_lnobj,v_tcur
		.xdef	v_win0
		.xdef	v_cur

		.xdef	fc_sw,fc_val

| ------------------------------------------------------------------------------

| Hardware base addresses
| -----------------------
io_fpu		=	0x180000	| FPU base address

VB		=	0x200000	| VSDD base address

io_time		=	0x3A0001	| Timer chip
io_lcd		=	0x3A4001	| LCD controller
io_ser		=	0x3A8001	| Serial ports  (RS232)
io_midi		=	0x3AC001	| MIDI ports
io_disk	=		0x3B0001	| Disk controller
io_tone		=	0x3B4001	| Sound generator chip
io_leds		=	0x3B8001	| LED driver
io_kbrd		=	0x3BC001	| Keyboard / panel processor

lcd_a0		=	io_lcd		| LCD port a0
lcd_a1		=	io_lcd+2	| LCD port a1

		.page

| Video definitions
| -----------------
io_vreg		=	VB		| Relocated video registers after setup
io_vraw		=	VB+0x400	| Raw video registers at RESET
io_vram		=	VB		| Video RAM base address

| Name			Offset		  Usage			       Bank
| -------		---------	  -------------------------    ----
v_regs		=	VB		| Video registers	       0,1

v_odtab		=	VB+128		| Object Descriptor Table	0
v_actab		=	VB+256		| Access Table			0
v_ct0		=	VB+1024		| Character Text-0		0
v_gt1		=	VB+1304		| Graphics Text-1		0
v_score		=	VB+8192		| Score object			0
v_cgtab		=	VB+122880	| Character Generator Table	0

v_curs0		=	VB+1024		| Cursor object 0  (arrow ULE)	1
v_curs1		=	VB+1152		| Cursor object 1  (arrow ULO)	1
v_curs2		=	VB+1280		| Cursor object 2  (arrow URE)	1
v_curs3		=	VB+1408		| Cursor object 3  (arrow URO)	1
v_curs4		=	VB+1536		| Cursor object 4  (arrow LLE)	1
v_curs5		=	VB+1664		| Cursor object 5  (arrow LLO)	1
v_curs6		=	VB+1792		| Cursor object 6  (arrow LRE)	1
v_curs7		=	VB+1920		| Cursor object 7  (arrow LRO)	1
v_tcur		=	VB+2048		| Typewriter cursor		1
v_kbobj		=	VB+2880		| Keyboard object		1
v_lnobj		=	VB+4672		| Line object			1
v_cur		=	VB+6464		| Underline cursor		1
v_win0		=	VB+16384	| Window-0 object		1

| BIOS RAM definitions
| --------------------
| WARNING: the following addresses must match those of the corresponding
| variables defined in bios.s or chaos is guaranteed.

fc_sw		=	0x420		| word - Frame counter switch
fc_val		=	0x422		| long - Frame counter value

		.end
