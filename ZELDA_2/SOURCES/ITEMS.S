items:

; *******************************************************
; *****************  AFFICHAGE DE L'ITEM ****************
; *******************************************************
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	on_affiche_pas_item	

	move.w	flag_direction_link,d0		; pour ‚viter d'afficher link quand il ne bouge pas
	cmp.b	#0,d0
	beq	on_affiche_pas_item
	cmp.b	#droite,d0
	beq	on_affiche_item_32x16
	cmp.b	#gauche,d0
	beq	on_affiche_item_32x16
	cmp.b	#bas,d0
	beq	on_affiche_item_32x16
	cmp.b	#haut,d0
	beq	on_affiche_item_32x16
	;bsr	on_remet_le_fond_16x24

on_affiche_pas_item:
	rts






on_affiche_item_32x16:
;on affiche le masque et on AND le fond
	move.l	sprite_item_RAM,a0
	move.l	sprite_item_ECRAN,a1 
	move.l	adr_frame_buffer2,a2
	move.w	#hauteur_item-1,d7
on_affiche_une_ligne_AND_item:
	REPT	4
	move.l	(a0)+,d0
	and.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-largeur_item,a1
	add.l	#160-largeur_item,a2
	dbf	d7,on_affiche_une_ligne_AND_item
; on affiche le sprite et on OR avec le masque
	move.l	sprite_item_RAM,a0
	add.l	#160*hauteur_item,a0
	move.l	sprite_item_ECRAN,a1
	move.l	adr_frame_buffer2,a2
	move.w	#hauteur_item-1,d7
on_affiche_une_ligne_OR_item:
	REPT	4
	move.l	(a0)+,d0
	or.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-largeur_item,a1
	add.l	#160-largeur_item,a2
	dbf	d7,on_affiche_une_ligne_OR_item
	rts



on_sauve_le_fond_item16x16
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	on_porte_que_tchi
	move.l	fond_item,a0		; adr o— va s'afficher le sprite
	move.l	#adr_sauve_fond_item,a1		; adr. RAM o— on va sauver le fond
	move.w	#hauteur_item,d7			; nbr. de ligne de hauteur du sprite
on_sauve_une_ligne_item16x16:
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 6*4 octets … l'‚cran
	ENDR	
	add.l	#160-largeur_item,a0	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_sauve_une_ligne_item16x16	; fois la hauteur du sprite (ligne)
on_porte_que_tchi
	rts

on_remet_le_fond_item16x16
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	on_remet_que_dalle
	move.l	#adr_sauve_fond_item,a0	; adr o— va recup‚rer le fond
	move.l	fond_item,a1		; adr. o— l'on va ‚crire le fond
	move.w	#hauteur_item,d7			; nbr. de ligne de hauteur du sprite
on_remet_une_ligne_item16x16:
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 4*4 octets … l'‚cran
	ENDR	
	add.l	#160-largeur_item,a1	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_remet_une_ligne_item16x16	; fois la hauteur du sprite (ligne)
on_remet_que_dalle
	rts





on_affiche_sfx_32x43:
;on affiche le masque et on AND le fond
	move.l	sprite_sfx_RAM,a0
	move.l	sprite_sfx_ECRAN,a1 
	move.l	adr_frame_buffer2,a2
	move.w	#43-1,d7
on_affiche_une_ligne_AND_sfx:
	REPT	4
	move.l	(a0)+,d0
	and.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-16,a1
	add.l	#160-16,a2
	dbf	d7,on_affiche_une_ligne_AND_sfx
; on affiche le sprite et on OR avec le masque
	move.l	sprite_sfx_RAM,a0
	add.l	#160*43,a0
	move.l	sprite_sfx_ECRAN,a1
	move.l	adr_frame_buffer2,a2
	move.w	#43-1,d7
on_affiche_une_ligne_OR_sfx:
	REPT	4
	move.l	(a0)+,d0
	or.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-16,a1
	add.l	#160-16,a2
	dbf	d7,on_affiche_une_ligne_OR_sfx
	rts



on_sauve_le_fond_sfx16x43
	move.l	fond_sfx,a0		; adr o— va s'afficher le sprite
	move.l	#adr_sauve_fond_sfx,a1		; adr. RAM o— on va sauver le fond
	move.w	#43,d7			; nbr. de ligne de hauteur du sprite
on_sauve_une_ligne_sfx16x43:
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 6*4 octets … l'‚cran
	ENDR	
	add.l	#160-16,a0	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_sauve_une_ligne_sfx16x43	; fois la hauteur du sprite (ligne)
	rts

on_remet_le_fond_sfx16x43
	move.l	#adr_sauve_fond_sfx,a0	; adr o— va recup‚rer le fond
	move.l	fond_sfx,a1		; adr. o— l'on va ‚crire le fond
	move.w	#43,d7			; nbr. de ligne de hauteur du sprite
on_remet_une_ligne_sfx16x43:
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 4*4 octets … l'‚cran
	ENDR	
	add.l	#160-16,a1	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_remet_une_ligne_sfx16x43	; fois la hauteur du sprite (ligne)
	rts




; **********************************************************
; **********  PLACER UN ITEM AVEC LES COORDONNEES **********
; **********************************************************
calcul_item_ecran:	
	move.l	#0,d1
	move.l	adr_frame_buffer,d0	; adresse de l'‚cran de d‚part
	move.w	item_posY,d1		; coordon‚e Y de l'item
	mulu.w	#160,d1			; longeur d'une ligne
	add.l	d1,d0			; adfresse de la ligne dans d0

	move.w	item_posX,d1		; coordon‚e X de link
	divu.w	#2,d1			; 
	add.l	d1,d0	
	move.l	d0,sprite_item_ECRAN
	move.l	d0,fond_item
	rts
