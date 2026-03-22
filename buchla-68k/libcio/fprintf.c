/*
   =============================================================================
	fprintf.c -- fprintf function
	Version 2 -- 1987-06-26 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

static FILE *Stream;

static int16_t fpsub(int16_t c);

int16_t fprintf(FILE *stream, int8_t *fmt, ...)
{
	register int16_t count;
	va_list aptr;

	Stream = stream;
	va_start(aptr, fmt);
	count = dofmt_(fpsub, fmt, aptr);
	va_end(aptr);
	return(count);
}

static int16_t fpsub(int16_t c)
{
	return(aputc(c, Stream));
}
