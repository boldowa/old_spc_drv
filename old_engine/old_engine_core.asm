/*
 *
 * SNES SPC700 Sound Driver v0.01
 *
 * by 757ÅüiTWiLoLoLo
 * http://koopa.es.land.to/
 *
 * This code can be compiled by WLA which I arranged.
 * You can download it at my web site.
 *
 */


.include "defs.i"
.include "ramdef.i"
.include "macros.asm"
.emptyfill $ff


; code start
.orga ENTRY_POINT-4
.dw _CODE_END - _CODE_START
.dw _CODE_START
;-----------------------------
; init
;-----------------------------
_CODE_START:
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
.ifdef DEBUG
		mov   a, #(DSP_CHANNEL1 | DSP_VOL)
		mov   y, #$10
		movw  SPC_REGADDR, ya
		inc   a
		movw  SPC_REGADDR, ya

		mov   x, #0
		mov   a, !PitchTable+x
		mov   y, #(1 << 4)
		mul   ya
		push  y
		mov   y, #(DSP_CHANNEL1 | DSP_P)
		call  SendDSP
		pop   a
		inc   y
		call  SendDSP
		
		mov   a, #(DSP_CHANNEL1 | DSP_SRCN)
		mov   y, #$00
		movw  SPC_REGADDR, ya
		
		mov   a, #$03
		mov   y, #DSP_KON
		call  SendDSP
		set1  MiscBits, 0

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

		mov   SeqPointer.C1+1, #$1f
		mov   SeqPointer.C2+1, #$1f
		mov   Octave.C1, #$05
		mov   Octave.C2, #$04
		.printt "Tone = $"
		.printv hex Tone
		.printt "\n"
.endif
		


;-----------------------------
; main loop
;-----------------------------
MainLoop:	mov   y, SPC_COUNTER0
		beq   MainLoop		; 0 -> loop
		mov   a, SeqTempo
		mul   ya
		clrc
		adc   a, SeqTempoSum
		mov   SeqTempoSum, a
		bcc   MainLoop
		mov   x, #7
		mov   ChannelBit, #$80
--		mov   a, x
		asl   a
		mov   ChannelIndexW, a
		mov   a, Step+x
		beq   +
		dec   Step+x
		bra   +++
+		mov   a, ChannelBit
		tclr1 RingingBit
		push  x
		mov   x, ChannelIndexW
		mov   a, (SeqPointer+1)+x
		beq   ++
		pop   x
		; --- seq main process
__		call  GetSeqParam
		beq   SeqEnd
		cmp   a, #13
		bcs   Command
		dec   a
		mov   Tone+x, a
		call  GetSeqParam
		mov   Step+x, a
		mov   a, Octave+x
		mov   Misc1, a
		mov   a, #1
		mov   y, #0
-		cmp   y, Misc1
		beq   +
		asl   a
		inc   y
		bra   -
+		mov   y, a
		mov   a, Tone+x
		push  x
		mov   x, a
		mov   a, !PitchTable+x
		pop   x
		mul   ya
		push  a
		mov   a, x
		xcn   a
		or    a, #(DSP_P+1)
		movw  SPC_REGADDR, ya
		dec   a
		pop   y
		movw  SPC_REGADDR, ya
		bra   +++


		; --- loop
SeqEnd:		push  x
		mov   x, ChannelIndexW
		mov   (SeqPointer+1)+x, a	;  if(Param == 0) -> store 0 at SeqPointer+1 

++		pop   x
+++		lsr   ChannelBit
		dec   x
		bpl   --				; process loop(8 times)
		jmp   MainLoop

Command:		jmp   _b		
		
		

;(ñvÉRÅ[Éh) -----------------------------
SendDSP:		mov   SPC_REGADDR, y
		mov   SPC_REGDATA, a
		ret
;----------------------------------------


GetSeqParam:	; @return ... a<=Param | @param ... void
		push  x
		mov   x, ChannelIndexW
		inc   SeqPointer+x		;\  inclement SeqPointer
		bne   +				; |
		inc   (SeqPointer+1)+x		;/
+		mov   a, [SeqPointer+x]
		pop   x
		ret

		

.include "tables.asm"

_CODE_END:


.ifdef DEBUG
	.org $1f00
	.incbin "Mus.bin"
.endif


;--------------------------------------
; insert BRRs
;--------------------------------------
.include "brr_table.asm"



