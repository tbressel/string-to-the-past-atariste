encodage:

	;bsr	encodage_triforce
	bsr	encodage_fonte
	;bsr	encodage_fee


convertir:
	move.l	a0,ENCpointeur_source	; on sauve l'adresse de d‚part pour le d‚placement en X
	move.l	a0,ENCpointeur_colonne	
	move.w	ENCnbr_ligne_tile,d7		; compteur de colonne pour 36 ligne de tiles 
	move.w	ENCnbr_colonne_tile,d6		; compteur de ligne pour 20 tiles
	move.w	ENChauteur_tile,d5		; compteur de ligne pour 1 tile
	move.w	ENClargeur_tile,d4
	sub.w	#1,d7
	sub.w	#1,d6
	sub.w	#1,d5
on_recopie_une_seule_tile:		
	cmp.w	#8,d4
	beq	recopie_8_octets
	cmp.w	#16,d4
	beq	recopie_16_octets
	cmp.w	#32,d4
	beq	recopie_32_octets
retour_recopie_octets	
	move.w	#160,d3
	sub.w	d4,d3
	add.l	d3,a0		; on passe … la ligne du dessous (longeur d'une ligne moins largeur d'une tile)
	dbf	d5,on_recopie_une_seule_tile

; j'ai recopi‚ 1 seule tiles en m‚moire lin‚airement
; mon pointeur source arrive en bas … droite de la tile
; il faut replacer le pointeur en haut … gauche

	move.l	ENCpointeur_source,a0	; on recupere l'adr. de d‚part (en haut … gauche de la tile)
	add.l	d4,a0			; on se d‚cale de 8 octets pour lire la tile suivante
	move.l	a0,ENCpointeur_source	; et on la sauvegarde le nouvel emplacement du pointeur
	move.w	ENChauteur_tile,d5		; on reinit le compteur de ligne
	sub.w	#1,d5	
	dbf	d6,on_recopie_une_seule_tile

; on recopie jusqu'… 20 tiles
	move.l	ENCpointeur_source,a0			; on recupŠre l'adr de la colonne pr‚cedante
	move.w	ENChauteur_tile,d5
	sub.w	#1,d5
	mulu.w	#160,d5
	add.l	d5,a0				; on addition … l'adr. qui pointait sur le depart de la colonne precedant
						; avec la longueur d'une ligne fois la hauteur d'une tile
	move.l	a0,ENCpointeur_source		; on met la variable … jour	
; on est pret … ecrire une nouvelle ligne de tile.
	move.w	ENCnbr_colonne_tile,d6		; compteur de ligne pour 20 tiles
	move.w	ENChauteur_tile,d5		; compteur de ligne pour 1 tile	
	sub.w	#1,d6
	sub.w	#1,d5
	dbf	d7,on_recopie_une_seule_tile
	rts



; on a fini

recopie_8_octets:
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	jmp	retour_recopie_octets
recopie_16_octets:
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	jmp	retour_recopie_octets
recopie_32_octets:
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	move.l	(a0)+,(a1)+		; on recopie 4 octets
	move.l	(a0)+,(a1)+		; et encore 4 octets
	jmp	retour_recopie_octets
pointeur_source:
	ds.l	1
pointeur_colonne:
	ds.l	1

ENCpointeur_source:
	ds.l	1
ENCpointeur_colonne:
	ds.l	1
ENChauteur_tile:
	ds.w	1
ENCnbr_colonne_tile:
	ds.w	1
ENCnbr_ligne_tile:
	ds.w	1
ENClargeur_tile:
	ds.w	1


; ****************************************************************
; ****************************************************************

; ***********************************************************
; *************************************************************
; ***************************************************************
; *************************************************************
; ***********************************************************
	;include	encodage\triforce.s
	include	encodage\fontes.s
	;include	encodage\fee.s






