; ***************************************************************
; ***************************************************************
; *****************  GESTION DU SPRITE DE LINK  *****************
; ***************************************************************
; ***************************************************************
; infos concernant les coordonn‚es X du sprites de Link:
; ‚tant affich‚ dans un rectangle de 24 ligne de haut par 16 octets
; de large, les coordonn‚es li‚es … son d‚placement de 8 octets (1 colonne)
; sont les suivante :
; 0 … 6 (colonne 1), 8 … 14, 16 … 22, 24 … 30, 32 … 38
; 40 … 46 (colonne 6), 48 … 54, 56 … 62, 64 … 70, 72 … 78
; 80 … 86 (colonne 11), 88 … 94, 96 …102, 104 … 110 et 112 … 118 (colonne 15)
; ****************************************************************
; info concerant les coordonn‚es de Y du sprite de Link:
; les coordonn‚es ‚voluent de 2 en 2 (2*160 octets) (PoxY) sur 6 adresse veerticales
; sur 13 lignes exemple : 
;	- $3F8000	: 0
;	- $3f8140	: 2
;	- $3f8280	: 4
; etc jusqu'au d‚but de la prochaine adress : coordonn‚e :
; 							- $3f88c0

; **************************************************************** 
; ******************  ON INITIALISE LINK *************************
; ****************************************************************
init_link:
; Pointeur d'animation
	move.l	#tbl_animation_link_droite,a0	; on pointe la table d'animation des sprite vers la droite
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupŠre l'adresse du sprite
	move.w	#1,direction_precedante	

; Coordonn‚es de Link au d‚part
	move.l	adr_frame_buffer,a0
	move.l	a0,sprite_link_ECRAN	
	move.w	#64,link_posX
	move.w	#144,link_posY
	bsr	calcul_link_ecran	; positionnement … l'‚cran avec les coordonn‚es

; Sauvegarde du decors
; on lit le fond et on sauvegarde en ram de fa‡on lin‚aire
	move.l	sprite_link_ECRAN,a0
	move.l	a0,fond_link
	bsr	on_sauve_le_fond_16x24	; a0, a1 & d7 sont modifi‚s
	bsr	on_affiche_link		; a0,a1,a2 & d0,d7 sont modifi‚s

; Coordonn‚es de Link quand il r‚apparait sur l'‚cran suivant
	move.w	#$0,posY_link_bord_haut
	move.w	#$A8,posY_link_bord_bas
	move.w	#$0,posX_link_bord_gauche
	move.w	#$E0,posX_link_bord_droite
	rts

; *******************************************************
; *****************  AFFICHAGE DE LINK ******************
; *******************************************************
link:
	move.w	flag_fireA,d7
	cmp.b	#1,d7
	beq	link_fireA

	move.w	flag_direction_link,d0		; pour ‚viter d'afficher link quand il ne bouge pas
	cmp.b	#0,d0
	beq	on_affiche_pas_link
link2:
	cmp.b	#droite,d0
	beq	on_affiche_sprite_16x24
	cmp.b	#gauche,d0
	beq	on_affiche_sprite_16x24
	cmp.b	#bas,d0
	beq	on_affiche_sprite_8x24
	cmp.b	#haut,d0
	beq	on_affiche_sprite_8x24
	bsr	on_remet_le_fond_16x24
update_link:
	move.w	count_anim_link,d7
	cmp.b	#0,d7
	bne	on_zap_update_link
	move.l	sprite_link_ECRAN,d0
	move.l	d0,fond_link
on_zap_update_link
	bsr	on_sauve_le_fond_16x24

; *********************************************************
; *********************************************************
; *********************************************************
; *********************************************************
; ********  AFFICHE SPRITE 16 OCTETS PAR 24 LIGNES  *******
; *********************************************************
; *********************************************************
; *********************************************************
; *********************************************************
on_affiche_link
on_affiche_sprite_16x24:
;on affiche le masque et on AND le fond
	move.l	sprite_link_RAM,a0
	move.l	sprite_link_ECRAN,a1 
	move.l	adr_frame_buffer2,a2
	move.w	#hauteur_link-1,d7
on_affiche_une_ligne_AND:
	REPT	4
	move.l	(a0)+,d0
	and.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-largeur_link,a1
	add.l	#160-largeur_link,a2
	dbf	d7,on_affiche_une_ligne_AND
; on affiche le sprite et on OR avec le masque
	move.l	sprite_link_RAM,a0
	add.l	#160*hauteur_link,a0
	move.l	sprite_link_ECRAN,a1
	move.l	adr_frame_buffer2,a2
	move.w	#hauteur_link-1,d7
on_affiche_une_ligne_OR:
	REPT	4
	move.l	(a0)+,d0
	or.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-largeur_link,a1
	add.l	#160-largeur_link,a2
	dbf	d7,on_affiche_une_ligne_OR
on_affiche_pas_link
	rts
on_sauve_le_fond_16x24
	move.l	fond_link,a0		; adr o— va s'afficher le sprite
	move.l	#adr_sauve_fond_link,a1		; adr. RAM o— on va sauver le fond
	move.w	#hauteur_link,d7			; nbr. de ligne de hauteur du sprite
on_sauve_une_ligne_16x24:
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 6*4 octets … l'‚cran
	ENDR	
	add.l	#160-largeur_link,a0	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_sauve_une_ligne_16x24	; fois la hauteur du sprite (ligne)
	rts
on_remet_le_fond_16x24
	move.l	#adr_sauve_fond_link,a0	; adr o— va recup‚rer le fond
	move.l	fond_link,a1		; adr. o— l'on va ‚crire le fond
	move.w	#hauteur_link,d7			; nbr. de ligne de hauteur du sprite
on_remet_une_ligne_16x24:
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 4*4 octets … l'‚cran
	ENDR	
	add.l	#160-largeur_link,a1	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_remet_une_ligne_16x24	; fois la hauteur du sprite (ligne)
	rts
; *********************************************************
; *********************************************************
; *********************************************************
; *********************************************************
; ********  AFFICHE SPRITE 8 OCTETS PAR 24 LIGNES  ********
; *********************************************************
; *********************************************************
; *********************************************************
; *********************************************************
on_affiche_sprite_8x24:
; on affiche le masque et on AND le fond
	move.l	sprite_link_RAM,a0
	move.l	sprite_link_ECRAN,a1 
	move.l	adr_frame_buffer2,a2
	move.w	#hauteur_link-1,d7
on_affiche_une_ligne_AND_8x24:
	REPT	2
	move.l	(a0)+,d0
	and.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-largeur_link+8,a1
	add.l	#160-largeur_link+8,a2
	dbf	d7,on_affiche_une_ligne_AND_8x24
; on affiche le sprite et on OR avec le masque
	move.l	sprite_link_RAM,a0
	add.l	#160*hauteur_link,a0
	move.l	sprite_link_ECRAN,a1
	move.l	adr_frame_buffer2,a2
	move.w	#hauteur_link-1,d7
on_affiche_une_ligne_OR_8x24:
	REPT	2
	move.l	(a0)+,d0
	or.l	(a1),d0
	move.l	d0,(a1)+
	move.l	d0,(a2)+
	ENDR
	add.l	#160-largeur_link+8,a1
	add.l	#160-largeur_link+8,a2
	dbf	d7,on_affiche_une_ligne_OR_8x24
	rts
on_sauve_le_fond_8x24
	move.l	fond_link,a0		; adr o— va s'afficher le sprite
	move.l	#adr_sauve_fond_link,a1		; adr. RAM o— on va sauver le fond
	move.w	#hauteur_link,d7			; nbr. de ligne de hauteur du sprite
on_sauve_une_ligne_8x24:
	REPT	2
	move.l	(a0)+,(a1)+		; on recopie 6*4 octets … l'‚cran
	ENDR	
	add.l	#160-8,a0		; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_sauve_une_ligne_8x24	; fois la hauteur du sprite (ligne)
	rts
on_remet_le_fond_8x24
	move.l	#adr_sauve_fond_link,a0	; adr o— va recup‚rer le fond
	move.l	fond_link,a1		; adr. o— l'on va ‚crire le fond
	move.w	#hauteur_link,d7			; nbr. de ligne de hauteur du sprite
on_remet_une_ligne_8x24:
	REPT	2
	move.l	(a0)+,(a1)+		; on recopie 4*4 octets … l'‚cran
	ENDR	
	add.l	#160-8,a1	; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d7,on_remet_une_ligne_8x24	; fois la hauteur du sprite (ligne)
	rts

; **********************************************************
; *************  PLACER LINK AVEC LES COORDONNEES **********
; **********************************************************
calcul_link_ecran:	
	move.l	#0,d1
	move.l	adr_frame_buffer,d0	; adresse de l'‚cran de d‚part
	move.w	link_posY,d1		; coordon‚e Y de link
	mulu.w	#160,d1			; longeur d'une ligne
	add.l	d1,d0			; adfresse de la ligne dans d0

	move.w	link_posX,d1		; coordon‚e X de link
	divu.w	#2,d1			; 
	add.l	d1,d0	
	move.l	d0,sprite_link_ECRAN
	move.l	d0,fond_link
	rts


