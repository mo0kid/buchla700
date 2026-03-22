/*
   =============================================================================
	fsize.c -- file size and disk capacity functions
	Version 1 -- 1987-10-29 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	fsize() -- return the current size of an open stream file

		how = 0: in bytes, 1: in allocated clusters
   =============================================================================
*/

int32_t fsize(FILE *fp, int16_t how)
{
	register struct channel *chp;
	register struct fcb *fcp;

	if (fp EQ (FILE *)0L)
		return(-1L);

	if (fp->_flags & _BUSY) {

		chp = &chantab[fp->_unit];

		if (chp->c_close NE _filecl)
			return(-1L);

		fcp = chp->c_arg;

		if (fcp->modefl & FC_OPN) {

			if (how)
				return(fcp->asects);
			else
				return(fcp->curlen);

		} else
			return(-1L);

	} else
		return(-1L);
}

/*
   =============================================================================
	dspace() -- return disk capacity or usage

		which = 0: capcity, 1: usage
   =============================================================================
*/

int16_t dspace(int16_t which)
{
	register int16_t maxcl, clcount, nc;

	if (_opnvol())
		return(-1L);

	maxcl = _thebpb->numcl;

	if (which) {

		clcount = 0;

		for (nc = 2; nc < maxcl; nc++)
			if (0 EQ _gtcl12(_thefat, nc))
				++clcount;

		return(clcount);

	} else {

		return(maxcl);
	}
}

