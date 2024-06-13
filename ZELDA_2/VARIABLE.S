; -----------------------------------------------------------
; ------------------------ AFFICHAGE ------------------------
; -----------------------------------------------------------

; *********************************************************
; ********************  SPRITE DE LINK ********************
; *********************************************************

sprite_link_RAM:		; adr. du sprite dans la ram
	ds.l	1
sprite_link_ECRAN:		; adr. du sprite … l'‚cran
	ds.l	1
sprite_link_retour_ECRAN:	; sauvegarde adr. sprite ‚cran 
	ds.l	1
fond_link:			; adr. o— est sauvegard‚ le fond o— est link
	ds.l	1

link_posX:			; coordonn‚e X de link
	ds.w	1
link_posY:			; coordonn‚e Y de link
	ds.w	1
link_retour_posX:		; coordonn‚e X sauv‚e de Link 
	ds.w	1
link_retour_posY:		; coordonn‚e Y sauv‚e de Link
	ds.w	1
posY_link_bord_haut:		; coordonn‚e Y de link qui revient en haut
	ds.w	1
posY_link_bord_bas:
	ds.w	1
posX_link_bord_gauche:
	ds.w	1
posX_link_bord_droite:
	ds.w	1
collision_X:
	ds.w	1
collision_Y:
	ds.w	1
adr_tile_collision:
	ds.l	1
vitesse_anim_link:
	ds.w	1
vitesse_anim_item_boom:
	ds.w	1
flag_direction_link:		; 1 (droite)
	ds.w	1
direction_precedante:
	ds.w	1
flag_fireA:
	ds.w	1
flag_choppe_buisson:
	ds.w	1
flag_porte_buisson:
	ds.w	1
flag_porte_item:
	ds.w	1
type_animation_item:
	ds.l	1
etape_choppe_buisson:
	ds.w	1
sprite_item_RAM:
	ds.l	1
sprite_item_ECRAN:
	ds.l	1
fond_item:
	ds.l	1
item_posX:
	ds.w	1
item_posY:
	ds.w	1
pointeur_table_anim_item:
	ds.l	1

sprite_sfx_RAM:
	ds.l	1
sprite_sfx_ECRAN:
	ds.l	1
fond_sfx:
	ds.l	1

nbr_anim_link:
	ds.w	1
type_animation_link:
	ds.l	1
pointeur_table_anim_link:
	ds.l	1
count_anim_link:
	ds.w	1






; ****************************************************

adr_stack:
	ds.l	1
adr_stack_retour:
	ds.l	1
adr_ecran:
	ds.l	1
adr_switch_buffer:
	ds.l	1
adr_tile_ram:
	ds.l	1
adr_tileset:
	ds.l	1
palette_gem:
	ds.w	16
resolution:
	ds.w	1
retour_utilisateur:
	ds.l	1

pointeur_maptile:
	ds.l	1
pointeur_ecran:
	ds.l	1
pointeur_ecran_Y:
	ds.l	1
adr_piece:
	ds.l	1
adr_piece_retour:
	ds.l	1
no_piece:
	ds.w	1
no_piece_retour:
	ds.w	1
no_tile_murs:
	ds.w	1
direction_scroll:
	ds.b	2

frame_counter:
	ds.w	1



; -------------------------------------------------------
; ---- Variable de l'affichage & animation de LINK ------
; -------------------------------------------------------

; -------------------------------------------------------
; -------------------------------------------------------
; -------------------------------------------------------




; -------------------------------------------------
; ------------------- FLAGS -----------------------
; -------------------------------------------------

flag_ecran:
	ds.b	2
flag_maison:
	ds.w	1
flag_presence_porte:
	ds.w	1
flag_foret:
	ds.w	1
no_tile:
	ds.w	1




tbl_anim_items:
	ds.l	4
compteur_buisson_boom:
	ds.w	1


stock_palette_fade_out:
	ds.w	16	
