/*
 * SPC Driver BRR table code
 *
 */


.ifndef _BRR_TABLE_ASM_
.define _BRR_TABLE_ASM_

.include "defs.i"

.org (DIR_VAL << 8)
		.dw   BRR0, BRR0+9
		.dw   BRR1, BRR1+9
		.dw   BRR2, BRR2+9
		.dw   BRR3, BRR3
		.dw   BRR4, BRR4
		.dw   BRR5, BRR5+$3CC
BRR0:
/*
		.db   $02, $00, $00, $00, $00, $00, $00, $00, $00
		.db   $c3, $77, $77, $99, $99, $99, $99, $99, $99
*/
		.incbin "p0.brr"

BRR1:
		.incbin "p1.brr"

BRR2:
		.incbin "poke-rgb_tri.brr"

BRR3:
		.incbin "kick.brr"
BRR4:
		.incbin "snare.brr"
BRR5:
		.incbin "pi_d6.brr"

.endif

