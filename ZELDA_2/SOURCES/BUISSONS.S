link_buisson:
; -------------------------------------------------------
; --------------- VITESSE DES ANIMATIONS ----------------
; -------------------------------------------------------
	;add.w	#1,vitesse_anim_link
	;move.w	vitesse_anim_link,d7
	;cmp.w	#vitesse_choppe_item,d7
	;bne	retour_link
	;move.w	#0,vitesse_anim_link

	move.w	#1,flag_fireA

	move.l	#tbl_anim_buisson,a0
	move.l	#tbl_anim_items,a1
	REPT	4
	move.l	(a0)+,(a1)+	
	ENDR

	move.w	direction_precedante,d7
	cmp.w	#droite,d7
	beq	link_buisson_droite
	cmp.w	#gauche,d7
	beq	link_buisson_gauche
	cmp.w	#haut,d7
	beq	link_buisson_haut
	cmp.w	#bas,d7
	beq	link_buisson_bas
	;jmp	retour_link
	jmp	retour_link
; *********************************************************
; *********************************************************
; *************** LINK PORTE BUISSON A DROITE *************
; *********************************************************
; *********************************************************

link_buisson_droite:
	move.w	etape_choppe_buisson,d7
	cmp.w	#0,d7
	beq	init_buisson_droite
	cmp.w	#1,d7
	beq	etp1_buisson_droite
	cmp.w	#2,d7
	beq	etp2_buisson_droite
	cmp.w	#3,d7
	beq	etp3_buisson_droite
	cmp.w	#4,d7
	beq	etp4_buisson_droite
	cmp.w	#5,d7
	beq	fin_buisson_droite

init_buisson_droite:
; on declare que link est en train de chopper un buisson
	move.w	#1,flag_choppe_buisson
	move.w	#1,flag_porte_buisson
	move.w	#1,flag_porte_item

; --- Link anim 1 & buisson anim 1
; --------------------------------
	bsr	on_remet_le_fond_16x24
	
	move.l	sprite_link_RAM,sprite_item_RAM
	move.l	sprite_link_ECRAN,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item
	

; on d‚termine … quel endroit de l'‚cran l'on doit arrachger le buisson
	move.w	collision_X,d6
	mulu.w	#8,d6
	move.w	collision_Y,d7
	mulu.w	#160*16,d7
	add.w	d6,d7
	add.l	adr_frame_buffer,d7
	move.l	d7,pointeur_ecran

; on affiche la tile du buisson arrach‚
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_buisson_coupe,a1
	move.l	a1,adr_tile_ram
	
	bsr	on_affiche_la_tile_a_lecran	
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_droite,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+4,a0
	move.l	(a0),sprite_item_RAM

	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	add.w	#1,etape_choppe_buisson
	;jmp	retour_link
	jmp	retour_link

; --- Link anim 2 & buisson anim 1
; --------------------------------
etp1_buisson_droite:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	
; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_droite,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+4,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*2,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16

	add.w	#1,etape_choppe_buisson
	;jmp	retour_link
	jmp	retour_link

; --- Link anim 2 & buisson anim 2
; --------------------------------
etp2_buisson_droite:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_droite,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+4,a0
	add.l	#4,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*2,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16

	add.w	#1,etape_choppe_buisson
	;jmp	retour_link
	jmp	retour_link


; --- Link anim 3 & buisson anim 2
; --------------------------------	
etp3_buisson_droite:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_droite,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+4,a0
	add.l	#4,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*2,sprite_item_ECRAN	
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	add.w	#1,etape_choppe_buisson
	;jmp	retour_link
	jmp	retour_link

; --- Link anim 3 & buisson anim 3
; --------------------------------
etp4_buisson_droite:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_droite,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+4,a0
	add.l	#12,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*4,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16

	add.w	#1,etape_choppe_buisson
	;jmp	retour_link
	jmp	retour_link
fin_buisson_droite:
; on met les coordonn‚es du buisson … jour
	move.w	link_posX,item_posX
	move.w	link_posY,d7
	sub.w	#2+2+2+4,d7
	move.w	d7,item_posY	
; on met le type d'animation … jour
	move.l	#tbl_anim_porte_buisson,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
; on met les flags d'‚tat … jour
	move.w	#0,etape_choppe_buisson		
	move.w	#0,flag_choppe_buisson
	move.w	#0,flag_fireA
	move.w	#1,direction_precedante
; on met la map tile … jour
	move.l	adr_tile_collision,a0		; on ‚crit dans la tilemap
	move.w	#tile_buisson_coupe,(a0)
	;jmp	retour_link
	jmp	retour_link

; *********************************************************
; *********************************************************
; *************** LINK PORTE BUISSON A GAUCHE *************
; *********************************************************
; *********************************************************
link_buisson_gauche:

	move.w	etape_choppe_buisson,d7
	cmp.w	#0,d7
	beq	init_buisson_gauche
	cmp.w	#1,d7
	beq	etp1_buisson_gauche
	cmp.w	#2,d7
	beq	etp2_buisson_gauche
	cmp.w	#3,d7
	beq	etp3_buisson_gauche
	cmp.w	#4,d7
	beq	etp4_buisson_gauche
	cmp.w	#5,d7
	beq	fin_buisson_gauche

init_buisson_gauche:
; on declare que link est en train de chopper un buisson
	move.w	#1,flag_choppe_buisson
	move.w	#1,flag_porte_buisson
	move.w	#1,flag_porte_item

; --- Link anim 1 & buisson anim 1
; --------------------------------
	bsr	on_remet_le_fond_16x24
	move.l	sprite_link_ECRAN,sprite_item_ECRAN	
	
	move.l	sprite_item_ECRAN,fond_item

; on d‚termine … quel endroit de l'‚cran l'on doit arrachger le buisson
	move.w	collision_X,d6
	mulu.w	#8,d6
	move.w	collision_Y,d7
	mulu.w	#160*16,d7
	add.w	d6,d7
	add.l	adr_frame_buffer,d7
	move.l	d7,pointeur_ecran

; on affiche la tile du buisson arrach‚
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_buisson_coupe,a1
	move.l	a1,adr_tile_ram
	
	bsr	on_affiche_la_tile_a_lecran	

	add.l	#8,sprite_link_ECRAN
	bsr	on_sauve_le_fond_16x24
	bsr	on_sauve_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_gauche,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+12,a0
	move.l	(a0),sprite_item_RAM

	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 2 & buisson anim 1
; --------------------------------
etp1_buisson_gauche:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16
	
; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_gauche,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+12,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*2,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16

	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 2 & buisson anim 2
; --------------------------------
etp2_buisson_gauche:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_gauche,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+12,a0
	sub.l	#4,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*2,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16

	add.w	#1,etape_choppe_buisson
	jmp	retour_link



; --- Link anim 3 & buisson anim 2
; --------------------------------	
etp3_buisson_gauche:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_gauche,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+12,a0
	sub.l	#8,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*2,sprite_item_ECRAN	
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 3 & buisson anim 3
; --------------------------------
etp4_buisson_gauche:
	bsr	on_remet_le_fond_16x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_gauche,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+12,a0
	sub.l	#12,a0
	move.l	(a0),sprite_item_RAM
	sub.l	#160*4,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16

	add.w	#1,etape_choppe_buisson
	jmp	retour_link
	
fin_buisson_gauche:
; on met les coordonn‚es du buisson … jour
	move.w	link_posX,item_posX
	move.w	link_posY,d7
	sub.w	#2+2+2+4,d7
	move.w	d7,item_posY
; on met le type d'animation … jour
	move.l	#tbl_anim_porte_buisson2,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
; on met les flags d'‚tat … jour
	move.w	#0,etape_choppe_buisson		
	move.w	#0,flag_choppe_buisson
	move.w	#0,flag_fireA
	move.w	#2,direction_precedante
; on met la map tile … jour
	move.l	adr_tile_collision,a0		; on ‚crit dans la tilemap
	move.w	#tile_buisson_coupe,(a0)

; Link … fini de chopper le buisson on remet les bonnes animations
	bsr	on_remet_le_fond_16x24
	sub.l	#8,sprite_link_ECRAN
	bsr	on_sauve_le_fond_16x24
	move.l	#tbl_animation_porte_item_gauche,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	bsr	on_affiche_sprite_16x24
	bsr	on_affiche_item_32x16
	jmp	retour_link



; *********************************************************
; *********************************************************
; *************** LINK PORTE BUISSON EN HAUT  *************
; *********************************************************
; *********************************************************
link_buisson_haut:

	move.w	etape_choppe_buisson,d7
	cmp.w	#0,d7
	beq	init_buisson_haut
	cmp.w	#1,d7
	beq	etp1_buisson_haut
	cmp.w	#2,d7
	beq	etp2_buisson_haut
	cmp.w	#3,d7
	beq	etp3_buisson_haut
	cmp.w	#4,d7
	beq	etp4_buisson_haut
	cmp.w	#5,d7
	beq	fin_buisson_haut

init_buisson_haut:
; on declare que link est en train de chopper un buisson
	move.w	#1,flag_choppe_buisson
	move.w	#1,flag_porte_buisson
	move.w	#1,flag_porte_item

; --- Link anim 1 & buisson anim 1
; --------------------------------
	bsr	on_remet_le_fond_8x24
	move.l	sprite_link_ECRAN,sprite_item_ECRAN	
	move.l	sprite_item_ECRAN,fond_item

; on d‚termine … quel endroit de l'‚cran l'on doit arrachger le buisson
	move.w	collision_X,d6
	mulu.w	#8,d6
	move.w	collision_Y,d7
	mulu.w	#160*16,d7
	add.w	d6,d7
	add.l	adr_frame_buffer,d7
	move.l	d7,pointeur_ecran

; on affiche la tile du buisson arrach‚
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_buisson_coupe,a1
	move.l	a1,adr_tile_ram
	
	bsr	on_affiche_la_tile_a_lecran	

	bsr	on_sauve_le_fond_8x24
	bsr	on_sauve_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_haut,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+16,a0
	move.l	(a0),sprite_item_RAM

	bsr	on_affiche_item_32x16
	bsr	on_affiche_sprite_8x24
	
	
	
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 2 & buisson anim 1
; --------------------------------
etp1_buisson_haut:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	
; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_haut,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM	

	sub.l	#160*2,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_item_32x16
	bsr	on_affiche_sprite_8x24
	
		
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 2 & buisson anim 2
; --------------------------------
etp2_buisson_haut:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_haut,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM
	sub.l	#160*2,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_item_32x16
	bsr	on_affiche_sprite_8x24
		
	add.w	#1,etape_choppe_buisson
	jmp	retour_link



; --- Link anim 3 & buisson anim 2
; --------------------------------	
etp3_buisson_haut:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_haut,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	sub.l	#160*2,sprite_item_ECRAN	
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_item_32x16
	bsr	on_affiche_sprite_8x24
		
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 3 & buisson anim 3
; --------------------------------
etp4_buisson_haut:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_haut,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	sub.l	#160*4,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_item_32x16
	bsr	on_affiche_sprite_8x24
				
	add.w	#1,etape_choppe_buisson
	jmp	retour_link
	
fin_buisson_haut:
; on met les coordonn‚es du buisson … jour
	move.w	link_posX,item_posX
	move.w	link_posY,d7
	sub.w	#2+2+2+4,d7
	move.w	d7,item_posY
; on met le type d'animation … jour
	move.l	#tbl_anim_porte_buisson3,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
; on met les flag d'‚tat … jour
	move.w	#0,etape_choppe_buisson		
	move.w	#0,flag_choppe_buisson
	move.w	#0,flag_fireA
	move.w	#3,direction_precedante
; on met la map tiler … jour
	move.l	adr_tile_collision,a0		; on ‚crit dans la tilemap
	move.w	#tile_buisson_coupe,(a0)
; on remet les bonnes animations
	bsr	on_remet_le_fond_8x24
	sub.l	#8,sprite_link_ECRAN
	bsr	on_sauve_le_fond_8x24
	move.l	#tbl_animation_porte_item_haut,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	add.l	#8,sprite_link_ECRAN
	bsr	on_affiche_item_32x16
	bsr	on_affiche_sprite_8x24
	jmp	retour_link



; *********************************************************
; *********************************************************
; *************** LINK PORTE BUISSON EN BAS   *************
; *********************************************************
; *********************************************************
link_buisson_bas:

	move.w	etape_choppe_buisson,d7
	cmp.w	#0,d7
	beq	init_buisson_bas
	cmp.w	#1,d7
	beq	etp1_buisson_bas
	cmp.w	#2,d7
	beq	etp2_buisson_bas
	cmp.w	#3,d7
	beq	etp3_buisson_bas
	cmp.w	#4,d7
	beq	etp4_buisson_bas
	cmp.w	#5,d7
	beq	fin_buisson_bas

init_buisson_bas:
; on declare que link est en train de chopper un buisson
	move.w	#1,flag_choppe_buisson
	move.w	#1,flag_porte_buisson
	move.w	#1,flag_porte_item

; --- Link anim 1 & buisson anim 1
; --------------------------------
	bsr	on_remet_le_fond_8x24
	move.l	sprite_link_ECRAN,sprite_item_ECRAN	
	move.l	sprite_item_ECRAN,fond_item

; on d‚termine … quel endroit de l'‚cran l'on doit arrachger le buisson
	move.w	collision_X,d6
	mulu.w	#8,d6
	move.w	collision_Y,d7
	mulu.w	#160*16,d7
	add.w	d6,d7
	add.l	adr_frame_buffer,d7
	move.l	d7,pointeur_ecran

; on affiche la tile du buisson arrach‚
	move.l	#bin_tileset,a1
	add.l	#16*8*tile_buisson_coupe,a1
	move.l	a1,adr_tile_ram
	
	bsr	on_affiche_la_tile_a_lecran	

	bsr	on_sauve_le_fond_8x24
	add.l	#160*24,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item
	bsr	on_sauve_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_bas,a0
	move.l	(a0),sprite_link_RAM
	move.l	#tbl_anim_buisson+16,a0
	move.l	(a0),sprite_item_RAM
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 2 & buisson anim 1
; --------------------------------
etp1_buisson_bas:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16
	
; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_bas,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM	

	sub.l	#160*6,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 2 & buisson anim 2
; --------------------------------
etp2_buisson_bas:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_bas,a0
	add.l	#4,a0
	move.l	(a0),sprite_link_RAM
	sub.l	#160*6,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item

	bsr	on_sauve_le_fond_item16x16
	
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link



; --- Link anim 3 & buisson anim 2
; --------------------------------	
etp3_buisson_bas:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_haut,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	sub.l	#160*6,sprite_item_ECRAN	
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
	
	add.w	#1,etape_choppe_buisson
	jmp	retour_link


; --- Link anim 3 & buisson anim 3
; --------------------------------
etp4_buisson_bas:
	bsr	on_remet_le_fond_8x24
	bsr	on_remet_le_fond_item16x16

; on affiche link qui se baisse pour prendre le buisson
	move.l	#tbl_anim_link_arrache_bas,a0
	add.l	#8,a0
	move.l	(a0),sprite_link_RAM
	sub.l	#160*12,sprite_item_ECRAN
	move.l	sprite_item_ECRAN,fond_item
	
	bsr	on_sauve_le_fond_item16x16
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
			
	add.w	#1,etape_choppe_buisson
	jmp	retour_link
	
fin_buisson_bas:
; on met les coordonn‚es du buisson … jour
	move.w	link_posX,item_posX
	move.w	link_posY,d7
	sub.w	#6+6+12,d7
	move.w	d7,item_posY
; on met le type d'animation … jour
	move.l	#tbl_anim_porte_buisson4,pointeur_table_anim_item
	move.l	pointeur_table_anim_item,type_animation_item
; on met les flags d'‚tat … jour
	move.w	#0,etape_choppe_buisson		
	move.w	#0,flag_choppe_buisson
	move.w	#0,flag_fireA
	move.w	#4,direction_precedante
; on met la map tile … jour
	move.l	adr_tile_collision,a0		; on ‚crit dans la tilemap
	move.w	#tile_buisson_coupe,(a0)
; on remet les bonnes animations
	bsr	on_remet_le_fond_8x24
	sub.l	#8,sprite_link_ECRAN
	bsr	on_sauve_le_fond_8x24
	move.l	#tbl_animation_porte_item_bas,a0
	move.l	a0,pointeur_table_anim_link
	move.l	a0,type_animation_link
	move.l	(a0),sprite_link_RAM
	add.l	#8,sprite_link_ECRAN
	bsr	on_affiche_sprite_8x24
	bsr	on_affiche_item_32x16
		
	jmp	retour_link

; *************************************************************
; *********************  BUISSON BOUUUUM **********************
; *************************************************************
buisson_boom:
; -------------------------------------------------------
; --------------- VITESSE DES DEPLACEMENTS  -------------
; -------------------------------------------------------
;	add.w	#1,vitesse_anim_item_boom
;	move.w	#5,d7
;	cmp.w	#vitesse_droite,d7
;	bne	retour_buisson_boom
;	move.w	#0,vitesse_anim_link


	add.w	#1,compteur_buisson_boom
	move.w	compteur_buisson_boom,d7
	cmp.w	#1,d7
	beq	etp1_buisson_boom
	cmp.w	#2,d7
	beq	etp2_buisson_boom
	cmp.w	#3,d7
	beq	etp3_buisson_boom
	cmp.w	#4,d7
	beq	etp4_buisson_boom	
	cmp.w	#5,d7
	beq	etp5_buisson_boom
	cmp.w	#6,d7
	beq	etp6_buisson_boom
	cmp.w	#7,d7
	beq	etp7_buisson_boom
	cmp.w	#8,d7
	beq	fin_buisson_boom
etp1_buisson_boom:
	move.l	#tbl_anim_buisson_boom,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
etp2_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.l	#tbl_anim_buisson_boom+4,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
etp3_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.l	#tbl_anim_buisson_boom+8,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
etp4_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.l	#tbl_anim_buisson_boom+12,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
etp5_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.l	#tbl_anim_buisson_boom+16,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
etp6_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.l	#tbl_anim_buisson_boom+20,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
etp7_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.l	#tbl_anim_buisson_boom+24,a0
	move.l	(a0),sprite_sfx_RAM
	bsr	on_affiche_sfx_32x43	
	jmp	retour_buisson_boom
fin_buisson_boom:
	bsr	on_remet_le_fond_sfx16x43
	move.w	#0,event_buisson_boom		
	move.l	#0,event_buisson_boom+2
	move.w	#0,compteur_buisson_boom
	move.l	direction_precedante,d0
	bsr	link2

	jmp	retour_buisson_boom