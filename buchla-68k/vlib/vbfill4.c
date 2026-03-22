/*
   =============================================================================
	vbfill4.c -- video block fill blitter for 4 bit per pixel objects
	Version 3 -- 1987-08-04 -- D.N. Lynx Crowe

	Fills an area with a color.  Coded for speed, not space.
   =============================================================================
*/

#include "ram.h"

static uint16_t	fm[] = {	/* fill masks */

	0x000F,
	0x00FF,
	0x0FFF,
	0xFFFF,

	0x00F0,
	0x0FF0,
	0xFFF0,

	0x0F00,
	0xFF00,

	0xF000
};

void vbfill4(volatile uint16_t *obj, int16_t obwidth, int16_t xmin, int16_t ymin, int16_t xmax, int16_t ymax, uint16_t color)
{
	int16_t mw, nl, width;

	volatile uint16_t *fwp, *wp;

	uint16_t lmask, rmask;
	int16_t i, j;

	fwp = obj + (int32_t)(xmin >> 2) + ((int32_t)ymin * obwidth);
	width = xmax - xmin + 1;
	nl = ymax - ymin + 1;
	lmask = rmask = 0;


	switch (xmin & 3) {

	case 0:

		if (width > 4) {

			width -= 5;
			lmask = fm[3];
			mw = width >> 2;

			if (mw) {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;

					for (j = 0; j < mw; j++)
						*wp++ = color;

					*wp = (*wp & ~rmask) | (color & rmask);
				}

			} else {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;
					*wp = (*wp & ~rmask) | (color & rmask);
				}
			}

		} else {

			lmask = fm[width - 1];

			for (i = 0; i < nl; i++)  {

				wp = fwp;
				fwp += obwidth;
				*wp = (*wp & ~lmask) | (color & lmask);
			}
		}

		return;


	case 1:

		if (width > 3) {

			width -= 4;
			lmask = fm[6];
			mw = width >> 2;

			if (mw) {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;

					for (j = 0; j < mw; j++)
						*wp++ = color;

					*wp = (*wp & ~rmask) | (color & rmask);
				}

			} else {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;
					*wp = (*wp & ~rmask) | (color & rmask);
				}
			}

		} else {

			lmask = fm[width + 3];

			for (i = 0; i < nl; i++) {

				wp = fwp;
				fwp += obwidth;
				*wp = (*wp & ~lmask) | (color & lmask);
			}
		}

		return;


	case 2:

		if (width > 2) {

			width -= 3;
			lmask = fm[8];
			mw = width >> 2;

			if (mw) {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;

					for (j = 0; j < mw; j++)
						*wp++ = color;

					*wp = (*wp & ~rmask) | (color & rmask);
				}

			} else {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;
					*wp = (*wp & ~rmask) | (color & rmask);
				}
			}

		} else {

			lmask = fm[width + 6];

			for (i = 0; i < nl; i++) {

				wp = fwp;
				fwp += obwidth;
				*wp = (*wp & ~lmask) | (color & lmask);
			}
		}

		return;


	case 3:

		if (width > 1) {

			width -= 2;
			lmask = fm[9];
			mw = width >> 2;

			if (mw) {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;

					for (j = 0; j < mw; j++)
						*wp++ = color;

					*wp = (*wp &~rmask) | (color & rmask);
				}

			} else {

				rmask = fm[width & 3];

				for (i = 0; i < nl; i++) {

					wp = fwp;
					fwp += obwidth;
					*wp = (*wp & ~lmask) | (color & lmask);
					wp++;
					*wp = (*wp & ~rmask) | (color & rmask);
				}
			}

		} else {

			lmask = fm[9];

			for (i = 0; i < nl; i++) {

				wp = fwp;
				fwp += obwidth;
				*wp = (*wp & ~lmask) | (color & lmask);
			}
		}

		return;
	}
}
