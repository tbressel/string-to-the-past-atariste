; ***************************************************************
; ***************************************************************
; ********************** LINK VA A DROITE ***********************
; ***************************************************************
; ***************************************************************
link_droite:
; ------- est ce qu'on allait d‚j… vers la droite ?
	move.w	flag_direction_link,d7
	cmp.w	#1,d7
	beq	on_continu_vers_la_droite

; ------- est ce qu'on vient de la gauche ?
	move.w	direction_precedante,d7
	cmp.w	#2,d7
	beq	on_decale_link_droite
; ------- est ce que l'on vient du haut ?
	move.w	direction_precedante,d7
	cmp.w	#4,d7
	beq	on_decale_link_droite2
; ------- est-ce que l'on vient du bas ?
	move.w direction_precedante,d7
	cmp.w	#3,d7
	beq	on_decale_link_droite2

retour_on_decale_link_droite
	move.w	#1,flag_direction_link		;flag … droite mi a 1
	move.w	#1,direction_precedante
	add.w	#1,count_anim_link	
		
; ------- on cible vers les sprites qui vont bien	
	move.w	flag_porte_item,d7
	cmp.w	#1,d7
	beq	link_porte_un_truc

link_ne_porte_rien:
	move.l	#tbl_animation_link_droite,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	move.w	#5,nbr_anim_link
	jmp	retour_test_de_touches
link_porte_un_truc:
	move.l	#tbl_animation_porte_item_droite,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM	
	move.w	#5,nbr_anim_link
	jmp	retour_test_de_touches

on_decale_link_droite:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	add.l	#8,sprite_link_ECRAN
	add.l	#8,fond_link
	add.l	#8,sprite_item_ECRAN
	add.l	#8,fond_item
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_anim_porte_buisson,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
	move.l	pointeur_table_anim_item,a3
	move.l	(a3),sprite_item_RAM
	jmp	retour_on_decale_link_droite
on_decale_link_droite2:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	;add.l	#8,sprite_item_ECRAN
	;add.l	#8,fond_item
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_anim_porte_buisson,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
	move.l	pointeur_table_anim_item,a3
	move.l	(a3),sprite_item_RAM
	jmp	retour_on_decale_link_droite




on_continu_vers_la_droite:	
; -------------------------------------------------------
; --------------- VITESSE DES DEPLACEMENTS  -------------
; -------------------------------------------------------
	add.w	#1,vitesse_anim_link
	move.w	vitesse_anim_link,d7
	cmp.w	#vitesse_droite,d7
	bne	retour_test_de_touches
	move.w	#0,vitesse_anim_link






; -------------------------------------------------------
; ------------ Mise … jour des coordonn‚es --------------
; -------------------------------------------------------
	add.w	#4,link_posX			; on met … jour les coordonn‚es
	move.w	link_posX,d0
	add.w	#4,item_posX
	
; on test si on touche le bord de l'‚cran
	cmp.w	#$e4,d0
	beq	link_sort_droite

; -------------------------------------------------------
; ----------- Test des collisions avec le decors --------
; -------------------------------------------------------
	
	bsr	collision_link_droite
	move.w	no_tile,d0
	cmp.w	no_tile_murs,d0
	bgt	stop_link_droite


; -------------------------------------------------------
; ---------------- Compteur D'animations ----------------
; -------------------------------------------------------
	bsr	on_remet_le_fond_16x24	
	bsr	on_remet_le_fond_item16x16

	add.w	#1,count_anim_link		; on incr‚mente le compteur d'animation
	move.w	count_anim_link,d7		; on verifie l'animation en cours
	cmp.w	nbr_anim_link,d7		; pour l'inertie de link
	beq	reinit_count_anim_link		; on la remet … zero
retour_reinit_count_anim_link:			; sinon on continu l'animation
		
; on va chercher l'animation suivante
	move.l	pointeur_table_anim_item,a1
	add.l	#4,a1
	move.l	pointeur_table_anim_link,a0	; on r‚cupŠre le pointeur de la derniŠre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe … l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_droite		; sinon on continue d'avancer le pointeur
	
	move.l	a1,pointeur_table_anim_item
	move.l	(a1),sprite_item_RAM
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupŠre l'adresse du sprite
	jmp	boucle_principale

reinit_anim_link_droite:
	move.l	type_animation_item,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,a1
	move.l	(a1),sprite_item_RAM
	move.l	type_animation_link,pointeur_table_anim_link
	move.l	pointeur_table_anim_link,a0
	move.l	(a0),sprite_link_RAM
	jmp	boucle_principale
reinit_count_anim_link:
	move.w	#0,count_anim_link
	add.l	#8,sprite_link_ECRAN
	add.l	#8,fond_link
	add.l	#8,sprite_item_ECRAN
	add.l	#8,fond_item
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	jmp	retour_reinit_count_anim_link

; -----------------------------------------------------------
; ----------------- Link sort de l'‚cran --------------------
; -----------------------------------------------------------
link_sort_droite:
; on d‚finit les animations … utiliser
	move.l	#tbl_animation_link_sort_droite,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	sub.l	#8,sprite_link_ECRAN
; on met … jour l'affichage
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	bsr	on_affiche_link
; on anime link qui sort de l'‚cran
	bsr	boucle_3
; on faire scroller vers l'‚cran suivant
	bsr	vers_la_droite

link_revient_droite:
; on met … jour les animations et l'affichage
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_animation_link_revient_droite,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	move.w	#$1B,flag_direction_link
; on anime link qui revient dans l'‚cran
	bsr	boucle_3
; on met … jour le type d'animation pr‚c‚dante de link
	move.l	type_animation_link,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	bsr	on_affiche_link
	bsr	link_scroll_fin
; on test si on porte un truc
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	NOUVELLE_PIECE
	bsr	on_affiche_item_32x16

	jmp	NOUVELLE_PIECE
	



	
stop_link_droite:
	sub.w	#$10,link_posX			; si on arrive ici c'est que l'on s'est d‚plac‚ en tout de 16 coordon‚es
	move.w	#0,count_anim_link		; on re`‚initialise le no d'animation de link
	move.l	type_animation_item,a1
	move.l	a1,pointeur_table_anim_item	
	move.l	type_animation_link,a0
	move.l	a0,pointeur_table_anim_link	; on sauve le pointeur
	

	move.l	(a1),sprite_item_RAM
	move.l	(a0),sprite_link_RAM		; on r‚cupŠre l'adresse du sprite
	bsr	on_remet_le_fond_16x24		; on efface le sprite
	bsr	on_remet_le_fond_item16x16
	bsr	on_sauve_le_fond_16x24		; on sauve le fond
	bsr	on_sauve_le_fond_item16x16
	bsr	link				; on affiche link
	bsr	items
	move.w	#0,flag_direction_link		; il ne bouge plus
	jmp	boucle_principale
	
