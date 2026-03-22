/*
   ============================================================================
	ungetc.c -- 'unget' a character
	Version 2 -- 1987-06-26 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int16_t ungetc(int16_t c, FILE *ptr)
{
	if ((c EQ EOF) OR (ptr->_bp LE ptr->_buff))
		return(EOF);

	*--ptr->_bp = (int8_t)c;

	return(c);
}

