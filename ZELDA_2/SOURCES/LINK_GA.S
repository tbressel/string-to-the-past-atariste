; ***************************************************************
; ***************************************************************
; ********************** LINK VA A GAUCHE ***********************
; ***************************************************************
; ***************************************************************
link_gauche:

; ------- est ce qu'on est entrain d'aller vers la gauche ?
	move.w	flag_direction_link,d7
	cmp.w	#2,d7
	beq	on_continu_vers_la_gauche

; ------- est ce qu'on venait de droite ?
	move.w	direction_precedante,d7
	cmp.w	#1,d7
	beq	on_decale_link_gauche

; ------- est-ce que l'on viens du bas ?
	move.w	direction_precedante,d7
	cmp.w	#3,d7
	beq	on_decale_link_gauche2

; ------- est-ce que l'on vient du haut ?
	move.w	direction_precedante,d7
	cmp.w	#4,d7
	beq	on_decale_link_gauche2

retour_on_decale_link_gauche
	move.w	#2,flag_direction_link		; flag … gauche mi a 2
	move.w	#2,direction_precedante
	add.w	#1,count_anim_link
		
	; ------- on cible vers les sprites qui vont bien	
	move.w	flag_porte_item,d7
	cmp.w	#1,d7
	beq	link_porte_un_truc2

link_ne_porte_rien2:
	move.l	#tbl_animation_link_gauche,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	move.w	#5,nbr_anim_link	
	jmp	retour_test_de_touches

link_porte_un_truc2:
	move.l	#tbl_animation_porte_item_gauche,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM	
	move.w	#5,nbr_anim_link	
	jmp	retour_test_de_touches

on_decale_link_gauche:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	sub.l	#8,sprite_link_ECRAN
	sub.l	#8,fond_link
	sub.l	#8,sprite_item_ECRAN
	sub.l	#8,fond_item
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_anim_porte_buisson2,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
	move.l	pointeur_table_anim_item,a3
	move.l	(a3),sprite_item_RAM
	jmp	retour_on_decale_link_gauche

on_decale_link_gauche2:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	sub.l	#8,sprite_link_ECRAN
	sub.l	#8,fond_link
	sub.l	#8,sprite_item_ECRAN
	sub.l	#8,fond_item
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_anim_porte_buisson2,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
	move.l	pointeur_table_anim_item,a3
	move.l	(a3),sprite_item_RAM
	jmp	retour_on_decale_link_gauche




on_continu_vers_la_gauche:	
; -------------------------------------------------------
; --------------- VITESSE DES ANIMATIONS ----------------
; -------------------------------------------------------
	add.w	#1,vitesse_anim_link
	move.w	vitesse_anim_link,d7
	cmp.w	#vitesse_gauche,d7
	bne	retour_test_de_touches
	move.w	#0,vitesse_anim_link
; -------------------------------------------------------
; ------------ Mise … jour des coordonn‚es --------------
; -------------------------------------------------------
	sub.w	#4,link_posX			; on met … jour les coordonn‚es
	move.w	link_posX,d0
	sub.w	#4,item_posX

; on test si on touche le bord de l'‚cran
	cmp.w	#-4,d0
	beq	link_sort_gauche
	
; -------------------------------------------------------
; ----------- Test des collisions avec le decors --------
; -------------------------------------------------------
	bsr	collision_link_gauche
	move.w	no_tile,d0
	cmp.w	no_tile_murs,d0
	bgt	stop_link_gauche
	
; -------------------------------------------------------
; ---------------- Compteur D'animations ----------------
; -------------------------------------------------------
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

	add.w	#1,count_anim_link		; on incr‚mente le compteur d'animation
	move.w	count_anim_link,d7		; on verifie l'animation en cours
	cmp.w	nbr_anim_link,d7				; pour l'inertie de link
	beq	reinit_count_anim_link2		; on la remet … zero
retour_reinit_count_anim_link2:			; sinon on continu l'animation
		
; on va chercher l'animation suivante
	move.l	pointeur_table_anim_item,a1
	add.l	#4,a1
	move.l	pointeur_table_anim_link,a0	; on r‚cupŠre le pointeur de la derniŠre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe … l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_gauche		; sinon on continue d'avancer le pointeur
	
	move.l	a1,pointeur_table_anim_item
	move.l	(a1),sprite_item_RAM
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupŠre l'adresse du sprite
	jmp	boucle_principale
reinit_anim_link_gauche:
	move.l	type_animation_item,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,a1
	move.l	(a1),sprite_item_RAM
	move.l	type_animation_link,pointeur_table_anim_link
	move.l	pointeur_table_anim_link,a0
	move.l	(a0),sprite_link_RAM	
	jmp	boucle_principale
reinit_count_anim_link2:
	move.w	#0,count_anim_link
	sub.l	#8,sprite_link_ECRAN
	sub.l	#8,fond_link
	sub.l	#8,sprite_item_ECRAN
	sub.l	#8,fond_item
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	jmp	retour_reinit_count_anim_link2


; -----------------------------------------------------------
; ----------------- Link sort de l'‚cran --------------------
; -----------------------------------------------------------
link_sort_gauche:
; on d‚finit les animatios … utiliser
	move.l	#tbl_animation_link_sort_gauche,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	add.l	#8,sprite_link_ECRAN
; on met … jour l'affichage
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	bsr	on_affiche_link
; on anim link qui sort de l'‚cran
	bsr	boucle_3
; on fait scroller vers l'‚cran pr‚c‚dent
	bsr	vers_la_gauche

link_revient_gauche:
; on met … jour les animations et l'affichage
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_animation_link_revient_gauche,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	sub.l	#8,sprite_link_ECRAN		; pour corriger un bug d'affichage
	move.w	#$2B,flag_direction_link
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
	
	
	
stop_link_gauche:
	add.w	#$4,link_posX			; si on arrive ici c'est que l'on s'est d‚plac‚ en tout de 16 coordon‚es
	move.w	#0,count_anim_link		; on re`‚initialise le no d'animation de link
	add.w	#$4,item_posX
	move.l	type_animation_item,a1
	move.l	a1,pointeur_table_anim_item
	move.l	(a1),sprite_item_RAM
	
	move.l	type_animation_link,a0	; on cible l'animatyion de d‚part
	move.l	a0,pointeur_table_anim_link	; on sauve le pointeur
	move.l	(a0),sprite_link_RAM		; on r‚cupŠre l'adresse du sprite
	
	bsr	on_remet_le_fond_16x24		; on efface le sprite
	bsr	on_remet_le_fond_item16x16
	bsr	on_sauve_le_fond_16x24		; on sauve le fond
	bsr	on_sauve_le_fond_item16x16
	bsr	link				; on affiche link
	bsr	items
	move.w	#0,flag_direction_link		; il ne bouge plus
	jmp	boucle_principale
