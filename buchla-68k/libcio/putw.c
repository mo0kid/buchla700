/*
   ============================================================================
	putw.c -- put a word onto a stream file
	Version 3 -- 1987-10-15 -- D.N. Lynx Crowe

	WARNING:  This fails if the stream is ASCII.
   ============================================================================
*/

#include "ram.h"

void putw(int32_t w, FILE *stream)
{
	if (putc((int16_t)((w >> 8) & 0xFF), stream) < 0 )
		return;

	putc((int16_t)(w & 0xFF), stream);
}

