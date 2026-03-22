/*
   =============================================================================
	close.c -- external declarations
   =============================================================================
*/

#pragma once

#include "biosdefs.h"
#include "fspars.h"
#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		_clsdir(void);
extern	void		_clsfat(void);
extern	void		_fd_cls(void);
extern	int16_t		_filecl(io_arg arg);
extern	int16_t		close(int16_t fd);
