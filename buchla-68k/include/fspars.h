/*
   =============================================================================
	fspars.h -- File system parameters
	Version 4 -- 1987-12-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#pragma once

#include "stdint.h"

#define	TBUFFER		1	/* non-zero to enable track buffering */

#define	NSTREAMS	11	/* maximum number of file streams */
#define MAXCHAN		11	/* maximum number of I/O channel fd's */
#define MAXDFILE	8	/* maximum number of open DISK files */

#define	BUFSIZL	256		/* buffer length -- longs */
#define BUFSIZ	(sizeof (int32_t) * BUFSIZL)
				/* buffer length -- chars */

#define	BPSEC		512	/* bytes per disk sector */
#define	FILESHFT	9	/* file shift */

#define	MAXFAT		7	/* maximum number of fat sectors */
#define	MAXDIRNT	224	/* maximum number of directory entries */

typedef	void	*io_arg;	/* must be big enough to contain a pointer */
