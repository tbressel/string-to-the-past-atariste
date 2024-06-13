triforce:
	move.l	#bin_palette_triforce,a3
	bsr	charge_palette


; initialisation des pointeurs
	move.l	#bin_triforce_msk,pointeur_triforceG_msk
	move.l	#bin_triforce_msk+64000,pointeur_triforceD_msk
	move.l	#bin_triforce_msk+64000*2,pointeur_triforceH_msk

	move.l	#bin_triforce_spr,pointeur_triforceG_spr
	move.l	#bin_triforce_spr+64000,pointeur_triforceD_spr
	move.l	#bin_triforce_spr+64000*2,pointeur_triforceH_spr

	
; initialisation de le zone de l'‚cran

; triforce de gauche
	move.l	adr_frame_buffer,a2
	add.l	#160*48*3,a2
	move.l	a2,adr_triforceG_ECRAN
	move.l	a2,ADR_ECRAN_TRIFORCE
	move.l	#fond_triforceG,a2
	move.l	a2,ADR_FOND_TRIFORCE
	bsr	on_sauve_le_fond_triforce
; triforce de droite
	move.l	adr_frame_buffer,a2
	add.l	#160*48*3,a2
	add.l	#32*4,a2
	move.l	a2,adr_triforceD_ECRAN
	move.l	a2,ADR_ECRAN_TRIFORCE
	move.l	#fond_triforceD,a2
	move.l	a2,ADR_FOND_TRIFORCE
	bsr	on_sauve_le_fond_triforce
; triforce du haut
	move.l	adr_frame_buffer,a2
	add.l	#32*2,a2
	move.l	a2,adr_triforceH_ECRAN
	move.l	a2,ADR_ECRAN_TRIFORCE
	move.l	#fond_triforceH,a2
	move.l	a2,ADR_FOND_TRIFORCE
	bsr	on_sauve_le_fond_triforce

; on affiche les 3 triangles de la triforce pour commencer
	move.l	pointeur_triforceG_msk,ADR_RAM_TRIFORCE_MSK
	move.l	pointeur_triforceG_spr,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	bsr	affiche_triforce

	move.l	pointeur_triforceD_msk,ADR_RAM_TRIFORCE_MSK
	move.l	pointeur_triforceD_spr,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceD_ECRAN,ADR_ECRAN_TRIFORCE
	bsr	affiche_triforce

	move.l	pointeur_triforceH_msk,ADR_RAM_TRIFORCE_MSK
	move.l	pointeur_triforceH_spr,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceH_ECRAN,ADR_ECRAN_TRIFORCE
	bsr	affiche_triforce
	rts
triforce_suite
; on demarre l'animation
	jmp	boucle_triforce_seq1
fin_anim_triforce_seq1:
	move.w	#1,flag_sequence1
	move.w	#0,compteur_anim_triforceG
	move.w	#0,compteur_anim_triforceD
	move.w	#0,compteur_anim_triforceH
	jmp	boucle_triforce_seq1
fin_anim_triforce_seq2:
;	sub.l	#32*48,pointeur_triforceG_msk
;	sub.l	#32*48,pointeur_triforceG_spr
	sub.l	#8,adr_triforceG_ECRAN
	move.l	pointeur_triforceG_msk,ADR_RAM_TRIFORCE_MSK	
	move.l	pointeur_triforceG_spr,ADR_RAM_TRIFORCE_SPR
	move.l	adr_triforceG_ECRAN,ADR_ECRAN_TRIFORCE
	bsr	on_sauve_le_fond_triforce
	bsr	affiche_triforce
	bsr	init_registres
	jmp	retour_triforce_suite



; **************************************************************
; ****************** ON AFFICHE LE LOGO TRIFORCE ***************
; **************************************************************
afficher_logoTRIF:
	move.l	#logo_spr+2,a3
	bsr	charge_palette
	bsr	init_registres
	move.l	#logo_msk+34,a0		; gfx des masques dans A0
	move.l	#logo_spr+34,a1		; gfx des sprites dans A1
	add.w	#8*logoTRIF_X,d0	; 8 octets * X	
	add.w	#160*16*logoTRIF_Y,d1	; 160*16 lignes * Y
	add.l	d0,a0
	add.l	d1,a0			; on pointe au debut du masque du logo en ram
	add.l	d0,a1			
	add.l	d1,a1			; on pointe au debut du logo en ram

	move.w	#logoTRIF_l-1,d7	; largeur-1
	move.w	#logoTRIF_h-1,d6	; hauteur-1
	add.w	#logoTRIF_h*16,d6	; hauteur * 16 lignes	
	sub.w	#6,d6
	move.l	adr_frame_buffer,a2
	move.l	#160*16*3,d0	
	move.l	#8*7,d1
	add.l	d0,a2
	add.l	d1,a2
boucle_logoTRIF:	
	move.l	(a1)+,(a2)+		; on recopie 8 octets d7 fois
	move.l	(a1)+,(a2)+
	dbf	d7,boucle_logoTRIF
	add.l	#160-8*logoTRIF_l,a1
	add.l	#160-8*logoTRIF_l,a2
	move.w	#logoTRIF_l-1,d7
	dbf	d6,boucle_logoTRIF
	rts