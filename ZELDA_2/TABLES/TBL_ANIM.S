; Fichier contenant les tables d'adressage m‚moire des animation
; des diff‚rents sprites. Dans l'ordre :
; 	-	Animations de Link
;	-	Animation du buisson

; --------------------------------------------------------------
; --------------------------------------------------------------


; ************************************************************
; ******************** ANIMATIONS DE LINK ********************
; ************************************************************


; *************************   GAUCHE   ***********************

; ----- Animation de Link quand il marche vers la gauche -----
tbl_animation_link_gauche:
	dc.l	bin_sprites_link+32000,bin_sprites_link+32000+384,bin_sprites_link+32000+384*2,bin_sprites_link+32000+384*3
	dc.l	bin_sprites_link+32000+384*4,bin_sprites_link+32000+384*5,bin_sprites_link+32000+384*6,bin_sprites_link+32000+384*7
	dc.l	$FFFFFFFF	

; ----- Animation de Link quand il porte un item vers la gauche -----
tbl_animation_porte_item_gauche:
	dc.l	bin_sprites_link+32000+384*44,bin_sprites_link+32000+384*45
	dc.l	bin_sprites_link+32000+384*46,bin_sprites_link+32000+384*47
	dc.l	$FFFFFFFF	

; ----- Animation de Link quand il arrache l'herbe       -----
tbl_anim_link_arrache_gauche:
	dc.l	bin_sprites_link_suite+192*120,bin_sprites_link_suite+192*121,bin_sprites_link_suite+192*122
tbl_anim_porte_buisson2:
	dc.l	bin_sprites_items1+256*4,bin_sprites_items1+256*3
	dc.l	bin_sprites_items1+256*2,bin_sprites_items1+256







; *************************   DROITE   ***********************

; ----- Animation de Link quand il marche vers la droite -----
tbl_animation_link_droite:
	dc.l	bin_sprites_link,bin_sprites_link+384,bin_sprites_link+384*2,bin_sprites_link+384*3
	dc.l	bin_sprites_link+384*4,bin_sprites_link+384*5,bin_sprites_link+384*6,bin_sprites_link+384*7
	dc.l	$FFFFFFFF	

; ----- Animation de Link quand il porte un item vers la droite -----
tbl_animation_porte_item_droite:
	dc.l	bin_sprites_link+384*44,bin_sprites_link+384*45
	dc.l	bin_sprites_link+384*46,bin_sprites_link+384*47
	dc.l	$FFFFFFFF	

; ----- Animation de Link quand il arrache l'herbe       -----
tbl_anim_link_arrache_droite:
	dc.l	bin_sprites_link_suite+192*80,bin_sprites_link_suite+192*81,bin_sprites_link_suite+192*82
tbl_anim_porte_buisson:
	dc.l	bin_sprites_items1,bin_sprites_items1+256
	dc.l	bin_sprites_items1+256*2,bin_sprites_items1+256*3






; **************************   HAUT   *************************
; ----- Animation de Link quand il marche vers le haut    -----
tbl_animation_link_haut:
	dc.l	bin_sprites_link_suite+192*40,bin_sprites_link_suite+192*41
	dc.l	bin_sprites_link_suite+192*42,bin_sprites_link_suite+192*43
	dc.l	bin_sprites_link_suite+192*44,bin_sprites_link_suite+192*45
	dc.l	$FFFFFFFF
	
; ----- Animation de Link quand il porte un item vers le haut   -----
tbl_animation_porte_item_haut:
	dc.l	bin_sprites_link_suite+192*128,bin_sprites_link_suite+192*129
	dc.l	bin_sprites_link_suite+192*130,bin_sprites_link_suite+192*131
	dc.l	bin_sprites_link_suite+192*132,bin_sprites_link_suite+192*133
	dc.l	bin_sprites_link_suite+192*134
	dc.l	$FFFFFFFF	

; ----- Animation de Link quand il arrache l'herbe en haut -----
tbl_anim_link_arrache_haut:
	dc.l	bin_sprites_link_suite+192*124,bin_sprites_link_suite+192*125,bin_sprites_link_suite+192*126
tbl_anim_porte_buisson3:
	dc.l	bin_sprites_items1+256,bin_sprites_items1+256
	dc.l	bin_sprites_items1+256,bin_sprites_items1+256







; **************************   BAS   *************************
; ----- Animation de Link quand il marche vers le bas    -----
tbl_animation_link_bas:
	dc.l	bin_sprites_link_suite,bin_sprites_link_suite+192
	dc.l	bin_sprites_link_suite+192*2,bin_sprites_link_suite+192*3
	dc.l	bin_sprites_link_suite+192*4,bin_sprites_link_suite+192*5
	dc.l	$FFFFFFFF

; ----- Animation de Link quand il porte un item vers le bas    -----
tbl_animation_porte_item_bas:
	dc.l	bin_sprites_link_suite+192*88,bin_sprites_link_suite+192*89
	dc.l	bin_sprites_link_suite+192*90,bin_sprites_link_suite+192*91
	dc.l	bin_sprites_link_suite+192*92,bin_sprites_link_suite+192*93
	dc.l	bin_sprites_link_suite+192*94
	dc.l	$FFFFFFFF	

; ----- Animation de Link quand il arrache l'herbe en bas  -----
tbl_anim_link_arrache_bas:
	dc.l	bin_sprites_link_suite+192*84,bin_sprites_link_suite+192*85,bin_sprites_link_suite+192*86
tbl_anim_porte_buisson4:
	dc.l	bin_sprites_items1,bin_sprites_items1
	dc.l	bin_sprites_items1,bin_sprites_items1





; ************************************************************
; ******************* ANIMATION DU BUISSON********************
; ************************************************************
tbl_anim_buisson:
	dc.l	bin_sprites_items1+256*4	
	dc.l	bin_sprites_items1+256*3,bin_sprites_items1+256*2
	dc.l	bin_sprites_items1+256,bin_sprites_items1
tbl_anim_buisson_boom:
	dc.l	bin_sprites_sfx,bin_sprites_sfx+688,bin_sprites_sfx+688*2
	dc.l	bin_sprites_sfx+688*3,bin_sprites_sfx+688*4,bin_sprites_sfx+688*5
	dc.l	bin_sprites_sfx+688*6,bin_sprites_sfx+688*7