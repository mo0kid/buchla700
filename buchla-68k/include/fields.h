/*
   =============================================================================
	fields.h -- field definition header
	Version 6 -- 1987-09-25 -- D.N. Lynx Crowe
   =============================================================================
*/

#pragma once

#include "stdint.h"

#define	MAXEBUF	80		/* maximum length of data in the edit buffer */

struct fet {			/* field definition structure */

	int16_t	frow;		/* row the field is in */
	int16_t	flcol;		/* leftmost column of field */
	int16_t	frcol;		/* rightmost column of field */
	int16_t	ftags;		/* field tags / parameters (used variously) */
	int16_t	(*ebto)(int16_t n);
				/* edit buffer 'to' (setup) function */
	int16_t	(*ebfrom)(int16_t n);
				/* edit buffer 'from' (parse) function */
	int16_t	(*redisp)(int16_t nn);
				/* field (re)display function */
	int16_t	(*datain)(int16_t nn, int16_t k);
				/* data entry function */
};

struct	selbox	{		/* selection box structure */

	int16_t	sbxmin;		/* minimum x - left edge of box */
	int16_t	sbymin;		/* minimum y - top edge of box */
	int16_t	sbxmax;		/* maximum x - right edge of box */
	int16_t	sbymax;		/* maximum y - bottom edge of box */
	int16_t	sbarg;		/* select box argument */
	int16_t	(*boxhit)(int16_t n);
				/* box-hit function */
};
