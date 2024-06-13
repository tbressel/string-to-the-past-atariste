scenario:
	move.l	#img_scenario+2,a3
	bsr	charge_palette
	move.l	#img_scenario+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#160*199/4-1,d7
boucle_scenario1
	move.l	(a0)+,(a1)+
	dbf	d7,boucle_scenario1
	
; *************************************************************
; *************************************************************
; *************************************************************


texte:
	bsr	init_registres
	move.l	pointeur_nom_joueur,a0
	move.l	#pseudo,a1
	move.l	#pseudo2,a2
	REPT	12
	move.b	(a0),(a1)+
	move.b	(a0)+,(a2)+
	ENDR

	
	move.l	#texte_intro,a0		; adresse du texte
	move.l	a0,pointeur_texte
	move.l	adr_frame_buffer,a1	; adresse ecran
	add.l	#160*16*7,a1
	add.l	#8*2,a1

	move.l	a1,pointeur_ligne_txt
	move.l	#bin_fonte,a2		; adresse de la fonte
	move.l	a2,a4
	add.l	#160*16*5,a4		; adresse du mask de la fonte
	bsr	on_affiche_le_texte

; *************************************************************
; *************************************************************
; *************************************************************
	bsr	init_registres

ICI
	move.l	#defile,pointeur_texte	; texte en RAM
	move.l	adr_frame_buffer,a0
	add.l	#160*16*10,a0
	add.l	#8*2,a0
	move.l	a0,pointeur_ligne_txt


boucle_scenario:
	move.l	$466,d0			; on recupŠre le compteur de vbl dans D0
boucle_vbl_scenario:
	cmp.w	$468.w,d0		; si il a chang‚ alors on boucle pas
	beq	boucle_vbl_scenario
	
	add.w	#1,frame_counter	
	move.w	frame_counter,d4
	cmp.w	#4,d4
	bne	boucle_scenario
	move.w	#0,frame_counter




	move.w	flag_ligne_en_cours,d7
	cmp.w	#1,d7
	beq	on_zap_scroll

;	cmp.b	#$02,$FFFFFC02
;	bne	hop
	
	bsr	on_scroll_une_ligne
on_zap_scroll:
	bsr	on_affiche_une_ligne
hop


	
	cmp.b	#$01,$FFFFFC02
	beq	on_quitte

	jmp	boucle_scenario


on_scroll_une_ligne:
	move.w	#16-1,d6
boucle_ligne_scroll_suivante
	move.l	adr_frame_buffer,a0	; adresse ecran
	add.l	#160*16*7,a0
	add.l	#8*2,a0
	add.l	#160,a0
	move.l	a0,a1
	sub.l	#160,a1
	move.w	#16*4,d7
	sub.w	#2,d7
boucle_scroll
	REPT	16	
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	ENDR
	add.l	#32,a0
	add.l	#32,a1
	dbf	d7,boucle_scroll
	dbf	d6,boucle_ligne_scroll_suivante
	;sub.l	#160*16,pointeur_ligne_txt
	rts







; ******************************************************
; ******************************************************
; ******************************************************

on_affiche_une_ligne:
; on cherche l'adresse de la lettre dans la fonte
	move.w	#1,flag_ligne_en_cours
	move.l	#bin_fonte,a2		; adresse de la fonte
	move.l	a2,a4
	add.l	#160*16*5,a4		; adresse du mask de la fonte
	move.l	pointeur_ligne_txt,a1
	move.l	pointeur_texte,a0	; RAM
	move.l	#0,d7
	move.b	(a0)+,d7	; on lit l'octet du texte et on point sur la prochaine lettre
	move.l	a0,pointeur_texte
	sub.b	#32,d7		; la fonte commence au caractŠre ASCII no 32 (expace)
	lsl.w	#7,d7		; rotation de 7 bits vers la gauche pour multiplier par 128 (16*8) 
	add.l	a2,d7			  
	move.l	d7,a3		; l'adresse de la lettre est dans A3			
	add.l	a4,d7
	move.l	d7,a5		; l'adresse du masque de la lettre est dans A5
; on test le switch des lettres dans la meme case
	move.w	flag_lettre,d7
	cmp.w	#2,d7			; si on ‚tait … la 2eme lettre
	beq	premiere_lettre2		; alors on va … la 1Šre
	cmp.w	#0,d7
	beq	premiere_lettre2
	jmp	deuxieme_lettre2
premiere_lettre2:
	move.w	#1,flag_lettre		; on indique que l'on ‚crit la lettre de gauche
	
	REPT	16
	move.l	(a3)+,(a1)+
	move.l	(a3)+,(a1)
	add.l	#160-4,a1
	ENDR

	move.b	(a0),d7			; on lit la prochaine lettre d‚j… point‚	
	cmp.b	#$FF,d7
	beq	fin_de_texte2
	cmp.b	#$FE,d7
	beq	texte_a_la_ligne2
	sub.l	#160*16,a1		; on pointe l'‚cran 16 lignes plus haut
	add.l	#1,a1			; 1 octet plus loin
	move.l	a1,pointeur_ligne_txt
	rts
deuxieme_lettre2
	move.w	#2,flag_lettre
		
	REPT	16
	move.b	(a3),(a1)		; on envoie le 1er octet (1er bit plan)
	add.l	#6,a3			; on se d‚cale de 6 octets (4eme bit plan)
	add.l	#6,a1			; idem … l'‚cran
	move.b	(a3),(a1)		; et on recopie l'octet
	add.l	#160-6,a1		; on pointe une ligne en dessous … l'‚cran et on revient au 1er bit plan
	add.l	#2,a3			; on pointe sur le 3eme bit plan suivant
	ENDR

	move.b	(a0),d7
	cmp.b	#$FF,d7
	beq	fin_de_texte2
	cmp.b	#$FE,d7
	beq	texte_a_la_ligne2
	sub.l	#160*16,a1		; on recule de 16 lignes
	add.l	#7,a1
	move.l	a1,pointeur_ligne_txt
	rts
texte_a_la_ligne2:
	add.l	#1,a0
	move.l	a0,pointeur_texte
	move.l	pointeur_ligne_txt,a1
	add.l	#160*16,a1
	move.l	a1,pointeur_ligne_txt
	move.w	#0,flag_lettre
	move.l	adr_frame_buffer,a0
	add.l	#160*16*10,a0
	add.l	#8*2,a0
	move.l	a0,pointeur_ligne_txt
	move.w	#0,flag_ligne_en_cours
	rts
fin_de_texte2:
	bsr	on_quitte