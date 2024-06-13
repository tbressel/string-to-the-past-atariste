; ***************************************************************
; ***************************************************************
; **********************  LINK VA EN HAUT  ***********************
; ***************************************************************
; ***************************************************************
link_haut:
; ------- est ce qu'on allait d‚j… vers le haut ?
	move.w	flag_direction_link,d7
	cmp.w	#4,d7
	beq	on_continu_vers_le_haut

; ------- est ce qu'on vient de la droite ?
	move.w	direction_precedante,d7
	cmp.w	#1,d7
	beq	on_decale_link_haut
; ------- est ce qu'on vient de la gauche ?
	move.w	direction_precedante,d7
	cmp.w	#2,d7
	beq	on_decale_link_haut2
retour_on_decale_link_haut	


	move.w	#4,flag_direction_link		;flag … haut mis … 4
	move.w	#4,direction_precedante
	add.w	#1,count_anim_link	

; ------- on cible vers les sprites qui vont bien	
	move.w	flag_porte_item,d7
	cmp.w	#1,d7
	beq	link_porte_un_truc3

link_ne_porte_rien3:
	move.l	#tbl_animation_link_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	move.w	#7,nbr_anim_link
	jmp	retour_test_de_touches

link_porte_un_truc3:
	move.l	#tbl_animation_porte_item_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM	
	move.w	#7,nbr_anim_link	
	jmp	retour_test_de_touches

; quand on vient de la droite
on_decale_link_haut:
	bsr	on_remet_le_fond_16x24
	bsr	on_sauve_le_fond_8x24
	jmp	retour_on_decale_link_haut

; quand on vient de la gauche
on_decale_link_haut2:
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
	jmp	retour_on_decale_link_haut

on_continu_vers_le_haut:	
; -------------------------------------------------------
; --------------- VITESSE DES ANIMATIONS ----------------
; -------------------------------------------------------
	add.w	#1,vitesse_anim_link
	move.w	vitesse_anim_link,d7
	cmp.w	#vitesse_haut,d7
	bne	retour_test_de_touches
	move.w	#0,vitesse_anim_link

; -------------------------------------------------------
; ------------ Mise … jour des coordonn‚es --------------
; -------------------------------------------------------
	sub.w	#2,link_posY			; on met … jour les coordonn‚es
	move.w	link_posY,d0
	sub.w	#2,item_posY
	
; on test si on touche le bord de l'‚cran
	move.w	#$A8,posY_link_bord_bas
	cmp.w	#-2,d0
	beq	link_sort_haut

; -------------------------------------------------------
; ----------- Test des collisions avec le decors --------
; -------------------------------------------------------
	bsr	collision_link_haut
	move.w	no_tile,d0
	
; on test si on entre dans un tronc
	cmp.w	#tile_porte_tronc_haut,d0
	bne	on_zap_entre_tronc_haut
	move.w	PosY_arrivee1_bas,posY_link_bord_bas
	jmp	link_sort_haut
on_zap_entre_tronc_haut

; on test si on entre dans une maison
	cmp.w	#tile_porte_maison,d0
	beq	link_entre_maison
	cmp.w	#tile_porte_maison_ouverte,d0
	beq	link_entre_maison
	
	
	cmp.w	no_tile_murs,d0
	bgt	stop_link_haut


; -------------------------------------------------------
; ---------------- Compteur D'animations ----------------
; -------------------------------------------------------
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	
	add.w	#1,count_anim_link		; on incr‚mente le compteur d'animation
	move.w	count_anim_link,d7		; on verifie l'animation en cours
	cmp.b	nbr_anim_link,d7		; pour l'inertie de link
	beq	reinit_count_anim_link4		; on la remet … zero
retour_reinit_count_anim_link4:			; sinon on continu l'animation
		
; on va chercher l'animation suivante
	move.l	pointeur_table_anim_link,a0	; on r‚cupŠre le pointeur de la derniŠre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe … l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_haut		; sinon on continue d'avancer le pointeur

retour_reinit_anim_link_haut:	
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupŠre l'adresse du sprite
	sub.l	#160*2,sprite_link_ECRAN
	sub.l	#160*2,fond_link
	sub.l	#160*2,sprite_item_ECRAN
	sub.l	#160*2,fond_item
	bsr	on_sauve_le_fond_item16x16
	bsr	on_sauve_le_fond_8x24
	jmp	boucle_principale

reinit_anim_link_haut:
	move.l	#tbl_animation_link_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.w	#0,count_anim_link
	jmp	retour_reinit_anim_link_haut

reinit_count_anim_link4:
	move.w	#0,count_anim_link
	bsr	on_sauve_le_fond_8x24
	bsr	on_sauve_le_fond_item16x16
	jmp	retour_reinit_count_anim_link4

; -----------------------------------------------------------
; ----------------- Link sort de l'‚cran --------------------
; -----------------------------------------------------------
link_sort_haut:
; on d‚finit les animations … utiliser
	move.l	#tbl_animation_link_sort_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
; on met … jour l'affichage
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
; on anim link qui sort de l'‚cran
	bsr	boucle_3
; on scroll vers l'‚cran du dessus
	bsr	vers_le_haut


link_revient_haut:
; on met … jour les animations et l'affichage
	bsr	on_sauve_le_fond_8x24
	bsr	on_sauve_le_fond_item16x16
	move.l	#tbl_animation_link_revient_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	move.w	#$4B,flag_direction_link
; on anime link qui revient dans l'‚cran
	bsr	boucle_3
; on met … jour l'animation de link avec sa forme pr‚c‚dante
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
	

	
stop_link_haut:
	add.w	#2,link_posY			; si on arrive ici c'est que l'on s'est d‚plac‚ en tout de 16 coordon‚es
	move.w	#0,count_anim_link		; on re`‚initialise le no d'animation de link
	add.w	#2,item_posY	
	move.l	type_animation_link,a0
	move.l	a0,pointeur_table_anim_link	; on sauve le pointeur
	move.l	(a0),sprite_link_RAM		; on r‚cupŠre l'adresse du sprite
	bsr	on_remet_le_fond_8x24		; 
	bsr	on_remet_le_fond_item16x16
	bsr	on_sauve_le_fond_8x24		; on sauve le fond
	bsr	on_sauve_le_fond_item16x16
	bsr	link
	bsr	items
	move.w	#0,flag_direction_link		; il ne bouge plus
	jmp	boucle_principale

;calcul_posY_arrivee_haut1:
	;move.l	#tbl_	
	;jmp	link_sort_haut



