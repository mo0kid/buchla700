/*
   =============================================================================
	scadv.c -- MIDAS-VII -- move score 1 frame forward or backward
	Version 48 -- 1989-12-19 -- D.N. Lynx Crowe
   =============================================================================
*/

#undef	DEBUGGER	/* define to enable debug trace */

#undef	TRACEIT		/* define to enable step by step trace */

#include "ram.h"

#ifdef	TRACEIT
short	tracesw;
#endif

/* initialized stuff */

int16_t		nbmoff = 3;
int16_t		wrdoff = 3;

uint16_t	nbmasks[4] = {		/* nybble masks */

	0x000F,
	0x00F0,
	0x0F00,
	0xF000
};

/*
   =============================================================================
	sc_adv() -- advance the score display 1 frame

	Note that the score display actually only moves every other frame,
	due to VSDD limitations, but it moves 2 pixels.
   =============================================================================
*/

void sc_adv(void)
{
	uint16_t masksl, maskpx;
	int16_t i;
	uint16_t sword;
	int32_t tl;
	volatile uint16_t *optr, *pptr, *fsl;
	volatile uint16_t *qptr;
	uint16_t pscrl;

	DB_ENTR("sc_adv");

#ifdef TRACEIT
	if (tracesw) {

		printf("scadv ----------------------\n");
		SEctrl();
	}

	if (tracesw & 0x0001) {

		SCslice();
	}
#endif

	if (v_regs[5] & 0x0180)		/* make sure we're in bank 0 */
		vbank(0);

	tl = 128L;			/* setup VSDD line increment */

	DB_CMNT("sc_adv - center ucslice");

	ucslice();			/* update the center slice */


	/* see if it's time to update VRAM from edges */

	if ((ndisp EQ 2) AND (soffset EQ ((sd EQ D_BAK) ? 0 : 3))) {

		if (sd EQ D_BAK) {	/* set source and target pointers */

			fsl  = prvsl;
			optr = saddr + wrdoff;

		} else {

			fsl  = nxtsl;
			optr = saddr + tl;
		}

		if (sbase > 28544) {		/* possible double update ? */

			/* set target pointer #2 */

			pptr = saddr - ((sd EQ D_BAK) ? 28542L : 28545L);

			if (sbase < 28672) {	/* double update - right and left */

				DB_CMNT("sc_adv - double update");

				for (i = 224; i--; ) {

					sword = *fsl++;	/* copy a slice word to the VSDD */
					*optr = sword;
					*pptr = sword;
					optr += tl;	/* advance the VSDD pointers */
					pptr += tl;
				}

			} else {		/* single update - left */

				DB_CMNT("sc_adv - left update");

				for (i = 224; i--; ) {

					*pptr = *fsl++;		/* copy a slice word to the VSDD */
					pptr += tl;		/* advance the VSDD pointers */
				}
			}

		} else {			/* single update - right */

				DB_CMNT("sc_adv - right update");

			for (i = 224; i--; ) {

				*optr = *fsl++;		/* copy a slice word to the VSDD */
				optr += tl;		/* advance the VSDD pointers */
			}
		}

		optr  = nxtsl;	/* refresh update slices from constant slice */
		pptr  = cursl;
		qptr  = prvsl;
		fsl   = consl;

		for (i = 224; i--; ) {

			sword = *fsl++;
			*optr++ = sword;
			*pptr++ = sword;
			*qptr++ = sword;
		}

		DB_CMNT("sc_adv - slices refreshed");
	}


	if (sd EQ D_FWD) {

		if (++soffset > 3) {			/* advance scroll counter */

			soffset = 0;			/* roll over scroll counter */
			++saddr;			/* advance VRAM address */

			if (++sbase > 28672) {		/* advance scroll offset */

				saddr = v_score;	/* roll over VRAM address */
				sbase = 0;		/* roll over scroll offset */
			}
		}

	} else {

		if (--soffset < 0) {			/* decrement scroll counter */

			soffset = 3;			/* roll over scroll counter */
			--saddr;			/* advance VRAM address */

			if (--sbase < 0) {		/* advance scroll offset */

				saddr = v_score + 28672L;	/* roll over VRAM address */
				sbase = 28672;		/* roll over scroll offset */
			}
		}
	}

	pscrl = scrl;			/* save old scrl value */

	DB_CMNT("sc_adv - edge uslice");

	maskpx = nbmasks[soffset];	/* setup source pixel mask */
	masksl = ~maskpx;		/* setup target pixel mask */

	uslice(prvsl, maskpx, masksl, gdstbp);		/* update left edge */

	uslice(nxtsl, maskpx, masksl, gdstbn);		/* update right edge */

	scrl  = 0x8000 | (((uint16_t)soffset >> 1) ^ 0x0001);

	/* only update VSDD registers if score is up and scrl changed */

	if ((ndisp EQ 2) AND (scrl NE pscrl)) {

		sword = (uint16_t)((int32_t)saddr >> 1);

		setipl(VID_DI);		/* disable video interrupts */

		vi_scrl = scrl;
		vi_sadr = sword;

		setipl(VID_EI);		/* enable video interrupts */
	}

	ctrsw = FALSE;

#ifdef TRACEIT
	if (tracesw & 0x0002) {

		SCslice();
	}
#endif

	DB_EXIT("sc_adv");
}

/*
   =============================================================================
	scupd() -- update the center slice without scrolling
   =============================================================================
*/

void scupd(void)
{
	uint16_t masksl, maskpx;
	int16_t i;
	uint16_t sword;
	int32_t tl;
	volatile uint16_t *optr, *qptr, *fsl;
	int16_t soff;

	DB_ENTR("scupd");

	if (v_regs[5] & 0x0180)			/* make sure we're in bank 0 */
		vbank(0);

	soff   = (nbmoff + soffset) & 3;	/* calculate offset to use */
	maskpx = nbmasks[(2 + soff) & 3];	/* setup source pixel mask */
	masksl = ~maskpx;			/* setup target pixel mask */
	tl = 128L;				/* setup VSDD line increment */

	/* update VRAM, if it's time */

	if (cslice(cursl, maskpx, masksl, gdstbc) AND (ndisp EQ 2)) {

		DB_CMNT("scupd - center write ...");

		fsl  = cursl;
		optr = saddr + ((soff > 1) ? 64L : 63L);
		qptr = consl;

		for (i = 224; i--; ) {

			if ((sword = maskpx & *fsl))
				*optr = (*optr & masksl) | sword;

			*fsl++ = *qptr++;	/* clean up the slice */
			optr += tl;
		}

		DB_CMNT("scupd - center written");
	}

	ctrsw = FALSE;
}

