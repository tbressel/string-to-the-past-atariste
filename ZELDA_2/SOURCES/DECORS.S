; **************************************************************
; ********************* Ecran de tiles *************************
; **************************************************************
ecran_de_tiles:
	moveq.l	#0,d1		; remise … z‚ro des registres
	move.l	d1,a0
	move.l	d1,d0
	move.l	d1,d2
	move.l	d1,d3

	move.l	adr_switch_buffer,D2	; destination ecran
	move.l	D2,A0		
	move.l	a0,pointeur_ecran_Y	; pour se d‚placer … la ligne de tile du dessous
	move.l	a0,pointeur_ecran	; pour se d‚placer … la tile suivante sur une meme ligne
	move.l	adr_piece,A0		; adr. de la maptile … afficher
	move.l	A0,pointeur_maptile	; pour se d‚placer dans la maptile

	moveq.l	#12-1,D3	; on r‚pŠtre 12 fois les 15 lignes de tile
	moveq.l	#15-1,D2	; on repŠte 15 tiles sur une ligne
on_affiche_15_tiles:
	bsr	affiche_tile
	addq.l 	#2,pointeur_maptile
	addq.l 	#8,pointeur_ecran
	dbf	D2,on_affiche_15_tiles
	move.l	pointeur_ecran_Y,a0	; on recupŠre le pointeur de d‚but de ligne de tile	lea	160*16(a0),a0
	lea	160*16(a0),a0
	move.l	a0,pointeur_ecran_Y
	move.l	a0,pointeur_ecran
	move.l	#15-1,D2		; on reinitialise le compteur des 20 tiles
	dbf	D3,on_affiche_15_tiles
	rts

affiche_tile:
; on calcule son emplacement dans la RAM
	moveq.l	#0,D0
	move.l	pointeur_maptile,A0	; on recupŠre la derniŠre adresse lue dans la maptile
	move.w	(A0),D0		; on recupŠre dans D0, les 2 octets lus … l'adresse A0 (numero de la tuile)
	lsl.l	#7,D0
	move.l	adr_tileset,A1		; adr du d‚but du tilset
	add.l	A1,D0			; adr de la tile … afficher dans D0
	move.l	D0,adr_tile_ram
on_affiche_la_tile_a_lecran
	move.l	pointeur_ecran,A0
	move.l	adr_tile_ram,A1			; adr de la tile dans le tile set
	move.l	#16-1,d1			; nombre de ligne de haut
boucle_une_seule_tile:
	move.l	(a1)+,(a0)+			; on recopie 4 octets
	move.l	(a1)+,(a0)+			; puis encore 4 octets
	lea	160-8(a0),a0
	dbf	d1,boucle_une_seule_tile
	rts
