/*
   =============================================================================
	dformat.c -- format a disk for the Buchla 700
	Version 2 -- 1988-03-28 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	DF_FREC		6		/* first sector of primary FAT */

#define	DF_FSIZ		5		/* FAT size */
#define	DF_DSIZ		7		/* directory size */

/*
   =============================================================================
	dformat() -- format a disk for the Bucla 700

	entry:		dt = zero for single sided disk,
			     non-zero for double sided disk

	returns:	SUCCESS or FAILURE and:

			defect  = formatting error code:

				0	no errors
				1	unable to format 1st side
				2	unable to format 2nd side
				3	unable to write boot sector
				4	unable to write primary FAT
				5	unable to write secondary FAT
				6	unable to write directory

			dferror = BIOS or XBIOS error code if an error occurred
   =============================================================================
*/

int16_t dformat(int16_t dt)
{
	register int16_t trk;

	if (dt) {	/* setup for double sided disk */

		dftype  = 3;	/* 80 tracks, double sided */
		dfsides = 2;	/* 2 sides */

	} else {	/* setup for single sided disk */

		dftype  = 2;	/* 80 tracks, single sided */
		dfsides = 1;	/* 1 side */
	}

	/* format each side of each track */

	for (trk = 0; trk < 80; trk++) {

		if ((dferror = (int16_t)XBIOS(X_FORMAT, dfbuf, 0L, 0, 9,
		    trk, 0, 1, 0x87654321L, 0xE5E5))) {

			defect = 1;	/* unable to format 1st side */
			return(FAILURE);
		}

		if (dfsides EQ 2) {	/* format second side */

			if ((dferror = (int16_t)XBIOS(X_FORMAT, dfbuf, 0L, 0, 9,
			    trk, 1, 1, 0x87654321L, 0xE5E5))) {

				defect = 2;	/* unable to format 2nd side */
				return(FAILURE);
			}
		}
	}

	/* create boot sector */

	memsetw(dfbuf, 0, 4096);
	XBIOS(X_PRBOOT, dfbuf, 0x01000000L, dftype, 0);

	/* write boot sector to disk */

	if ((dferror = (int16_t)XBIOS(X_FLOPWR, dfbuf, 0L, 0, 1, 0, 0, 1))) {

		defect = 3;	/* unable to write boot sector */
		return(FAILURE);
	}

	/* clear the FATs */

	memsetw(dfbuf, 0, 4096);

	if (dfsides EQ 2) {

		dfbuf[0] = 0xFDFF;
		dfbuf[1] = 0xFF00;

	} else {

		dfbuf[0] = 0xFCFF;
		dfbuf[1] = 0xFF00;
	}

	if ((dferror = (int16_t)BIOS(B_RDWR, 3, dfbuf,
	    DF_FSIZ, DF_FREC, 0))) {

		defect = 4;	/* unable to write primary FAT */
		return(FAILURE);
	}

	if ((dferror = (int16_t)BIOS(B_RDWR, 3, dfbuf,
	    DF_FSIZ, DF_FREC-DF_FSIZ, 0))) {

		defect = 5;	/* unable to write secondary FAT */
		return(FAILURE);
	}

	/* clear the directory */

	memsetw(dfbuf, 0, 4096);

	if ((dferror = (int16_t)BIOS(B_RDWR, 3, dfbuf,
	    DF_DSIZ, DF_FREC+DF_FSIZ, 0))) {

		defect = 6;	/* unable to write directory */
		return(FAILURE);
	}

	defect = 0;	/* no errors */
	return(SUCCESS);
}

