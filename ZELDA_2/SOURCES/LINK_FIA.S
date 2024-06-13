link_fireA:
	move.w	flag_choppe_buisson,D7
	cmp.w	#1,d7
	beq	link_buisson

	move.w	flag_porte_buisson,d7
	cmp.w	#1,d7
	beq	retour_link_fire_A


	move.w	no_tile,d0
	cmp.w	#tile_buisson,d0
	beq	link_buisson
	jmp	retour_link_fire_A

