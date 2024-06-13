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
	moveq	#%10,d0
	move.w	resolution,d0
	move.b	d0,$FFFF8260
	rts
;------------- RECUPERER ADRESSE DE L'ECRAN LOGIQUE ------------
adresse_ecran:
	move.l	$44e,adr_frame_buffer
	move.l	$44e,adr_ecran		; on sauve dans adr_ecran
	rts

;------------- ON STOCK LA PALETTE ----------------
sauve_palette:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	$ffff8240,d0-d7
	movem.l	d0-d7,(a3)
	movem.l	(sp)+,d0-d7/a0-a6
	rts

;------------    RESTAURER LA PALETTE -----------
charge_palette:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a3),d0-d7
	movem.l	d0-d7,$ffff8240
	movem.l	(sp)+,d0-d7/a0-a6
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

;--------------- EFFACE ECRAN ENCRE ZERO -----------------
efface_ecran
	move.l	adr_frame_buffer,a1
	move.w	#160*200/4,d7
bcl_zero:
	move.l	#0,(a1)+
	dbf	d7,bcl_zero
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
;	move.w	#-1,-(sp)			; moyenne r‚solution
;	move.l	#bin_tileset,-(sp)		; adr. ‚cran psysique
;	move.l  #-1,-(sp)			; adr. ‚cran logique
;	move.w	#5,-(sp)			; fonction 5 : Setscreen
;	trap 	#14	
;	add.w	#12,sp
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
	move.l	#bin_palette_title,A3		;adr. de la palette
	bsr	charge_palette		;on charge la palette en RAM	
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


