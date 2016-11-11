/*
 *
 * SNES SPC700 Sound Driver v0.000000000(ry 1 (��)
 *
 * by 757��iTWiLoLoLo
 * http://koopa.es.land.to/
 *
 * This code can be compiled by WLA which I arranged.
 * You can download it at my web site.
 *
 */


.include "defs.i"
.include "ramdef.i"
;.include "macros.asm" �}�N���g���Ăˁ[���� �g����Z�ʂ����ɂ͂Ȃ�����������
.emptyfill $ff


; code start
.orga ENTRY_POINT-4
.dw CODE_END - CODE_START
.dw CODE_START
;-----------------------------
; init
;-----------------------------
CODE_START:
Init:		clrp
		mov   x, #DEFAULT_STACK_POINTER
		mov   sp, x
		mov   a, #$00
		mov   x, a
-		mov   (x)+, a		;\
		cmp   x, #$f0		; |
		bne   -			; | clear $0000~$01ff
		mov   x, a		; |
		setp			; |
-		mov   (x)+, a		; |
		cmp   x, #$00		; |
		bne   -			; |
		clrp			;/
		mov   x,#11
-		mov   a, !DSP_InitValueTable+x
		mov   y, a
		mov   a, !DSP_InitAddressTable+x
		movw  SPC_REGADDR, ya	; y ... data | a ... address
		dec   x
		bpl   -
		mov   a, #INIT_TEMPO_VAL
		mov   SeqTempo, a
		mov   a, #(CNT_IPL | CNT_CLRPORT1 | CNT_CLRPORT2)
		mov   SPC_CONTROL, a
		mov   a, #TIMER_VAL
		mov   SPC_TIMER0, a
		mov   a, #CNT_TIMER0_ON
		mov   SPC_CONTROL, a

;----------------------------
; debug code
;----------------------------
.ifdef SA
		; �`�����l�����������炢�e�[�u����������΂����̂ɂˁ[��
		; ����炵�����������܂ł���Ŋ撣���Ă��炤
		mov   SeqPointerH.C1, #((Channel1)>>8)
		mov   SeqPointerL.C1, #((Channel1)&$ff)
		mov   SeqPointerH.C2, #((Channel2)>>8)
		mov   SeqPointerL.C2, #((Channel2)&$ff)
		mov   SeqPointerH.C3, #((Channel3)>>8)
		mov   SeqPointerL.C3, #((Channel3)&$ff)
		mov   SeqPointerH.C4, #((Channel4)>>8)
		mov   SeqPointerL.C4, #((Channel4)&$ff)
		mov   SeqPointerH.C5, #((Channel5)>>8)
		mov   SeqPointerL.C5, #((Channel5)&$ff)
		mov   SeqPointerH.C6, #((Channel6)>>8)
		mov   SeqPointerL.C6, #((Channel6)&$ff)
		mov   SeqPointerH.C7, #((Channel7)>>8)
		mov   SeqPointerL.C7, #((Channel7)&$ff)
		mov   SeqPointerH.C8, #((Channel8)>>8)
		mov   SeqPointerL.C8, #((Channel8)&$ff)
.endif

.ifdef DEBUG ; �ߋ��̃f�o�b�O�R�[�h�B���݁B----------------------------------------
		mov   a, #(DSP_CHANNEL1 | DSP_VOL)
		mov   y, #$10
		movw  SPC_REGADDR, ya
		inc   a
		movw  SPC_REGADDR, ya
		
		mov   a, #(DSP_CHANNEL1 | DSP_SRCN)
		mov   y, #$00
		movw  SPC_REGADDR, ya
		

		mov   a, #$ff
		mov   y, #(DSP_CHANNEL1 | DSP_ADSR)
		call  SendDSP

		mov   a, #$e3
		mov   y, #(DSP_CHANNEL1 | DSP_ADSR+1)
		call  SendDSP
		
		mov   a, #(DSP_CHANNEL2 | DSP_VOL)
		mov   y, #$10
		movw  SPC_REGADDR, ya
		inc   a
		movw  SPC_REGADDR, ya

		mov   x, #0
		mov   a, !PitchTable+x
		mov   y, #(1 << 4)
		mul   ya
		push  y
		mov   y, #(DSP_CHANNEL2 | DSP_P)
		call  SendDSP
		pop   a
		inc   y
		call  SendDSP
		
		mov   a, #(DSP_CHANNEL2 | DSP_SRCN)
		mov   y, #$00
		movw  SPC_REGADDR, ya

		mov   a, #$ff
		mov   y, #(DSP_CHANNEL2 | DSP_ADSR)
		call  SendDSP

		mov   a, #$e3
		mov   y, #(DSP_CHANNEL2 | DSP_ADSR+1)
		call  SendDSP

		mov   SeqPointerH.C1, #$20
		mov   SeqPointerH.C2, #$20
		/*
		.printt "Tone = $"
		.printv hex Tone
		.printt "\n"
		*/
.endif ; ���݂���� ------------------------------------------------------

;----------------------------
; �Ȃ񂩂̌l�p���o��
;----------------------------
		.printt "LoopNums = $"
		.printv hex LoopNums
		.printt "\n"


;-----------------------------
; tempo loop
;-----------------------------
MainLoop:	mov   a, SPC_COUNTER0
		beq   MainLoop		; 0 -> loop
		mov   y, SeqTempo		;\
		mul   ya			; | �e���|�������邨������
		clrc			; | ����ΰ�
		adc   a, SeqTempoSum	; |
		mov   SeqTempoSum, a	; |
		bcc   MainLoop		;/

;----------------------------
; port
;----------------------------
		mov   a, SPC_PORT.P0
		

;----------------------------
; channel loop
;----------------------------
		mov   x, #7		;\  ���[�v�p�̏�����
		mov   ChannelBit, #$80	;/
--		mov   a, Step+x		;\
		beq   +			; | �������܂��������Ȃ�l���P�R���炵�Ă����
		dec   Step+x		;/
		; ������call������łȂɂ������������
		; ���W�����[�V�������f�Ƃ����̂ւ񂩂ȁH��
		; call  foo ���Ă�
		bra   +++		;
+		mov   y, SeqPointerH+x	;\  �V�[�P���X�|�C���^��NULL�Ȃ珈�����Ȃ�
		beq   +++		;/
		; �����ɂȂɂ�����������\�肩������Ȃ�
		; �Ȃ񂾂낤�˂�
		mov   a, SeqPointerL+x
		movw  AddrTmp, ya		;   �V�[�P���X�|�C���^����Ɨpram�Ɉړ�
__		call  GetSeqParam		;   �|�C���^���1byte�擾(A�ɕԂ�)
		bne   +				;\
		mov   SeqPointerH+x, a		; | �V�[�P���X�I������($00)
		or    KeyOffBit, ChannelBit	; |
		bra   +++			;/
+		bpl   Command		;   �e��R�}���h����($01�`$7F)
		and   a, #$7f
;		mov   Tone+x, a	; �܂��Q�Ƃ��鏈����������R�����g�A�E�g�[��
		push  a
		or    KeyOnBit, ChannelBit		;   �ŏI������KeyOn����\��
		or    KeyOffBit, ChannelBit	;   �ŏI������KeyOff����\�� ����KeyOff��Ch���̂ق����ǂ��炵����
		call  GetSeqParam			;\
		dec   a				; | �������Z�b�g 1�R����
		mov   Step+x, a			;/
		; �ȉ������Z�b�g
		pop   a
		asl   a
		mov   y, #0
		push  x
		mov   x, #(12<<1)
		div   ya, x			; A<=�I�N�^�[�u y<=����(�e�[�u���l)
		mov   x, a
		mov   a, !(PitchTable+1)+y
		mov   tmp1, a
		mov   a, !PitchTable+y
		bra   +
-		lsr   tmp1
		ror   a
		inc   x
+		cmp   x, #8
		bmi   -
		mov   y, a
		pop   x
		mov   a, x
		xcn   a
		or    a, #DSP_P			;\
		movw  SPC_REGADDR, ya		; | KeyOff����O�Ƀs�b�`�ς���Ƃ���
		inc   a				; | ���̍���������
		mov   y, tmp1			; |
		movw  SPC_REGADDR, ya		;/
		
;------------------
; �A�h���X��n��
;------------------
RTRet:		movw  ya, AddrTmp
		mov   SeqPointerL+x, a
		mov   a, y
		mov   SeqPointerH+x, a
;------------------
; Ch. Loop Jump
;------------------
+++		lsr   ChannelBit
		dec   x
		bpl   --			; ChLoop
;------------------
; All channel
;------------------
		; �S�`�����l������
		mov   y, KeyOffBit	;\
		beq   +			; | KeyOff
		mov   a, #DSP_KOF		; | �s�b�`�ς������KeyOff�Ƃ��ޯ��������
		movw  SPC_REGADDR, ya	;/
		mov   y, #20		;\  wait 118cycles
-		dbnz  y, -		;/
		movw  SPC_REGADDR, ya
		mov   KeyOffBit, y
+		mov   y, KeyOnBit		;\
		beq   +			; | KeyOn
		mov   a, #DSP_KON		; |
		movw  SPC_REGADDR, ya	;/
		mov   y, #20		;\  wait 118cycles
-		dbnz  y, -		;/
		movw  SPC_REGADDR, ya
		mov   KeyOnBit, y
+		jmp   MainLoop


Command:		cmp   a, #3
		bcs   ++
		cmp   a, #2			; $01 ... �X���[ / $02 ... �x��
		bne   +
		or    KeyOffBit, ChannelBit	;   �ŏI������KeyOff����\��
+		call  GetSeqParam			;\
		dec   a				; |  �������Z�b�g 1�R����
		mov   Step+x, a			;/
		bra   RTRet

++		push  x		; �C���f�b�N�X�ێ��p
		call  CJ
		pop   x
		jmp   _b

CJ:		push  x		; �`�����l���C���f�b�N�X�擾�p
		asl   a
		mov   x, a
		jmp   [(CommandTable-6)+x]
CommandTable:	; �R�}���h�͂R����Ł[��
					; ----------------- Usage -----------------
		.dw   ProgChange		; ProgChange <Val>
		.dw   VolumeChange	; VolumeChange <LeftVol> <RightVol>
		.dw   Tempo		; Tempo <Val>
		.dw   ADSR		; ADSR <AD> <SR> or ADSR <GAINMODE> <GAIN>
		.dw   NoizChange		; NoizChange
		.dw   SetFlug		; SetFlug <Val>
		.dw   AddrJump		; AddrJump <Address(16bit)>
		.dw   LoopStart		; LoopStart <Nums> <Address(16bit)>
		.dw   LoopEnd		; LoopEnd
		.dw   LoopEscape		; LoopEscape

; ���ς���O��KeyOff�����ق���������[��ʰ

ProgChange:	call  GetSeqParam
		pop   a
		xcn   a
		or    a, #DSP_SRCN
Trans:		movw  SPC_REGADDR, ya
		ret

VolumeChange:	pop   x
		call  GetSeqParam
		push  a
		call  GetSeqParam
		mov   a, x
		xcn   a
		or    a, #DSP_VOL+1
		movw  SPC_REGADDR, ya
		pop   y
		dec   a
		bra   Trans

NoizChange:	pop   x
		mov   a, NoizBit
		eor   a, ChannelBit
		mov   NoizBit, a
		mov   y, a
		mov   a, #DSP_NON
		bra   Trans

SetFlug:		pop   x		;   �p�������̂�pop����Ƃ��ޯ��������
		call  GetSeqParam
		mov   a, #DSP_FLG
		bra   Trans

Tempo:		pop   x		;   �p�������̂�pop����Ƃ��ޯ��������
		call  GetSeqParam
		mov   SeqTempo, a
		ret

AddrJump:	pop   x		;   �p�������̂�pop����Ƃ��ޯ��������
		call  GetSeqParam
		mov   x, a
		call  GetSeqParam
		mov   (AddrTmp+1), a
		mov   AddrTmp, x
		ret

ADSR:		call  GetSeqParam
		mov   tmp1, a
		call  GetSeqParam
		pop   a
		xcn   a
		or    a, #DSP_ADSR+1
		movw  SPC_REGADDR, ya
		mov   y, tmp1
		bpl   +
		dec   a
		bra   Trans
+		inc   a
		bra   Trans

LoopStart:	call  GetSeqParam
		pop   a
		asl   a
		mov   x, a
		mov   a, LoopStAddressH+x
		beq   +
		inc   x
+		mov   a, y
		mov   LoopNums+x, a
		call  GetSeqParam
		push  a
		call  GetSeqParam
		mov   a, (AddrTmp+1)		; ���sHB
		mov   LoopRtAddressH+x, a		; LoopBackH
		mov   a, AddrTmp			; ���sLB
		mov   LoopRtAddressL+x, a		; LoopBackL
		mov   a, y
		mov   (AddrTmp+1), a
		mov   LoopStAddressH+x, a
		pop   a
		mov   AddrTmp, a
		mov   LoopStAddressL+x, a
		ret

LoopEnd:		pop   a
		asl   a
		inc   a
		mov   x, a
		mov   a, LoopStAddressH+x
		bne   +
		dec   x
+		mov   a, LoopNums+x
		beq   _f
		dec   LoopNums+x
		mov   a, LoopStAddressH+x
		mov   (AddrTmp+1), a
		mov   a, LoopStAddressL+x
		mov   AddrTmp, a
		ret

__		mov   LoopStAddressH+x, a	; LoopStAddressH��0���� - ���[�v����
		mov   a, LoopRtAddressH+x
		mov   (AddrTmp+1), a
		mov   a, LoopRtAddressL+x
		mov   AddrTmp, a
		ret

LoopEscape:	pop   a
		asl   a
		inc   a
		mov   x, a
		mov   a, LoopStAddressH+x
		bne   +
		dec   x
+		mov   a, LoopNums+x
		beq   _b
		ret
		
		
		
		

NullCommand:	pop   x		;   �p�������̂�pop����Ƃ��ޯ��������
		ret


		

;(�v�R�[�h) -----------------------------
.ifdef DEBUG
SendDSP:		mov   SPC_REGADDR, y
		mov   SPC_REGDATA, a
		ret
.endif
;----------------------------------------

GetSeqParam:	mov   y, #0		;
		mov   a, [AddrTmp]+y	;   mov a, [AddrTmp] ������΂悩�����̂�
		incw  AddrTmp		;   �A�h���X�C���N�������g
		mov   y, a		;   y�ɒl���R�s�[����ƂƂ��Ƀt���O����(N, Z)
		ret

		

.include "tables.asm"

CODE_END:


.include "seq_data.asm"



;--------------------------------------
; insert BRRs
;--------------------------------------
.include "brr_table.asm"



