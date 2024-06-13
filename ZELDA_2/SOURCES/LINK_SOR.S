; ********************************************************
; ***************** ANIMATIONS DES SORTIES ***************
; *****************    D'ECRAN DE LINK     ***************
; ********************************************************


; ---- LINK SORT A DROITE
; -----------------------

anim_link_sort_droite:
	bsr	on_remet_le_fond_16x24
	
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_sort_droite		; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_16x24
	jmp	boucle_3
reinit_anim_link_sort_droite:
	move.l	#tbl_animation_link_droite,a0
	move.l	a0,pointeur_table_anim_link
	rts
	
anim_link_revient_droite:
	bsr	on_remet_le_fond_16x24
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_revient_droite		; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_16x24
	jmp	boucle_3
reinit_anim_link_revient_droite:
	move.l	#tbl_animation_link_droite,a0
	move.l	a0,pointeur_table_anim_link
	rts


; ------------------------------------------------------------
; ----- Animation de Link quand il sort de l'Çcran droite ----
; ------------------------------------------------------------

tbl_animation_link_sort_droite:
	dc.l	bin_sprites_link+384*8,bin_sprites_link+384*9,bin_sprites_link+384*20,bin_sprites_link+384*21
	dc.l	bin_sprites_link+384*22,bin_sprites_link+384*23,bin_sprites_link+384*24,bin_sprites_link+384*25
	dc.l	$FFFFFFFF
	
tbl_animation_link_revient_droite:
	dc.l	bin_sprites_link+384*26,bin_sprites_link+384*27,bin_sprites_link+384*28,bin_sprites_link+384*29
	dc.l	bin_sprites_link+384*40,bin_sprites_link+384*41,bin_sprites_link+384*42,bin_sprites_link+384*43
	dc.l	$FFFFFFFF



; ---- LINK SORT A GAUCHE
; -----------------------

anim_link_sort_gauche:
	bsr	on_remet_le_fond_16x24
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_sort_gauche		; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_16x24
	jmp	boucle_3
reinit_anim_link_sort_gauche:
	move.l	#tbl_animation_link_gauche,a0
	move.l	a0,pointeur_table_anim_link
	rts
	
anim_link_revient_gauche:
	bsr	on_remet_le_fond_16x24
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_revient_gauche		; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	move.l	sprite_link_ECRAN,a0
	move.l	a0,fond_link	

; ********* a debugger *************
	;move.l	#$3fde28,sprite_link_ECRAN
	;move.l	#$3Fde28,fond_link
; **********************************
	bsr	on_sauve_le_fond_16x24
	bsr	update_link
	jmp	boucle_3
reinit_anim_link_revient_gauche:
	move.l	#tbl_animation_link_gauche,a0
	move.l	a0,pointeur_table_anim_link
	rts

; ------------------------------------------------------------
; ----- Animation de Link quand il sort de l'Çcran gauche ----
; ------------------------------------------------------------
tbl_animation_link_sort_gauche:
	dc.l	bin_sprites_link+32000+384*8,bin_sprites_link+32000+384*9,bin_sprites_link+32000+384*20,bin_sprites_link+32000+384*21
	dc.l	bin_sprites_link+32000+384*22,bin_sprites_link+32000+384*23,bin_sprites_link+32000+384*24,bin_sprites_link+32000+384*25
	dc.l	$FFFFFFFF
tbl_animation_link_revient_gauche:
	dc.l	bin_sprites_link+32000+384*26,bin_sprites_link+32000+384*27,bin_sprites_link+32000+384*28,bin_sprites_link+32000+384*29
	dc.l	bin_sprites_link+32000+384*40,bin_sprites_link+32000+384*41,bin_sprites_link+32000+384*42,bin_sprites_link+32000+384*43
	dc.l	$FFFFFFFF


; ---- LINK SORT EN BAS
; -----------------------

anim_link_sort_bas:
	bsr	on_remet_le_fond_8x24
	
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_sort_bas	; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_8x24
	jmp	boucle_3
reinit_anim_link_sort_bas:
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	rts
	
anim_link_revient_bas:
	bsr	on_remet_le_fond_8x24
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_revient_bas		; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_8x24
	jmp	boucle_3
reinit_anim_link_revient_bas:
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	rts


; ------------------------------------------------------------
; ----- Animation de Link quand il sort de l'Çcran en bas ----
; ------------------------------------------------------------
tbl_animation_link_sort_bas:
	dc.l	bin_sprites_link_suite+192*7,bin_sprites_link_suite+192*8,bin_sprites_link_suite+192*9
	dc.l	bin_sprites_link_suite+192*9,bin_sprites_link_suite+192*10,bin_sprites_link_suite+192*11,bin_sprites_link_suite+192*12
	dc.l	$FFFFFFFF
tbl_animation_link_revient_bas:
	dc.l	bin_sprites_link_suite+192*13,bin_sprites_link_suite+192*14,bin_sprites_link_suite+192*15
	dc.l	bin_sprites_link_suite+192*16,bin_sprites_link_suite+192*17,bin_sprites_link_suite+192*18,bin_sprites_link_suite+192*19
	dc.l	$FFFFFFFF	




; ---- LINK SORT EN HAUT
; -----------------------

anim_link_sort_haut:
	bsr	on_remet_le_fond_8x24
	
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_sort_bas	; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_8x24
	jmp	boucle_3
reinit_anim_link_sort_haut:
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	rts
	
anim_link_revient_haut:
	bsr	on_remet_le_fond_8x24
	move.l	pointeur_table_anim_link,a0	; on rÇcupäre le pointeur de la derniäre animation
	add.l	#4,a0				; on pointe l'adresse de l'animation suivante
	move.l	(a0),d0				; on passe Ö l'animation suivante
	cmp.l	#$FFFFFFFF,d0			; si c'est fini on reinitialise les animations
	beq	reinit_anim_link_revient_haut		; sinon on continue d'avancer le pointeur
	move.l	a0,pointeur_table_anim_link
	move.l	(a0),sprite_link_RAM		; et on recupäre l'adresse du sprite
	bsr	on_affiche_sprite_8x24
	jmp	boucle_3
reinit_anim_link_revient_haut:
	move.l	#tbl_animation_link_bas,a0
	move.l	a0,pointeur_table_anim_link
	rts


; ------------------------------------------------------------
; ----- Animation de Link quand il sort de l'Çcran en haut ---
; ------------------------------------------------------------
tbl_animation_link_sort_haut:
	dc.l	bin_sprites_link_suite+192*47,bin_sprites_link_suite+192*48,bin_sprites_link_suite+192*49
	dc.l	bin_sprites_link_suite+192*49,bin_sprites_link_suite+192*50,bin_sprites_link_suite+192*51,bin_sprites_link_suite+192*52
	dc.l	$FFFFFFFF
tbl_animation_link_revient_haut:
	dc.l	bin_sprites_link_suite+192*53,bin_sprites_link_suite+192*54,bin_sprites_link_suite+192*55
	dc.l	bin_sprites_link_suite+192*56,bin_sprites_link_suite+192*57,bin_sprites_link_suite+192*58,bin_sprites_link_suite+192*59
	dc.l	$FFFFFFFF	




compteur_de_frame:
	move.l	#0,d0	
	move.w	frame_counter,d0
	cmp.w	#3,d0
	beq	reinit_compteur_de_frame
	add.w	#1,frame_counter
	jmp	boucle_3
reinit_compteur_de_frame:
	move.w	#0,frame_counter
	jmp	retour_compteur_de_frame



;*******************************************************
;*****************     3EME BOUCLE   *******************
;*******************************************************
;***********************  DEBUT ************************
;*******************************************************
boucle_3:
	;bsr	switch_ecran		; on change d'Çcran et de pointeur			; on recupäre le compteur de vbl dans D0
	;bsr	recopie_ecran
		move.l	$466,d0
boucle_vbl3:
	cmp.w	$468.w,d0		; si il a changÇ alors on boucle pas
	beq	boucle_vbl3		; si il n'a pas changÇ on boucle

	jmp	compteur_de_frame
retour_compteur_de_frame
	move.w	flag_direction_link,d7
	cmp.w	#1,d7
	beq	anim_link_sort_droite
	cmp.w	#2,d7
	beq	anim_link_sort_gauche
	cmp.w	#3,d7
	beq	anim_link_sort_bas
	cmp.w	#4,d7
	beq	anim_link_sort_haut
	cmp.w	#$1b,d7
	beq	anim_link_revient_droite
	cmp.w	#$2b,d7
	beq	anim_link_revient_gauche
	cmp.w	#$3b,d7
	beq	anim_link_revient_bas
	cmp.w	#$4b,d7
	beq	anim_link_revient_haut
	jmp	boucle_3
;*******************************************************
;***************** BOUCLE TERCIAIRE  *******************
;*******************************************************
;***********************  FIN  *************************
;*******************************************************
