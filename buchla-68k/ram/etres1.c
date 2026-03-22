/*
   =============================================================================
	etres1.c -- analog variable field handlers
	Version 16 -- 1988-06-28 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_res1() -- load edit buffer
   =============================================================================
*/

int16_t et_res1(int16_t n)
{
	ebuf[0] = (int8_t)anrs[n][abs(angroup)-1];
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_res1() -- parse edit buffer
   =============================================================================
*/

int16_t ef_res1(int16_t n)
{
	register int16_t ival, grp, vg;
	register struct s_entry *ep;

	ebflag = FALSE;
	grp = abs(angroup)-1;
	ival = ebuf[0] & 0x00FF;

	if ((ival < 3) OR (ival > 8))
		return(FAILURE);

	anrs[n][grp] = ival;

	if (recsw AND grpstat[grp] AND
	    (2 EQ (ancmsw ? varmode[n][grp] : grpmode[grp]))) {

		vg = ((n << 4) | grp);

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_ANRS, vg, -1))) {

			ep->e_data2 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_ANRS;
			ep->e_data1 = (int8_t)vg;
			ep->e_data2 = (int8_t)ival;
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_ANRS);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_res1() -- (re)display the field
   =============================================================================
*/

int16_t rd_res1(int16_t n)
{
	register int16_t grp, chr;

	grp = abs(angroup) - 1;

	chr = anrs[n][grp] + '0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 7, 6 + (n * 9), chr, SDW12ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_res1() -- data entry function
   =============================================================================
*/

int16_t nd_res1(int16_t n, int16_t k)
{
	(void)n;

	ebuf[0] = (int8_t)k;

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 7, stccol, k + '0', SDW12DEA);

	return(SUCCESS);
}

/*
   =============================================================================
	et_aval() -- load edit buffer
   =============================================================================
*/

int16_t et_aval(int16_t n)
{
	register int16_t val, grp, gs;
	int16_t val1, val2;

	grp = abs(angroup) - 1;
	gs = (grp << 4) | var2src[n];
	val = (valents[gs].val) >> 5;

	if (val < 0 ) {

		ebuf[0] = 8;
		val = -val;

	} else {

		ebuf[0] = 9;
	}

	val1 = val / 100;
	ebuf[4] = (int8_t)((val - (val1 * 100)) / 10);
	val2 = val1 / 10;
	ebuf[2] = (int8_t)(val1 - (val2 * 10));
	ebuf[1] = (int8_t)val2;

	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_res1() -- parse edit buffer
   =============================================================================
*/

int16_t ef_aval(int16_t n)
{
	register int16_t val, grp, src, vg;
	register struct s_entry *ep;

	ebflag = FALSE;
	grp = abs(angroup) - 1;
	src = var2src[n];
	val = ((ebuf[1] * 100) + (ebuf[2] * 10) + ebuf[4]) * 10;

	if (val > 1000)
		return(FAILURE);

	if (ebuf[0] EQ 8)
		val = -val;

	val = val << 5;

	setsv(grp, src, val);

	if (recsw AND grpstat[grp] AND
	    (2 EQ (ancmsw ? varmode[n][grp] : grpmode[grp]))) {

		vg =  (n << 4) | grp;

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_ANVL, vg, -1))) {

			ep->e_dn = (struct s_entry *)((int32_t)val << 16);

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_ANVL;
			ep->e_data1 = (int8_t)vg;
			ep->e_dn    = (struct s_entry *)((int32_t)val << 16);
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_aval() -- (re)display the field
   =============================================================================
*/

int16_t rd_aval(int16_t n)
{
	register int16_t grp, val, gs;
	int16_t val1, val2;
	int8_t	buf[6];

	grp = abs(angroup) - 1;
	gs = (grp << 4) | var2src[n];
	val = (valents[gs].val) >> 5;

	if (val < 0) {

		buf[0] = '-';
		val = -val;

	} else {

		buf[0] = '+';
	}

	val1 = val / 100;
	buf[4] = (int8_t)('0' + ((val - (val1 * 100)) / 10));
	val2 = val1 / 10;
	buf[2] = (int8_t)('0' + (val1 - (val2 * 10)));
	buf[1] = (int8_t)('0' + val2);
	buf[3] = '.';
	buf[5] = '\0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 7, 8 + (n * 9), buf, SDW12ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_aval() -- data entry function
   =============================================================================
*/

int16_t nd_aval(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;

	if (ec EQ 3)
		return(FAILURE);

	ebuf[ec] = (int8_t)k;

	if (ec EQ 0)
		k = (k EQ 8) ? '-' : '+';
	else
		k += '0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 7, stccol, k, SDW12DEA);

	if (ec EQ 4)
		return(SUCCESS);

	advscur();

	if (ec EQ 2)
		advscur();

	return(SUCCESS);
}

/*
   =============================================================================
	et_agrp() -- load edit buffer
   =============================================================================
*/

int16_t et_agrp(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02.2d", abs(angroup));
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_agrp() -- parse edit buffer
   =============================================================================
*/

int16_t ef_agrp(int16_t n)
{
	register int16_t ival;

	(void)n;

	ebflag = FALSE;
	ival = (10 * (ebuf[0] - '0')) + (ebuf[1] - '0');

	if ((ival >12) OR (ival < 1))
		return(FAILURE);

	angroup = sign(angroup, ival);

	ds_anmd();
	ds_anrs();
	ds_anvl();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_agrp() -- (re)display the field
   =============================================================================
*/

int16_t rd_agrp(int16_t n)
{
	int8_t	buf[4];

	(void)n;

	sprintf(buf, "%02.2d", abs(angroup));

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 7, 61, buf, SDW12ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_agrp() -- data entry function
   =============================================================================
*/

int16_t nd_agrp(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;

	ebuf[ec] = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 7, stccol, k + '0', SDW12DEA);
	advscur();

	return(SUCCESS);
}

