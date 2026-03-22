/*
   =============================================================================
	open.c -- external declarations
   =============================================================================
*/

#pragma once

#include "io.h"
#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		_fileop(int8_t *name, uint16_t flags, struct channel *chp, struct devtabl *dp);
extern	int16_t		creat(int8_t *name);
extern	int16_t		creata(int8_t *name);
extern	int16_t		creatb(int8_t *name);
extern	int16_t		open(int8_t *name, uint16_t flags);
extern	int16_t		opena(int8_t *name, uint16_t flags);
extern	int16_t		openb(int8_t *name, uint16_t flags);
