on_affiche_le_texte:
	move.l	#0,d7
	move.b	(a0)+,d7		; on lit l'octet du texte et on point sur la prochaine lettre
	sub.b	#32,d7			; la fonte commence au caractŠre ASCII no 32 (expace)
	mulu.w	#16*8,d7		; no de l'emplacement de la lettre (d7) fois la longueure d'une lettre (16 lignes sur 8 octets)
	add.l	a2,d7			;  
	move.l	d7,a3		; l'adresse de la lettre est dans A3			
	;add.l	a4,d7
	;move.l	d7,a5		; l'adresse du masque est dans A5
	
	move.w	flag_lettre,d7
	cmp.w	#2,d7			; si on ‚tait … la 2eme lettre
	beq	premiere_lettre		; alors on va … la 1Šre
	cmp.w	#0,d7
	beq	premiere_lettre
	jmp	deuxieme_lettre

flag_lettre:
	ds.w	1
pointeur_ligne_txt:
	ds.l	1

premiere_lettre
	move.w	#1,flag_lettre		; on indique que l'on ‚crit la lettre de gauche
	add.l	#4,a1			; 4 octets plus loin (3eme bit plan ou "word")

	add.l	#4,a3			; idem pour la lettre de la fonte
	;add.l	#4,a5

	REPT	16
	
	;move.b	(a5),d0
	;and.b	(A1),d0
	;move.b	d0,(a1)
	
	;move.b	(a3),d0
	;or.b	(A1),d0
	;move.b	d0,(A1)
	
	move.b	(a3),(a1)		; on ‚crit l'octet … l'‚cran
	
	add.l	#160,a1			; on pointe une ligne en dessous … l'‚cran
	add.l	#8,a3			; on pointe sur le 3eme bit plan suivant
	;add.l	#8,a5
	ENDR

	move.b	(a0),d7			; on lit la prochaine lettre d‚j… point‚	
	cmp.b	#$FF,d7
	beq	fin_de_texte
	cmp.b	#$FE,d7
	beq	texte_a_la_ligne

	sub.l	#160*16,a1		; on pointe l'‚cran 16 lignes plus haut
	add.l	#1,a1			; sur l'octet suivant
	
	jmp	on_affiche_le_texte
deuxieme_lettre
	move.w	#2,flag_lettre

	add.l	#4,a3
	;add.l	#4,a5
	
	REPT	16
	;move.b	(a5),d0
	;and.b	(A1),d0
	;move.b	d0,(a1)
	
	;move.b	(a3),d0
	;or.b	(A1),d0
	;move.b	d0,(A1)


	move.b	(a3),(a1)
	
	add.l	#160,a1
	add.l	#8,a3
	;add.l	#8,a5	
	ENDR		

	move.b	(a0),d7
	cmp.b	#$FF,d7
	beq	fin_de_texte
	cmp.b	#$FE,d7
	beq	texte_a_la_ligne

	sub.l	#1+4,a1
	sub.l	#160*16,a1
	add.l	#8,a1
	jmp	on_affiche_le_texte

texte_a_la_ligne:
	add.l	#1,a0
	move.l	pointeur_ligne_txt,a1
	add.l	#160*16,a1
	move.l	a1,pointeur_ligne_txt
	move.w	#0,flag_lettre
	jmp	on_affiche_le_texte

fin_de_texte:
	bsr	attendre_une_touche
;	bsr	quitter
	rts
