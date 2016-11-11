/*
 * defines for spc700 driver
 *
 *
 */
 
 .ifndef _DEFS_I_
 .define _DEFS_I_

;-------------------------------------------------
; spc memory map
;-------------------------------------------------
.memorymap
	slotsize $10000
	defaultslot 0
	slot 0 $0000
.endme

.rombankmap
	bankstotal 1
	banksize $10000
	banks 1
.endro

;-------------------------------------------------
; defines
;-------------------------------------------------

.define DIR_VAL			$40	; 波形テーブル位置
.define ENTRY_POINT		$0200	; プログラム開始地点
.define DEFAULT_STACK_POINTER	$ff	; スタックポインタ位置
.define TIMER_VAL			40	; セットするタイマーの値
.define INIT_TEMPO_VAL		120	; 初期テンポ
.define SEQADDR			$2000	; シーケンス位置

;-------------------------------------------------
; Struct define
;-------------------------------------------------
.struct SPC_PORT
	P0	db
	P1	db
	P2	db
	P3	db
.endst

.struct CHANNEL
	C1	db
	C2	db
	C3	db
	C4	db
	C5	db
	C6	db
	C7	db
	C8	db
.endst

.struct CHANNEL_W
	C1	dw
	C2	dw
	C3	dw
	C4	dw
	C5	dw
	C6	dw
	C7	dw
	C8	dw
.endst

;-------------------------------------------------
; spc dsp define
;-------------------------------------------------
.define DSP_VOL		$00
.define DSP_P		$02
.define DSP_SRCN		$04
.define DSP_ADSR		$05
.define DSP_GAIN		$07
.define DSP_ENVX		$08	; *
.define DSP_OUTX		$09	; *
.define DSP_MVOLL		$0c
.define DSP_MVOLR		$1c
.define DSP_EVOLL		$2c
.define DSP_EVOLR		$3c
.define DSP_KON		$4c
.define DSP_KOF		$5c
.define DSP_FLG		$6c
.define DSP_ENDX		$7c	; *
.define DSP_EFB		$0d
.define DSP_PMON		$2d
.define DSP_NON		$3d
.define DSP_EON		$4d
.define DSP_DIR		$5d
.define DSP_ESA		$6d
.define DSP_EDL		$7d
.define DSP_FIR		$0F

.define DSP_CHANNEL1	$00
.define DSP_CHANNEL2	$10
.define DSP_CHANNEL3	$20
.define DSP_CHANNEL4	$30
.define DSP_CHANNEL5	$40
.define DSP_CHANNEL6	$50
.define DSP_CHANNEL7	$60
.define DSP_CHANNEL8	$70


;-------------------------------------------------
; spc register define
;-------------------------------------------------
.define SPC_TEST		$f0
.define SPC_CONTROL	$f1
.define SPC_REGADDR	$f2
.define SPC_REGDATA	$f3
.define SPC_PORT0		$f4
.define SPC_PORT1		$f5
.define SPC_PORT2		$f6
.define SPC_PORT3		$f7
.define SPC_TIMER0	$FA
.define SPC_TIMER1	$FB
.define SPC_TIMER2	$FC
.define SPC_COUNTER0	$FD
.define SPC_COUNTER1	$FE
.define SPC_COUNTER2	$FF

;-------------------------------------------------
; spc flug define
;-------------------------------------------------
.define FLG_ECEN		$20
.define FLG_MUTE		$40
.define FLG_RES		$80

;-------------------------------------------------
; spc control flug define
;-------------------------------------------------
.define CNT_TIMER0_ON	%00000001
.define CNT_TIMER1_ON	%00000010
.define CNT_TIMER2_ON	%00000100
.define CNT_CLRPORT2	%00010000	; clear PORT0&1
.define CNT_CLRPORT1	%00100000	; clear PORT2&3
.define CNT_IPL		%10000000


.endif

