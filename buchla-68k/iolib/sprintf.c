/*
   =============================================================================
	sprintf.c -- sprintf function
	Version 2 -- 1987-06-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

static int8_t	*buff;
static int16_t spsub(int16_t c);

/*
   =============================================================================
	sprintf(str, fmt, args) -- format args into str according to fmt
   =============================================================================
*/

int16_t sprintf(int8_t *str, int8_t *fmt, ...)
{
	register int16_t count;
	va_list aptr;

	buff = str;
	va_start(aptr, fmt);
	count = dofmt_(spsub, fmt, aptr);
	va_end(aptr);
	*buff = '\0';
	return(count);
}

/*
   =============================================================================
	spsub(c) - put c into the output string
   =============================================================================
*/

static int16_t spsub(int16_t c)
{
	return((*buff++ = (int8_t)c) & 0xFF);
}
