/*
   =============================================================================
	fputs.c -- output a string to a stream
	Version 3 -- 1987-07-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

int16_t puts(int8_t *str)
{
	while (*str)
		if (putchar(*str++) EQ EOF)
			return(EOF);

	return(putchar('\n'));
}

int16_t aputc(int16_t c, FILE *ptr)
{
	c &= 127;

	if (c EQ '\n')
		if (putc('\r', ptr) EQ EOF)
			return(EOF);

	return(putc(c, ptr));
}

int16_t fputs(int8_t *s, FILE *fp)
{
	while ( *s )
		if (aputc(*s++, fp) EQ EOF)
			return(EOF);
	return(0);
}

