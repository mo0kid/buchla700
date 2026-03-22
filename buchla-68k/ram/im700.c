/*
   =============================================================================
	im700.c -- variable definitions and initialization for MIDAS-VII
	Version 102 -- 1989-11-16 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGVAL	0		/* initial value for debugsw */

#define	FET_DEFS	1		/* so fields.h gets things right */
#define	M7CAT		1		/* so libdsp.h gets it right */

#include "ram.h"

int16_t		admctl;			/* assignment display submenu control variable */
int16_t		adnamsw;		/* assignment display virtual typewriter flag */
int16_t		aflag;			/* analog activity flag */
int16_t		aform;			/* action buffer format */
int16_t		amplval;		/* amplitude */
int16_t		ancmsw;			/* analog variable r/p control source */
int16_t		angroup;		/* analog variable group being shown */
int16_t		asgfks;			/* first key selected */
int16_t		asghit;			/* row hit / assignment in progress */
int16_t		asgmod;			/* assignment number or table modified */
int16_t		asig;			/* analog signal number */
int16_t		asmode;			/* panel assignment mode */
int16_t		astat;			/* analog signal status */
int16_t		auxctl;			/* aux control flag */
int16_t		aval;			/* analog signal value */
int16_t		bform;			/* oscillator data buffer format */
int16_t		catin;			/* catalog read in flag */
int16_t		cents;			/* pitch to cents conversion buffer */
int16_t		chtime;			/* horizontal cursor counter */
int16_t		chwait;			/* horizontal cursor wait time */
int16_t		cflag;			/* accidental flag */
int16_t		clkctl;			/* clock control */
int16_t		clkrun;			/* clock status */
int16_t		clksrc;			/* clock source */
int16_t		cmfirst;		/* first cursor motion switch */
int16_t		cmtype;			/* cursor motion type */
int16_t		cnote;			/* note value at cursor */
int16_t		ctrsw;			/* scupd center update switch */
int16_t		curasg;			/* current assignment table */
int16_t		curfunc;		/* current function number */
int16_t		curgrp;			/* current group */
int16_t		curinst;		/* current instrument number */
int16_t		curmop;			/* current MIDI output port */
int16_t		curpnt;			/* current point number (absolute) */
int16_t		curpos;			/* cursor pad position for current axis */
int16_t		cursbox;		/* currently selected box */
int16_t		curscor;		/* Current score number */
int16_t		cursect;		/* current section */
int16_t		curslim;		/* cursor type change point */
int16_t		curtun;			/* current tuning table */
int16_t		curvce;			/* current voice number */
int16_t		curwave;		/* current waveshape library slot */
int16_t		curwdth;		/* current waveshape cursor width */
int16_t		curwfnl;		/* current waveshape final value */
int16_t		curwhrm;		/* current waveshape harmonic number */
int16_t		curwhrv;		/* current waveshape harmonic value */
int16_t		curwoff;		/* current waveshape offset value */
int16_t		curwpnt;		/* current waveshape point number */
int16_t		curwslt;		/* current waveshape instrument slot */
int16_t		cvtime;			/* vertical cursor counter */
int16_t		cvwait;			/* veritcal cursor wait time */
int16_t		cxrate;			/* cursor x rate */
int16_t		cxval;			/* graphic cursor x value */
int16_t		cyrate;			/* cursor y rate */
int16_t		cyval;			/* graphic cursor y value */
int16_t		debugne;		/* debug flag for note entry */
int16_t		defect;			/* defect code */
int16_t		dferror;		/* error code from BIOS or XBIOS */
int16_t		dfsides;		/* number of sides */
int16_t		dftype;			/* disk type code */
int16_t		dsp_ok;			/* display update OK this cycle flag */
int16_t		dubsw;			/* overdub / replace switch */
int16_t		ebflag;			/* edit buffer data flag */
int16_t		editss;			/* edit panel switch state */
int16_t		editsw;			/* edit mode switch */
int16_t		endflg;			/* !end flag */
int16_t		ext_cv1;		/* CV-1 value */
int16_t		ext_cv2;		/* CV-2 value */
int16_t		ext_cv3;		/* CV-3 value */
int16_t		ext_cv4;		/* CV-4 value */
int16_t		ext_mod;		/* Aux Signal Mod value */
int16_t		gomode;			/* go to mode */
int16_t		grptran;		/* group translation value */
int16_t		gtmsel;			/* group transpose/map select */
int16_t		hitbox;			/* box we just hit */
int16_t		hitcx;			/* x of cursor when we hit the box */
int16_t		hitcy;			/* y of cursor when we hit the box */
int16_t		idcfsw;			/* copy / fetch menu switch */
int16_t		idimsw;			/* instrument display instrument menu switch */
int16_t		idintmp;		/* temporary for instrument number */
int16_t		idnamsw;		/* typewriter switch */
int16_t		idsrcsw;		/* source menu switch */
int16_t		idtdat;			/* current instrument vtyper data entry string */
int16_t		imflag;			/* instrument modified flag */
int16_t		initcfg;		/* initial configuration */
int16_t		insmode;		/* score insert mode */
int16_t		ismode;			/* instrument select mode */
int16_t		lampio;			/* LCD timeout disable switch state at I/O time */
int16_t		lampsw;			/* LCD timeout disable switch */
int16_t		lasgsw;			/* assignments store switch */
int16_t		lastam;			/* last assignment menu base */
int16_t		ldelsw;			/* delete switch */
int16_t		lderrsw;		/* error message displayed switch */
int16_t		ldidsiz;		/* getcat() did showsiz() switch */
int16_t		ldkind;			/* fetch file type */
int16_t		ldpass;			/* librarian load state variable */
int16_t		ldrow;			/* fetch select row */
int16_t		ldslot;			/* fetch select slot */
int16_t		legato;			/* execkey() "legato" mode switch */
int16_t		lksel;			/* librarian key slot selector */
int16_t		lmwtype;		/* librarian message window type */
int16_t		loadrow;		/* librarian row selected for load letter */
int16_t		loadsw;			/* panel "Load" mode state */
int16_t		lorchl;			/* load hi (TRUE) / lo (FALSE) orchestra */
int16_t		lorchsw;		/* hi orchestra (21 - 40) store switch */
int16_t		lorclsw;		/* lo orchestra (01 - 20) store switch */
int16_t		lpatsw;			/* patch table store switch */
int16_t		lrasw;			/* append (TRUE) / replace (FALSE) score */
int16_t		lscrsw;			/* score store switch */
int16_t		lselsw;			/* fetch select switch */
int16_t		lseqsw;			/* sequence table store switch */
int16_t		lstbgnc;		/* last note begin entry table index */
int16_t		lstendc;		/* last note end entry table index */
int16_t		lstflag;		/* last note list end switch */
int16_t		lstrsw;			/* store state switch */
int16_t		lstwoff;		/* last waveshape offset value */
int16_t		lstwpnt;		/* last waveshape point number */
int16_t		ltagged;		/* load tag switch */
int16_t		ltunsw;			/* tunings store switch */
int16_t		lwavsw;			/* waveshapes store switch */
int16_t		mascntr;		/* MIDI active sensing timeout counter */
int16_t		mdb1;			/* current MIDI data byte 1 */
int16_t		mdb2;			/* current MIDI data byte 2 */
int16_t		michan;			/* current MIDI channel */
int16_t		midiclk;		/* MIDI clock switch */
int16_t		midigo;			/* MIDI run switch */
int16_t		mistat;			/* current MIDI status */
int16_t		nchwait;		/* next chwait value */
int16_t		ncvwait;		/* next cvwait value */
int16_t		ndisp;			/* current display number */
int16_t		newflag;		/* new data entered while t_cur EQ t_ctr */
int16_t		nkdown;			/* number of keys down */
int16_t		notenum;		/* note number */
int16_t		noteop;			/* pending note operation code */
int16_t		notepit;		/* note pitch */
int16_t		notesel;		/* note selection state */
int16_t		npts;			/* number of points in function */
int16_t		nxtflag;		/* next score flag */
int8_t		oldltag;		/* previous load tag for tagslot */
int16_t		oldpk;			/* previous pkctrl state */
int16_t		oldsl;			/* previous sliders state */
int16_t		pchsw;			/* punch-in enable switch */
int16_t		pecase;			/* point edit case variable */
int16_t		pkctrl;			/* local performance key state */
int16_t		pntsv;			/* point selection state variable */
int16_t		prgchan;		/* MIDI program change channel  (port 1) */
int16_t		ps_dpth;		/* phase shifter -- depth */
int16_t		ps_intn;		/* phase shifter -- intensity */
int16_t		ps_rate;		/* phase shifter -- rate */
int16_t		pulsclk;		/* pulse clock state */
int16_t		recsw;			/* record / play switch */
int16_t		runit;			/* run switch for main scan loop */
int16_t		sbase;			/* score VSDD RAM scroll offset */
int16_t		scmctl;			/* score submenu control flag */
int16_t		scrlpot;		/* scroll pot state */
int16_t		sd;			/* score display direction */
int16_t		se;			/* score execution direction */
int16_t		sdmcol;			/* score menu - saved stccol */
int16_t		sdmctl;			/* score menu - control variable */
int16_t		sdmrow;			/* score menu - saved stcrow */
int16_t		secop;			/* pending score section operation */
int16_t		secopok;		/* section operation OK flag */
int16_t		sgcsw;			/* graphic cursor display switch */
int16_t		sgoflag;		/* section number relative column 0..3 */
int16_t		sharp;			/* sharp flag */
int16_t		sliders;		/* slider and switch state */
int16_t		soffset;		/* score scroll offset */
int16_t		ss_ptsw;		/* smooth scroll patch scroll switch */
int16_t		ss_sqsw;		/* smooth scroll sequence scroll switch */
int16_t		stccol;			/* score cursor col */
int16_t		stcrow;			/* score cursor row */
int16_t		stepclk;		/* note entry - step clock state */
int16_t		stepenb;		/* note entry - step enable flag */
int16_t		stepint;		/* note entry - note interval */
int16_t		stepwgt;		/* note entry - note weight */
int16_t		subj;			/* edited point number (relative) */
int16_t		submenu;		/* submenu active switch */
int16_t		swctrl;			/* scroll wheel 'srolling' flag */
int16_t		swdelta;		/* scroll wheel change while touched */
int16_t		swdir;			/* scroll wheel direction */
int16_t		swfiin;			/* scroll wheel fifo input pointer */
int16_t		swflag;			/* scroll wheel touched flag */
int16_t		swlast;			/* scroll wheel last value */
int16_t		swstop;			/* scroll wheel stop flag */
int16_t		swndx;			/* scroll wheel look back index */
int16_t		tagslot;		/* tagged load slot */
int16_t		tdnamsw;		/* tuning editor displaying typewriter */
uint16_t	temax;			/* time upper limit */
uint16_t	temin;			/* time lower limit */
int16_t		testing;		/* test level */
int16_t		tglclk;			/* clock on/off toggle flag */
int16_t		tglpch;			/* punch in/out toggle flag */
int16_t		thescore;		/* score selected from sqscan */
uint16_t	timemlt;		/* time scaling */
int16_t		tkctrl;			/* trackball active flag */
int16_t		tmpomlt;		/* tempo multiplier */
int16_t		tmpoval;		/* tempo value */
int16_t		trkball;		/* trackball selected switch */
int16_t		ttcmdsv;		/* tuning editor edit state variable */
int16_t		ttsel1;			/* tuning editor key select variable 1 */
int16_t		ttsel2;			/* tuning editor key select variable 2 */
int16_t		ttsel3;			/* tuning editor key select variable 3 */
int16_t		tuneval;		/* fine tuning */
int16_t		tunmod;			/* tuning table modified */
int16_t		tunval;			/* tuning editor increment / transpose  value */
int16_t		txfiin;			/* trackball x fifo input pointer */
int16_t		txflag;			/* trackball x axis active flag */
int16_t		txlast;			/* trackball x axis last value */
int16_t		txstop;			/* trackball x axis filter counter */
int16_t		tyfiin;			/* trackball y fifo input pointer */
int16_t		tyflag;			/* trackball y axis active flag */
int16_t		tylast;			/* trackball y axis last value */
int16_t		tystop;			/* trackball y axis filter counter */
int16_t		velflag;		/* velocity display flag */
int16_t		verbose;		/* verbose output switch */
int16_t		vlbtype;		/* type of message window display */
int16_t		vrbw08;			/* score display video reset detail word */
int16_t		vrbw09;			/* score display video reset detail word */
int16_t		vrbw10;			/* score display video reset detail word */
int16_t		vrbw11;			/* score display video reset detail word */
int16_t		vrbw12;			/* score display video reset detail word */
int16_t		vrbw13;			/* score display video reset detail word */
int16_t		vrbw14;			/* score display video reset detail word */
int16_t		vrbw15;			/* score display video reset detail word */
int16_t		vrcw;			/* score display video reset control word */
int16_t		vtccol;			/* virtual typewriter cursor column */
int16_t		vtcrow;			/* virtual typewriter cursor row */
int8_t		vtdechr;		/* virtual typewriter data entry character */
int16_t		vtdecol;		/* virtual typewriter data entry column */
int16_t		vtpcol;			/* virtual typewriter column */
int16_t		vtprow;			/* virtual typewriter row */
int16_t		vtwcol;			/* virtual typewriter window left column */
int16_t		vtwrow;			/* virtual typewriter window top row */
int16_t		vtxval;			/* virtual typewriter cursor x value */
int16_t		vtyval;			/* virtual typewriter cursor y value */
int16_t		wcflag;			/* ws/cf menu select flag (cf=0, ws=1) */
int16_t		wcmcol;			/* ws/cf menu label column */
int16_t		wcmrow;			/* ws/cf menu label row */
int16_t		wcpage;			/* ws/cf menu page */
int16_t		wdupdfl;		/* waveshape display needs updated flag */
int16_t		wmcsel;			/* ws menu ws a/b select */
int16_t		wmctag;			/* ws/cf display update flag */
int16_t		wplast;			/* last point for interpolate operation */
int16_t		wpntsv;			/* waveshape point selection state variable */
int16_t		wshmax;			/* waveshape maximum value */
int16_t		wvlast;			/* last value for interpolate operation */
int16_t		xkcount;		/* cursor x key on count */
int16_t		xkstat;			/* cursor x key status */
int16_t		xycntr;			/* xy center for cursor pad */
int16_t		ykcount;		/* cursor y key on count */
int16_t		ykstat;			/* cursor y key status */

int16_t		anrs[8][16];		/* analog variable resolution */
int16_t		grp2prt[12][2];		/* group to port and channel table */
int16_t		sctctab[10][64];	/* score background color table */
int16_t		sigtab[128][2];		/* signals:  [0] = value, [1] = switch */
int16_t		tunlib[NTUNS][128];	/* tuning table library */
int16_t		varmode[8][16];		/* analog variable record mode */
int16_t		wsnmod[12][2];		/* waveshape number / data modified */

struct	EXFILE	mphead;		/* MIDAS-VII program header */
struct	fet	*cfetp;		/* current fet entry pointer */
struct	fet	*curfet;	/* current fet table pointer */
struct	fet	*infetp;	/* in-field fet pointer */
struct	gdsel	*gdfsep;	/* gdsel freechain pointer */
struct	instpnt	*pntptr;	/* pointer to edited point */
struct	mlibhdr	ldhead;		/* library header */
struct	nevent	*nefree;	/* pointer to free note entries */
struct	nevent	*nelist;	/* pointer to note entry list */
struct	octent	*adoct;		/* assignment display object control pointer */
struct	octent	*ldoct;		/* librarian object control table pointer */
struct	octent	*mdoct;		/* menu display object control table pointer */
struct	octent	*tdoct;		/* tuning display object control table pointer */
struct	octent	*wdoct;		/* object control table pointer */
struct	octent	*idoct;		/* instrument display octent pointer */
struct	pflent	*pflist;	/* pendant function list header */
struct	pflent	*pfqhdr;	/* pendant function list entry freechain header */
struct	s_entry	*libsp;		/* librarian score pointer */
struct	s_entry	*peg;		/* insert mode 'peg' to hang the tail on */
struct	s_entry	*size1;		/* score E_SIZE1 entry free list pointer */
struct	s_entry	*size2;		/* score E_SIZE2 entry free list pointer */
struct	s_entry	*size3;		/* score E_SIZE3 entry free list pointer */
struct	selbox	*csbp;		/* current select box table pointer */
struct	selbox	*curboxp;	/* current select box pointer */
struct	s_entry *p_bak;		/* pointer to entry at left edge of display */
struct	s_entry	*p_cbgn;	/* pointer to start of copy */
struct	s_entry	*p_cend;	/* pointer to end of copy */
struct	s_entry *p_cur;		/* pointer to entry at current execution time */
struct	s_entry *p_ctr;		/* pointer to entry at center of display */
struct	s_entry *p_fwd;		/* pointer to entry at right edge of display */
struct	n_entry	*p_nbeg;	/* pointer to note begin */
struct	n_entry	*p_nend;	/* pointer to note end */
struct	s_entry	*p_sbgn;	/* pointer to start of section */
struct	s_entry	*p_sec1;	/* pointer to start of 1st section */
struct	s_entry	*p_sec2;	/* pointer to start of 2nd section */
struct	s_entry	*p_send;	/* pointer to end of section */
struct	s_entry *scp;		/* current score pointer */

struct	asgent	asgtab[NASGS];		/* assignment table library */
struct	fcat	filecat[FCMAX];		/* file catalog */
struct	gdsel	*gdstbc[NGDSEL];	/* center group & event status lists */
struct	gdsel	*gdstbn[NGDSEL];	/* right group & event status lists */
struct	gdsel	*gdstbp[NGDSEL];	/* left group & event status lists */
struct	gdsel	gdfsl[MAXFSL];		/* gdsel pool */
struct	instdef	idefs[NINST];		/* current instrument definitions */
struct	n_entry	*lstbgns[NLSTENTS];	/* last note begin entry table */
struct	n_entry	*lstends[NLSTENTS];	/* last note end entry table */
struct	instdef	vbufs[12];		/* voice instrument buffers */
struct	nevent	nevents[NNEVTS];	/* note event list */
struct	pflent	pfents[NPFENTS];	/* pendant function list entry pool */
struct	scndx	sindex[N_SCORES];	/* score file table of contents */
struct	sment	*vpsms[192];		/* voice parameter general S/M pointer table */
struct	sment	sments[192];		/* source multiplier assignment table */
struct	valent	valents[NGPSRS];	/* source value table */
struct	wstbl	wslib[NUMWAVS];		/* waveshape library */
struct	s_entry *scores[N_SCORES];	/* Score pointer table */

struct	s_time	stimes[N_SCORES][N_SECTS];	/* score section SMPTE times */
struct	s_entry *hplist[N_SCORES][N_TYPES];	/* Score change list pointers */
struct	s_entry *seclist[N_SCORES][N_SECTS];	/* Section pointer table */

volatile	uint16_t	*asgob;		/* assignment display object pointer */
volatile	uint16_t	*consl;		/* constant slice pointer */
volatile	uint16_t	*cursl;		/* current (center) slice pointer */
volatile	uint16_t	*instob;	/* instrument object pointer */
volatile	uint16_t	*librob;	/* librarian display object pointer */
volatile	uint16_t	*menuob;	/* menu display object pointer */
volatile	uint16_t	*nxtsl;		/* next (right edge) slice pointer */
volatile	uint16_t	*obj0;		/* object  0 VSDD RAM pointer */
volatile	uint16_t	*obj1;		/* object  1 VSDD RAM pointer */
volatile	uint16_t	*obj2;		/* object  2 VSDD RAM pointer */
volatile	uint16_t	*obj3;		/* object  3 VSDD RAM pointer */
volatile	uint16_t	*obj4;		/* object  4 VSDD RAM pointer */
volatile	uint16_t	*obj5;		/* object  5 VSDD RAM pointer */
volatile	uint16_t	*obj6;		/* object  6 VSDD RAM pointer */
volatile	uint16_t	*obj7;		/* object  7 VSDD RAM pointer */
volatile	uint16_t	*obj8;		/* object  8 VSDD RAM pointer */
volatile	uint16_t	*obj9;		/* object  9 VSDD RAM pointer */
volatile	uint16_t	*obj10;		/* object 10 VSDD RAM pointer */
volatile	uint16_t	*obj11;		/* object 11 VSDD RAM pointer */
volatile	uint16_t	*obj12;		/* object 12 VSDD RAM pointer */
volatile	uint16_t	*obj13;		/* object 13 VSDD RAM pointer */
volatile	uint16_t	*obj14;		/* object 14 VSDD RAM pointer */
volatile	uint16_t	*obj15;		/* object 15 VSDD RAM pointer */
volatile	uint16_t	*prvsl;		/* previous (left edge) slice pointer */
volatile	uint16_t	*saddr;		/* score VSDD RAM base pointer */
volatile	uint16_t	*tunob;		/* tuning table display object pointer */
volatile	uint16_t	*vtobj;		/* virtual typewriter display object pointer */
volatile	uint16_t	*waveob;	/* waveshape display object pointer */

uint16_t	curintp;	/* current interpolate time (FPU format) */
uint16_t	scrl;		/* score VSDD object scroll register image */
int16_t		vtbgval;	/* virtual typewriter data background color */
int16_t		vtfgval;	/* virtual typewriter data foreground color */

uint16_t	dfbuf[4096];	/* track formatting buffer */
uint16_t	slices[896];	/* score display slices */

/* initialized variables */

int16_t	debugsw = DEBUGVAL;	/* debug output switch */

int16_t	swback  = SWBACK;	/* scroll wheel look back count */
int16_t	swthr   = SWTHR;	/* scroll wheel movement threshold */
int16_t	swtime  = SWTIME;	/* scroll wheel timer scan time */
int16_t	swwait	= SWWAIT;	/* scroll wheel wait count */

int16_t	tkback  = TKBACK;	/* trackball FIFO look back count */
int16_t	tkrmin  = TKRMIN;	/* trackball rate threshold */
int16_t	tkthr   = TKTHR;	/* trackball movement threshold */
int16_t	tktime  = TKTIME;	/* trackball timer scan time */
int16_t	tkwait	= TKWAIT;	/* trackball wait count */

int16_t	curhold = CURHOLD;	/* cursor hold time */
int16_t	hcwval  = HCWVAL;	/* graphics cursor X wait time */
int16_t	thcwval = THCWVAL;	/* text cursor H wait time */
int16_t	tvcwval = TVCWVAL;	/* text cursor V wait time */
int16_t	vcwval  = VCWVAL;	/* graphics cursor Y wait time */

uint16_t	tmultab[] = {		/* time multiplier table - indexed by voltage */

	0xFFFF, 0xFAFA, 0xF627, 0xF182, 0xED09, 	/*   0 */
	0xE8BA, 0xE492, 0xE08F, 0xDCB0, 0xD8F2, 	/*   5 */
	0xD555, 0xD1D6, 0xCE73, 0xCB2C, 0xC800, 	/*  10 */
	0xC4EC, 0xC1F0, 0xBF0B, 0xBC3C, 0xB981, 	/*  15 */
	0xB6DB, 0xB448, 0xB1C7, 0xAF57, 0xACF9, 	/*  20 */
	0xAAAA, 0xA86B, 0xA63B, 0xA41A, 0xA206, 	/*  25 */
	0xA000, 0x9E06, 0x9C18, 0x9A37, 0x9861, 	/*  30 */
	0x9696, 0x94D6, 0x9320, 0x9174, 0x8FD1, 	/*  35 */
	0x8E38, 0x8CA8, 0x8B21, 0x89A2, 0x882B, 	/*  40 */
	0x86BC, 0x8555, 0x83F5, 0x829C, 0x814A, 	/*  45 */
	0x8000, 0x7EBB, 0x7D7D, 0x7C45, 0x7B13, 	/*  50 */
	0x79E7, 0x78C1, 0x77A0, 0x7684, 0x756E, 	/*  55 */
	0x745D, 0x7350, 0x7249, 0x7146, 0x7047, 	/*  60 */
	0x6F4D, 0x6E58, 0x6D66, 0x6C79, 0x6B90, 	/*  65 */
	0x6AAA, 0x69C8, 0x68EB, 0x6810, 0x6739, 	/*  70 */
	0x6666, 0x6596, 0x64C9, 0x6400, 0x6339, 	/*  75 */
	0x6276, 0x61B5, 0x60F8, 0x603D, 0x5F85, 	/*  80 */
	0x5ED0, 0x5E1E, 0x5D6E, 0x5CC0, 0x5C16, 	/*  85 */
	0x5B6D, 0x5AC7, 0x5A24, 0x5982, 0x58E3, 	/*  90 */
	0x5846, 0x57AB, 0x5713, 0x567C, 0x55E7, 	/*  95 */
	0x5555						/* 100 */
};

int16_t	crate0[] = {			/* cursor rate table 1 */

	 0,  0,  0,  0,  0,  0,  0,  0,		/* 0..7 */
	 0,  0,  0,  0,  1,  1,  1,  1,		/* 8..15 */
	 1,  1,  1,  1,  1,  1,  1,  1,		/* 16..23 */
	 1,  1,  1,  1,  1,  1,  1,  1,		/* 24..31 */
	 1,  1,  1,  1,  1,  1,  1,  1,		/* 32..39 */
	 1,  1,  1,  1,  1,  1,  1,  1,		/* 40..47 */
	 1,  1,  1,  1,  1,  1,  1,  1,		/* 48..55 */
	 1,  1,  1,  1,  1,  1,  1,  1		/* 56..63 */
};

int16_t	crate1[] = {			/* cursor rate table 1 */

	 0,  0,  0,  0,  0,  0,  0,  0,		/* 0..7 */
	 1,  1,  1,  1,  1,  1,  1,  1,		/* 8..15 */
	 3,  3,  3,  3,  3,  3,  3,  3,		/* 16..23 */
	 5,  5,  5,  5,  5,  5,  5,  5,		/* 24..31 */
	 7,  7,  7,  7,  7,  7,  7,  7,		/* 32..39 */
	 9,  9,  9,  9,  9,  9,  9,  9,		/* 40..47 */
	11, 11, 11, 11, 11, 11, 11, 11,		/* 48..55 */
	13, 13, 13, 13, 13, 13, 13, 13		/* 56..63 */
};

int16_t crate2[] = {			/* cursor rate table 2 */

	  0,  0,  0,  0,  0,  0,  0,  0,	/* 0..7 */
	  1,  1,  1,  1,  1,  1,  1,  1,	/* 8..15 */
	  2,  2,  2,  2,  2,  2,  2,  2,	/* 16..23 */
	  4,  4,  4,  4,  8,  8,  8,  8,	/* 24..31 */
	 16, 16, 16, 16, 32, 32, 32, 32,	/* 32..39 */
	 64, 64, 64, 64,128,128,128,128,	/* 40..47 */
	 96, 96, 96, 96,256,256,256,256,	/* 48..55 */
	256,256,256,256,256,256,256,256		/* 56..63 */
};

int16_t	loctab[9] = {

	0,		/* 0 - left */

	125 << 5,	/* 1 */
	250 << 5,	/* 2 */
	375 << 5,	/* 3 */

	500 << 5,	/* 4 - center */

	625 << 5,	/* 5 */
	750 << 5,	/* 6 */
	875 << 5,	/* 7 */

	1000 << 5	/* 8 - right */
};

/*
   =============================================================================
	valof() -- return initial value of a source
   =============================================================================
*/

int16_t valof(int16_t srcv)
{
	switch (srcv) {

	case SM_NONE:		/* -none- */
		return(0);

	case SM_RAND:		/* Random */
		return(xgetran(0));

	case SM_CTL1:		/* Ctl V1 */
		return(SM_SCALE(sigtab[79][0]));

	case SM_PTCH:		/* Pitch */
	case SM_KPRS:		/* Key Prs */
	case SM_KVEL:		/* Key Vel */
		return(0);

	case SM_PED1:		/* Pedal 1 */
		return(SM_SCALE(sigtab[77][0]));

	case SM_HTPW:		/* Hor Tab / Pch Whl */
		return(0);

	case SM_VTMW:		/* Vrt Tab / Mod Whl */
		return(SM_SCALE(sigtab[54][0]));

	case SM_LPBR:		/* LongPot / Breath */
		return(SM_SCALE(sigtab[57][0]));

	default:
		return(0);
	}
}

/*
   =============================================================================
	inismtb() -- initialize source / multiplier data structures
   =============================================================================
*/

void inismtb(void)
{
	register int16_t i, oldi;

	oldi = setipl(FPU_DI);

/* ++++++++++++++++++++++++++++ FPU interrupts disabled +++++++++++++++++++++ */

	for (i = 0; i < NGPSRS; i++) {

		valents[i].nxt = (struct sment *)&valents[i];
		valents[i].prv = (struct sment *)&valents[i];
		valents[i].val = valof(i & 0x000F);
	}

	for (i = 0; i < 192; i++) {

		vpsms[i] = &sments[i];

		sments[i].prv = (struct sment *)&valents[0];
		sments[i].nxt = valents[0].nxt;

		valents[0].nxt->prv = &sments[i];
		valents[0].nxt      = &sments[i];

		sments[i].vp = i;
		sments[i].sm = 0;
	}

	setipl(oldi);

/* ++++++++++++++++++++++++++++ Interrupts restored +++++++++++++++++++++++++ */

}

/*
   =============================================================================
	clrpfl() -- clear pendant function list
   =============================================================================
*/

void clrpfl(void)
{
	register int16_t i;

	memsetw(&pfents[0], 0, (NPFENTS * sizeof (struct pflent))/2);

	for (i = 0; i < NPFENTS-1; i++)
		pfents[i].nextpf = &pfents[i+1];

	pfqhdr = &pfents[0];
	pflist = (struct pflent *)NULL;
}

/*
   =============================================================================
	im700() -- initialize MIDAS 700
   =============================================================================
*/

void im700(void)
{
	register int16_t i, j, k;
	volatile uint8_t *ioadr;
	register struct instdef *ip;

	debugsw = DEBUGVAL;		/* initialize debug switch */

	GLCinit();			/* initialize the GLC */
	GLCcurs(G_ON);
	GLCtext(2, 1, "MIDAS 7 -- Initialization in progress -- Please stand by");
	GLCcurs(G_OFF);

	vsndpal(blakpal);		/* setup the blackout palette */

	VHinit();			/* clear the video hardware */
	VSinit();			/* ... and the video software */

	memset(keystat, 0, 24);		/* clear front panel key status */
	memset(trgtab, 	0, NTRIGS);	/* clear trigger status table */
	memsetw(mctlval, 0, NCTRLS);	/* clear MIDI controller values */

	memsetw(grpmode, 0, 12);	/* set all groups to PLAY */
	memsetw(grpstat, GS_ENBL, 12);	/* enable all groups for param. artic. */
	memsetw(grpsel, TRUE, 12);	/* enable all groups for instr. sel. */
	memsetw(sigtab, 0, ((sizeof sigtab) / (sizeof sigtab[0][0])));

	memsetw(veltab, SM_SCALE(64), NTRIGS);	/* clear velocity table */
	memsetw(lastvel, SM_SCALE(64), 12);	/* clear last velocity table */
	memsetw(prstab, 0, NTRIGS);	/* clear pressure table */

	curintp = tofpu(100);		/* set default interpolate time */

	angroup = -1;			/* analog values:  group 1, not shown */
	ancmsw  = FALSE;		/* analog variable mode from grpmode */
	velflag = FALSE;		/* velocity not displayed */

	dubsw   = TRUE;			/* set overdub mode */

	sd = D_FWD;			/* set display direction */
	se = D_FWD;			/* set execution direction */

	swinit();			/* reset the scroll wheel variables */

	inismtb();			/* clear the S/M data structures */
	clrnl();			/* clear note entry lists */
	clrpfl();			/* clear pendant function list */

	lstbgnc = 0;			/* reset last note begin count */
	lstendc = 0;			/* reset last note end count */
	lstflag = TRUE;			/* set end of note entry list flag */

	memsetw(lstbgns, 0, (NLSTENTS << 1));	/* clear note begin list */
	memsetw(lstends, 0, (NLSTENTS << 1));	/* clear note end list */

	/* set funcndx[] entries */

	for (i = 0; i < 12; i++) {

		ip = &vbufs[i];

		for (j = 0; j < NFINST; j++) {

			k = (i << 4) + fnoff[j];

			funcndx[k][0] = (int8_t *)&ip->idhfnc[j];
			funcndx[k][1] = (int8_t *)ip->idhpnt;
		}
	}


	for (i = 0; i < 3; i++) {	/* reset the state machines */

		msmstv[i] = 0;		/* state = 0 */
		mrstat[i] = 0;		/* clear running status */
		mdbyte[i] = 0;		/* clear first byte buffer */
		masens[i] = 0;		/* clear active sensing */
	}

	for (i = 0; i < 48; i++) {

		mpbend[i] = 0;		/* clear bend values */
		mpsust[i] = 0;		/* clear sustain values */
	}

	for (i = 0; i < 12; i++) {

		for (j = 0; j < 6; j++) {

			varmode[j][i] = 0;	/* set r/p mode */
			anrs[j][i]    = 4;	/* set analog resolution */
		}

		setdyn(i, 6);		/* set group dynamics */
		setloc(i, 4);		/* set group locations */
		lastvce[i] = 0;		/* clear last voice assigned */
		vce2trg[i] = -1;	/* clear voice to trigger table */
	}

	for (i = 0; i < NLTYPES; i++) {

		memset(loadedc[i], ' ', 37);
		memset(loadedf[i], ' ', 8);
	}

	memset(ldfile, ' ', 8);		/* clear the library file name field */
	ldfile[8] = '\0';

	memset(ldcmnt, ' ', 37);	/* clear the library comment field */
	ldcmnt[37] = '\0';


	xkcount = 1;			/* reset cursor control variables */
	ykcount = 1;
	xycntr  = XYCENTRE;

	clksrc  = CK_LOCAL;		/* clock source = local */
	clkctl  = CK_LOCAL;		/* clock control = local */
	clkrun  = FALSE;		/* clock stopped */
	midiclk = FALSE;		/* ... */
	pulsclk = FALSE;		/* ... */
	stepclk = FALSE;		/* ... */
	fc_sw   = 0;			/* stop the frame clock */
	fc_val  = 0L;			/* ... and reset it */
	scrlpot = 0;			/* not scrolling */
	tmpomlt = 50;			/* initialize tempo multiplier */
	io_leds = 0x18;			/* ... and turn off the LEDs */
	io_leds = 0x19;			/* ... */
	settmpo(60);			/* set default tempo */

	timemlt = tmultab[50];		/* initialize time scaling */
	io_leds = 0x1A;
	io_leds = 0x1B;

	tuneval = 0;			/* initialize fine tuning */
	io_leds = 0x1C;
	io_leds = 0x1D;

	for (i = 0; i < 12; i++)	/* setup default values for gtctab */
		gtctab[i] = (uint16_t)
			(((i+3) << 12) | ((i+3) << 8) | ((i+3) << 4) | (i+3));

	editsw  = FALSE;		/* setup edit switch state */
	io_leds = 0x1E;
	ioadr   = &io_ser + 2L;
	editss  = *ioadr & 0x0008;

	ac_code = N_SHARP;	/* default accidentals to display as sharps */

	memsetw(articen, TRUE, 12);	/* enable articulation for all voices */

	curmove = cmvgen;
	premove = nokey;
	pstmove = nokey;
	curtype = stdctp2;

	x_key = nokey;		/* setup default key processors */
	e_key = nokey;
	m_key = stdmkey;
	d_key = nodkey;

	not_fld = nonf;

	cx_key  = cxkstd;	/* setup default cursor processors */
	cy_key  = cykstd;
	cx_upd  = cxgen;
	cy_upd  = cygen;
	xy_up   = nokey;
	xy_dn   = nokey;

	curslim = 349;		/* cursor limit for graphics to text switch */

	chtime  = hcwval;	/* initialize default cursor wait times */
	cvtime  = vcwval;
	nchwait = curhold;
	ncvwait = curhold;
	chwait  = 1;
	cvwait  = 1;

	cratex  = crate1;	/* initialize default cursor x rate table */
	cratey  = crate1;	/* initialize default cursor y rate table */

	cmfirst = TRUE;		/* setup for first motion of cursor */
	cmtype  = CT_GRAF;

	cxval   = XCTR;		/* default cursor to center of screen */
	cyval   = YCTR;

	stcrow  = cyval / 14;	/* keep text position in sync */
	stccol  = cxval / 8;

	submenu = FALSE;	/* no submenu up to start with */

	curinst = 0;		/* current instrument = 0 */
	curfunc = 12;		/* current function = 12 = level */
	curvce  = 0;		/* current voice = 0 */

	asmode  = FALSE;	/* deselect assignment mode */
	gomode  = GO_NULL;	/* deselect go to mode */
	ismode  = IS_NULL;	/* deselect instrument select mode */
	pkctrl  = PK_PFRM;	/* select local performance key state */
	oldpk   = pkctrl;	/* ... */
	sliders = LS_PRMTR;	/* setup the LCD display pots and switches */
	oldsl   = sliders;	/* ... */
	swpt    = &t_prmtr;	/* ... */
	oldsw   = swpt;		/* ... */
	setleds();		/* set performance keyboard leds */

	initpt();		/* initialize the patch table */
	initsq();		/* initialize the sequence table */
	initil();		/* initialize the instrument library */
	iniwslb();		/* initialize the waveshape library */
	inital();		/* initialize the assignment library */
	inittl();		/* initialize the tuning table library */
	scinit();		/* initialize the score */

	clearer(1);		/* reset the fpu to its nominal values */
	getasg(curasg = 0);	/* setup default assignments */

	lcdlbls();		/* put up the LCD display */
	lampsw = FALSE;		/* enable LCD timeout */
}

