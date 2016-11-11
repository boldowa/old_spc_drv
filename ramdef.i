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
	RingingBit	db			; ���ݔ������̃`�����l���r�b�g
	RingingBitStack	db			; ���ʉ��ޔ�p
	NoizBit		db			; �m�C�Y�L���`�����G���r�b�g
	SeqTempo		db			;\ �e���|�����p
	SeqTempoSum	db			;/
	SeqPointerH	INSTANCEOF CHANNEL
	Tone		INSTANCEOF CHANNEL	; ����
	SeqPointerL	INSTANCEOF CHANNEL
	Step		INSTANCEOF CHANNEL	; ����
	ChannelBit	db

	LoopNums		ds $10
	LoopRtAddressL	ds $10
	LoopRtAddressH	ds $10
	LoopStAddressL	ds $10
	LoopStAddressH	ds $10
	_end_0		db
.ende
.if _end_0 <= $f0
	.printt "$0000~�̎c���"
	.printv dec $f0-_end_0
	.printt "�o�C�g�ł�.\n"
.else
	.printt "Error: $0000~�̗񋓂��e�ʕs��\n"
	.fail
.endif


;--------------------------------------
; define $0100~$0200
;--------------------------------------
.enum $0000
	_end_1	db
.ende
.if _end_1 <= $100
	.printt "$0100~�̎c���"
	.printv dec $100-_end_1
	.printt "�o�C�g�ł�.\n"
.else
	.printt "Error: $0100~�̗񋓂��e�ʕs��\n"
	.fail
.endif



.endif

