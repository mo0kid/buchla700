/*
   ============================================================================
	hwdefs.h -- Buchla 700 I/O addresses defined in hwdefs.s
	Version 12 -- 1988-08-15 -- D.N. Lynx Crowe
   ============================================================================
*/

#pragma once

#include "stdint.h"

/* hardware addresses */

extern	volatile uint16_t	io_fpu[];	/* 0x180000 */
extern	volatile uint8_t	io_time[];	/* 0x3a0001 */
extern	volatile uint8_t	io_lcd;		/* 0x3a4001 */
extern	volatile uint8_t	io_ser;		/* 0x3a8001 */
extern	volatile uint8_t	io_midi;	/* 0x3ac001 */
extern	volatile uint8_t	io_disk;	/* 0x3b0001 */
extern	volatile uint8_t	io_tone;	/* 0x3b4001 */
extern	volatile uint8_t	io_leds;	/* 0x3b8001 */
extern	volatile uint8_t	io_kbrd;	/* 0x3bc001 */
extern	volatile uint8_t	lcd_a0;		/* io_lcd + 0 */
extern	volatile uint8_t	lcd_a1;		/* io_lcd + 2 */

extern	volatile uint16_t	io_vreg[];	/* 0x200000 Video registers after setup */
extern	volatile uint16_t	io_vraw[];	/* 0x200400 Video registers after reset */
extern	volatile uint16_t	io_vram[];	/* 0x200000 Video RAM */

/* video memory allocations, bank 0 */

extern	volatile uint16_t	v_regs[];	/* 0x200000 Video registers */
extern	volatile uint16_t	v_odtab[][4];	/* 0x200080 Object Descriptor Table */
extern	volatile uint16_t	v_actab[];	/* 0x200100 Access Table */
extern	volatile uint16_t	v_ct0[];	/* 0x200400 */
extern	volatile uint16_t	v_gt1[];	/* 0x200518 */
extern	volatile uint16_t	v_score[];	/* 0x202000 Score */
extern	volatile uint16_t	v_cgtab[];	/* 0x21e000 Character Generator */

/* video memory allocations, bank 1 */

extern	volatile uint16_t	v_curs0[];	/* 0x200400 ULE cursor */
extern	volatile uint16_t	v_curs1[];	/* 0x200480 ULO cursor */
extern	volatile uint16_t	v_curs2[];	/* 0x200500 URE cursor */
extern	volatile uint16_t	v_curs3[];	/* 0x200580 URO cursor */
extern	volatile uint16_t	v_curs4[];	/* 0x200600 LLE cursor */
extern	volatile uint16_t	v_curs5[];	/* 0x200680 LLO cursor */
extern	volatile uint16_t	v_curs6[];	/* 0x200700 LRE cursor */
extern	volatile uint16_t	v_curs7[];	/* 0x200780 LRO cursor */
extern	volatile uint16_t	v_tcur[];	/* 0x200800 Typewriter */
extern	volatile uint16_t	v_kbobj[];	/* 0x200b40 Keyboard */
extern	volatile uint16_t	v_lnobj[];	/* 0x201240 Line */
extern	volatile uint16_t	v_cur[];	/* 0x201940 Underline cursor */
extern	volatile uint16_t	v_win0[];	/* 0x204000 Window 0 */

/* stuff in the depths of the bios */

extern	volatile int16_t	fc_sw;
extern	volatile int32_t	fc_val;
