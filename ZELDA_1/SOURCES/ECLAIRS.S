boucle_eclairs:

boucle_wait_eclairs:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
eclairs_vbl:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	eclairs_vbl		; si il n'a pas chang‚ on boucle
	
	bsr	affiche_eclair


	sub.w	#1,wait
	move.w	wait,d0
	cmp.w	#0,d0
	bne	boucle_eclairs
	move.w	#3,wait
	
	cmp.b	#$01,$FFFFFC02
	beq	retour_boucle_eclairs
	
	bsr	on_remet_fond_eclair
	bsr	on_change_eclair
	bsr	calcul_eclair
	bsr	on_sauve_fond_eclair

	bsr	affiche_eclair

	jmp	boucle_eclairs


calcul_eclair:
	move.w	etp_eclairs,d7
	cmp.w	#0,d7
	beq	etp_eclairs1
	cmp.w	#1,d7
	beq	etp_eclairs2
	cmp.w	#2,d7
	beq	etp_eclairs3
	cmp.w	#3,d7
	beq	etp_eclairs4
	cmp.w	#4,d7
	beq	etp_eclairs5
	cmp.w	#5,d7
	beq	etp_eclairs6
	cmp.w	#6,d7
	beq	etp_eclairs7
	cmp.w	#7,d7
	beq	etp_eclairs8
	cmp.w	#8,d7
	beq	etp_eclairs_fin
init_etp_eclairs:
	

etp_eclairs1:
	add.w	#1,etp_eclairs
	move.l	#logo_msk+34,a3
	move.l	#logo_spr+34,a4
	add.l	#160*16*3,a3
	add.l	#160*16*3,a4
	move.l	a3,adr_eclair_msk
	move.l	a4,adr_eclair_spr
	move.l	a5,adr_eclair_ECRAN
	cmp.w	#0,d3
	bne	on_deplace_eclair
	rts
etp_eclairs2:
	add.w	#1,etp_eclairs
	add.l	#8,a3
	add.l	#8,a4
	move.l	a3,adr_eclair_msk
	move.l	a4,adr_eclair_spr
	move.l	a5,adr_eclair_ECRAN
	cmp.w	#0,d3
	bne	on_deplace_eclair
	rts
etp_eclairs3:
	add.w	#1,etp_eclairs
	add.l	#160*16,a3
	sub.l	#8,a3
	add.l	#160*16,a4
	sub.l	#8,a4
	move.l	a3,adr_eclair_msk
	move.l	a4,adr_eclair_spr
	move.l	a5,adr_eclair_ECRAN
	cmp.w	#0,d3
	bne	on_deplace_eclair
	
	rts
etp_eclairs4:
	jmp	etp_eclairs2
etp_eclairs5:
	jmp	etp_eclairs3
etp_eclairs6:
	jmp	etp_eclairs2
etp_eclairs7:
	jmp	etp_eclairs3
etp_eclairs8:
	jmp	etp_eclairs2
etp_eclairs_fin:
	move.w	#0,etp_eclairs
	bsr	on_remet_fond_eclair
	add.w	#1,choix_eclair
	rts

on_deplace_eclair
	add.w	#160*2,d3
	add.l	d3,adr_eclair_ECRAN
	rts



affiche_eclair
	move.l	adr_eclair_msk,a0
	move.l	adr_eclair_spr,a1
	move.l	adr_eclair_ECRAN,a2
	move.w	#16-1,d7
boucle_eclair:
	move.l	(a0)+,d0
	move.l	(a1)+,d1
	and.l	(a2),d0
	move.l	d0,(a2)
	or.l	(a2),d1
	move.l	d1,(a2)+

	move.l	(a0)+,d0
	move.l	(a1)+,d1
	and.l	(a2),d0
	move.l	d0,(a2)
	or.l	(a2),d1
	move.l	d1,(a2)+

	add.l	#160-8,a0
	add.l	#160-8,a1
	add.l	#160-8,a2
	dbf	d7,boucle_eclair
	rts	

on_sauve_fond_eclair
	move.l	adr_eclair_ECRAN,a0
	move.l	#fond_eclair,a1
	REPT	16
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	add.l	#160-8,a0
	ENDR	
	rts
on_remet_fond_eclair
	move.l	adr_eclair_ECRAN,a0
	move.l	#fond_eclair,a1
	REPT	16
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	add.l	#160-8,a0
	ENDR	
	rts

on_change_eclair:
	move.w	choix_eclair,d7
	cmp.w	#1,d7
	beq	choix_eclair1
	cmp.w	#2,d7
	beq	choix_eclair2
	cmp.w	#3,d7
	beq	choix_eclair3
	cmp.w	#4,d7
	beq	choix_eclair4
	cmp.w	#5,d7
	beq	choix_eclair5
	cmp.w	#6,d7
	beq	choix_eclair6
	cmp.w	#7,d7
	beq	choix_eclair_epee1
	cmp.w	#8,d7
	beq	choix_eclair_epee2
	cmp.w	#9,d7
	beq	choix_eclair_fin

init_eclair:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*4,a5
	add.l	#8*6,a5		
	rts	
choix_eclair1:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*8,a5
	add.l	#8*7,a5
	rts
choix_eclair2:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*7,a5
	sub.l	#160*8,a5
	add.l	#8*10,a5
	rts
choix_eclair3:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*8,a5
	add.l	#8*13,a5
	rts
choix_eclair4:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*5,a5
	sub.l	#160*8,a5
	add.l	#8*13,a5
	;move.w	#0,choix_eclair
	rts
choix_eclair5:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*3,a5
	add.l	#160*8,a5
	add.l	#8*13,a5
	rts
choix_eclair6:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*3,a5
	add.l	#160*4,a5
	add.l	#8*9,a5
	rts
choix_eclair_epee1:
	move.l	adr_frame_buffer,a6
	add.l	#160*16*5,a6
	sub.l	#160*4,a6
	add.l	#8*6,a6
	move.l	a6,a5
	add.w	#160*4,d3		
	rts
choix_eclair_epee2:
	move.l	adr_frame_buffer,a5
	add.l	#160*16*10,a5
	sub.l	#160*6,a5
	add.l	#8*6,a5
	move.w	#0,d3
	rts

choix_eclair_fin:
	move.w	#0,choix_eclair
	move.w	#0,d3
	rts