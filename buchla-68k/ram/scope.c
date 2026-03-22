/*
   =============================================================================
	scope.c -- MIDAS-VII diagnostic scope functions
	Version 6 -- 1988-10-12 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	SCOPEOLD	0x0014		/* scope old text attribute */
#define	SCOPENEW	0x0054		/* scope new text attribute */

int16_t		scopec;			/* scope col position */
int16_t		scopef;			/* scope control flag */
int16_t		scoper;			/* scope row position */

int16_t		scopev;			/* last scope value */

int8_t		scopebf[65];		/* scope display buffer */

volatile	uint16_t	*scopeob;		/* scope display object */

struct curpak dt_flds = {

	stdctp2,		/* curtype */
	nokey,			/* premove */
	nokey,			/* pstmove */
	nokey,			/* cx_key */
	nokey,			/* cy_key */
	nokey,			/* cx_upd */
	nokey,			/* cy_upd */
	nokey,			/* xy_up */
	nokey,			/* xy_dn */
	nokey,			/* x_key */
	scptogl,		/* e_key */
	stdmkey,		/* m_key */
	nodkey,			/* d_key */
	nonf,			/* not_fld */
	(struct fet *)NULL,	/* curfet */
	(struct selbox *)NULL,	/* csbp */
	crate1,			/* cratex */
	crate1,			/* cratey */
	CT_GRAF,		/* cmtype */
	0,			/* cxval */
	0			/* cyval */
};

/*
   =============================================================================
	scope() -- display a value in binary on the crt
   =============================================================================
*/

void scope(int16_t val)
{
	register int16_t i;
	register int8_t *bp = scopebf;

	if ((ndisp NE 11) OR (NOT scopef))
		return;

	vputs(scopeob, scoper++, scopec, scopebf, SCOPEOLD);

	*bp++ = ' ';

	if (scoper > 24) {

		scoper = 0;
		scopec += 12;

		if (scopec GE 60)
			scopec = 0;
	}

	scopev = val;

	for (i = 0; i < 4; i++)
		if (val & (0x0080 >> i))
			*bp++ = '1';
		else
			*bp++ = '0';

	*bp++ = ' ';

	for (i = 4; i < 8; i++)
		if (val & (0x0080 >> i))
			*bp++ = '1';
		else
			*bp++ = '0';

	*bp++ = ' ';
	*bp = 0;

	vputs(scopeob, scoper, scopec, scopebf, SCOPENEW);
}

/*
   =============================================================================
	scptogl() -- toggle "scope" status
   =============================================================================
*/

void scptogl(void)
{
	if (NOT astat)
		return;

	scopef = NOT scopef;
}

/*
   =============================================================================
	scopeon() -- put up the "scope" display
   =============================================================================
*/

void scopeon(void)
{
	scopeob = &v_score[0];

	curset(&dt_flds);

	scopec  = 0;
	scopef  = TRUE;
	scoper  = 0;
	scopev  = 0;

	strcpy(scopebf, " ???? ???? ");

	dswap();

	vbank(0);

	memsetw(scopeob, 0, 32767);
	memsetw(scopeob+32767L, 0, 12033);

	SetObj(0, 1, 0, scopeob, 512, 350, 0, 0, CHR3, -1);
	vsndpal(scorpal);

	SetPri(0, 15);
}

