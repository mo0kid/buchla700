/*
   =============================================================================
	unlink.c -- unlink (delete) a file
	Version 6 -- 1987-11-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

/*
   =============================================================================
	unlink(name) -- delete file 'name'.
   =============================================================================
*/

int16_t unlink(int8_t *name)
{
	struct fcb delfcb;

	if (fcbinit(name, &delfcb))
		return(FAILURE);

#if	DEBUGIT
	if (fsdebug) {

		printf("unlink(%s):  deletion FCB created\n", name);
		SnapFCB(&delfcb);
		waitcr();
	}
#endif
	return(DelFile(&delfcb));
}


