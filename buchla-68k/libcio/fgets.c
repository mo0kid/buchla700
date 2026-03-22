/*
   =============================================================================
	fgets.c -- get a string from an ASCII stream file
	Version 2 -- 1987-07-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	EATCHAR	'\n'	/* character to be "eaten" on input */

int16_t agetc(FILE *ptr)
{
	register int16_t c;

top:
	if ((c = getc(ptr)) NE EOF) {

		switch (c &= 0x7F) {

		case 0x1a:		/* {x}DOS EOF */
			--ptr->_bp;
			return(EOF);

		case EATCHAR:		/* CR or LF */
		case 0:			/* NUL */
			goto top;
		}
	}

	return(c);
}

int8_t *gets(int8_t *line)
{
	register int8_t *cp;
	register int16_t i;

	cp = line;

	while ((i = getchar()) NE EOF AND i NE '\n')
		*cp++ = (int8_t)i;

	*cp = 0;	/* terminate the line */

	if ((i EQ EOF) AND (cp EQ line))
		return(NULL);

	return(line);
}

int8_t *fgets(int8_t *s, int16_t n, FILE *fp)
{
	register int16_t c;
	register int8_t *cp;

	c = 0;
	cp = s;

	while (--n > 0 AND (c = agetc(fp)) NE EOF) {

		*cp++ = (int8_t)c;

		if (c EQ '\n')
			break;
	}

	*cp = 0;

	if (c EQ EOF AND cp EQ s)
		return(NULL);

	return(s);
}


