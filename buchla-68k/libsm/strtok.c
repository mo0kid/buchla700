/*
   =============================================================================
	strtok.c -- tokenize a string
	Version 1 -- 1987-06-12

	Uses strpbrk and strspn to break 'string' into tokens on
	sequentially subsequent calls.  Returns NULL when no
	non-separator characters remain.
	'subsequent' calls are calls with first argument == NULL.
   =============================================================================
*/

#include "ram.h"

int8_t *strtok(int8_t *string, int8_t *sepset)
{
	register int8_t *p, *q, *r;
	static int8_t *savept;

	/* first or subsequent call ? */

	p = (string == NULL) ? savept : string;

	if (p == 0)              /* return if no tokens remain */
		return(NULL);

	q = p + strspn(p, sepset);      /* skip leading separators */

	if (*q == '\0')          /* return if no tokens remain */
		return(NULL);

	if ((r = strpbrk(q, sepset)) == NULL)    /* move past token */
		savept = 0;     /* indicate this is last token */
	else {
		*r = '\0';
		savept = ++r;
	}

	return(q);
}
