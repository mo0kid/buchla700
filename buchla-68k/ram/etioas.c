/*
   =============================================================================
	etioas.c -- line 17 field handlers  (I/O Assignment thru Interpolate)
	Version 12 -- 1988-08-22 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	Assignment table field handlers
   =============================================================================
*/

/*
   =============================================================================
	et_ioas() -- load edit buffer
   =============================================================================
*/

int16_t et_ioas(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02.2d", curasg);
	ebflag = TRUE;

	return(SUCCESS);
}


/*
   =============================================================================
	ef_ioas() -- parse edit buffer
   =============================================================================
*/

int16_t ef_ioas(int16_t n)
{
	register int16_t ival;
	register struct s_entry *ep;

	(void)n;

	ebuf[2] = '\0';
	ival = ((ebuf[0] - '0') * 10) + (ebuf[1] - '0');

	ebflag = FALSE;

	if (ival GE NASGS)
		return(FAILURE);

	getasg(curasg = ival);
	mpcupd();

	if (recsw) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_ASGN, -1, -1))) {

			ep->e_data1 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_ASGN;
			ep->e_data1 = (int8_t)ival;
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_ASGN);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_ioas() -- (re)display the field
   =============================================================================
*/

int16_t rd_ioas(int16_t n)
{
	(void)n;

	sprintf(dspbuf, "%02.2d", curasg);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 1, 11, dspbuf, SDW04ATR);
	return(SUCCESS);
}

/*
   =============================================================================
	nd_ioas() -- data entry function
   =============================================================================
*/

int16_t nd_ioas(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;
	ebuf[ec]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 1, stccol, k + '0', SDW04DEA);
	advscur();
	return(SUCCESS);
}

/*
   =============================================================================
	Tuning field handlers
   =============================================================================
*/

/*
   =============================================================================
	et_tune() -- load edit buffer
   =============================================================================
*/

int16_t et_tune(int16_t n)
{
	(void)n;

	ebuf[0] = (int8_t)('0' + curtun);
	ebuf[1] = '\0';
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_tune() -- parse edit buffer
   =============================================================================
*/

int16_t ef_tune(int16_t n)
{
	register int16_t ival;
	register struct s_entry *ep;

	(void)n;

	ebuf[1] = '\0';
	ival = ebuf[0] - '0';
	ebflag = FALSE;
	gettun(ival);

	if (recsw) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_TUNE, -1, -1))) {

			ep->e_data1 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type = EV_TUNE;
			ep->e_data1 = (int8_t)ival;
			ep->e_time = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_TUNE);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_tune() -- (re)display the field
   =============================================================================
*/

int16_t rd_tune(int16_t n)
{
	(void)n;

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 1, 19, curtun + '0', SDW05ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_tune() -- data entry function
   =============================================================================
*/

int16_t nd_tune(int16_t n, int16_t k)
{
	(void)n;

	ebuf[0]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 1, stccol, k + '0', SDW05DEA);

	return(SUCCESS);
}

/*
   =============================================================================
	Tempo field handlers
   =============================================================================
*/

/*
   =============================================================================
	et_tmpo() -- load edit buffer
   =============================================================================
*/

int16_t et_tmpo(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%03.3d", tmpoval);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_tmpo() -- parse edit buffer
   =============================================================================
*/

int16_t ef_tmpo(int16_t n)
{
	register int16_t ival;
	register struct s_entry *ep;

	(void)n;

	ebuf[3] = '\0';
	ival = ((ebuf[0] - '0') * 100) + ((ebuf[1] - '0') * 10)
	       + (ebuf[2] - '0');

	ebflag = FALSE;

	if ((ival GT 240) OR (ival LT 4))
		return(FAILURE);

	settmpo(ival);

	if (recsw) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_TMPO, -1, -1))) {

			ep->e_data1 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_TMPO;
			ep->e_data1 = (int8_t)ival;
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_TMPO);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_tmpo() -- (re)display the field
   =============================================================================
*/

int16_t rd_tmpo(int16_t n)
{
	(void)n;

	sprintf(dspbuf, "%03.3d", tmpoval);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 1, 27, dspbuf, SDW06ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_tmpo() -- data entry function
   =============================================================================
*/

int16_t nd_tmpo(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;
	ebuf[ec]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 1, stccol, k + '0', SDW06DEA);
	advscur();

	return(SUCCESS);
}

/*
   =============================================================================
	Interpolate field handlers
   =============================================================================
*/

/*
   =============================================================================
	et_intp() -- load edit buffer
   =============================================================================
*/

int16_t et_intp(int16_t n)
{
	register int16_t th, tl;
	register int32_t tt, sc, sf;

	(void)n;

	sc = 1000L;
	sf = 100L;
	tt = fromfpu(curintp);
	th = (int16_t)(tt / sc);
	tl = (int16_t)((tt - (th * sc)) / sf);

	sprintf(ebuf, "%02d.%d", th, tl);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_intp() -- parse edit buffer
   =============================================================================
*/

int16_t ef_intp(int16_t n)
{
	register int16_t i;
	register uint16_t tmpval;
	register struct s_entry *ep;

	(void)n;

	ebuf[2] = '.';			/* add implied decimal point */
	ebuf[4] = '\0';			/* terminate the string in ebuf */
	ebflag  = FALSE;
	tmpval  = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (uint16_t)(ebuf[i] - '0');

	tmpval = ((tmpval * 10) + (uint16_t)(ebuf[3] - '0')) * 100;

	if (tmpval > (uint16_t)64900)
		return(FAILURE);

	if (tmpval EQ 0)
		tmpval = 1;

	curintp = tofpu(tmpval);

	if (recsw) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_INTP, -1, -1))) {

			ep->e_data1 = (int8_t)(curintp >> 8);
			ep->e_data2 = (int8_t)(0x00FF & curintp);

		} else if (E_NULL NE (ep = e_alc(E_SIZE3))) {

			ep->e_type  = EV_INTP;
			ep->e_time  = t_cur;
			ep->e_data1 = (int8_t)(curintp >> 8);
			ep->e_data2 = (int8_t)(0x00FF & curintp);
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_INTP);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_intp() -- (re)display the field
   =============================================================================
*/

int16_t rd_intp(int16_t n)
{
	register int16_t th, tl;
	register int32_t tt, sc, sf;

	(void)n;

	sc = 1000L;
	sf = 100L;
	tt = fromfpu(curintp);
	th = (int16_t)(tt / sc);
	tl = (int16_t)((tt - (th * sc)) / sf);

	sprintf(dspbuf, "%02d.%d", th, tl);	/* convert to ASCII */

	vbank(0);			/* display the value */

	vputs(obj8, 1, 35, dspbuf, SDW07ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_intp() -- data entry function
   =============================================================================
*/

int16_t nd_intp(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */

	if (ec EQ 2)
		return(FAILURE);

	if ((ec EQ 0) AND (k > 6))
		return(FAILURE);

	if ((ec EQ 1) AND (ebuf[0] EQ '6') AND (k > 4))
		return(FAILURE);

	ebuf[ec] = (int8_t)(k + '0');
	ebuf[2] = '.';
	ebuf[4] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);

	vputs(obj8, 1, stccol, dspbuf, SDW07DEA);

	advscur();

	if (stccol EQ 37)
		advscur();

	return(SUCCESS);
}

