; dans la m‚moire du ST les couleur RBG sont envoy‚ en $FF8240
; sous cette forme : 0000 0RRR 0GGG 0BBB
init_fade_out2:
	move.l	#selection_1+2,a0
	jmp	saute_init

init_fade_out:
	move.l	#title_screen+2,a0
saute_init
	move.l	#stock_palette_fade_out,a1
	REPT	16
	move.w	(a0)+,(a1)+
	ENDR
	bsr	init_registres		; mise a zero des registres
	move.l	#stock_palette_fade_out,a0
	move.w	#16-1,d7
	rts

stock:
	ds.w	1

boucle_fade_out:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
test_vbl_fade_out:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	test_vbl_fade_out	; si il n'a pas chang‚ on boucle
	

	add.w	#1,frame_counter	
	move.w	frame_counter,d4
	cmp.w	#4,d4
	bne	boucle_fade_out
	move.w	#0,frame_counter

	;move.l	$FF8240,d0		; on stock l'adresse des cannaux RGB
	move.l	#stock_palette_fade_out,a0
boucle_encre_suivante:	
canal_rouge	
	move.w	(a0),d1
	and.w	#%0000011100000000,d1	; on garde que les bits du canal rouge
	cmp.w	#%0000000000000000,d1	; est ce que le canal rouge  est … 0 ?
	beq	canal_vert
	sub.w	#%0000000100000000,(a0)	; si non on diminu de 1
canal_vert
	move.w	(a0),d1
	and.w	#%0000000001110000,d1
	cmp.w	#%0000000000000000,d1
	beq	canal_bleu
	sub.w	#%0000000000010000,(a0)
canal_bleu
	move.w	(a0),d1
	and.w	#%0000000000000111,d1
	cmp.w	#%0000000000000000,d1
	beq	encre_suivante
	sub.w	#%0000000000000001,(a0)
encre_suivante:
	add.l	#2,a0			; on pointe sur l'encre suivante
	dbf	d7,boucle_encre_suivante

	move.w	#16-1,d7		; on reinit le compteur d'encre
	move.l	#stock_palette_fade_out,a3	; on pointe au debut de la palette temporaire
	move.l	#$FF8240,a1			; on pointe dans l'affichage des canaux du ST
	REPT	16
	move.w	(a3)+,(a1)+			; on envoie la palette mise … jour
	ENDR

	jmp	couleurs_a_zero			; on va tester si tout est … z‚ros ou pas
retour_couleurs_a_zero
	jmp	boucle_fade_out

couleurs_a_zero:
	move.l	#stock_palette_fade_out,a2	; on pointe au debut de la palette temporaire
	REPT	16
	move.w	(a2)+,d6		; on lit la valeur de l'encre
	cmp.w	#0,d6			; est elle … z‚ro ?
	bne	retour_couleurs_a_zero		; non, alors on retour d'ou on vient
	ENDR	
	
	jmp	retour_boucle_fade_out		; on arrive ici quand toutes les encre sont … z‚ros





; *********************************************************************
; *********************************************************************
; *********************************************************************
logozelda_OK:
	ds.w	1

boucle_fade_in:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
test_vbl_fade_in:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	test_vbl_fade_in	; si il n'a pas chang‚ on boucle
	
	add.w	#1,frame_counter	
	move.w	frame_counter,d4
	cmp.w	#7,d4
	bne	boucle_fade_in
	move.w	#0,frame_counter


	move.w	logozelda_OK,d4
	cmp.w	#1,d4
	beq	on_zap_logoZELDA
	
	bsr	afficher_logoZELDA
on_zap_logoZELDA:

	move.l	#rgb_color,a1
	move.l	#stock_palette_fade_out,a0
	move.w	#16-1,d7
boucle_encre_suivante2:	
canal_rouge2	
	move.w	(a1),d1
	and.w	#%0000011100000000,d1	; on garde que les bits du canal rouge
	move.w	(a0),d0
	and.w	#%0000011100000000,d0
	cmp.w	d0,d1	; est ce que le canal rouge  est … 0 ?
	beq	canal_vert2
	add.w	#%0000000100000000,(a1)	; si non on diminu de 1
canal_vert2
	move.w	(a1),d1
	and.w	#%0000000001110000,d1
	move.w	(a0),d0
	and.w	#%0000000001110000,d0
	cmp.w	d0,d1
	beq	canal_bleu2
	add.w	#%0000000000010000,(a1)
canal_bleu2
	move.w	(a1),d1
	and.w	#%0000000000000111,d1
	move.w	(a0),d0
	and.w	#%0000000000000111,d0
	cmp.w	d0,d1
	beq	encre_suivante2
	add.w	#%0000000000000001,(a1)
encre_suivante2:
	move.w	(a0),d0
	cmp.w	(a1),d0
	beq	count_color_ok
retour_count_color_ok
	add.l	#2,a0			; on pointe sur l'encre suivante
	add.l	#2,a1
	dbf	d7,boucle_encre_suivante2

	move.w	#16-1,d7		; on reinit le compteur d'encre
	move.l	#stock_palette_fade_out,a0	; on pointe au debut de l	
	jmp	boucle_fade_in

count_color_ok
	add.w	#1,count_color
	move.w	count_color,d0
	cmp.w	#16,d0
	beq	retour_boucle_fade_in
	jmp	retour_count_color_ok

count_color:
	ds.w	1

