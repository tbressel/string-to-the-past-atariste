encodage_fee:
	move.w	#16,ENChauteur_tile
	move.w	#10,ENCnbr_colonne_tile
	move.w	#12,ENCnbr_ligne_tile
	move.w	#16,ENClargeur_tile
	move.l	#img_fee+34,a0
	move.l	#enc_fee,a1
	bsr	convertir	
	rts

img_fee:
	incbin	__TEMP__\PI1\fee.pi1

Y
enc_fee:
	ds.b	32000
Z

