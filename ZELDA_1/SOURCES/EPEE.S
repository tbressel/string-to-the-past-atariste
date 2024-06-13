epee:
	bsr	init_registres
	move.l	#logo_msk+34,a0
	move.l	#logo_spr+34,a1	
	add.w	#8*logoEPEE_X,d0	; 8 octets * X	
	add.w	#160*16*logoEPEE_Y,d1	; 160*16 lignes * Y
	add.l	d0,a1			
	add.l	d1,a1			; on pointe au debut du logo en ram
	move.l	a1,adr_epee_RAM

	move.w	#logoEPEE_l-1,d7	; largeur-1
	move.w	#logoEPEE_h-1,d6	; hauteur-1
	add.w	#logoEPEE_h*16,d6	; hauteur * 16 lignes	
	sub.w	#6,d6
	
	move.l	adr_frame_buffer,a2
	add.w	#8*5,a2
	move.l	a2,adr_epee_ECRAN
	bsr	on_sauve_le_fond_epee

boucle_spriteEPEE:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
test_vbl_epee:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	test_vbl_epee	; si il n'a pas chang‚ on boucle
	

	add.w	#1,frame_counter	
	move.w	frame_counter,d0
	cmp.w	#4,d0
	bne	boucle_spriteEPEE
	move.w	#0,frame_counter

	move.w	etape_anim_epee,d0
	cmp.w	#11,d0
	beq	fin_epee


	
	bsr	on_remet_le_fond_epee
	jmp	affiche_epee	
retour_affiche_epee
	jmp	boucle_spriteEPEE

affiche_epee:
	move.w	etape_anim_epee,d7
	cmp.w	#1,d7
	beq	etp_epee_1
	cmp.w	#2,d7
	beq	etp_epee_2
	cmp.w	#3,d7
	beq	etp_epee_3
	cmp.w	#4,d7
	beq	etp_epee_4
	cmp.w	#5,d7
	beq	etp_epee_5
	cmp.w	#6,d7
	beq	etp_epee_6
	cmp.w	#7,d7
	beq	etp_epee_7
	cmp.w	#8,d7
	beq	etp_epee_8
	cmp.w	#9,d7
	beq	etp_epee_9
	cmp.w	#10,d7
	beq	etp_epee_10
	add.w	#1,etape_anim_epee
	jmp	retour_affiche_epee

etp_epee_1:
	
;	bsr	on_sauve_le_fond_epee
	move.w	#1*15,d7
	bsr	bcle_affiche_epee
	add.w	#1,etape_anim_epee
	jmp	retour_affiche_epee

etp_epee_2:
	move.l	adr_epee_RAM,a1
	sub.l	#160*16,a1
	move.l	adr_epee_ECRAN,a2
	move.l	a2,a4
	;bsr	on_sauve_le_fond_epee
	move.w	#2*15,d7
	bsr	bcle_affiche_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee
etp_epee_3:
	
	move.l	adr_epee_RAM,a1
	sub.l	#160*16*2,a1
	move.l	adr_epee_ECRAN,a2
	move.l	a2,a4
	;bsr	on_sauve_le_fond_epee
	move.w	#3*15,d7
	bsr	bcle_affiche_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee

etp_epee_4:
	move.l	adr_epee_RAM,a1
	sub.l	#160*16*3,a1
	move.l	adr_epee_ECRAN,a2
	move.l	a2,a4
	;bsr	on_sauve_le_fond_epee
	move.w	#4*15,d7
	bsr	bcle_affiche_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee

etp_epee_5:
	move.l	adr_epee_RAM,a1
	sub.l	#160*16*4,a1
	move.l	adr_epee_ECRAN,a2
	move.l	a2,a4
	;bsr	on_sauve_le_fond_epee
	move.w	#5*15,d7
	bsr	bcle_affiche_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee
etp_epee_6:
	move.l	#160*16*7,d0
	add.l	#8*3,d0
	move.l	#logo_spr+34,a1
	add.l	d0,a1
	move.l	a1,adr_epee_RAM

	move.l	adr_frame_buffer,a2
	add.l	#160*16*4,a2
	add.l	#8*5,a2
	move.l	a2,adr_epee_ECRAN
	bsr	on_sauve_le_fond_epee	
	move.w	#2*15,d7

	bsr	bcle_affiche_epee
	
	move.l	#160*16*6,d0
	add.l	#8*15,d0
	move.l	#logo_spr+34,a1
	add.l	d0,a1
	move.l	a1,adr_epee_RAM

	move.l	adr_frame_buffer,a2
	add.l	#160*16*1,a2
	add.l	#160*4,a2
	add.l	#8*5,a2
	move.l	a2,adr_epee_ECRAN
	;bsr	on_sauve_le_fond_epee	
	move.w	#3*15,d7	
	bsr	bcle_affiche_epee
	
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee	
etp_epee_7:
	move.l	#160*16*7,d0
	add.l	#8*7,d0
	move.l	#logo_spr+34,a1
	add.l	d0,a1
	move.l	a1,adr_epee_RAM
	move.l	adr_frame_buffer,a2
	add.l	#160*16*2,a2
	add.l	#8*5,a2
	move.l	a2,adr_epee_ECRAN
		
	move.w	#5*15,d7
	bsr	bcle_affiche_epee
	bsr	on_sauve_le_fond_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee

etp_epee_8:
	move.l	#logo_spr+34,a1
	move.l	a1,adr_epee_RAM
	move.l	adr_frame_buffer,a2
	add.l	#160*16*6,a2
	add.l	#8*6,a2
	move.l	a2,adr_epee_ECRAN
		
	move.w	#2*15,d7
	bsr	bcle_affiche_epee2
	bsr	on_sauve_le_fond_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee


etp_epee_9:
	move.l	#logo_spr+34+8,a1
	move.l	a1,adr_epee_RAM
	move.l	adr_frame_buffer,a2
	add.l	#160*16*7,a2
	add.l	#8*6,a2
	move.l	a2,adr_epee_ECRAN
	move.w	#3*15,d7
	bsr	bcle_affiche_epee2
	bsr	on_sauve_le_fond_epee
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee


	

etp_epee_10:
	move.l	#160*16*10,d0
	add.l	#8*13,d0
	move.l	#logo_spr+34,a1
	add.l	d0,a1
	move.l	a1,adr_epee_RAM
	move.l	adr_frame_buffer,a2
	add.l	#160*16*8,a2
	add.l	#8*6,a2
	move.l	a2,adr_epee_ECRAN
	bsr	on_sauve_le_fond_epee	
	move.w	#2*15,d7
	bsr	bcle_affiche_epee2
	add.w	#1,etape_anim_epee	
	jmp	retour_affiche_epee
	

; ************************************************************
; ******************     AFFICHAGE  EPEE      ****************
; ************************************************************
bcle_affiche_epee:
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	add.l	#160-24,a1
	add.l	#160-24,a2
	dbf	d7,bcle_affiche_epee
	rts

bcle_affiche_epee2:
	move.l	(a1)+,(a2)+
	move.l	(a1)+,(a2)+
	add.l	#160-8,a1
	add.l	#160-8,a2
	dbf	d7,bcle_affiche_epee2
	rts


; ************************************************************
; ****************** SAUVEGARDE DU FOND EPEE  ****************
; ************************************************************
on_sauve_le_fond_epee:
	move.l	adr_frame_buffer,a4
	add.l	#8*5,a4
	move.l	#fond_epee,a5
	move.w	#15*12,d7
bcl_sauve_fond_epee:
	REPT	6
	move.l	(a4)+,(a5)+
	ENDR
	add.l	#160-24,a4
	dbf	d7,bcl_sauve_fond_epee
	rts
; ************************************************************
; ******************* ON REMET LE FOND EPEE ******************
; ************************************************************
on_remet_le_fond_epee:
	move.l	adr_frame_buffer,a4
	add.l	#8*5,a4
	move.l	#fond_epee,a5
	move.w	#15*12,d7
bcl_remet_fond_epee:
	REPT	6
	move.l	(a5)+,(a4)+
	ENDR
	add.l	#160-24,a4
	dbf	d7,bcl_remet_fond_epee
	rts

fin_epee:	
	rts
	