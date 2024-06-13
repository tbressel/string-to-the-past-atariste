
;*******************************************************
;***************** BOUCLE SECONDAIRE *******************
;*******************************************************
;***********************  DEBUT ************************
;*******************************************************
boucle_scrolling:
boucle_secondaire:
	bsr	switch_ecran		; on change d'‚cran et de pointeur			; on recupŠre le compteur de vbl dans D0
	bsr	recopie_ecran
	move.l	$466,d0
boucle_vbl2:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	boucle_vbl2		; si il n'a pas chang‚ on boucle

	move.b	direction_scroll,D1
	cmp.b	#1,D1
	beq	on_scroll_vers_le_haut	; on decale l'‚cran vers le haut d'une ligne
					; et on ecrit une ligne de tiles dans le bas
	move.b	direction_scroll,D1
	cmp.b	#2,D1
	beq	on_scroll_vers_le_bas	; on decale l'‚cran vers le bas d'une ligne

	move.b	direction_scroll,D1
	cmp.b	#3,D1
	beq	on_scroll_vers_la_gauche

	move.b	direction_scroll,D1
	cmp.b	#4,D1
	beq	on_scroll_vers_la_droite

retour_scroll:

	dbf	d6,boucle_secondaire	; tant que le compteur n'est pas … -1
					; on boucle
	move.b	flag_ecran,d0		; sur quel ecran fini on ?
	cmp.b	#1,d0
	beq	on_fini_en_ecran_1
on_fini_en_ecran_2:			; scroll horizontal
	bsr	switch_ecran		; on montre le dernier ‚cran dans le quel on a ‚crit avant de quitter la boucle.
	bsr	recopie_ecran	
	rts
on_fini_en_ecran_1:			; scroll vertical
	bsr	switch_ecran
	bsr	recopie_ecran
	bsr	switch_ecran	
	rts			; quand c'est fini on quitte la boucle pour retourner 
				; vers link qui revient dans l'‚cran
	
;*******************************************************
;***************** BOUCLE SECONDAIRE *******************
;*******************************************************
;***********************  FIN  *************************
;*******************************************************

; -------------------------------------------------
; ----      On switch d'un ecran … l'autre     ----
; -------------------------------------------------
switch_ecran:
	move.b	flag_ecran,d0		; on test le flag d'‚cran
	cmp.b	#1,d0			; si on voit l'‚cran 1
	beq	on_switch_ecran2	; on switch vers l'‚cran 2
	cmp.b	#2,d0			; si on voit l'‚cran 2
	beq	on_switch_ecran1	; on switch vers l'‚cran 1
on_switch_ecran1:
	bsr	ecran_no_1		; appel du TOS
	move.b	#1,flag_ecran		; on est dans l'‚cran 1
	move.l	adr_frame_buffer2,A0	; on ‚crit dans l'‚cran 2
	move.l	a0,adr_switch_buffer
	rts
on_switch_ecran2:
	bsr	ecran_no_2		; appel du TOS
	move.b	#2,flag_ecran		; on est dans l'‚cran 2
	move.l	adr_frame_buffer,A0	; on ‚crit dans l'‚cran 1
	move.l	a0,adr_switch_buffer
	rts	

; -------------------------------------------------
; ----      On recopie l'ecran sur l'autre     ----
; -------------------------------------------------
recopie_ecran:
	move.w	#16*12*2,D5		; compteur -> on recopie 16 lignes * 11 rang‚es de tiles
	move.b	flag_ecran,d0		; on test le flag d'‚cran
	cmp.b	#1,d0			; si on voit l'‚cran 1
	beq	on_recopie_AversB	; on recopie
	cmp.b	#2,d0			; si on voit l'‚cran 2
	beq	on_recopie_BversA	; on recopie
on_recopie_AversB:
	move.l	adr_frame_buffer,a0
	move.l	adr_frame_buffer2,a1
	jmp	boucle_recopie_ecran
on_recopie_BversA:
	move.l	adr_frame_buffer2,a0
	move.l	adr_frame_buffer,a1

boucle_recopie_ecran:
	REPT	30
	move.l	(a0)+,(a1)+
	ENDR
	sub.l	#5*8,A0			; on arrive au bord de l'‚cran et il faut ‚viter le HUD
	sub.l	#5*8,A1
	dbf	d5,boucle_recopie_ecran		
	rts
