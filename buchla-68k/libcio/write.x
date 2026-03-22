/*
   =============================================================================
	write.c -- external declarations
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

extern	int16_t		_filewr(io_arg arg, void *buffer, int16_t len);
extern	int16_t		_putsec(struct fcb *fp, void *buf, int16_t len);
extern	int16_t		write(int16_t fd, void *buff, int16_t len);
