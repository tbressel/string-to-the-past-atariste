; **************************************************************
; ************ On affiche les premiers ‚l‚ments  ***************
; **************************************************************
init_du_jeu:
	
; initialisation de la palette
	bsr	init_palettes
; -------------------------------------------------
; ----      on  affiche le HUD … droite        ----
; -------------------------------------------------
	bsr	affichage_hud		; bah on affiche le hud
	bsr	adresse_ecran		; on r‚cupŠre l'adresse du frame buffer

; -------------------------------------------------
; ----      on  affiche le premier ‚cran       ----
; -------------------------------------------------
; on initialise l'adresse de la piece … afficher
	move.l	#bin_tileset,adr_tileset
	move.l	#foret_01+18,adr_piece	
	move.l	#adr_piece-18,a0
	move.w	a0,no_piece
	bsr	ecran_de_tiles
; -------------------------------------------------
; ----   on  affiche dans le deuxiŠme ‚cran    ----
; -------------------------------------------------	
	bsr	ecran_no_1		; appel du TOS
	move.b	#1,flag_ecran		; on est dans l'‚cran 1
	move.l	adr_frame_buffer2,A0	; on ‚crit dans l'‚cran 2
	move.l	a0,adr_switch_buffer
	bsr	recopie_ecran		; on recopie en encran 2

; -------------------------------------------------
; -----------     on initialise link     ----------
; -------------------------------------------------
	bsr	init_link
	move.w	#tile_murs_foret,no_tile_murs
	rts
