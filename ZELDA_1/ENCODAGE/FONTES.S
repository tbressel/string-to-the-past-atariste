; *****************************************************
; *************** ENCODAGE DE LA FONTE ****************
; *****************************************************
encodage_fonte:	
	move.w	#16,ENChauteur_tile		
	move.w	#20,ENCnbr_colonne_tile	
	move.w	#10,ENCnbr_ligne_tile		; 6 lignes droite et 6 lignes gauche
	move.w	#8,ENClargeur_tile
	
	move.l	#img_fonte+34,a0
	move.l	#enc_fonte,a1
	bsr	convertir
	rts	


img_fonte:
	incbin	__TEMP__\PI1\fonte3.pi1

enc_fonte:
FO
	ds.w	32000
NT