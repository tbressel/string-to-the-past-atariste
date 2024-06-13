; *****************************************************
; *************** ENCODAGE DE LA TRIFORCE *************
; *****************************************************
encodage_triforce:
	move.w	#48,ENChauteur_tile
	move.w	#5,ENCnbr_colonne_tile
	move.w	#4,ENCnbr_ligne_tile
	move.w	#32,ENClargeur_tile
	move.l	#img_trif_1+34,a0
	move.l	#enc_trif_1,a1
	bsr	convertir	
	move.l	#img_trif_2+34,a0
	move.l	#enc_trif_2,a1
	bsr	convertir	
	move.l	#img_trif_3+34,a0
	move.l	#enc_trif_3,a1
	bsr	convertir	
	move.l	#img_trif_4+34,a0
	move.l	#enc_trif_4,a1
	bsr	convertir	
	move.l	#img_trif_5+34,a0
	move.l	#enc_trif_5,a1
	bsr	convertir	
	move.l	#img_trif_6+34,a0
	move.l	#enc_trif_6,a1
	bsr	convertir	
	



	move.l	#img_trif_1m+34,a0
	move.l	#enc_trif_1m,a1
	bsr	convertir	
	move.l	#img_trif_2m+34,a0
	move.l	#enc_trif_2m,a1
	bsr	convertir	
	move.l	#img_trif_3m+34,a0
	move.l	#enc_trif_3m,a1
	bsr	convertir	
	move.l	#img_trif_4m+34,a0
	move.l	#enc_trif_4m,a1
	bsr	convertir	
	move.l	#img_trif_5m+34,a0
	move.l	#enc_trif_5m,a1
	bsr	convertir	
	move.l	#img_trif_6m+34,a0
	move.l	#enc_trif_6m,a1
	bsr	convertir	
	rts


img_trif_1:
	incbin	__TEMP__\PI1\trif_1.pi1
img_trif_2:
	incbin	__TEMP__\PI1\trif_2.pi1
img_trif_3:
	incbin	__TEMP__\PI1\trif_3.pi1
img_trif_4:
	incbin	__TEMP__\PI1\trif_4.pi1
img_trif_5:
	incbin	__TEMP__\PI1\trif_5.pi1
img_trif_6	
	incbin	__TEMP__\PI1\trif_6.pi1

img_trif_1m:
	incbin	__TEMP__\PI1\trif_1m.pi1
img_trif_2m:
	incbin	__TEMP__\PI1\trif_2m.pi1
img_trif_3m:
	incbin	__TEMP__\PI1\trif_3m.pi1
img_trif_4m:
	incbin	__TEMP__\PI1\trif_4m.pi1
img_trif_5m:
	incbin	__TEMP__\PI1\trif_5m.pi1
img_trif_6m:
	incbin	__TEMP__\PI1\trif_6m.pi1


enc_trif_1:
	ds.b	32000
enc_trif_2:
	ds.b	32000
enc_trif_3:
	ds.b	32000
enc_trif_4:
	ds.b	32000
enc_trif_5:
	ds.b	32000
enc_trif_6:
	ds.b	32000

enc_trif_1m:
	ds.b	32000
enc_trif_2m
	ds.b	32000
enc_trif_3m:
	ds.b	32000
enc_trif_4m:
	ds.b	32000
enc_trif_5m:
	ds.b	32000
enc_trif_6m:
	ds.b	32000

