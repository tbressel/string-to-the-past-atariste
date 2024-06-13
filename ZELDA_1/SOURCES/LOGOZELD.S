afficher_logoZELDA:
	;move.l	#logo_spr+2,a3
	;bsr	charge_palette

couleurs:
	move.l	#logo_spr+2,a0
	move.l	#stock_palette_fade_out,a1
	REPT	8
	move.l	(a0)+,(a1)+
	ENDR	

	move.l	#rgb_color+2,a0		; encre 2
	move.w	#$0000,(a0)
	move.l	#rgb_color+8,a0		; encre4
	move.w	#$0000,(a0)		
	move.l	#rgb_color+14,a0		; encre 7
	move.w	#$0000,(a0)
	move.l	#rgb_color+24,a0		; encre 11
	move.w	#$0000,(a0)	

	bsr	init_registres
	
	move.l	#logo_msk+34,a0
	move.l	#logo_spr+34,a1
	add.w	#8*logoZELDA_X,d0	; 8 octets * X	
	add.w	#160*16*logoZELDA_Y,d1	; 160*16 lignes * Y
	add.l	d0,a1			
	add.l	d1,a1		; on pointe au debut du logo en ram
	add.l	d0,a0
	add.l	d1,a0		; on pointe au debut du masque du logo	

	move.w	#logoZELDA_l-1,d7	; largeur-1
	move.w	#logoZELDA_h-1,d6	; hauteur-1
	add.w	#logoZELDA_h*16,d6	; hauteur * 16 lignes	
	sub.w	#6,d6
	move.l	adr_frame_buffer,a2
	move.l	#160*16*4,d0	
	move.l	#8*5,d1
	add.l	d0,a2
	add.l	d1,a2

boucle_logoZELDA:	
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
	dbf	d7,boucle_logoZELDA
	add.l	#160-8*logoZELDA_l,a0
	add.l	#160-8*logoZELDA_l,a1
	add.l	#160-8*logoZELDA_l,a2
	move.w	#logoZELDA_l-1,d7
	dbf	d6,boucle_logoZELDA
	
	add.w	#1,logozelda_OK

	rts