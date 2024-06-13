init_fade_out:
	move.l	#title_screen+2,a0
	move.l	#stock_palette_fade_out,a1
	REPT	16
	move.w	(a0)+,(a1)+	
	ENDR
	rts
couleur_a_zero:
	cmp.w	#32-1,d5
	beq	retour_boucle_fade_out
	add.w	#1,d5
	jmp	retour_couleur_a_zero
boucle_fade_out:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
test_vbl_fade_out:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	test_vbl_fade_out	; si il n'a pas chang‚ on boucle
	bsr	init_registres		; mise a zero des registres
	move.l	#stock_palette_fade_out,a0
	move.w	#32-1,d7	
boucle_encre_suivante:
	move.b	(a0),d6
	cmp.b	#0,d6
	beq	couleur_a_zero
	sub.b	#1,(a0)
retour_couleur_a_zero
	add.l	#1,a0
	dbf	d7,boucle_encre_suivante
on_envoie:	
	move.l	#stock_palette_fade_out,a3
	bsr	charge_palette	
	jmp	boucle_fade_out