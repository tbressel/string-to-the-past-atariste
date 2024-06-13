; ************************************************************
; ********************* COLLISION LINK ***********************
; ************************************************************
collision_link_gauche:
	bsr	init_registres
; registre D0 pour le calcule de Y
	move.w	link_posY,d0		; on recupŠre la corrdon‚es Y de Link
	add.w	#hauteur_link-4,d0	; on pointe ses pieds

; registre D1 pour le calcule de X	
	move.w	link_posX,d1
	jmp	collisions

collision_link_droite:
	bsr	init_registres
; registre D0 pour le calcule de Y
	move.w	link_posY,d0		; on recupŠre la corrdon‚es Y de Link
	add.w	#hauteur_link-4,d0		
	
; registre D1 pour le calcule de X	
	move.w	link_posX,d1
	
	jmp	collisions



collision_link_bas:
	bsr	init_registres
; registre D0 pour le calcule de Y
	move.w	link_posY,d0		; on recupŠre la corrdon‚es Y de Link
	add.w	#hauteur_link-4,d0	; on pointe ses pieds

; registre D1 pour le calcule de X	
	move.w	link_posX,d1
	jmp	collisions

collision_link_haut:
	bsr	init_registres
; registre D0 pour le calcule de Y
	move.w	link_posY,d0		; on recupŠre la corrdon‚es Y de Link
	add.w	#hauteur_link-12,d0		
	
; registre D1 pour le calcule de X	
	move.w	link_posX,d1
	jmp	collisions


; ************************************************************
; *************** CALCULE DES COLLISIONS DECORS **************
; ************************************************************
collisions:
; d‚terminer la ligne de la maptile
	divu.w	#nbr_lignes_par_tile,d0		; hauteur d'une tuile
						; link_posY / hauteur tuile
						; d0 donne la ligne de la maptile
	move.w	d0,collision_Y
; d‚terminer la colonne de la maptile
	divu.w	#nbr_lignes_par_tile,d1			; 
	move.w	d1,collision_X
; d‚terminer l'adresse de la tile dans la maptile
	move.l	adr_piece,a0
	mulu.w	#15*2,d0		; 30 octets pour une ligne de maptile
	mulu.w	#2,d1			; 2 octets pour une nbr "d1" de tiles sur la ligne d0
	add.l	d0,d1			; on additionne
	add.l	d1,a0			; avec l'adresse du d‚but de la maptile
	move.l	a0,adr_tile_collision
	move.w	(a0),d0			; on recupŠre le numero de tile
	move.w	d0,no_tile
	rts
