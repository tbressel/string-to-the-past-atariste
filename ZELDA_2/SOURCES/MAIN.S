;****************************************************************
;****************************************************************
;             FICHIER SOURCES CONTENANT LES BOUCLES           
;****************************************************************                     
;****************************************************************

debut_du_programme:
	
NOUVELLE_PIECE:
	bsr	init_registres
	move.l	adr_piece,a0
	sub.l	#18,a0
	move.w	(a0),no_piece	

	bsr	calcul_posXY_porte_scroll
NOUVELLE_MAISON:
	

	
	

;*******************************************************
;***************** BOUCLE PRINCIPALE *******************
;*******************************************************
;***********************  DEBUT ************************
;*******************************************************
boucle_principale:
	;bsr	switch_ecran
	bsr	link
retour_link
	bsr	items
retour_items

	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
boucle_vbl:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	boucle_vbl		; si il n'a pas chang‚ on boucle

event_buisson_boom:
	ds.l	16
retour_buisson_boom

	jmp	test_de_touches
retour_test_de_touches
	jmp	boucle_principale
;**********************************************************
;****************** BOUCLE PRINCIPALE  ********************
;**********************************************************
;***********************   FIN  ***************************
;**********************************************************



; -------------------------------------------------
; ----      Test des touches du clavier        ----
; -------------------------------------------------
test_de_touches:
	cmp.b	#$01,$FFFFFC02		; on test la touche ESC ($01)
					; avec la donn‚e de la pression
					; de la touche log‚ en $FFFFFC02
	beq	on_quitte		

	cmp.b	#$13,$FFFFFC02		; on test la touche R
	beq	on_recommence


	
	move.w	count_anim_link,d7	; pour donner une inetie … link, on empeche les changement de direction
	cmp.b	#0,d7			; durant 4 animations cons‚cutives.
	bne	fin_du_test

	move.w	#0,flag_direction_link
	
	
	bsr	ecrans_debug
	
	cmp.b	#$2C,$FFFFFC02
	beq	link_fireA
retour_link_fire_A
	cmp.b	#$2D,$FFFFFC02
	beq	link_fireB
retour_link_fire_B
	
	cmp.b	#$4D,$FFFFFC02
	beq	link_droite		; touche fleche droite
	cmp.b	#$4B,$FFFFFC02		; touche fleche gauche
	beq	link_gauche			
	cmp.b	#$50,$FFFFFC02		; touche fleche bas
	beq	link_bas	
	cmp.b	#$48,$FFFFFC02		; touche fleche haut
	beq	link_haut	



; ************************************************
	cmp.b	#$6b,$FFFFFc02
	beq	link_bas_debug
	jmp	retour_test_de_touches
fin_du_test:
	move.w	flag_direction_link,d7	; est ce que link allait … droite ?
	cmp.b	#droite,d7
	beq	link_droite
	cmp.b	#gauche,d7
	beq	link_gauche
	cmp.b	#bas,d7
	beq	link_bas
	cmp.b	#haut,d7
	beq	link_haut
	move.w	#0,flag_direction_link
	move.w	#0,count_anim_link
	jmp	boucle_principale
link_scroll_fin:
	move.w	#0,flag_direction_link
	move.w	#0,count_anim_link
	rts


init_registres:
	move.l	#0,d0
	move.l	d0,d1
	move.l	d0,d2
	move.l	d0,d3
	move.l	d0,d4
	move.l	d0,d5
	move.l	d0,d6
	move.l	d0,d7
	move.l	#0,a0
	move.l	a0,a1
	move.l	a0,a2
	move.l	a0,a3
	move.l	a0,a4
	move.l	a0,a5
	move.l	a0,a6
	rts

calcul_posXY_porte_scroll:
	move.l	#tbl_scroll_piece,a0			; l'adresse du tableau
	move.l	#resultat_scroll_piece_en_cours,a1

boucle_calcul_posXY_porte_scroll
	move.w	(a0),d0					; on r‚cupŠre le 1 octet de la ligne (no de la piece)
	move.w	no_piece,d1
	cmp.w	d1,d0
	beq	calcul_OK_porte_scroll
	cmp.w	#0,d0
	beq	calcul_FIN_porte_scroll
	add.w	#18,a0
	jmp	boucle_calcul_posXY_porte_scroll		
calcul_FIN_porte_scroll
	rts

calcul_OK_porte_scroll
	add.l	#2,a0
	REPT	8
	move.w	(a0)+,(a1)+
	ENDR		
	rts	


; **************************************************************
; ******************** On quitte le programme   ****************
; **************************************************************
on_quitte:
; **************************************************************
; ********************* On redeplace l'‚cran   *******************
; **************************************************************
	move.w	#1,-(sp)			; moyenne r‚solution
	move.l	adr_frame_buffer,-(sp)		; adr. ‚cran psysique
	move.l  #-1,-(sp)		; adr. ‚cran logique
	move.w	#5,-(sp)			; fonction 5 : Setscreen
	trap 	#14	
	add.w	#12,sp
	move.l	#palette_gem,A3		; on charge la palette
	bsr	charge_palette		; on r‚cupŠre la pelette du GEM
	bsr	keyclic_on
	bsr	mouse_on
;	move.l	adr_stack_retour,a7
	jmp	quitter


