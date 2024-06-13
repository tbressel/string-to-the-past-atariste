; a0 = pointeur texte
; a1 = frame buffer
; a2 = adresse de la FONTE en RAM
; a3 = adresse de la LETTRE en RAM 
; a4 = adresse du MASK de la FONTE en RAM
; a5 = adresse du MASK de la LETTRE en RAM	



on_affiche_le_texte:
; on cherche l'adresse de la lettre dans la fonte
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
	beq	premiere_lettre		; alors on va … la 1Šre
	cmp.w	#0,d7
	beq	premiere_lettre
	jmp	deuxieme_lettre

premiere_lettre:
	move.w	#1,flag_lettre		; on indique que l'on ‚crit la lettre de gauche
	
	REPT	16
	move.l	(a3)+,(a1)+
	move.l	(a3)+,(a1)
	add.l	#160-4,a1
	ENDR

	move.b	(a0),d7			; on lit la prochaine lettre d‚j… point‚	
	cmp.b	#$FF,d7
	beq	fin_de_texte
	cmp.b	#$FE,d7
	beq	texte_a_la_ligne
	sub.l	#160*16,a1		; on pointe l'‚cran 16 lignes plus haut
	add.l	#1,a1			; 1 octet plus loin
	jmp	on_affiche_le_texte
deuxieme_lettre
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
	beq	fin_de_texte
	cmp.b	#$FE,d7
	beq	texte_a_la_ligne
	sub.l	#160*16,a1		; on recule de 16 lignes
	add.l	#7,a1
	jmp	on_affiche_le_texte
texte_a_la_ligne:
	add.l	#1,a0
	move.l	a0,pointeur_texte
	move.l	pointeur_ligne_txt,a1
	add.l	#160*16,a1
	move.l	a1,pointeur_ligne_txt
	move.w	#0,flag_lettre
	jmp	on_affiche_le_texte
fin_de_texte:
	bsr	attendre_une_touche
	rts

; ***************************************************************
; ****************** REAGIRE AVEC LE CLAVIER ********************
; ***************************************************************






