/*
   =============================================================================
	etidin.c -- MIDAS instrument editor - instrument number field handlers
	Version 28 -- 1988-09-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	DIN_OFF		14

/*
   =============================================================================
	et_idin() -- load the edit buffer
   =============================================================================
*/

int16_t et_idin(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", curinst);
	ebflag = TRUE;

	return(SUCCESS);
}


/*
   =============================================================================
	ef_idin() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_idin(int16_t n)
{
	register int16_t i, tmpval, j;

	(void)n;

	if (idcfsw) {		/* 'E' with menu up */

		if (vtcrow EQ 22) {		/* fetch or escape */

			if (vtccol LT 35) {

				newinst(idintmp);
				execins(curvce, curinst, 1);

				if (NOT editsw) {

					if ((i = vce2grp[curvce]) > 0) {

						for (j =0; j < 12; j++)
							if (vce2grp[j] EQ i)
								execins(j, curinst, 1);
					}
				}
			}

			objclr(TTCPRI);
			idvlblc();
			idcfsw = FALSE;
			submenu = FALSE;

			if (vtccol LT 35) {

				allwins();

			} else {

				dswin(22);
				dswin(19);
			}

		} else if (vtcrow EQ 23) {	/* copy to library */

			if (idintmp) {

				memcpyw(&idefs[idintmp], &vbufs[curvce],
					(sizeof (struct instdef) / 2));

				curinst = idintmp;
				instmod[curvce] = FALSE;
			}

			objclr(TTCPRI);
			idvlblc();
			idcfsw = FALSE;
			submenu = FALSE;
			dswin(22);
			dswin(19);

			if (idintmp EQ 0)
				return(FAILURE);

		} else
			return(FAILURE);

		return(SUCCESS);

	} else {		/* 'E' with menu not up */

		ebuf[2] = '\0';			/* terminate the string in ebuf */
		ebflag = FALSE;

		tmpval = 0;

		for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
			tmpval = (tmpval * 10) + (ebuf[i] - '0');

		if (tmpval GE NINST)		/* check the range */
			return(FAILURE);

		idintmp = tmpval;		/* save selected value */
		idcpfch();			/* put up copy/fetch menu */
		dswin(22);
		SetPri(TTCURS, TTCPRI);
		ttcpos(22, 17);
		idcfsw = TRUE;
		submenu = TRUE;
		return(SUCCESS);
	}
}

/*
   =============================================================================
	rd_idin() -- (re)display the field
   =============================================================================
*/

int16_t rd_idin(int16_t n)
{
	if (idcfsw)			/* don't display if copy/fetch is up */
		return(FAILURE);

	/* convert to ASCII */

	sprintf(dspbuf, "%02d", curinst);

	vbank(0);			/* display the value */

	vcputsv(instob, 64, (instmod[curvce] ? ID_CHGD : idbox[n][4]),
		idbox[n][5], idbox[n][6], idbox[n][7] + DIN_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_idin() -- handle new data entry
   =============================================================================
*/

int16_t nd_idin(int16_t n, int16_t k)
{
	register int16_t ec;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');
	ebuf[2] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);

	vcputsv(instob, 64, ID_ENTRY, idbox[n][5],
		idbox[n][6], stccol, dspbuf, 14);

	advicur();

	return(SUCCESS);
}


