; *************************************************************
; ****************** BOUCLE ANIMATION DE LA TRIFORCE **********
; *************************************************************
;                            SEQUENCE NO 1
; *************************************************************

boucle_triforce_seq1:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
boucle_vbl_triforce_seq1:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	boucle_vbl_triforce_seq1	; si il n'a pas chang‚ on boucle
	jmp	vitesse_animation
retour_vitesse_animation
	
;	bsr	attendre_une_touche	
	
	bsr	triforceG
	bsr	triforceD
	bsr	triforceH	
	
	
	jmp	boucle_triforce_seq1

vitesse_animation:
	add.w	#1,frame_counter	
	move.w	frame_counter,d4
	cmp.w	#4,d4
	bne	boucle_triforce_seq1
	move.w	#0,frame_counter
	jmp	retour_vitesse_animation



; *************************************************************
; *************** GESTION TRIFORCE GAUCHE *********************
; *************************************************************
triforceG:
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	move.l	#fond_triforceG,ADR_FOND_TRIFORCE
	bsr	on_remet_le_fond_triforce	
	jmp	calcul_triforceG
retour_calcul_triforceG
	bsr	on_sauve_le_fond_triforce	
	bsr	affiche_triforce
	rts

; *************************************************************
; *************** GESTION TRIFORCE DROITE *********************
; *************************************************************
triforceD:
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	move.l	#fond_triforceD,ADR_FOND_TRIFORCE
	bsr	on_remet_le_fond_triforce	
	jmp	calcul_triforceD
retour_calcul_triforceD
	bsr	on_sauve_le_fond_triforce	
	bsr	affiche_triforce
	rts


; *************************************************************
; *************** GESTION TRIFORCE HAUT   *********************
; *************************************************************
triforceH:
	move.l	adr_triforceH_ECRAN,ADR_ECRAN_TRIFORCE
	move.l	#fond_triforceH,ADR_FOND_TRIFORCE
	bsr	on_remet_le_fond_triforce	
	jmp	calcul_triforceH
retour_calcul_triforceH
	bsr	on_sauve_le_fond_triforce	
	bsr	affiche_triforce
	rts

; *************************************************************
; ***************** CALCULE DE TRIFORCE GAUCHE ****************
; *************************************************************
calcul_triforceG:
	move.w	flag_sequence1,d7
	cmp.w	#1,d7
	beq	on_rapproche_triforceG
; mise … jour des pointeurs
	move.l	pointeur_triforceG_msk,a0
	add.l	#32*48,a0
	move.l	a0,pointeur_triforceG_msk
	move.l	a0,ADR_RAM_TRIFORCE_MSK
	move.l	pointeur_triforceG_spr,a1
	add.l	#32*48,a1
	move.l	a1,pointeur_triforceG_spr
	move.l	a1,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	move.l	ADR_ECRAN_TRIFORCE,a2
; gestion des cas sp‚cieux de d‚calage
	move.w	compteur_anim_triforceG,d6
	cmp.w	#9-1,d6
	beq	on_decale_triforceG_haut8	; 8 lignes
	cmp.w	#10-1,d6
	beq	on_decale_triforceG_haut4	; 4 lignes
	cmp.w	#11-1,d6
	beq	on_decale_triforceG_haut8	; 8 lignes
	cmp.w	#12-1,d6
	beq	on_decale_triforceG_haut8	; 8 lignes
	cmp.w	#13-1,d6
	beq	on_decale_triforceG_droite	; + aussi 4 lignes
	cmp.w	#14-1,d6
	beq	on_decale_triforceG_haut4	; 4 lignes
	cmp.w	#15-1,d6
	beq	on_decale_triforceG_haut4	; 4 lignes
	cmp.w	#16-1,d6
	beq	on_decale_triforceG_haut8	; 8 lignes
	cmp.w	#19-1,d6
	beq	planche_suivanteG		; 
	cmp.w	#40-1,d6
	beq	fin_anim_triforce_seq1b
	add.w	#1,compteur_anim_triforceG
	jmp	retour_calcul_triforceG
on_decale_triforceG_haut4
	sub.l	#160*4,adr_triforceG_ECRAN
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#4,cmpt
	add.w	#1,compteur_anim_triforceG
	jmp	retour_calcul_triforceG
on_decale_triforceG_haut8
	sub.l	#160*8,adr_triforceG_ECRAN
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#8,cmpt
	add.w	#1,compteur_anim_triforceG
	jmp	retour_calcul_triforceG
on_decale_triforceG_droite
	add.l	#16,adr_triforceG_ECRAN
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#1,compteur_anim_triforceG
	sub.l	#160*4,adr_triforceG_ECRAN
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#4,cmpt
	jmp	retour_calcul_triforceG
planche_suivanteG:
	add.w	#1,compteur_anim_triforceG
	add.l	#160*8,pointeur_triforceG_msk
	add.l	#160*8,pointeur_triforceG_spr
	sub.l	#160*8,adr_triforceG_ECRAN
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#8,cmpt
	jmp	retour_calcul_triforceG
on_rapproche_triforceG:
	move.l	pointeur_triforceG_msk,ADR_RAM_TRIFORCE_MSK	
	move.l	pointeur_triforceG_spr,ADR_RAM_TRIFORCE_SPR
	add.l	#8,adr_triforceG_ECRAN
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#1,compteur_anim_triforceG	
	move.w	compteur_anim_triforceG,d6
	cmp.w	#5,d6
	beq	fin_anim_triforce_seq2	
	jmp	retour_calcul_triforceG

fin_anim_triforce_seq1b:
	sub.l	#32*48,pointeur_triforceG_msk
	sub.l	#32*48,pointeur_triforceG_spr
	move.l	pointeur_triforceG_msk,ADR_RAM_TRIFORCE_MSK	
	move.l	pointeur_triforceG_spr,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	bsr	on_sauve_le_fond_triforce
	bsr	affiche_triforce
	jmp	fin_anim_triforce_seq1
; *************************************************************
; ***************** CALCULE DE TRIFORCE DROITE ****************
; *************************************************************
calcul_triforceD:
	move.w	flag_sequence1,d7
	cmp.w	#1,d7
	beq	on_rapproche_triforceD

; mise … jour des pointeurs
	move.l	pointeur_triforceD_msk,a0
	add.l	#32*48,a0
	move.l	a0,pointeur_triforceD_msk
	move.l	a0,ADR_RAM_TRIFORCE_MSK
	move.l	pointeur_triforceD_spr,a1
	add.l	#32*48,a1
	move.l	a1,pointeur_triforceD_spr
	move.l	a1,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	move.l	ADR_ECRAN_TRIFORCE,a2
; gestion des cas sp‚cieux de d‚calage
	move.w	compteur_anim_triforceD,d6
	cmp.w	#9-1,d6
	beq	on_decale_triforceD_haut8	; 8 lignes
	cmp.w	#10-1,d6
	beq	on_decale_triforceD_haut4	; 4 lignes
	cmp.w	#11-1,d6
	beq	on_decale_triforceD_haut8	; 8 lignes
	cmp.w	#12-1,d6
	beq	on_decale_triforceD_haut8	; 8 lignes
	cmp.w	#13-1,d6
	beq	on_decale_triforceD_gauche	; + aussi 4 lignes
	cmp.w	#14-1,d6
	beq	on_decale_triforceD_haut4	; 4 lignes
	cmp.w	#15-1,d6
	beq	on_decale_triforceD_haut4	; 4 lignes
	cmp.w	#16-1,d6
	beq	on_decale_triforceD_haut8	; 8 lignes
	cmp.w	#19-1,d6
	beq	planche_suivanteD		; 
	cmp.w	#40-1,d6
	beq	fin_anim_triforce_seq1
	add.w	#1,compteur_anim_triforceD
	jmp	retour_calcul_triforceD
on_decale_triforceD_haut4
	sub.l	#160*4,adr_triforceD_ECRAN
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#4,cmpt
	add.w	#1,compteur_anim_triforceD
	jmp	retour_calcul_triforceD
on_decale_triforceD_haut8
	sub.l	#160*8,adr_triforceD_ECRAN
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#8,cmpt
	add.w	#1,compteur_anim_triforceD
	jmp	retour_calcul_triforceD
on_decale_triforceD_gauche
	sub.l	#16,adr_triforceD_ECRAN
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#1,compteur_anim_triforceD
	sub.l	#160*4,adr_triforceD_ECRAN
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#4,cmpt
	jmp	retour_calcul_triforceD
planche_suivanteD:
	add.w	#1,compteur_anim_triforceD
	add.l	#160*8,pointeur_triforceD_msk
	add.l	#160*8,pointeur_triforceD_spr
	sub.l	#160*8,adr_triforceD_ECRAN
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#8,cmpt
	jmp	retour_calcul_triforceD
on_rapproche_triforceD:
	move.l	pointeur_triforceD_msk,ADR_RAM_TRIFORCE_MSK	
	move.l	pointeur_triforceD_spr,ADR_RAM_TRIFORCE_SPR
	sub.l	#8,adr_triforceD_ECRAN
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#1,compteur_anim_triforceD	
	move.w	compteur_anim_triforceD,d6
	cmp.w	#5,d6
	beq	fin_anim_triforce_seq2	
	jmp	retour_calcul_triforceD
; *************************************************************
; ***************** CALCULE DE TRIFORCE HAUT E ****************
; *************************************************************
calcul_triforceH:
	move.w	flag_sequence1,d7
	cmp.w	#1,d7
	beq	on_rapproche_triforceH

; mise … jour des pointeurs
	move.l	pointeur_triforceH_msk,a0
	add.l	#32*48,a0
	move.l	a0,pointeur_triforceH_msk
	move.l	a0,ADR_RAM_TRIFORCE_MSK

	move.l	pointeur_triforceH_spr,a1
	add.l	#32*48,a1
	move.l	a1,pointeur_triforceH_spr
	move.l	a1,ADR_RAM_TRIFORCE_SPR

	move.l	adr_triforceH_ECRAN,ADR_ECRAN_TRIFORCE
	move.l	ADR_ECRAN_TRIFORCE,a2

; gestion des cas sp‚cieux de d‚calage
	move.w	compteur_anim_triforceH,d6
	cmp.w	#19-1,d6
	beq	planche_suivanteH		; 
	cmp.w	#40-1,d6
	beq	fin_anim_triforce_seq1
	add.w	#1,compteur_anim_triforceH
	jmp	retour_calcul_triforceH
planche_suivanteH:
	add.w	#1,compteur_anim_triforceH
	add.l	#160*8,pointeur_triforceH_msk
	add.l	#160*8,pointeur_triforceH_spr
	add.l	#160*4,adr_triforceH_ECRAN
	move.l	adr_triforceH_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#8,cmpt
	jmp	retour_calcul_triforceH
on_rapproche_triforceH:
	move.l	pointeur_triforceH_msk,ADR_RAM_TRIFORCE_MSK	
	move.l	pointeur_triforceH_spr,ADR_RAM_TRIFORCE_SPR
	add.l	#160*11,adr_triforceH_ECRAN
	move.l	adr_triforceH_ECRAN,ADR_ECRAN_TRIFORCE
	add.w	#1,compteur_anim_triforceH
	move.w	compteur_anim_triforceH,d6
	cmp.w	#5,d6
	beq	fin_anim_triforce_seq2	
	jmp	retour_calcul_triforceH


fin_triforce:
	rts

; *************************************************************
; ************* AFFICHAGE DU SPRITE TRIFORCE ******************
; *************************************************************
affiche_triforce:
	move.l	ADR_RAM_TRIFORCE_MSK,a0
	move.l	ADR_RAM_TRIFORCE_SPR,a1
	move.l	ADR_ECRAN_TRIFORCE,a2
	move.w	#48-1,d7
boucle_triforce_mask:	
	REPT	8
	move.l	(a0)+,d0
	and.l	(a2),d0
	move.l	d0,(a2)+
	ENDR	
	add.l	#160-32,a2
	dbf	d7,boucle_triforce_mask
	move.l	ADR_ECRAN_TRIFORCE,a2
	move.w	#48-1,d7	
boucle_triforce_sprite:
	REPT	8
	move.l	(a1)+,d0
	or.l	(a2),d0
	move.l	d0,(a2)+
	ENDR
	add.l	#160-32,a2
	dbf	d7,boucle_triforce_sprite
	rts
; ************************************************************
; ****************** SAUVEGARDE DU FOND DES TRIFORCES ********
; ************************************************************
on_sauve_le_fond_triforce:
	move.l	ADR_ECRAN_TRIFORCE,a4
	move.l	ADR_FOND_TRIFORCE,a5
	move.w	#48-1,d7
bcl_sauve_fond_triforce:
	REPT	8
	move.l	(a4)+,(a5)+
	ENDR
	add.l	#160-32,a4
	dbf	d7,bcl_sauve_fond_triforce
	rts
; ************************************************************
; ******************* ON REMET  LE FOND **********************
; ************************************************************
on_remet_le_fond_triforce:
	move.l	ADR_ECRAN_TRIFORCE,a4
	move.l	ADR_FOND_TRIFORCE,a5
	move.w	#48-1,d7
bcl_remet_fond_triforce:
	REPT	8
	move.l	(a5)+,(a4)+
	ENDR
	add.l	#160-32,a4
	dbf	d7,bcl_remet_fond_triforce
	rts
