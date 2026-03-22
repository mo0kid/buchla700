/*
   =============================================================================
	sqread.c -- librarian - read sequence functions
	Version 2 -- 1988-11-17 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	sqioerr() -- put up an I/O error message
   =============================================================================
*/

void sqioerr(void)
{
	int8_t erms[40];

	clrlsel();

	sprintf(erms, "  errno = %d", errno);

	ldermsg("Couldn't read", " the sequence table", erms,
		LD_EMCF, LD_EMCB);
}

/*
   =============================================================================
	sqread() -- read a sequence
   =============================================================================
*/

int16_t sqread(FILE *fp)
{
	int8_t cb;
	int16_t seq;

	ldwmsg(" Busy -- please stand by", (int8_t *)NULL, "  Reading sequences",
		LCFBX10, LCBBX10);

	for (;;) {

		if (rd_ec(fp, &cb, 1L)) {	/* get control byte */

			sqioerr();
			return(FAILURE);
		}

		if (0 EQ cb)			/* zero control byte is end */
			return(SUCCESS);

		if (rd_ec(fp, &seq, 2L)) {	/* get Line number */

			sqioerr();
			return(FAILURE);
		}

		if (cb & 0x08) {		/* get Time */

			if (rd_ec(fp, &seqtab[seq].seqtime, 2L)) {

				sqioerr();
				return(FAILURE);
			}
		}

		if (cb & 0x04) {		/* get Action 1 */

			if (rd_ec(fp, &seqtab[seq].seqact1, 4L)) {

				sqioerr();
				return(FAILURE);
			}
		}

		if (cb & 0x02) {		/* get Action 2 */

			if (rd_ec(fp, &seqtab[seq].seqact2, 4L)) {

				sqioerr();
				return(FAILURE);
			}
		}

		if (cb & 0x01) {		/* get Action 3 */

			if (rd_ec(fp, &seqtab[seq].seqact3, 4L)) {

				sqioerr();
				return(FAILURE);
			}
		}
	}
}

