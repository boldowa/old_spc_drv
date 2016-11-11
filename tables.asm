/*
 * Tables for SPC Driver
 *
 */

.ifndef _TABLES_ASM_
.define _TABLES_ASM_


;-------------------------------------------------
; DSP Init
;-------------------------------------------------
DSP_InitAddressTable:
		.db   DSP_MVOLL
		.db   DSP_MVOLR
		.db   DSP_EVOLL
		.db   DSP_EVOLR
		.db   DSP_FLG
		.db   DSP_EFB
		.db   DSP_PMON
		.db   DSP_NON
		.db   DSP_EON
		.db   DSP_DIR
		.db   DSP_ESA
		.db   DSP_EDL

DSP_InitValueTable:
		.db   $40	; mvoll
		.db   $40	; mvolr
		.db   $00	; evoll
		.db   $00	; evolr
		.db   FLG_ECEN	; flg
		.db   $00	; efb
		.db   $00	; pmon
		.db   $00	; non
		.db   $00	; eon
		.db   DIR_VAL	; dir
		.db   $fe	; esa
		.db   $00	; edl


/* ‹ŒŽ®‚Ì‚²‚Ý
PitchTable:
		.db   134	; c
		.db   142	; c+
		.db   150	; d
		.db   159	; d+
		.db   168	; e
		.db   178	; f
		.db   189	; f+
		.db   200	; g
		.db   212	; g+
		.db   225	; a
		.db   238	; a+
		.db   252	; b
*/

PitchTable:
		.dw   $217c	; c
		.dw   $237a	; c+
		.dw   $2596	; d
		.dw   $27d2	; d+
		.dw   $2a30	; e
		.dw   $2cb2	; f
		.dw   $2f5a	; f+
		.dw   $322c	; g
		.dw   $3528	; g+
		.dw   $3850	; a
		.dw   $3baa	; a+
		.dw   $3f36	; b




.endif


