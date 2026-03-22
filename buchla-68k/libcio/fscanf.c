/*
   =============================================================================
	fscanf.c -- scan a stream file for input for the portable C I/O Library
	Version 4 -- 1989-01-16 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

static int16_t scnlast;
static FILE *scnfp;

static int16_t gchar(int16_t what)
{
	if (what EQ 0) {

		if (feof(scnfp))
			scnlast = EOF;
		else
			scnlast = agetc(scnfp);
	} else
		scnlast = ungetc(scnlast, scnfp);

	return(scnlast);
}

int16_t scanf(int8_t *fmt, int16_t *args)
{
	scnfp = stdin;
	scnlast = 0;
	return(scanfmt(gchar, fmt, &args));
}

int16_t fscanf(FILE *fp, int8_t *fmt, int16_t *args)
{
	scnfp = fp;
	scnlast = 0;
	return(scanfmt(gchar, fmt, &args));
}

