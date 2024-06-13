link_fireB:
	move.w	flag_porte_item,d7
	cmp.w	#0,d7
	beq	retour_link_fire_B

	move.w	flag_porte_buisson,d7
	cmp.w	#1,d7
	beq	on_lance_buisson

	
	jmp	retour_link_fire_B


on_lance_buisson:
; on fait disparaitre le buisson
	bsr	on_remet_le_fond_item16x16
	move.l	sprite_item_ECRAN,sprite_sfx_ECRAN
	move.l	sprite_sfx_ECRAN,fond_sfx
	move.w	direction_precedante,d0
	bsr	link2
	bsr	on_sauve_le_fond_sfx16x43
	move.w	#0,flag_porte_item
	move.w	#0,flag_porte_buisson

; on cr‚er l'evenement … l'interieur de la boucle
; $4EF9 l'opcode de 'jmp $adr'	
	move.w	#$4EF9,event_buisson_boom		
	move.l	#buisson_boom,event_buisson_boom+2
	jmp	retour_link_fire_B	

