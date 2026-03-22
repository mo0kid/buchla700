/*
   =============================================================================
	setv2gi.c -- MIDAS-VII -- set the voices to the instrument for a group
	Version 2 -- 1988-07-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	setv2gi() -- set voices to the instrument for a group
   =============================================================================
*/

void setv2gi(int16_t group)
{
	register int16_t grp, vce, ins;

	ins = ins2grp[group] & 0x00FF;
	grp = group + 1;

	for (vce = 0; vce < 12; vce++) {

		if (vce2grp[vce] EQ grp) {	/* for each voice in the group */

			if (curvce EQ vce) {

				curinst = ins;
				s_inst[curvce] = ins;
			}

			execins(vce, ins, 1);
		}
	}
}


