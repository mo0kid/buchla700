/*
   =============================================================================
	read.c -- external declarations
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

extern	int16_t		_filerd(io_arg arg, void *buffer, int16_t len);
extern	int16_t		_getsec(struct fcb *fp, void *buf, int16_t len);
extern	int16_t		read(int16_t fd, void *buff, int16_t len);
