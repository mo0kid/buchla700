/*
   =============================================================================
	smscrl.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	volatile	uint16_t	*LineBuf;
extern	volatile	uint16_t	*OldLine;
extern	volatile	uint16_t	*ScObAdr;

extern	int8_t		*(*BakLine)(void);
extern	int16_t		CurLine;
extern	int16_t		CurScan;
extern	int16_t		DupLine;
extern	int8_t		*(*FwdLine)(void);
extern	uint16_t	LineAtr;
extern	int16_t		LineCon;
extern	int16_t		LineLen;
extern	int8_t		*LinePtr;
extern	int16_t		PdScDnF;
extern	int16_t		PdScUpF;
extern	int16_t		ScrlObj;
extern	int16_t		SmScLim;
extern	int16_t		SmScNsl;
extern	int16_t		SmScTop;
extern	int8_t		TheBuf[66];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int8_t		*LineBak(void);
extern	int8_t		*LineFwd(void);
extern	void		SetDTop(int16_t row, int16_t scan);
extern	void		UpdVid(int16_t row, int16_t col, int8_t *str, uint16_t atr);
extern	void		WrVideo(int16_t row, int16_t col, int8_t *str, uint16_t atr);
extern	void		bgncm(void);
extern	void		smscrl(void);
extern	void		smxupd(void);
extern	void		smy_up(int16_t tag);
extern	void		smyupd(void);
extern	void		sqy_up(int16_t tag);
extern	void		sqyupd(void);
extern	void		stopcm(void);
extern	void		stopsm(void);
