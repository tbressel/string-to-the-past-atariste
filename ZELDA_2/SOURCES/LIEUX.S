; ********************************************************
; ********************************************************
; ************** LINK ENTRE DANS UNE MAISON **************
; ********************************************************
; ********************************************************
link_entre_maison:
	bsr	on_remet_le_fond_8x24

; on signal que l'on est dans une maison
	move.w	#1,flag_maison
	move.w	#0,flag_foret

; on defini les murs du mouveau tile set
	move.w	#tile_murs_maison,no_tile_murs

; on m‚morise les variable de retour de link
	move.l	sprite_link_ECRAN,sprite_link_retour_ECRAN
	move.w	link_posX,link_retour_posX
	move.w	link_posY,link_retour_posY	
	move.l	adr_piece,adr_piece_retour
	move.w	no_piece,no_piece_retour

; on s‚lŠctionne la maison dans laquelle on entre
	move.w	no_piece,d0
	cmp.w	#12,d0
	beq	conf_maison_12
	cmp.w	#40,d0
	beq	conf_maison_40
retour_affiche_porte:	
	move.l	sprite_link_ECRAN,pointeur_ecran
	sub.l	#160*4,pointeur_ecran
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_porte_maison_ouverte,a1
	move.l	a1,adr_tile_ram
	bsr	on_affiche_la_tile_a_lecran	
pas_de_porte_a_afficher:
	bsr	on_sauve_le_fond_8x24

; animation de link qui entre dans la maison	
	move.l	#tbl_animation_link_sort_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	bsr	on_affiche_sprite_8x24
	bsr	boucle_3
	move.w	#haut_entre,flag_direction_link
	move.l	#bin_palette_maisons,A3
	bsr	charge_palette		;on charge la palette en RAM
	bsr	ecran_de_tiles
	
; animation de link qui arrive dans la maison
	move.w	#112,link_posX
	move.w	#162,link_posY
	bsr	calcul_link_ecran	; positionnement … l'‚cran avec les coordonn‚es
	bsr	on_sauve_le_fond_8x24
	move.l	#tbl_animation_link_revient_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	
	bsr	on_affiche_sprite_8x24
	bsr	boucle_3	
	move.w	#haut,flag_direction_link
	move.l	#tbl_animation_link_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	jmp	boucle_principale





; ********************************************************
; ********************************************************
; ************* LINK REVIENT DANS LA FORET ***************
; ********************************************************
; ********************************************************
link_revient_foret:

; on signal que l'on est dans la foret
	move.w	#0,flag_maison
	move.w	#1,flag_foret

; link sort de la maison
	bsr	on_remet_le_fond_8x24
	move.l	#tbl_animation_link_sort_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	bsr	on_affiche_sprite_8x24
	bsr	boucle_3
	move.w	#bas_entre,flag_direction_link


; on defini les murs du mouveau tile set
	move.w	#tile_murs_foret,no_tile_murs
	
; on replace les variable pr‚c‚dement sauv‚es
	move.l	adr_piece_retour,adr_piece
	move.l	adr_piece,adr_piece_retour
	move.w	no_piece_retour,no_piece
	move.w	link_retour_posX,link_posX
	move.w	link_retour_posY,link_posY
	move.l	sprite_link_retour_ECRAN,sprite_link_ECRAN
		
; on affiche la foret
	move.l	adr_frame_buffer,a0
	move.l	a0,adr_switch_buffer
	move.l	#bin_tileset,adr_tileset
	bsr	ecran_de_tiles
	move.l	#bin_palette_foret,a3
	;move.l	#img_hud+2,A3
	bsr	charge_palette		;on charge la palette en RAM
		

; on affiche une porte si y'en avait une	
	move.w	flag_presence_porte,d7
	cmp.w	#0,d7
	beq	on_zap_affiche_porte

	move.l	sprite_link_ECRAN,pointeur_ecran
	sub.l	#160*2,pointeur_ecran
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_porte_maison_ouverte,a1
	move.l	a1,adr_tile_ram
	bsr	on_affiche_la_tile_a_lecran	
on_zap_affiche_porte
	bsr	on_sauve_le_fond_8x24
	
; animation de link qui sort de la maison
	
	bsr	calcul_link_ecran	; positionnement … l'‚cran avec les coordonn‚es
	bsr	on_sauve_le_fond_8x24
	move.l	#tbl_animation_link_revient_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	
	bsr	on_affiche_sprite_8x24
	bsr	boucle_3


	move.w	flag_presence_porte,d7
	cmp.w	#0,d7
	beq	on_zap_affiche_porte2

	move.l	sprite_link_ECRAN,a0
	;sub.l	#160*4,a0
	move.l	a0,pointeur_ecran
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_porte_maison,a1
	move.l	a1,adr_tile_ram
	move.l	adr_piece,adr_piece_retour
	bsr	on_affiche_la_tile_a_lecran
on_zap_affiche_porte2
	
	bsr	on_sauve_le_fond_8x24
	
	
	move.w	#bas,flag_direction_link
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM
	jmp	boucle_principale
