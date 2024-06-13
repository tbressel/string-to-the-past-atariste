
;coordonn‚e X/Y fee : 48/48
; d‚placement en Y : 48,64,80,96,112



menu_joueurs:
	move.l	#selection_1+2,a3
	bsr	charge_palette
on_affiche_selection1:
	move.l	#selection_1+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#160*199/4-1,d7
boucle_selection1:
	move.l	(a0)+,(a1)+
	dbf	d7,boucle_selection1
	move.w	#0,frame_counter
	move.l	adr_frame_buffer,a0
	add.l	#160*48,a0		; coordonn‚ Y
	add.l	#48/2,a0		; coordonn‚ X
	move.l	a0,adr_fee_ECRAN
	bsr	on_sauve_le_fond_fee
	jmp	boucle_fee


boucle_fee:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
boucle_vbl_fee:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	boucle_vbl_fee
	
	jmp	vitesse_animation_fee
retour_vitesse_animation_fee	
;	bsr	ecrans_debug

	bsr	on_remet_le_fond_fee	
	bsr	on_sauve_le_fond_fee	
	bsr	calcul_fee

	move.w	flag_saisie,d6
	cmp.w	#1,d6
	beq	test_de_touches
; navigation
	cmp.b	#$50,$FFFFFC02		; touche fleche bas
	beq	fee_bas	
	cmp.b	#$48,$FFFFFC02		; touche fleche haut
	beq	fee_haut		
	cmp.b	#$72,$FFFFFC02		; touche ENTER
	beq	selection_ligne
	cmp.b	#$01,$FFFFFC02		; on test la touche ESC ($01)
					; avec la donn‚e de la pression
					; de la touche log‚ en $FFFFFC02
	beq	on_quitte		
	cmp.b	#$72,$FFFFFC02		; touche ENTER
	beq	selection_ligne
	jmp	boucle_fee

	jmp	test_de_touches
retour_test_de_touches
	cmp.b	#$72,$FFFFFC02		; touche ENTER
	beq	selection_ligne
	jmp	boucle_fee

vitesse_animation_fee:
	add.w	#1,frame_counter	
	move.w	frame_counter,d4
	cmp.w	#4,d4
	bne	boucle_fee
	move.w	#0,frame_counter
	jmp	retour_vitesse_animation_fee

; -------------------------------------------------
; ----      Test des touches du clavier        ----
; -------------------------------------------------
test_de_touches:
	cmp.b	#$70,$FFFFFC02
	beq	chiffre_0
	cmp.b	#$6d,$FFFFFC02
	beq	chiffre_1
	cmp.b	#$39,$FFFFFC02
	beq	espace
	cmp.b	#$05,$FFFFFC02
	beq	apostrophe
	cmp.b	#$09,$FFFFFC02
	beq	exclamation
	cmp.b	#$06,$FFFFFC02
	beq	parenthese1
	cmp.b	#$0c,$FFFFFC02
	beq	parenthese2
	cmp.b	#$10,$FFFFFC02
	beq	lettre_A
	cmp.b	#$11,$FFFFFC02
	beq	lettre_Z
	cmp.b	#$12,$FFFFFC02
	beq	lettre_E
	cmp.b	#$13,$FFFFFC02
	beq	lettre_R
	cmp.b	#$14,$FFFFFC02
	beq	lettre_T
	cmp.b	#$15,$FFFFFC02
	beq	lettre_Y
	cmp.b	#$16,$FFFFFC02
	beq	lettre_U
	cmp.b	#$17,$FFFFFC02
	beq	lettre_I
	cmp.b	#$18,$FFFFFC02
	beq	lettre_O
	cmp.b	#$19,$FFFFFC02
	beq	lettre_P
	cmp.b	#$1E,$FFFFFC02
	beq	lettre_Q
	cmp.b	#$1F,$FFFFFC02
	beq	lettre_S
	cmp.b	#$20,$FFFFFC02
	beq	lettre_D
	cmp.b	#$21,$FFFFFC02
	beq	lettre_F
	cmp.b	#$22,$FFFFFC02
	beq	lettre_G
	cmp.b	#$23,$FFFFFC02
	beq	lettre_H
	cmp.b	#$24,$FFFFFC02
	beq	lettre_J
	cmp.b	#$25,$FFFFFC02
	beq	lettre_K
	cmp.b	#$26,$FFFFFC02
	beq	lettre_L
	cmp.b	#$27,$FFFFFC02
	beq	lettre_M
	cmp.b	#$2C,$FFFFFC02
	beq	lettre_W
	cmp.b	#$2D,$FFFFFC02
	beq	lettre_X
	cmp.b	#$2E,$FFFFFC02
	beq	lettre_C
	cmp.b	#$2F,$FFFFFC02
	beq	lettre_V
	cmp.b	#$30,$FFFFFC02
	beq	lettre_B
	cmp.b	#$31,$FFFFFC02
	beq	lettre_N
	jmp	retour_test_de_touches
fee_bas:
	move.w	no_menu_fee,d7
	cmp.b	#4,d7
	beq	fee_bas2
	cmp.b	#6,d7
	beq	retour_test_de_touches
	
	add.w	#1,no_menu_fee
	bsr	on_remet_le_fond_fee
	move.l	adr_fee_ECRAN,a0
	add.l	#160*16,a0
	move.l	a0,adr_fee_ECRAN
	bsr	on_sauve_le_fond_fee
	bsr	affiche_fee
	jmp	boucle_fee
fee_bas2:
	add.w	#1,no_menu_fee
	bsr	on_remet_le_fond_fee
	move.l	adr_fee_ECRAN,a0
	add.l	#160*32,a0
	add.l	#8,a0
	move.l	a0,adr_fee_ECRAN
	bsr	on_sauve_le_fond_fee
	bsr	affiche_fee
	jmp	boucle_fee


fee_haut:
	move.w	no_menu_fee,d7
	cmp.b	#0,d7
	beq	retour_test_de_touches
	cmp.b	#5,d7
	beq	fee_haut2

	sub.w	#1,no_menu_fee
	bsr	on_remet_le_fond_fee
	move.l	adr_fee_ECRAN,a0
	sub.l	#160*16,a0
	move.l	a0,adr_fee_ECRAN
	bsr	on_sauve_le_fond_fee
	bsr	affiche_fee
	jmp	boucle_fee

fee_haut2:
	sub.w	#1,no_menu_fee
	bsr	on_remet_le_fond_fee
	move.l	adr_fee_ECRAN,a0
	sub.l	#160*32,a0
	sub.l	#8,a0
	move.l	a0,adr_fee_ECRAN
	bsr	on_sauve_le_fond_fee
	bsr	affiche_fee
	jmp	boucle_fee

calcul_fee:
	move.w	compteur_anim_fee,d7
	cmp.w	#0,d7
	beq	animation_fee1
	cmp.w	#1,d7
	beq	animation_fee2
animation_fee1:
	move.l	#bin_fee,a0
	add.l	#160*16*6,a0
	move.l	a0,adr_fee_msk
	move.l	#bin_fee,adr_fee_spr
	;move.l	adr_frame_buffer,adr_fee_ECRAN
	bsr	affiche_fee
	move.w	#1,compteur_anim_fee
	rts
animation_fee2:
	move.l	#bin_fee+16*16,a0
	add.l	#160*16*6,a0
	move.l	a0,adr_fee_msk
	move.l	#bin_fee+16*16,adr_fee_spr
	;move.l	adr_frame_buffer,adr_fee_ECRAN
	bsr	affiche_fee
	move.w	#0,compteur_anim_fee
	rts
affiche_fee:
	move.l	adr_fee_msk,a0
	move.l	adr_fee_spr,a1
	move.l	adr_fee_ECRAN,a2
	move.w	#16-1,d7
boucle_fee_mask:	
	REPT	4
	move.l	(a0)+,d0
	and.l	(a2),d0
	move.l	d0,(a2)+
	ENDR	
	add.l	#160-16,a2
	dbf	d7,boucle_fee_mask
	move.l	adr_fee_ECRAN,a2
	move.w	#16-1,d7	
boucle_fee_sprite:
	REPT	4
	move.l	(a1)+,d0
	or.l	(a2),d0
	move.l	d0,(a2)+
	ENDR
	add.l	#160-16,a2
	dbf	d7,boucle_fee_sprite
	rts



; ************************************************************
; ****************** SAUVEGARDE DU FOND FEE   ****************
; ************************************************************
on_sauve_le_fond_fee:
	move.l	adr_fee_ECRAN,a4
	move.l	#fond_fee,a5
	move.w	#16-1,d7
bcl_sauve_fond_fee:
	REPT	4
	move.l	(a4)+,(a5)+
	ENDR
	add.l	#160-16,a4
	dbf	d7,bcl_sauve_fond_fee
	rts
; ************************************************************
; ******************* ON REMET LE FOND FEE *******************
; ************************************************************
on_remet_le_fond_fee:
	move.l	adr_fee_ECRAN,a4
	move.l	#fond_fee,a5
	move.w	#16-1,d7
bcl_remet_fond_fee:
	REPT	4
	move.l	(a5)+,(a4)+
	ENDR
	add.l	#160-16,a4
	dbf	d7,bcl_remet_fond_fee
	rts



profil_joueur_ok:
	move.w	#0,nbr_lettre
	move.l	#tbl_nom_joueur,a0
	move.l	pointeur_nom_joueur,a1
	REPT	3
	move.l	(a0)+,(a1)+
	ENDR
	move.l	#0,d0
	move.l	#tbl_nom_joueur,a0
	
	REPT	3
	move.l	d0,(a0)+
	ENDR			

	
	move.l	#bin_fee+16000,a0
	add.l	#32*16,a0
	move.l	a0,adr_link_msk
	move.l	#bin_fee,a1
	add.l	#32*16,a1
	move.l	a1,adr_link_spr
	move.l	adr_fee_ECRAN,a2
	add.l	#8*2,a2
	;move.l	adr_frame_buffer,a2
	move.l	a2,adr_link_ECRAN


affiche_link
	move.l	adr_link_msk,a0
	move.l	adr_link_spr,a1
	move.l	adr_link_ECRAN,a2
	move.w	#16-1,d7
boucle_link:
	REPT	4
	move.l	(a0)+,d0
	move.l	(a1)+,d1
	and.l	(a2),d0
	move.l	d0,(a2)
	or.l	(a2),d1
	move.l	d1,(a2)+
	ENDR

	;add.l	#160-8,a0
	;add.l	#160-8,a1
	add.l	#160-16,a2
	dbf	d7,boucle_link
	rts	
	