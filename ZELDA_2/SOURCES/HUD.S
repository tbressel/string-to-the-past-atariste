; **************************************************************
; ********************* Affichage du HUD ***********************
; **************************************************************
affichage_hud:
	moveq.l	#0,d1		; remise … z‚ro des registres
	move.l	d1,a0
	move.l	d1,d0
	move.l	d1,d2
	move.l	d1,d3
	move.l	#img_hud+34,a5		; adr. de l'image dans A5
	move.l	adr_frame_buffer,a6		; adr. destination dans A6
	move.b	#191,d1		; nbr. de ligne de haut dans D1
	

	; calcule de l'adr du d‚but de la ligne posY
	move.w	#0,d2			; no de la ligne dans D2
	mulu.w	#160,d2			; 160octets * la ligne	
	add.l	d2,a6			; adr. ecran + 160 fois la longeur d'une ligne
					; on obtient l'adr du d‚but de la ligne posY
	
	move.w	#240,d2		; no du pixel X
	divu.w	#2,d2		; on obtient le nbr. d'octet depuis le d‚but de la ligne
	add.l	d2,a6		; que l'on addition avec l'adresse de la ligne
	move.l	a6,adr_frame_buffer		

on_affiche_une_ligne:
	REPT	10
	move.l	(a5)+,(a6)+			; on recopie 4 octets … l'‚cran
	ENDR

	;add.l	#120,a5			; on ajoute aux registre A5 et A6 la
	add.l	#120,a6			; longueur d'une ligne moins la largeur du sprite en octets
	dbf	d1,on_affiche_une_ligne		; fois la hauteur du sprite (ligne)
	rts

;**********************************
