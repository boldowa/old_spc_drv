.ifndef _SEQ_DATA_ASM_
.define _SEQ_DATA_ASM_

.org SEQADDR

/*
.incdir "rocket"
Channel1:
	.incbin "ch1_i.bin"
-	.incbin "ch1_l.bin"
	.db $09
	.dw -
Channel2:
	.incbin "ch2_i.bin"
-	.incbin "ch2_l_.bin"
	.db $0a, $04
	.dw +
	.db $06, $fa, $e8, $c6, $30
	.incbin "ch2_l.bin"
	.db $0a, $04
	.dw +
	.db $06, $fa, $e8, $c6, $30
	.db $09
	.dw -
+	.incbin "ch2_sub.bin"

Channel3:
	.incbin "ch3_i.bin"
-	.incbin "ch3_l.bin"
	.db $09
	.dw -
Channel4:
Channel5:
Channel6:
Channel7:
Channel8:
	.db $00

.incdir ""

*/



Channel1:
	.db $05,$a0
-	.db $03,$01,$04,$0f,$0f,$06,$ff,$f8
	.db $0a,$02
	.dw +
	.db $c8,$18,$ca,$18,$c8,$18,$c8,$18,$c8,$18,$02,$18
	.db $09
	.dw -
+	.db $c8,$18,$ca,$18,$0c,$cc,$18,$ca,$18,$0b
Channel2:
	.db $03,$00,$04,$12,$09,$06,$ff,$f8
-	.db $bc,$18,$c8,$18
	.db $09
	.dw -
Channel3:
	.db $02,$00,$02,$00,$02,$ff,$08,$1f
-	.db $03,$03,$04,$30,$30,$06,$ff,$e0
	.db $d4,$16
	.db $02,$02,$07,$06,$ff,$fb,$04,$04,$18
	.db $c0,$0c,$c0,$0a
	.db $02,$01,$07,$02,$01
	.db $03,$04,$04,$40,$40,$06,$ff,$e0
	.db $d0,$16
	.db $02,$02,$07,$06,$ff,$fb,$04,$04,$18
	.db $c0,$0c,$c0,$0a
	.db $02,$01,$07,$02,$01
	.db $09
	.dw -

Channel4:
	.db $02,$00,$02,$00,$02,$00
	.db $02,$00,$02,$00,$02,$00
	.db $03,$02,$04,$30,$40,$06,$ff,$e0
-	.db $c3,$0c,$02,$24
	.db $09
	.dw -
Channel5:
	.db $02,$00,$02,$00,$02,$00
	.db $02,$00,$02,$00,$02,$00
	.db $02,$00,$02,$00,$02,$00
-	.db $03,$05,$04,$30,$30,$06,$af,$74
	.db $0a,$03
	.dw +
	.db $ca,$0c,$c8,$0c,$ca,$0c,$cc,$0c,$ca,$0c
	.db $09
	.dw -
+	.db $c8,$0c,$ca,$0c,$cc,$0c,$0c,$cf,$0c,$d4,$0c,$cf,$0c,$cc,$0c,$ca,$0c,$0b
	
Channel6:
Channel7:
Channel8:
	.db $00

	

.endif

