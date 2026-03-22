/*
   =============================================================================
	etdyn.c -- dynamics field handlers
	Version 8 -- 1988-06-08 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_dyn() -- load edit buffer
   =============================================================================
*/

int16_t et_dyn(int16_t n)
{
	ebuf[0] = (int8_t)(grpdyn[n] + '0');
	ebuf[1] = '\0';
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_dyn() -- parse edit buffer
   =============================================================================
*/

int16_t ef_dyn(int16_t n)
{
	register int16_t ival;
	register struct s_entry *ep;

	ebuf[1] = '\0';
	ival = ebuf[0] - '0';
	ebflag = FALSE;

	setdyn(n, ival);

	if (recsw AND grpmode[n] AND (2 EQ grpmode[n])) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_DYN, n, -1))) {

			ep->e_data2 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_DYN;
			ep->e_data1 = (int8_t)n;
			ep->e_data2 = (int8_t)ival;
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_DYN);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_dyn() -- (re)display the field
   =============================================================================
*/

int16_t rd_dyn(int16_t n)
{
	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 4, 6+(n*5), (grpdyn[n] + '0'), SDW11ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	ds_dyn() -- display all dynamics to group assignments
   =============================================================================
*/

void ds_dyn(void)
{
	register int16_t i;

	for (i = 0; i < 12; i++)
		rd_dyn(i);
}

/*
   =============================================================================
	nd_dyn() -- data entry function
   =============================================================================
*/

int16_t nd_dyn(int16_t n, int16_t k)
{
	(void)n;

	ebuf[0]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 4, stccol, k + '0', SDW11DEA);
	advscur();

	return(SUCCESS);
}

