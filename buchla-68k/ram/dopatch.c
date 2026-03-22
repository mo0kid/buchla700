/*
   =============================================================================
	dopatch.c -- MIDAS-VII Patch facility -- execution functions
	Version 15 -- 1988-11-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGPA		0

#include "ram.h"

#if	DEBUGPA
short	debugpa = 1;
#endif

#define	ST_NUL	0x0000		/* no subaddress breakdown */
#define	ST_VGT	0x0001		/* break subaddress into voice, group */
#define	ST_PCT	0x0002		/* break subaddress into port, chan, trig */

uint16_t	seqdupd;		/* sequence display update flag */
int8_t	ledstat[24];			/* LED status */

int16_t	frq2par[] = {1, 3, 5, 7};			/* Frq to par */

int16_t	ind2par[] = {9, 11, 12, 13, 14, 15};		/* Ind to par */

int16_t	cv2vce[] = {11, 10, 6, 8};			/* CV to voice */

int16_t	lg2base[7] = { 0, 3, 7, 10, 14, 17, 21};	/* LED group bases */

uint8_t	vgtype[] = {

	ST_NUL,		/* PA_NULL */

	ST_PCT,		/* PA_KEY */
	ST_PCT,		/* PA_TRG */

	ST_NUL,		/* PA_PLS */
	ST_NUL,		/* PA_LED */
	ST_NUL,		/* PA_SLIN */
	ST_NUL,		/* PA_SCTL */
	ST_NUL,		/* PA_TUNE */
	ST_NUL,		/* PA_RSET */
	ST_NUL,		/* PA_RADD */

	ST_VGT,		/* PA_INST */
	ST_VGT,		/* PA_OSC */
	ST_VGT,		/* PA_WAVA */
	ST_VGT,		/* PA_WAVB */
	ST_VGT,		/* PA_CNFG */
	ST_VGT,		/* PA_LEVL */
	ST_VGT,		/* PA_INDX */
	ST_VGT,		/* PA_FREQ */
	ST_VGT,		/* PA_FILT */
	ST_VGT,		/* PA_FILQ */
	ST_VGT,		/* PA_LOCN */
	ST_VGT,		/* PA_DYNM */

	ST_NUL,		/* PA_AUX */
	ST_NUL,		/* PA_RATE */
	ST_NUL,		/* PA_INTN */
	ST_NUL,		/* PA_DPTH */
	ST_NUL,		/* PA_VOUT */
};

/*
   =============================================================================
	pdows() -- get a waveshape for a voice
   =============================================================================
*/

void pdows(int16_t slot, int16_t voice, int16_t wsn)
{
	volatile uint16_t *fpuws;

	if (slot) {		/* waveshape slot B */

		vbufs[voice].idhwsb = (int8_t)wsn;

		memcpyw(vbufs[voice].idhwvbf, &wslib[wsn],
			NUMHARM + (2 * NUMWPNT));

		fpuws = io_fpu + FPU_OWST + (voice << 9) + 1;

		memcpyw(fpuws, vbufs[voice].idhwvbf, NUMWPNT);

		*(fpuws - 1) = (uint16_t)vbufs[voice].idhwvbf[0];
		*(fpuws + NUMWPNT) = (uint16_t)vbufs[voice].idhwvbf[NUMWPNT - 1];

	} else {		/* waveshape slot A */

		vbufs[voice].idhwsa = (int8_t)wsn;

		memcpyw(vbufs[voice].idhwvaf, &wslib[wsn],
			NUMHARM + (2 * NUMWPNT));

		fpuws = io_fpu + FPU_OWST + (voice << 9) + 0x0100 + 1;

		memcpyw(fpuws, vbufs[curvce].idhwvaf, NUMWPNT);

		*(fpuws - 1) = (uint16_t)vbufs[voice].idhwvaf[0];
		*(fpuws + NUMWPNT) = (uint16_t)vbufs[voice].idhwvaf[NUMWPNT - 1];

	}
}

/*
   =============================================================================
	pfpufn() -- process an FPU function operation for a patch
   =============================================================================
*/

void pfpufn(int16_t voice, int16_t par, uint16_t dat1, uint16_t dat2)
{
	volatile uint16_t *fpu;
	int16_t delay;

	fpu = io_fpu + FPU_OFNC + (voice << 8) + (par << 4);

	switch (dat1) {

	case PSA_SRC:		/* source */
		break;

	case PSA_MLT:		/* multiplier */

		*(fpu + FPU_TSF1) = dat2;
		break;

	case PSA_TIM:		/* time */

		*(fpu + FPU_TMNT) = (uint16_t)(((uint32_t)(dat2 & 0xFFF0)
			* (uint32_t)timemlt) >> 15);

		++delay;

		*(fpu + FPU_TEXP) = expbit[dat2 & 0x000F];

		break;

	case PSA_VAL:		/* value */

		sendval(voice, par, (int16_t)dat2);
		break;

	case PSA_FNC:		/* function */
		break;

	default:		/* something weird got in here ... */
		break;
	}
}

/*
   =============================================================================
	pdoctl() -- do oscillator control for a patch entry
   =============================================================================
*/

void pdoctl(int16_t voice, int16_t osc, int16_t dat1, int16_t dat2)
{
	register struct instdef *ip;

	ip = &vbufs[voice];
	bform = dat1;
	setoval(ip, osc, dat2 >> 1);
}

/*
   =============================================================================
	dopatch() -- execute a patch entry
   =============================================================================
*/

void dopatch(struct patch *pp)
{
	uint16_t suba, dat1, dat2;
	int16_t i, temp;
	volatile uint8_t *ser;
	int8_t *iorec;
	uint16_t oldsr;
	int16_t chan, osc, port, spec, sat, trig, vgr, vgn, vgt;
	int16_t baseled, curled, ledctl;

	osc = -1;
	trig = -1;
	vgn = -1;
	vgt = -1;

	spec = PE_SPEC & pp->paspec;		/* destination */
	suba = pp->pasuba;			/* sub address */
	dat1 = pp->padat1;			/* data word 1 */
	dat2 = pp->padat2;			/* data word 2 */

	sat = vgtype[spec];			/* sub-address type */

	if (ST_VGT & sat) {		/* vg, osc sub-address types */

		vgr  = (int16_t)(0x00FF & (suba >> 8));		/* voice / group */
		osc  = (int16_t)(0x00FF &  suba);		/* oscillator */

		if (vgr > 11) {		/* sort out voices from groups */

			vgt = 1;		/* group */
			vgn = vgr - 12;

		} else {

			vgt = 0;		/* voice */
			vgn = vgr;
		}

	} else if (ST_PCT & sat) {	/* port, chan, trig sub-address types */

		port = 0x0003 & (suba >> 11);		/* port */
		chan = 0x000F & (suba >>  7);		/* channel */
		trig = 0x007F &  suba;			/* trigger */

		(void)port;
		(void)chan;
	}

	switch (spec) {		/* dispatch on destination */

	case PA_KEY:		/* key action */

		if ((dat2 EQ 0) OR (dat2 EQ 2))
			putwq(&ptefifo, suba & 0x1FFF);		/* closure */

		if ((dat2 EQ 0) OR (dat2 EQ 1))
			putwq(&ptefifo, suba | 0x8000);		/* release */

		break;

	case PA_TRG:		/* trigger */

		trig &= 0x000F;
		trstate[trig] = dat2;

		if (dat2)
			putwq(&ptefifo, suba);		/* closure */

		seqdupd |= ((uint16_t)1 << trig);
		break;

	case PA_PLS:		/* pulse output */

		if (suba) {

			ser   = &io_midi + 10L;	/* pulse 2 */
			iorec = M2IoRec;

		} else {

			ser   = &io_midi + 2L;	/* pulse 1 */
			iorec = M1IoRec;
		}

		oldsr = setsr(0x2700);		/* DISABLE INTERRUPTS */

		temp  = iorec[29];		/* get current CFR1 */

		switch (dat2) {			/* switch on operation */

		case 0:				/* transient */

			*ser = (uint8_t)(temp | 0x0082);		/* on */
			*ser = (uint8_t)((temp & 0x00FD) | 0x0080);	/* off */
			break;

		case 1:				/* off */

			*ser = (uint8_t)((temp & 0x00FD) | 0x0080);	/* off */
			break;

		case 2:				/* on */

			*ser = (uint8_t)(temp | 0x0082);		/* on */
			break;
		}

		setsr(oldsr);			/* RESTORE INTERRUPTS */

		break;

	case PA_LED:		/* LED control */

		baseled = lg2base[suba];	/* get base of LED group */

		for (i = 0; i < (int16_t)(3 + (suba & 1)); i++) {	/* scan LEDs */

			curled = i + baseled;
			ledctl = 0x0003 & (dat1 >> (14 - (i << 1)));

			if (ledctl EQ 1) {			/* on */

				ledstat[curled] = TRUE;
				io_leds = (uint8_t)curled;

			} else if (ledctl EQ 2) {		/* off */

				ledstat[curled] = FALSE;
				io_leds = (uint8_t)(curled | 0x0080);

			} else if (ledctl EQ 3) {		/* toggle */

				if (ledstat[curled]) {	/* on -> off */

					ledstat[curled] = FALSE;
					io_leds = (uint8_t)(curled | 0x0080);

				} else {			/* off -> on */

					ledstat[curled] = TRUE;
					io_leds = (uint8_t)curled;
				}
			}
		}

		break;

	case PA_SLIN:		/* sequence line */

		seqline[suba] = (int16_t)dat1;
		seqdupd |= ((uint16_t)1 << suba);
		break;

	case PA_SCTL:		/* sequence control */


		if (dat2) {	/* start */

			seqflag[suba] |= (SQF_RUN|SQF_CLK);
			seqtime[suba]  = seqtab[seqline[suba]].seqtime;

#if	DEBUGPA
	if (debugsw AND debugpa)
		printf("dopatch($%08lX):  SLIN %02u %03u %5u RUN\n",
			pp, suba, seqline[suba], seqtime[suba]);
#endif

		} else {	/* stop */

			seqflag[suba] = 0;
			seqtime[suba] = 0;

#if	DEBUGPA
	if (debugsw AND debugpa)
		printf("dopatch($%08lX):  SLIN %02u %03u STOP\n",
			pp, suba, seqline[suba]);
#endif

		}

		seqdupd |= ((uint16_t)1 << suba);
		break;

	case PA_TUNE:		/* tuning table */

		gettun((int16_t)dat1);
		break;

	case PA_RSET:		/* register set */

		sregval[suba] = dat1 ? sregval[dat2] : dat2;
		seqdupd |= ((uint16_t)1 << suba);
		break;

	case PA_RADD:		/* regsister add */

		temp = (int16_t)(sregval[suba] + (dat1 ? sregval[dat2] : dat2));

		if (temp > 99)
			temp = 99;
		else if (temp < 0)
			temp = 0;

		sregval[suba] = (uint16_t)temp;
		seqdupd |= ((uint16_t)1 << suba);
		break;

	case PA_INST:		/* instrument select */

		if (vgt) {	/* group */

			ins2grp[vgn] = (ins2grp[vgn] & (int16_t)0xFF00) | (int16_t)dat1;
			setv2gi(vgn);

		} else {	/* voice */

			if (curvce EQ vgn)
				curinst = (int16_t)dat1;

			s_inst[vgn] = (int16_t)dat1;
			execins(vgn, (int16_t)dat1, 1);
		}

		break;

	case PA_OSC:		/* oscillator control */

		if (vgt) {		/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pdoctl(i, osc, (int16_t)dat1, (int16_t)dat2);

		} else {		/* voice */

			pdoctl(vgn, osc, (int16_t)dat1, (int16_t)dat2);
		}

		break;

	case PA_WAVA:		/* waveshape A select */

		if (vgt) {		/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pdows(0, i, (int16_t)dat1);

		} else {		/* voice */

			pdows(0, vgn, (int16_t)dat1);
		}

		break;

	case PA_WAVB:		/* waveshape B select */

		if (vgt) {		/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pdows(1, i, (int16_t)dat1);

		} else {		/* voice */

			pdows(1, vgn, (int16_t)dat1);
		}

		break;

	case PA_CNFG:		/* configuration select */

		if (vgt) {

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn)) {

					vbufs[i].idhcfg = (int8_t)dat1;
					dosync(i);
				}
		} else {

			vbufs[vgn].idhcfg = (int8_t)dat1;
			dosync(vgn);
		}

		break;

	case PA_LEVL:		/* level */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, 2, dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, 2, dat1, dat2);
		}

		break;

	case PA_INDX:		/* index */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, ind2par[osc], dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, ind2par[osc], dat1, dat2);
		}

		break;

	case PA_FREQ:		/* frequency */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, frq2par[osc], dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, frq2par[osc], dat1, dat2);
		}

		break;

	case PA_FILT:		/* filter frequency */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, 10, dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, 10, dat1, dat2);
		}

		break;

	case PA_FILQ:		/* filter resonance */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, 6, dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, 6, dat1, dat2);
		}

		break;

	case PA_LOCN:		/* location */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, 4, dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, 4, dat1, dat2);
		}

		break;

	case PA_DYNM:		/* dynamics */

		if (vgt) {	/* group */

			for (i = 0; i < 12; i++)
				if (vce2grp[i] EQ (1 + vgn))
					pfpufn(i, 8, dat1, dat2);

		} else {	/* voice */

			pfpufn(vgn, 8, dat1, dat2);
		}

		break;

	case PA_AUX:		/* auxiliary control */

		pfpufn(9, 0, dat1, dat2);
		break;

	case PA_RATE:		/* phase shifter rate */

		pfpufn(2, 0, dat1, dat2);
		break;

	case PA_INTN:		/* phase shifter intensity */

		pfpufn(1, 0, dat1, dat2);
		break;

	case PA_DPTH:		/* phase shifter depth */

		pfpufn(3, 0, dat1, dat2);
		break;

	case PA_VOUT:		/* control voltage output */

		pfpufn(cv2vce[suba], 0, dat1, dat2);
		break;

	}
}

