/*
   =============================================================================
	dcopy.c -- copy MIDAS-VII to disk
	Version 3 -- 1988-09-01 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	PROGID	"midas.abs"		/* MIDAS-VII program file name */

/*
*/

/*
   =============================================================================
	dcopy() -- copy MIDAS-VII to disk
   =============================================================================
*/

int16_t dcopy(void)
{
	register FILE *fp;
	register uint8_t *from;
	register int32_t wrtlen, loadlen, bsslen, txtlen;

	defect  = 0;				/* reset error word */

	txtlen  = (int32_t)&etext - (int32_t)&Lo_RAM;	/* calculate text length */
	bsslen  = (int32_t)&end   - (int32_t)&edata;	/* calculate BSS length */

	loadlen = (int32_t)&edata - (int32_t)&Lo_RAM;	/* calculate write length */

	/* create the object file header */

	mphead.F_Magic  = F_R_C;		/* magic = contiguous file */
	mphead.F_Text   = txtlen;		/* text length */
	mphead.F_Data   = p_dlen;		/* data length */
	mphead.F_BSS    = bsslen;		/* BSS length */
	mphead.F_Symtab = 0L;			/* symbol table length */
	mphead.F_Res1   = 0L;			/* reserved area #1 */
	mphead.F_Res2   = (int32_t)&Lo_RAM;	/* text base */
	mphead.F_Res3   = (int16_t)0xFFFF;	/* flag word */

	/* ***** initialize for a (possibly) new disk here ***** */

	/* open MIDAS-VII object file for writing */

	preio();	/* kill the LCD backlight */

	if ((FILE *)NULL EQ (fp = fopenb(PROGID, "w"))) {

		defect = 1;		/* couldn't open file */
		postio();		/* restore LCD backlight */
		return(FAILURE);
	}


	/* write program header to disk */

	from = (uint8_t *)&mphead;

	for (wrtlen = sizeof mphead; wrtlen--; )
		if (EOF EQ putc(*from++, fp)) {

			defect = 2;	/* couldn't write program header */
			fclose(fp);
			postio();	/* restore LCD backlight */
			return(FAILURE);
		}

	/* write MIDAS-VII to disk */

	from = (uint8_t *)&Lo_RAM;

	for (wrtlen = loadlen; wrtlen--; )
		if (EOF EQ putc(*from++, fp)) {

			defect = 3;	/* couldn't write program */
			fclose(fp);
			postio();	/* restore LCD backlight */
			return(FAILURE);
		}

	/* flush and close file */

	fflush(fp);
	fclose(fp);
	postio();	/* restore LCD backlight */
	return(SUCCESS);
}

