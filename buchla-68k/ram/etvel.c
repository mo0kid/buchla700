/*
   =============================================================================
	etvel.c -- velocity field handlers
	Version 2 -- 1988-06-13 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_vel() -- load edit buffer
   =============================================================================
*/

int16_t et_vel(int16_t n)
{
	sprintf(ebuf, "%03d", lastvel[n] / 252);

	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_vel() -- parse edit buffer
   =============================================================================
*/

int16_t ef_vel(int16_t n)
{
	register int16_t ival, i;
	register struct s_entry *ep;

	ival = 0;

	for (i = 0; i < 3; i++)
		ival = (ival * 10) + (ebuf[i] - '0');

	ebflag = FALSE;

	if (ival > 127)
		return(FAILURE);

	ival = SM_SCALE(ival);

	if (recsw AND grpstat[n] AND (2 EQ grpmode[n])) {

		lastvel[n] = ival;
		ep = ep_adj(p_cur, 1, t_cur);

		while (t_cur EQ ep->e_time) {

			if ((EV_NBEG EQ (0x007F & ep->e_type)) AND
			    (ep->e_data2 EQ n)) {

				((struct n_entry *)ep)->e_vel = ival;
			}

			ep = ep->e_fwd;
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_vel() -- (re)display the field
   =============================================================================
*/

int16_t rd_vel(int16_t n)
{
	int8_t buf[6];

	sprintf(buf, "%03d", lastvel[n] / 252);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 5, 6 + (n * 5), buf, SDW11ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_vel() -- data entry function
   =============================================================================
*/

int16_t nd_vel(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 5, stccol, k + '0', SDW11DEA);
	advscur();

	return(SUCCESS);
}

