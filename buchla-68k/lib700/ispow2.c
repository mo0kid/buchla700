/*
   =============================================================================
	ispow2.c -- fast test to see if X is a power of 2
	Version 2 -- 1989-01-24 -- D.N. Lynx Crowe

	Returns:

		TRUE if X is a power of 2,
		FALSE otherwise.
   =============================================================================
*/

#include "ram.h"

int16_t ispow2(int32_t x)
{
	register int16_t i;
	register int32_t k;

	k = 0x00000001L;		/* setup the bit mask in k */

	for (i = 32; i--; ) {		/* check each bit in x ... */

		if ((x & k) NE 0L) {	/* ... for the 1st 1 and ... */

			if ((x & ~k) NE 0L)	/* ... if there are others ... */
				return(FALSE);	/* ... it's not a power of 2 */
			else			/* ... otherwise .. */
				return(TRUE);	/* ... it is a power of 2 */
		}

		k = k << 1;		/* examine the next position */
	}

	return(FALSE);			/* no bits on isn't a power of 2 */
}

