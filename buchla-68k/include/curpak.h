/*
   =============================================================================
	curpak.h -- header for cursor and data entry functions
	Version 5 -- 1988-10-12 -- D.N. Lynx Crowe
   =============================================================================

*/

#pragma once

#include "fields.h"
#include "stdint.h"

/* cursor types */

#define	CT_GRAF		0	/* graphics */
#define	CT_TEXT		1	/* text -- general */
#define	CT_VIRT		2	/* virtual -- graphic */
#define	CT_SCOR		3	/* text -- score */
#define	CT_SMTH		4	/* text -- smooth scroll */
#define	CT_MENU		5	/* virtual -- character */

/* cursor and data entry function parameter structure */

struct curpak {

	int16_t		(*curtype)(void);
	void		(*premove)(void);
	void		(*pstmove)(void);
	void		(*cx_key)(void);
	void		(*cy_key)(void);
	void		(*cx_upd)(void);
	void		(*cy_upd)(void);
	void		(*xy_up)(void);
	void		(*xy_dn)(void);
	void		(*x_key)(void);
	void		(*e_key)(void);
	void		(*m_key)(void);
	void		(*d_key)(int16_t k);
	int16_t		(*not_fld)(int16_t k);
	struct fet	*curfet;
	struct selbox	*csbp;
	int16_t		*cratex;
	int16_t		*cratey;
	int16_t		cmtype;
	int16_t		cxval;
	int16_t		cyval;
};

