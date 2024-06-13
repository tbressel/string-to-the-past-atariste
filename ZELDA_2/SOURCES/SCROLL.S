;**********************************************************
;****************** SCROLL VERS LE HAUT *******************
;**********************************************************
vers_le_bas:
; on attends d'etre dans l'‚cran 1 pour recopier l'‚cran
	move.b	flag_ecran,d0
	cmp.b	#1,d0
	bne	boucle_principale
	bsr	recopie_ecran
; on configure le scrolling
	move.b	#1,direction_scroll
	move.l	#nbr_rangees_tiles,D6	; compteur scroll total
	move.l	adr_piece,a0		; on r‚cupŠre l'adresse actuelle de la maptile
	move.l	-4(a0),adr_piece	; on lit 4 octets en arriŠre, l'adresse de la nouvelle maptile
	move.l	adr_piece,a0
	move.l	a0,pointeur_maptile	; on stock cette adresse comme pointeur de d‚part
; on met … jour les coordonn‚es de link
	move.w	posY_link_bord_haut,link_posY
	move.l	sprite_link_ECRAN,d0
	bsr	calcul_link_ecran
; on test si link porte un truc
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	boucle_secondaire
; si oui on met … jour l'item et on l'affiche
	move.w	link_posY,item_posY
	;sub.w	#6+6+12,item_posY
	move.w	link_posX,item_posX
	;sub.w	#16,item_posX
	bsr	calcul_item_ecran
	jmp	boucle_secondaire



on_scroll_vers_le_haut:
	move.l	adr_switch_buffer,a0		; lecture de l'‚cran
	move.l	a0,a1				; meme adresse pour l'‚criture
	add.l	#160*nbr_lignes_par_tile*1,a0			; framebuffer+160 octets*16 lignes*(no ligne-1)
	move.w	#nbr_lignes_par_tile*nbr_rangees_tiles,D5	; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
	sub.w	#1,D5
boucle_scroll_haut
	REPT	30
	move.l	(a0)+,(a1)+		
	ENDR
	add.l	#largeur_hud,A0			; on arrive au bord de l'‚cran et il faut ‚viter le HUD
	add.l	#largeur_hud,A1			; donc on enlŠve 5 tiles de 8 octets aux 2 pointeurs
	dbf	D5,boucle_scroll_haut
; *************************************************************
; **************** ON ECRIT UNE LIGNE DE TILES ****************
; *************************************************************
	move.l	adr_switch_buffer,a0	; on recupŠre l'adresse de d‚part de l'‚cran
	add.l	#160*nbr_lignes_par_tile*nbr_rangees_tiles,a0		; framebuffer+160 octets*16 lignes*(no ligne-1)
	move.l	a0,pointeur_ecran	; et on met … jour l'endroit o— l'on va ‚crire
	moveq.w	#15-1,D2	; on repŠte 15 tiles sur une ligne
on_affiche_15_tiles_haut:
	bsr	affiche_tile
	addq.l 	#2,pointeur_maptile	; on avance de 2 octets dans la maptile
	addq.l 	#8,pointeur_ecran	; on avance de 8 octets … l'‚cran
	dbf	D2,on_affiche_15_tiles_haut
	jmp	retour_scroll

;**********************************************************
;****************** SCROLL VERS LE BAS ********************
;**********************************************************
vers_le_haut:
; on attends d'etre dans l'‚cran 1 pour recopier l'‚cean
	move.b	flag_ecran,d0
	cmp.b	#1,d0
	bne	boucle_principale
	bsr	recopie_ecran
; on configurer le scrolling
	move.b	#2,direction_scroll
	moveq.l	#nbr_rangees_tiles,D6		; compteur scroll total
	move.l	adr_piece,a0			; on pointe sur la prochaine piŠce … afficher
	move.l	-8(a0),adr_piece
	move.l	adr_piece,a0
		; … partir de l… il faut se placer … la fin
		; de la maptile pour afficher le bas en premier
	add.l	#15*nbr_rangees_tiles*2,a0	; je pointe sur la derniŠre ligne de la maptile
	move.l	a0,pointeur_maptile	; on la stock comme pointeur
; on met … jour les coordonn‚es de link
	move.w	posY_link_bord_bas,link_posY
	move.l	sprite_link_ECRAN,d0
	bsr	calcul_link_ecran
; on test si link porte un truc
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	boucle_secondaire
; si oui on met l'item … jour et on l'affiche
	move.w	link_posY,d7
	sub.w	#12,d7
	move.w	d7,item_posY
	bsr	calcul_item_ecran
	jmp	boucle_secondaire

on_scroll_vers_le_bas:
	move.l	adr_switch_buffer,a0	; d‚part de l'‚cran 
	add.l	#160*nbr_lignes_par_tile*nbr_rangees_tiles,A0		; on pointe sur la 12eme rang‚e
	sub.l	#largeur_hud,a0			; on recule de 5 tuiles de 8 octets pour 
					; se positionner … la fin de la 12eme rang‚e
	move.l	adr_switch_buffer,a1	; ‚criture
	add.l	#160*nbr_lignes_par_tile*12,a1		; framebuffer+160 octets*16 lignes*(no ligne-1)
	sub.l	#largeur_hud,a1
	move.w	#nbr_lignes_par_tile*nbr_rangees_tiles,D5		; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
boucle_scroll_bas
	REPT	30
	move.l	-(a0),-(a1)		
	ENDR						
	sub.l	#largeur_hud,A0			; on arrive au bord de l'‚cran et il faut ‚viter le HUD
	sub.l	#largeur_hud,A1			; donc on enlŠve 5 tiles de 8 octets aux 2 pointeurs
	dbf	D5,boucle_scroll_bas
; *************************************************************
; **************** ON ECRIT UNE LIGNE DE TILES ****************
; *************************************************************
	move.l	adr_switch_buffer,a0	; on recupŠre l'adresse de d‚part de l'‚cran
	move.l	a0,pointeur_ecran	; et on met … jour l'endroit o— l'on va ‚crire
	move.w	#nbr_colonnes_tiles,D2	; on repŠte 15 tiles sur une ligne
on_affiche_15_tiles_bas:
	bsr	affiche_tile
	addq.l 	#2,pointeur_maptile
	addq.l 	#8,pointeur_ecran
	dbf	D2,on_affiche_15_tiles_bas
	sub.l	#60,pointeur_maptile
	jmp	retour_scroll


;**********************************************************
;****************** SCROLL VERS LA GAUCHE *****************
;**********************************************************
vers_la_droite:
; on attends d'etre dans l'‚cran 1
	move.b	flag_ecran,d0
	cmp.b	#1,d0
	bne	boucle_principale
	bsr	recopie_ecran	

; on configure le scrolling
	move.b	#3,direction_scroll
	moveq.l	#nbr_colonnes_tiles,D6
	move.l	adr_piece,a0
	move.l  -12(a0),adr_piece
	move.l	adr_piece,a0
	move.l	a0,pointeur_maptile

; on met … jour les coordonn‚es de link
	move.w	posX_link_bord_gauche,link_posX
	bsr	calcul_link_ecran
; on test si link porte un truc ou pas
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	boucle_secondaire
; si oui alors on affiche l'item
	move.w	link_posX,item_posX
	bsr	calcul_item_ecran
	jmp	boucle_secondaire
on_scroll_vers_la_gauche:
	move.l	adr_switch_buffer,a0	; d‚part de l'‚cran 
	add.l	#8,A0			; on pointe sur la 2eme colonne
	move.l	adr_switch_buffer,a1	; ‚criture sur la 1ere colonne
	move.w	#nbr_lignes_par_tile*12,D5		; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
boucle_scroll_gauche:
	REPT	28
	move.l	(a0)+,(a1)+
	ENDR	
	add.l	#largeur_hud_bis,a0
	add.l	#largeur_hud_bis,a1
	dbf	D5,boucle_scroll_gauche
; *************************************************************
; **************** ON ECRIT UNE LIGNE DE TILES ****************
; *************************************************************
	move.l	adr_switch_buffer,a0
	add.l	#8*nbr_colonnes_tiles,a0
	move.l	a0,pointeur_ecran
	moveq.w	#12-1,D5	; on repŠte 15 tiles sur une ligne
on_affiche_12_tiles_gauche:
	bsr	affiche_tile
	add.l 	#30,pointeur_maptile	; on avance de 15*2 octets
	add.l 	#160*nbr_lignes_par_tile,pointeur_ecran	; on se cale une ligne en dessous 
	dbf	D5,on_affiche_12_tiles_gauche
	sub.l	#30*12-2,pointeur_maptile
	jmp	retour_scroll

;**********************************************************
;****************** SCROLL VERS LA DROITE *****************
;**********************************************************
vers_la_gauche:
	; on attends d'etre dans l'‚cran 1
	move.b	flag_ecran,d0
	cmp.b	#1,d0
	bne	boucle_principale
	bsr	recopie_ecran		
	moveq.l	#0,D0
	move.l	D0,D1
	move.l	d0,d2
	move.l 	d0,d3
	move.b	#4,direction_scroll
	moveq.l	#nbr_colonnes_tiles,D6
	move.l	adr_piece,a0		; on recupŠre l'adr de la piece en cours
	move.l	-16(a0),adr_piece	; on prends l'addresse contenue dans a0, on soustrrait 16 octets
	move.l	adr_piece,a0		; au contenu.
	add.l	#28,a0
	move.l	a0,pointeur_maptile
	
; on met … jour les coordonn‚es de link
	move.w	posX_link_bord_droite,link_posX		; coordonn‚e pour afficher le sprite
	bsr	calcul_link_ecran
; on test si link porte un truc	
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	boucle_secondaire
; si oui on met … jour l'item et on l'affiche 
	move.w	link_posX,item_posX
	sub.w	#16,item_posX
	bsr	calcul_item_ecran
	jmp	boucle_secondaire
	
on_scroll_vers_la_droite:
	move.l	adr_switch_buffer,a0	; d‚part de l'‚cran 
	add.l	#160*nbr_lignes_par_tile*12-8*6,a0	; on pointe au d‚but de la 13eme rang‚e
	move.l	adr_switch_buffer,a1	; ‚criture
	add.l	#160*nbr_lignes_par_tile*12-8*5,a1
	move.l	#15*13,D5			; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
boucle_scroll_droite:
	REPT	28
	move.l	-(a0),-(a1)		
	ENDR
	sub.l	#largeur_hud_bis,a0
	sub.l	#largeur_hud_bis,a1
	dbf	D5,boucle_scroll_droite
; *************************************************************
; **************** ON ECRIT UNE LIGNE DE TILES ****************
; *************************************************************
	move.l	adr_switch_buffer,a0
	move.l	a0,pointeur_ecran
	moveq.w	#12-1,D5	; on repŠte 15 tiles sur une ligne
on_affiche_12_tiles_droite:
	bsr	affiche_tile
	add.l 	#15*2,pointeur_maptile	; on avance de 15*2 octets
	add.l 	#160*nbr_lignes_par_tile,pointeur_ecran	; on se cale une ligne en dessous 
	dbf	D5,on_affiche_12_tiles_droite
	; on recule de 30 octets en arriver pour arriver 2 ligne plus haut
	; ainsi que 2 octects qui ont ‚t‚ ajout‚
	; on revient de 15 tiles de 2 octets sur 12 lignes 
	; pour retrouver l'adresse de la tile de d‚part
	; et on passe … celle juste avant
	sub.l	#15*2*12,pointeur_maptile
	sub.l	#2,pointeur_maptile
	jmp	retour_scroll
