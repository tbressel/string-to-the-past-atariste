; ***************************************************************
; ***************************************************************
; **********************  LINK VA EN BAS  ***********************
; ***************************************************************
; ***************************************************************
link_bas:
; ------- est ce qu'on allait d‚j… vers le bas ?
	move.w	flag_direction_link,d7
	cmp.w	#3,d7
	beq	on_continu_vers_le_bas


; ------- est ce qu'on vient de la droite ?
	move.w	direction_precedante,d7
	cmp.w	#1,d7
	beq	on_decale_link_bas
; ------- est ce qu'on vient de la gauche ?
	move.w	direction_precedante,d7
	cmp.w	#2,d7
	beq	on_decale_link_bas2


retour_on_decale_link_bas	

	
	move.w	#3,flag_direction_link		;flag … bas mis … 3
	move.w	#3,direction_precedante
	add.w	#1,count_anim_link	
		
; ------- on cible vers les sprites qui vont bien	
	move.w	flag_porte_item,d7
	cmp.w	#1,d7
	beq	link_porte_un_truc4

link_ne_porte_rien4:
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	move.w	#7,nbr_anim_link
	jmp	retour_test_de_touches

link_porte_un_truc4:
	move.l	#tbl_animation_porte_item_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM	
	move.w	#7,nbr_anim_link	
	jmp	retour_test_de_touches

; on vient de la droite
on_decale_link_bas:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	bsr	on_sauve_le_fond_item16x16	
	bsr	on_sauve_le_fond_8x24
	jmp	retour_on_decale_link_bas

; on vient de la gauche
on_decale_link_bas2:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	add.l	#8,sprite_link_ECRAN
	add.l	#8,fond_link
	add.l	#8,sprite_item_ECRAN
	add.l	#8,fond_item

	move.l	#tbl_anim_porte_buisson4,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
	move.l	pointeur_table_anim_item,a3
	move.l	(a3),sprite_item_RAM


	bsr	on_sauve_le_fond_8x24
	bsr	on_sauve_le_fond_item16x16
	jmp	retour_on_decale_link_bas


on_continu_vers_le_bas:	
; -------------------------------------------------------
; --------------- VITESSE DES ANIMATIONS ----------------
; -------------------------------------------------------
	add.w	#1,vitesse_anim_link
	move.w	vitesse_anim_link,d7
	cmp.w	#vitesse_bas,d7
	bne	retour_test_de_touches
	move.w	#0,vitesse_anim_link

; -------------------------------------------------------
; ------------ Mise … jour des coordonn‚es --------------
; -------------------------------------------------------
	add.w	#2,link_posY			; on met … jour les coordonn‚es
	move.w	link_posY,d0
	add.w	#2,item_posY
	
; on test si on touche le bord de l'‚cran
	move.w	#$0,posY_link_bord_haut
	cmp.w	#170,d0
	beq	link_sort_bas

; -------------------------------------------------------
; ----------- Test des collisions avec le decors --------
; -------------------------------------------------------
	bsr	collision_link_bas
	move.w	no_tile,d0

; est-ce que l'on est dans une maison ?
	move.w	flag_maison,d1
	cmp.w	#0,d1
	bne	test_maison_bas

; test de tuile de la foret
test_foret_bas:
	cmp.w	#tile_porte_tronc_bas,d0
	bne	test_murs_bas
	move.w	PosY_arrivee1_haut,posY_link_bord_haut
	jmp	link_sort_bas
	
; test de tuile des maisons
test_maison_bas:
	cmp.w	#tile_porte_maison_bas,d0
	bne	test_murs_bas
	jmp	link_revient_foret

; test si link touche un murs
test_murs_bas:
	cmp.w	no_tile_murs,d0
	bgt	stop_link_bas
	
; -------------------------------------------------------
; ---------------- Compteur D'animations ----------------
; -------------------------------------------------------
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

	add.w	#1,count_anim_link		; on incr‚mente le compteur d'animation
	move.w	count_anim_link,d7		; on verifie l'animation en cours
	cmp.b	nbr_anim_link,d7				; pour l'inertie de link
	beq	reinit_count_anim_link3		; on la remet … zero
retour_reinit_count_anim_link3:			; sinon on continu l'animation
		
; on va chercher l'animation suivante
	move.l	pointeur_table_anim_link,a0	; on r‚cupŠre le pointeur de la derniŠre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe … l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_bas		; sinon on continue d'avancer le pointeur
retour_reinit_anim_link_bas:	
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupŠre l'adresse du sprite
	add.l	#160*2,sprite_link_ECRAN
	add.l	#160*2,fond_link
	add.l	#160*2,sprite_item_ECRAN
	add.l	#160*2,fond_item
	bsr	on_sauve_le_fond_item16x16
	bsr	on_sauve_le_fond_8x24
	jmp	boucle_principale

reinit_anim_link_bas:
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.w	#0,count_anim_link
	jmp	retour_reinit_anim_link_bas
reinit_count_anim_link3:
	move.w	#0,count_anim_link
	bsr	on_sauve_le_fond_8x24
	bsr	on_sauve_le_fond_item16x16
	jmp	retour_reinit_count_anim_link3

; -----------------------------------------------------------
; ----------------- Link sort de l'‚cran --------------------
; -----------------------------------------------------------
link_sort_bas:
; on d‚fini les animation … utiliser
	move.l	#tbl_animation_link_sort_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
; on met … jour l'affichage
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
; on anim link qui sort de l'‚cran
	bsr	boucle_3
; on fait scroller vers le bon ‚cran
	bsr	vers_le_bas


link_revient_bas:
; on met … jour les animations et l'affichage
	bsr	on_sauve_le_fond_8x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_animation_link_revient_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	move.w	#$3B,flag_direction_link
; on anim link qui sort de l'‚cran
	bsr	boucle_3
; on met … jour le type d'animation pr‚c‚dante de link
	move.l	type_animation_link,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	bsr	on_affiche_sprite_8x24
	bsr	link_scroll_fin
; on test si on porte un truc
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	NOUVELLE_PIECE
	bsr	on_affiche_item_32x16
	jmp	NOUVELLE_PIECE
	
stop_link_bas:
	sub.w	#2,link_posY			; si on arrive ici c'est que l'on s'est d‚plac‚ en tout de 16 coordon‚es
	move.w	#0,count_anim_link		; on re`‚initialise le no d'animation de link
	sub.w	#2,item_posY
	move.l	type_animation_link,a0		; on cible l'animatyion de d‚part
	move.l	a0,pointeur_table_anim_link	; on sauve le pointeur
	move.l	(a0),sprite_link_RAM		; on r‚cupŠre l'adresse du sprite
	bsr	on_remet_le_fond_8x24		; on efface le sprite
	bsr	on_remet_le_fond_item16x16
	bsr	on_sauve_le_fond_8x24		; on sauve le fond
	bsr	on_sauve_le_fond_item16x16
	bsr	link				; on affiche link
	bsr	items
	move.w	#0,flag_direction_link		; il ne bouge plus
	jmp	boucle_principale
