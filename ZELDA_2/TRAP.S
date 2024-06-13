;------------- ATTENDRE QU'UNE TOUCHE SOIT PRESSEE  ------------
attendre_une_touche:
	move.w	#1,-(sp)	; fonction 1: Cconin
	trap	#1		; GEMDOS : resultat dans D0 : scancode/ASCII
	add.w	#2,sp
	rts

;-------------          QUITTER LE PROGRAMME        ------------
quitter:
	move.w  #0,-(sp)	; fonction 0 : Pterm0
	trap	#1		; GEMDOS
	
;-------------    PASSER EN MOYENNE RESOLUTION    ------------
changer_resolution:
	move.w	resolution,-(sp)	; moyenne r‚solution
	move.l	#-1,-(sp)		; adr. ‚cran psysique
	move.l  #-1,-(sp)		; adr. ‚cran logique
	move.w	#5,-(sp)		; fonction 5 : Setscreen
	trap 	#14	
	add.w	#12,sp
	rts
;------------- RECUPERER ADRESSE DE L'ECRAN LOGIQUE ------------
adresse_ecran:
	move.w	#3,-(sp)		; fonction 3 : Logbase
	trap	#14			; XBIOS (adr. r‚cup‚r‚e dans D0)
	add.w	#2,sp
	move.l	d0,adr_ecran		; on sauve dans adr_ecran
	move.l	d0,adr_frame_buffer
	rts

;------------- ON STOCK LA PALETTE GEMDOS ----------------
sauve_palette:
	move.w	#0,d2			; no de la couleur dans d4
boucle_palette:	
	move.w	#-1,-(sp)		; on change pas de couleur
	move.w	d2,-(sp)		; couleur no 0
	move.w	#7,-(sp)		; fontion 7 : Setcolor
	trap	#14			; XBIOS. On r‚cupŠre la valeur de la couleur dans D0
	move.w	d0,d1			; on stock la valeur dans D2
	add.w	#6,sp		
	move.w	d1,(a3)+		; on envoie la valeur d'une couleur
					; … l'adresse du tableau
	add.w	#1,d2
	cmp.w	#16,d2			; on compare #16 et D4
	blt	boucle_palette
	rts

;------------    RESTAURER LA PALETTE GEMDOS -----------
charge_palette:
	move.l	A3,-(sp)		; adresse de la pallette
	move.w	#6,-(sp)		; fonction 6 : Setpalette
	trap	#14			; XBIOS
	add.w	#6,sp	
	rts
;-------------	MODE SUPERVISEUR -----------------
superviseur:
	move.l	retour_utilisateur,D0
	move.l	d0,-(sp)
	move.w	#32,-(sp)
	trap	#1
	add.w	#6,sp
	move.l	d0,retour_utilisateur
	rts	

;-------------- CLICK DU CLAVIER ET DING ------------
keyclic_on:
	move.b	#%0111,$484
	rts
keyclic_off:
	move.b	#%0110,$484
	rts

;---------------- GESTION DE LA SOURIS ----------------
; on r‚ active la souris
mouse_on:
	dc.w	$A009				; Line A command to make mouse appearing
	move.b	#$8,$FFFFFC02.w			; Mouse movement enable
	rts


; on empeche la souris de bouger:
mouse_off:
	dc.w	$A00A				; Line A command to make mouse disappearing
	move.b	#$12,$fffffc02.w		; Mouse movement disabled
	rts










; ---------------- ECRAN 1 ------------------
ecran_no_1:
	move.w	#-1,-(sp)			; moyenne r‚solution
	move.l	adr_frame_buffer,-(sp)		; adr. ‚cran psysique
	move.l  #-1,-(sp)			; adr. ‚cran logique
	move.w	#5,-(sp)			; fonction 5 : Setscreen
	trap 	#14	
	add.w	#12,sp
	rts


; ---------------- ECRAN 2 ------------------
ecran_no_2:
	move.w	#-1,-(sp)			; moyenne r‚solution
	move.l	adr_frame_buffer2,-(sp)		; adr. ‚cran psysique
	move.l  #-1,-(sp)			; adr. ‚cran logique
	move.w	#5,-(sp)			; fonction 5 : Setscreen
	trap 	#14	
	add.w	#12,sp
	rts



; ---------------- ECRAN 4 ------------------
ecran_no_4:
	;move.w	#-1,-(sp)			; moyenne r‚solution
	;move.l	#img_tileset+34,-(sp)		; adr. ‚cran psysique
	;move.l  #-1,-(sp)			; adr. ‚cran logique
	;move.w	#5,-(sp)			; fonction 5 : Setscreen
	;trap 	#14	
	;add.w	#12,sp
	rts

; ---------------- ECRAN 4b ------------------
ecran_no_4b:
	;move.w	#-1,-(sp)			; moyenne r‚solution
	;move.l	#img_tileset+34+32000,-(sp)		; adr. ‚cran psysique
	;move.l  #-1,-(sp)			; adr. ‚cran logique
	;move.w	#5,-(sp)			; fonction 5 : Setscreen
	;trap 	#14	
	;add.w	#12,sp
	rts

; ---------------- ECRAN 5 ------------------
ecran_no_5:
	move.w	#-1,-(sp)			; moyenne r‚solution
	move.l	#bin_tileset,-(sp)		; adr. ‚cran psysique
	move.l  #-1,-(sp)			; adr. ‚cran logique
	move.w	#5,-(sp)			; fonction 5 : Setscreen
	trap 	#14	
	add.w	#12,sp
	rts



init_ecran:
; -------------------------------------------------
; ----  on r‚cupŠre l'adresse du frame buffer  ----
; -------------------------------------------------
	bsr	adresse_ecran		; appel du TOS
	move.l	adr_frame_buffer,d0	; on recupŠre l'adr actuelle de l'‚cran
	move.l	d0,adr_switch_buffer	; adr_switch_buffer est le pointeur ecran changeant quand on switch d'ecran
	sub.l	#32000+160+160+160,d0		; le deuxiŠme ecran est 32000 octets plus bas
	move.l	d0,adr_frame_buffer2	
	;move.l	sp,a0
	;move.l	a0,adr_stack_retour
	;sub.l	#160*20,d0
	;move.l	d0,a1
	;move.l	a1,a7
	


	;move.l	#espace_ecrans,d0
	;move.b	#0,d0
	;add.l	#256,d0
	;move.l	d0,adr_frame_buffer
	;add.l	#32000,d0
	;move.l	d0,adr_frame_buffer2
; -------------------------------------------------
; ----      on passe en basse r‚solution       ----
; -------------------------------------------------
	move.w	#0,resolution
	bsr	changer_resolution	
	rts

init_palettes:
; ----------------------------------------------------------------
; ---- on sauve la palette du GEM / charge celle du programme ----
; ----------------------------------------------------------------
	move.l	#palette_gem,a3		; adr. RAM de la palette dans A3	
	bsr	sauve_palette		
	move.l	#bin_palette_foret,A3	;adr. de la palette
	bsr	charge_palette		;on charge la palette en RAM	
	rts