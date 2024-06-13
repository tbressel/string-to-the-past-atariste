fistendo: 
	move.l	#logo_spr+2,a3
	bsr	charge_palette
	move.l	#logo_msk+34+160*16*9+8*2,a0
	move.l	#logo_spr+34+160*16*9+8*2,a1
	move.l	adr_frame_buffer,a2
	add.l	#160*16*6+8*8,a2
	;add.l	#160*16*9,a0
	;add.l	#8*2,a0
	;add.l	#160*16*9,a1
	;add.l	#8*2,a1	
	;add.l	#160*16*6,a2
	;add.l	#8*8,a2
	move.w	#4-1,d7
	move.w	#16-1,d6
boucle_nintendo_presente:
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

	dbf	d7,boucle_nintendo_presente
	add.l	#160-32,a0
	add.l	#160-32,a1
	add.l	#160-32,a2
	move.w	#4-1,d7
	dbf	d6,boucle_nintendo_presente

	move.w	#128,wait
boucle_wait:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
wait_vbl:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	wait_vbl		; si il n'a pas chang‚ on boucle
	
	sub.w	#1,wait
	move.w	wait,d0
	cmp.w	#0,d0
	bne	boucle_wait
	move.w	#255,wait
	rts