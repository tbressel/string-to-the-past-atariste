encodage:

; *****************************************************
; ********* ENCODAGE TILESET DES LA FORET *************
; *****************************************************
	;bsr	init_registres
	;move.w	#16,ENChauteur_tile		
	;move.w	#20,ENCnbr_colonne_tile	
	;move.w	#36,ENCnbr_ligne_tile
	;move.w	#8,ENClargeur_tile

	;move.l	#img_tileset+34,a0	; adr. source
	;move.l	#bin_tileset,a1		; adr. destination
	;bsr	convertir

; on choppe la palette de la foret au passage
;	move.l	#img_hud+2,a0		; adr. source
;	move.l	#palette_foret,a1	
;	REPT	16
;	move.w	(a0)+,(a1)+
;	ENDR


; *****************************************************
; ********* ENCODAGE TILESET DES MAISONS **************
; *****************************************************
;	bsr	init_registres
;	move.w	#16,ENChauteur_tile		
;	move.w	#20,ENCnbr_colonne_tile	
;	move.w	#36,ENCnbr_ligne_tile
;	move.w	#8,ENClargeur_tile

;	move.l	#img_tileset2+34,a0		; adr. source
;	move.l	#bin_tileset2,a1		; adr. destination
;	bsr	convertir

; on choppe la palette des maison au passage	
;	move.l	#img_tileset2+2,a0		; adr. source
;	move.l	#palette_maisons,a1	
;	REPT	16
;	move.w	(a0)+,(a1)+
;	ENDR


; *****************************************************
; ********* ENCODAGE DES SPRITES DE LINK **************
; *****************************************************
	
; sprites de link gauche  ou l'inverse je sais plus
;	bsr	init_registres
;	move.w	#24,ENChauteur_tile		
;	move.w	#10,ENCnbr_colonne_tile	
;	move.w	#6,ENCnbr_ligne_tile		; 6 lignes droite et 6 lignes gauche
;	move.w	#16,ENClargeur_tile

;	move.l	#img_sprites_link+34,a0	; adr. source
;	move.l	#bin_sprites_link,a1	; adr. destination
;	bsr	convertir


; sprites de link droite ou gauche .... chai plus
;	move.w	#24,ENChauteur_tile		
;	move.w	#10,ENCnbr_colonne_tile	
;	move.w	#6,ENCnbr_ligne_tile
;	move.w	#16,ENClargeur_tile

;	move.l	#img_sprites_link+32000+34+34,a0	; adr. source
;	move.l	#bin_sprites_link+32000,a1	; adr. destination
;	bsr	convertir

; sprites de Link haut et bas
;	move.w	#24,ENChauteur_tile		
;	move.w	#20,ENCnbr_colonne_tile	
;	move.w	#8,ENCnbr_ligne_tile		; 6 lignes droite et 6 lignes gauche
;	move.w	#8,ENClargeur_tile
	
;	move.l	#img_sprites_link_suite+34,a0
;	move.l 	#bin_sprites_link_suite,a1
;	bsr	convertir


; *****************************************************
; *************** ENCODAGE DES ITEMS ******************
; *****************************************************
; sprites items
	;move.w	#16,ENChauteur_tile		
	;move.w	#10,ENCnbr_colonne_tile	
	;move.w	#6,ENCnbr_ligne_tile
	;move.w	#16,ENClargeur_tile

	;move.l	#img_sprites_items1+34,a0
	;move.l	#bin_sprites_items1,a1
	;bsr	convertir

; sprites des effets 
	;move.w	#43,ENChauteur_tile		
	;move.w	#10,ENCnbr_colonne_tile	
	;move.w	#4,ENCnbr_ligne_tile		; 6 lignes droite et 6 lignes gauche
	;move.w	#16,ENClargeur_tile
	
	;move.l	#img_sprites_sfx+34,a0
	;move.l	#bin_sprites_sfx,a1
	;bsr	convertir
	
; *****************************************************
; *************** ENCODAGE DE LA FONTE ****************
; *****************************************************
	
;	move.w	#16,ENChauteur_tile		
;	move.w	#20,ENCnbr_colonne_tile	
;	move.w	#10,ENCnbr_ligne_tile		; 6 lignes droite et 6 lignes gauche
;	move.w	#8,ENClargeur_tile
	
;	move.l	#img_fonte+34,a0
;	move.l	#bin_fonte,a1
;	bsr	convertir

	rts	




convertir:
	move.l	a0,ENCpointeur_source	; on sauve l'adresse de d‚part pour le d‚placement en X
	move.l	a0,ENCpointeur_colonne	
	move.w	ENCnbr_ligne_tile,d7		; compteur de colonne pour 36 ligne de tiles 
	move.w	ENCnbr_colonne_tile,d6		; compteur de ligne pour 20 tiles
	move.w	ENChauteur_tile,d5		; compteur de ligne pour 1 tile
	move.w	ENClargeur_tile,d4
	sub.w	#1,d7
	sub.w	#1,d6
	sub.w	#1,d5
on_recopie_une_seule_tile:		
	cmp.w	#8,d4
	beq	recopie_8_octets
	cmp.w	#16,d4
	beq	recopie_16_octets
retour_recopie_octets	
	move.w	#160,d3
	sub.w	d4,d3
	add.l	d3,a0		; on passe … la ligne du dessous (longeur d'une ligne moins largeur d'une tile)
	dbf	d5,on_recopie_une_seule_tile

; j'ai recopi‚ 1 seule tiles en m‚moire lin‚airement
; mon pointeur source arrive en bas … droite de la tile
; il faut replacer le pointeur en haut … gauche

	move.l	ENCpointeur_source,a0	; on recupere l'adr. de d‚part (en haut … gauche de la tile)
	add.l	d4,a0			; on se d‚cale de 8 octets pour lire la tile suivante
	move.l	a0,ENCpointeur_source	; et on la sauvegarde le nouvel emplacement du pointeur
	move.w	ENChauteur_tile,d5		; on reinit le compteur de ligne
	sub.w	#1,d5	
	dbf	d6,on_recopie_une_seule_tile

; on recopie jusqu'… 20 tiles
	move.l	ENCpointeur_source,a0			; on recupŠre l'adr de la colonne pr‚cedante
	move.w	ENChauteur_tile,d5
	sub.w	#1,d5
	mulu.w	#160,d5
	add.l	d5,a0				; on addition … l'adr. qui pointait sur le depart de la colonne precedant
						; avec la longueur d'une ligne fois la hauteur d'une tile
	move.l	a0,ENCpointeur_source		; on met la variable … jour	
; on est pret … ecrire une nouvelle ligne de tile.
	move.w	ENCnbr_colonne_tile,d6		; compteur de ligne pour 20 tiles
	move.w	ENChauteur_tile,d5		; compteur de ligne pour 1 tile	
	sub.w	#1,d6
	sub.w	#1,d5
	dbf	d7,on_recopie_une_seule_tile
	rts

; on a fini

recopie_8_octets:
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	jmp	retour_recopie_octets
recopie_16_octets:
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	jmp	retour_recopie_octets

pointeur_source:
	ds.l	1
pointeur_colonne:
	ds.l	1

ENCpointeur_source:
	ds.l	1
ENCpointeur_colonne:
	ds.l	1
ENChauteur_tile:
	ds.w	1
ENCnbr_colonne_tile:
	ds.w	1
ENCnbr_ligne_tile:
	ds.w	1
ENClargeur_tile:
	ds.w	1


; ****************************************************************
; ****************************************************************


;img_tileset2:
;	incbin	__TEMP__\PI1\maisons.pi1

img_grille:
	incbin	__TEMP__\debug\grille.pi1

img_grillem:
	incbin	__TEMP__\debug\grillem.pi1

img_grille2:
	incbin	__TEMP__\debug\grille2.pi1

img_grille2m:
	incbin	__TEMP__\debug\grille2m.pi1

title_screen:
	incbin	__TEMP__\PI1\title.pi1

selection_1:
	incbin	__TEMP__\PI1\selec.pi1

;img_sprite_sfx:
;	incbin	__TEMP__\PI1\sfx.pi1

;img_tileset:			; 32Ko par fichier
;	incbin	__TEMP__\PI1\foret123.pi1

;img_sprites_link:
;	incbin	__TEMP__\PI1\linkdr.pi1
;	incbin  __TEMP__\PI1\linkga.pi1
	;incbin	__TEMP__\debug\linkd2.pi1
	;incbin	__TEMP__\debug\linkg2.pi1

; ----------------------------------------------------
;img_sprites_link_suite:
;	incbin	__TEMP__\PI1\linkbaha.pi1
	;incbin sprites\debug\linkbh2.pi1
; ----------------------------------------------------
;img_sprites_items1:
;	incbin	__TEMP__\PI1\items1.pi1
	;incbin	sprites\debug\items12.pi1

img_hud:
	incbin	__TEMP__\PI1\hud.pi1	

;img_fonte:
;	incbin	__TEMP__\PI1\fonte.pi1

; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!! ZONE D'ENCODAGE DES PI1  !!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;bin_tileset:
;	DS.B 	96000
;bin_tileset2:
;	DS.B	96000
;bin_sprites_link:
;	DS.B	64000
;bin_sprites_link_suite:
;	DS.B	32000
;bin_sprites_items1:
;	ds.b	32000
;bin_sprites_sfx:
;	ds.b	32000
;palette_maisons:
;	ds.w	16
;bin_fonte:
;A
;	ds.w	32000
;B
