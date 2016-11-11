/*
 * SPC Driver status ram define
 *
 */

.ifndef _RAMDEF_I_
.define _RAMDEF_I_

.include "defs.i"

;--------------------------------------
; define $0000~$0100
;--------------------------------------
.enum $0000
	ZERO_RAM		dw
	tmp1		db
	tmp2		db
	tmp3		db
	tmp4		db
	AddrTmp		dw
	KeyOnBit		db
	KeyOffBit	db
	RingingBit	db			; 現在発音中のチャンネルビット
	RingingBitStack	db			; 効果音退避用
	NoizBit		db			; ノイズ有効チャンエルビット
	SeqTempo		db			;\ テンポ処理用
	SeqTempoSum	db			;/
	SeqPointerH	INSTANCEOF CHANNEL
	Tone		INSTANCEOF CHANNEL	; 音程
	SeqPointerL	INSTANCEOF CHANNEL
	Step		INSTANCEOF CHANNEL	; 音長
	ChannelBit	db

	LoopNums		ds $10
	LoopRtAddressL	ds $10
	LoopRtAddressH	ds $10
	LoopStAddressL	ds $10
	LoopStAddressH	ds $10
	_end_0		db
.ende
.if _end_0 <= $f0
	.printt "$0000~の残りは"
	.printv dec $f0-_end_0
	.printt "バイトです.\n"
.else
	.printt "Error: $0000~の列挙が容量不足\n"
	.fail
.endif


;--------------------------------------
; define $0100~$0200
;--------------------------------------
.enum $0000
	_end_1	db
.ende
.if _end_1 <= $100
	.printt "$0100~の残りは"
	.printv dec $100-_end_1
	.printt "バイトです.\n"
.else
	.printt "Error: $0100~の列挙が容量不足\n"
	.fail
.endif



.endif

