;**********************************************************
;********************** DEBUG MODE  ***********************
;**********************************************************
ecrans_debug:
	;cmp.b	#$47,$FFFFFC02
	;beq	debut_du_programme
	cmp.b	#$02,$FFFFFC02		; touche 1 : ecran 1
	beq	ecran_no_1
	cmp.b	#$03,$FFFFFC02		; touche 2 : ecran 2
	beq	ecran_no_2
	cmp.b	#$20,$FFFFFC02		; touche D : debug mode
	beq	debug_mode
	
	move.w	flag_debug,d7
	cmp.b	#1,d7
	bne	zap_debug_mode

	cmp.b	#$4E,$FFFFFC02		; touche fleche gauche
	beq	ecran_suivant
	cmp.b	#$4A,$FFFFFC02		; touche fleche gauche
	beq	ecran_precedant
	cmp.b	#$64,$FFFFFC02
	beq	word_suivant
	cmp.b	#$63,$FFFFFC02
	beq	word_precedant
	cmp.b	#$1E,$FFFFFC02		; touche Q : Quitter le mode debug
	beq	quitter_debug_mode
	cmp.b	#$3b,$FFFFFC02		; touche F1 : Debut du programme 
	beq	voir_debut_programme	
	cmp.b	#$3c,$FFFFFC02
	beq	voir_debut_maptile
	cmp.b	#$3d,$FFFFFC02
	beq	voir_sprites_link
	cmp.b	#$3e,$FFFFFC02
	beq	voir_tileset_foret
	cmp.b	#$3f,$FFFFFC02
	beq	voir_sprites_link2
	cmp.b	#$40,$FFFFFC02
	beq	encode_sprites_link
	cmp.b	#$41,$FFFFFC02
	beq	encode_sprites_link2
	cmp.b	#$43,$FFFFFC02
	beq	voir_items
	cmp.b	#$72,$FFFFFC02
	beq	adr_memoire
	cmp.b	#$42,$FFFFFC02
	beq	voir_sprites_link_suite
	cmp.b	#$22,$FFFFFC02
	beq	grille
	cmp.b	#$23,$FFFFFC02
	beq	grille2
zap_debug_mode
	rts

; ******************************************************
; ******************************************************
; ******************************************************

; ------- Touche F1 -------
voir_debut_programme:
;	move.l	#debut_du_programme,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts

; ------- Touche F2 -------
voir_debut_maptile:
;	move.l	#debut_maptile,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts	

; ------- Touche F3 --------
voir_sprites_link:
;	move.l	#img_sprites_link+34,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts

; ------- Touche F4 -------
voir_tileset_foret:
;	move.l	#img_tileset+34,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts

; ------- Touche F5 -------
voir_sprites_link2:
;	move.l	#img_sprites_link+32000+34+34,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts


; ------- Touche F6 -------
encode_sprites_link:
;	move.l	#bin_sprites_link,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts

; ------- Touche F7 -------
encode_sprites_link2:
;	move.l	#bin_sprites_link+32000,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts

; ------- Touche F8 --------
voir_sprites_link_suite:
;	move.l	#img_sprites_link_suite+34,d0
;	move.l	d0,adresse_debug_ecran
;	bsr	ecran_no_3
	rts

; Touche F9
voir_items:
	;move.l	#img_sprites_items1+34,d0
	;move.l	d0,adresse_debug_ecran
	;bsr	ecran_no_3
	rts

grille:
	move.l	#img_grillem+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#16*12*2,D5		; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
boucle_grillem:
	REPT	30
	move.l	(a0)+,d0		; on recupŠre l'octet
	and.l	(a1),d0
	move.l	d0,(a1)+
	ENDR
	sub.l	#5*8,A0			; on arrive au bord de l'‚cran et il faut ‚viter le HUD
	sub.l	#5*8,A1
	dbf	d5,boucle_grillem
	move.w	#16*12*2,d5
	move.l	#img_grille+34,a0
	move.l	adr_frame_buffer,a1
boucle_grille:
	REPT	30
	move.l	(a0)+,d0
	or.l	(a1),d0
	move.l	d0,(a1)+		
	ENDR
	sub.l	#5*8,a0
	sub.l	#5*8,a1
	dbf	d5,boucle_grille
	rts


grille2:
	move.l	#img_grille2m+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#16*12*2,D5		; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
boucle_grille_2m:
	REPT	30
	move.l	(a0)+,d0		; on recupŠre l'octet
	and.l	(a1),d0
	move.l	d0,(a1)+
	ENDR
	sub.l	#5*8,A0			; on arrive au bord de l'‚cran et il faut ‚viter le HUD
	sub.l	#5*8,A1
	dbf	d5,boucle_grille_2m
	move.w	#16*12*2,d5
	move.l	#img_grille2+34,a0
	move.l	adr_frame_buffer,a1
boucle_grille2:
	REPT	30
	move.l	(a0)+,d0
	or.l	(a1),d0
	move.l	d0,(a1)+		
	ENDR
	sub.l	#5*8,a0
	sub.l	#5*8,a1
	dbf	d5,boucle_grille2
	rts

; ---------------- ECRAN 3 ------------------
ecran_no_3:
	move.w	#-1,-(sp)			; moyenne r‚solution
	move.l	adresse_debug_ecran,-(sp)	; adr. ‚cran psysique
	move.l  #-1,-(sp)			; adr. ‚cran logique
	move.w	#5,-(sp)			; fonction 5 : Setscreen
	trap 	#14	
	add.w	#12,sp
	rts

debug_mode:
	move.w	#1,flag_debug
	bsr	ecran_no_3
	rts
quitter_debug_mode:
	move.w	#0,flag_debug
	move.l	#0,adresse_debug_ecran
	bsr	ecran_no_1
	rts
ecran_suivant:
	move.l	adresse_debug_ecran,d0
	cmp.l	#$003f8000,d0
	beq	reinit_ecran_suivant
	add.l	#160*2,adresse_debug_ecran
	bsr	ecran_no_3	
	rts
reinit_ecran_suivant:
	move.l	#$00000000,adresse_debug_ecran
	bsr	ecran_no_3
	rts
ecran_precedant:
	move.l	adresse_debug_ecran,d0
	cmp.l	#$00000000,d0
	beq	reinit_ecran_precedant
	sub.l	#160*2,adresse_debug_ecran
	bsr	ecran_no_3	
	rts
reinit_ecran_precedant:
	move.l	#$003f8000,adresse_debug_ecran
	bsr	ecran_no_3
	rts
word_precedant:
	move.l	adresse_debug_ecran,d0
	cmp.l	#$00000000,d0
	beq	reinit_word_precedant
	sub.l	#2,adresse_debug_ecran
	bsr	ecran_no_3	
	rts
reinit_word_precedant:
	move.l	#$00000000,adresse_debug_ecran
	bsr	ecran_no_3
	rts
word_suivant:
	move.l	adresse_debug_ecran,d0
	cmp.l	#$003F8000,d0
	beq	reinit_word_suivant
	add.l	#2,adresse_debug_ecran
	bsr	ecran_no_3	
	rts
reinit_word_suivant:
	move.l	#$03f80000,adresse_debug_ecran
	bsr	ecran_no_3
	rts
adr_memoire:
	move.l	adresse_debug_ecran,a6
	rts



link_bas_debug
;	add.w	#12,link_posY
;	bsr	calcul_link_ecran
;	move.l	#tbl_animation_link_bas,a0
;	move.l	(a0),sprite_link_RAM
;	bsr	on_affiche_sprite_8x24
	rts


adresse_debug_ecran:
	ds.l	1
flag_debug:
	ds.w	1


img_grille:
	incbin	__TEMP__\DEBUG\grille.pi1
img_grillem:
	incbin	__TEMP__\DEBUG\grillem.pi1
img_grille2:
	incbin	__TEMP__\DEBUG\grille2.pi1
img_grille2m:
	incbin	__TEMP__\DEBUG\grille2m.pi1