/*
   =============================================================================
	dbentr.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		DB_Flag;
extern	int16_t		DB_In;
extern	int8_t		*DB_Last;
extern	int32_t		DB_Levl;
extern	int16_t		DB_Out;
extern	int8_t		*DB_Type[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		DB_Clr(void);
extern	void		DB_Cmnt(int8_t *str);
extern	void		DB_Dump(void);
extern	void		DB_Entr(int8_t *str);
extern	void		DB_Exit(int8_t *str);
