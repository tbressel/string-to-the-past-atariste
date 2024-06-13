selection_ligne:
; on initialise le des joueurs
	move.w	no_menu_fee,d5			; je r‚cupŠre le copteur de lignes
	add.w	#1,d5				; j'ajoute 1 pour que ligne 1 =1
	move.l	#tbl_nom_joueur,a0		; je pointe sur le tablerau
	move.l	a0,pointeur_tbl_nom_joueur	
	mulu.w	#12,d5				; 12 octets * le compteur de ligne
	add.l	d5,a0				; additionn‚ … l'adresse du tableau
	move.l	a0,pointeur_nom_joueur		; donne l'adresse de la variable du joueur cibl‚

	cmp.w	#0,(a0)
	bne	retour_menu_joueur	

; on initialise la saisie du texte
	move.w	#1,flag_saisie

	add.w	#1,flag_selection
	move.w	flag_selection,d7	; on test si la ligne est pleine
	cmp.w	#2,d7			; si oui
	beq	texte_valide		; alors on valide le texte saisie
	move.l	adr_fee_ECRAN,a0	; l'adresse de la fee
	add.l	#32+8,a0			; 64 octets plus loin
	move.l	a0,adr_lettre_ECRAN	; on a l'adr ecran de la lettre de d‚part
	move.w	#0,flag_lettre
; si c'est non alors on de pr‚pare … saisir une lettre
	jmp	test_de_touches
texte_valide:
	move.l	#tbl_nom_joueur,a0
	cmp.w	#0,(a0)
	beq	texte_non_valide
	move.w	#0,flag_selection
	move.w	#0,flag_saisie
	bsr	profil_joueur_ok
	jmp	retour_test_de_touches
texte_non_valide:
	move.w	#0,flag_selection
	move.w	#0,flag_saisie
	jmp	retour_test_de_touches



;===========================================================
espace:
	move.w	#" ",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
apostrophe:
	move.w	#"'",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
exclamation:
	move.w	#"!",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
parenthese1:
	move.w	#"(",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
parenthese2:
	move.w	#")",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================

chiffre_0:
	move.w	#"0",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
chiffre_1:
	move.w	#"1",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================

lettre_A:
	move.w	#"A",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_Z:
	move.w	#"Z",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_E:
	move.w	#"E",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_R:
	move.w	#"R",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_T:
	move.w	#"T",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_Y:
	move.w	#"Y",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_U:
	move.w	#"U",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_I:
	move.w	#"I",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_O:
	move.w	#"O",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_P:
	move.w	#"P",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_Q:
	move.w	#"Q",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_S:
	move.w	#"S",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_D:
	move.w	#"D",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_F:
	move.w	#"F",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_G:
	move.w	#"G",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_H:
	move.w	#"H",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_J:
	move.w	#"J",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_K:
	move.w	#"K",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_L:
	move.w	#"L",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_M:
	move.w	#"M",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_W:
	move.w	#"W",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_X:
	move.w	#"X",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_C:
	move.w	#"C",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_V:
	move.w	#"V",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_B:
	move.w	#"B",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================
lettre_N:
	move.w	#"N",d7			; adresse du texte
	bsr	on_affiche_la_lettre
	jmp	retour_test_de_touches
;===========================================================


on_affiche_la_lettre:
	;move.w	no_menu_fee,d6
	;move.l	#tbl_nom_joueur,a6
	;mulu.w	#12,d6
	;add.l	d6,a6
	;cmp.w	#0,(a6)
	;bne	on_zap_lettre
	
	


	move.w	vitesse_lettre,d6
	cmp.w	#1,d6
	bne	on_zap_lettre
	

	move.w	nbr_lettre,d6
	cmp.w	#12,d6
	beq	lettre_maxi

	move.w	d7,lettre
	bsr	gestion_joueurs
	
	
	move.w	#0,vitesse_lettre

	move.l	adr_lettre_ECRAN,a1	; adresse ecran
	move.l	#bin_fonte,a2		; adresse de la fonte
	move.l	a2,a4
	add.l	#160*16*5,a4		; adresse du mask de la fonte
; on cherche l'adresse de la lettre dans la fonte
	sub.b	#32,d7		; la fonte commence au caractŠre ASCII no 32 (expace)
	lsl.w	#7,d7		; rotation de 7 bits vers la gauche pour multiplier par 128 (16*8) 
	add.l	a2,d7		; adr de la fonte + decalage			  
	move.l	d7,a3		; l'adresse de la lettre est dans A3			
	add.l	a4,d7
	move.l	d7,a5		; l'adresse du masque de la lettre est dans A5
	move.l	#0,d7
	move.w	#0,vitesse_lettre
; on test le switch des lettres dans la meme case
	move.w	flag_lettre,d7
	cmp.w	#2,d7			; si on ‚tait … la 2eme lettre
	beq	lettre_paire		; alors on va … la 1Šre
	cmp.w	#0,d7
	beq	lettre_paire
	jmp	lettre_impaire
lettre_paire:
	move.l	adr_lettre_ECRAN,a1
	move.w	#1,flag_lettre		; on indique que l'on ‚crit la lettre de gauche
	REPT	16
	move.l	(a3)+,(a1)+
	move.l	(a3)+,(a1)
	add.l	#160-4,a1
	ENDR
	sub.l	#160*16,a1		; on pointe l'‚cran 16 lignes plus haut
	add.l	#1,a1			; 1 octet plus loin
	move.l	a1,adr_lettre_ECRAN
	jmp	retour_test_de_touches
lettre_impaire:
	move.w	#2,flag_lettre
	move.l	adr_lettre_ECRAN,a1
	REPT	16
	move.b	(a3),(a1)		; on envoie le 1er octet (1er bit plan)
	add.l	#6,a3			; on se d‚cale de 6 octets (4eme bit plan)
	add.l	#6,a1			; idem … l'‚cran
	move.b	(a3),(a1)		; et on recopie l'octet
	add.l	#160-6,a1		; on pointe une ligne en dessous … l'‚cran et on revient au 1er bit plan
	add.l	#2,a3			; on pointe sur le 3eme bit plan suivant
	ENDR
	sub.l	#160*16,a1		; on recule de 16 lignes
	add.l	#7,a1
	move.l	a1,adr_lettre_ECRAN
	jmp	retour_test_de_touches
on_zap_lettre:
	add.w	#1,vitesse_lettre
	rts

gestion_joueurs:

; !!!!!!!!!!!!!!!!!!!!!!!!!!!!! a terminer  !!!!!!!!!!!!!!!!!!!!!!!
; on initialise 
	move.l	a0,pointeur_nom_joueur	; donne l'adresse de la variable du joueur cibl‚
	move.b	d7,(a0)+		; on y recopie l'octet de la lettre
	move.l	a0,pointeur_nom_joueur

	move.l	pointeur_tbl_nom_joueur,a0
	move.b	d7,(a0)+
	move.l	a0,pointeur_tbl_nom_joueur
	
	add.w	#1,nbr_lettre

	rts

lettre_maxi:
	jmp	retour_test_de_touches