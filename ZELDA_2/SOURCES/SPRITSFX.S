; **********************************************************
; Pour convertir des sprites de 16 octets de large sur 24 ligne de haut
; **********************************************************

convertir_sfx_16x43:
	move.l	a0,pointeur_source	; on sauve l'adresse de d‚part pour le d‚placement en X
	move.l	a0,pointeur_colonne	
	
	move.w	#4-1,d7			; compteur de colonne pour 4 lignes de sprites 
	move.w	#10-1,d6		; compteur de ligne pour 10 sprites par ligne
	move.w	#43-1,d5		; compteur de ligne pour 1 sprites
on_recopie_un_seul_sfx:		
	REPT	4
	move.l	(a0)+,(a1)+		; on recopie 4 x4 octets
	ENDR
	add.l	#160-16,a0		; on passe … la ligne du dessous (longeur d'une ligne moins largeur d'un sprite)
	dbf	d5,on_recopie_un_seul_sfx

; j'ai recopi‚ 1 seul sprite en m‚moire lin‚airement
; mon pointeur source arrive en bas … droite du sprite
; il faut replacer le pointeur en haut … gauche

	move.l	pointeur_source,a0	; on recupere l'adr. de d‚part (en haut … gauche de la tile)
	add.l	#16,a0			; on se d‚cale de 16 octets pour lire le sprite suivant
	move.l	a0,pointeur_source	; et on la sauvegarde le nouvel emplacement du pointeur
	move.w	#43-1,d5		; on reinit le compteur de ligne
	dbf	d6,on_recopie_un_seul_sfx

; on recopie jusqu'… 10 sprites
	move.l	pointeur_source,a0	; on recupŠre l'adr de la colonne pr‚cedante
	add.l	#160*42,a0		; on addition … l'adr. qui pointait sur le depart de la colonne precedant
					; avec la longueur d'une ligne fois la hauteur d'un sprite
	move.l	a0,pointeur_source	; on met la variable … jour	
; on est pret … ecrire une nouvelle ligne de sprite
	move.w	#10-1,d6		; compteur de ligne pour 10 sprites
	move.w	#43-1,d5		; compteur de ligne pour 1 sprite
	dbf	d7,on_recopie_un_seul_sfx
	rts

; on a fini

