/*
   =============================================================================
	select.c -- field selection processing
	Version 9 -- 1988-12-13 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

#if	DEBUGIT
short	debugsf = 1;;
#endif

/*
   =============================================================================
	whatbox() -- determine which selection box a hit occured in
   =============================================================================
*/

int16_t whatbox(void)
{
	register struct selbox *sb;

	sb = csbp;
	hitbox = -1;

#if	DEBUGIT
	if (debugsw AND debugsf)
		printf("whatbox():  ENTRY  cxval=%d  cyval=%d  cursbox=%d  csbp=$%lX\n",
			cxval, cyval, cursbox, csbp);
#endif

	if (0L EQ sb)
		return(FALSE);

	while (sb->boxhit) {

		hitbox++;

		if ((cxval GE sb->sbxmin) AND
		    (cxval LE sb->sbxmax) AND
		    (cyval GE sb->sbymin) AND
		    (cyval LE sb->sbymax)) {

			hitcx = cxval;
			hitcy = cyval;
			curboxp = sb;

#if	DEBUGIT
	if (debugsw AND debugsf)
		printf("whatbox():  HIT  hitbox=%d, curboxp=$%lX, sbarg=$%04.4X\n",
			hitbox, curboxp, sb->sbarg);
#endif

			return(TRUE);
		}

		sb++;
	}

#if	DEBUGIT
	if (debugsw AND debugsf)
		printf("whatbox():  FAILED\n");
#endif

	hitbox = -1;
	return(FALSE);
}

/*
   =============================================================================
	select() -- standard item selection processing
   =============================================================================
*/

void select(void)
{
	if (astat) {	/* only when the E key goes down */

#if	DEBUGIT
	if (debugsw AND debugsf)
		printf("select():  ENTRY\n");
#endif

		if (whatbox()) {	/* see if we're in a box */

#if	DEBUGIT
	if (debugsw AND debugsf)
		printf("select():  HIT  hitbox = %d  curboxp $%lX\n",
			hitbox, curboxp);
#endif

			(*curboxp->boxhit)(curboxp->sbarg);	/* process it */
			cursbox = hitbox;

		} else {

#if	DEBUGIT
	if (debugsw AND debugsf)
		printf("select():  FAILED\n");
#endif

		}
	}
}

