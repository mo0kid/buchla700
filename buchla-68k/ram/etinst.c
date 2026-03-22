/*
   =============================================================================
	etinst.c -- instrument field handlers
	Version 23 -- 1988-07-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_inst() -- load edit buffer
   =============================================================================
*/

int16_t et_inst(int16_t n)
{
	sprintf(ebuf, "%02.2d", ins2grp[n] & 0x00FF);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_inst() -- parse edit buffer
   =============================================================================
*/

int16_t ef_inst(int16_t n)
{
	register int16_t ival;
	register struct s_entry *ep;

	ebuf[2] = '\0';
	ival = ((ebuf[0] - '0') * 10) + (ebuf[1] - '0');
	ebflag = FALSE;

	if (ival GE NINST)
		return(FAILURE);

	ins2grp[n] = ival | (ins2grp[n] & (int16_t)0xFF00);
	setv2gi(n);
	setinst();

	if (recsw AND grpstat[n] AND (2 EQ grpmode[n])) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_INST, n, -1))) {

			ep->e_data2 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_INST;
			ep->e_data1 = (int8_t)n;
			ep->e_data2 = (int8_t)ival;
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_INST);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_inst() -- (re)display the field
   =============================================================================
*/

int16_t rd_inst(int16_t n)
{
	int8_t	buf[4];

	sprintf(buf, "%02.2d", ins2grp[n] & 0x00FF);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 2, 7+(n*5), buf, SDW11ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	ds_inst() -- display all instrument to group assignments
   =============================================================================
*/

void ds_inst(void)
{
	register int16_t i;

	for (i = 0; i < 12; i++)
		rd_inst(i);
}

/*
   =============================================================================
	nd_inst() -- data entry function
   =============================================================================
*/

int16_t nd_inst(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;
	ebuf[ec]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 2, stccol, k + '0', SDW11DEA);
	advscur();

	return(SUCCESS);
}

