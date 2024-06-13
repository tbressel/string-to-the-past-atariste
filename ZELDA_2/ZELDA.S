on_recommence

; **************************************************************
; ************************ On Initialise  **********************
; **************************************************************
; mise … zero de tous les registres
	bsr	init_registres

; passage en mode superviseur	
	bsr	superviseur

; d‚sactivation du clic des touches du clavier
	bsr	keyclic_off

; d‚sactivation de la souris
	bsr	mouse_off

; encodage des ‚l‚ments graphiques
	;bsr	encodage

; initialisation de l'‚cran
	bsr	init_ecran

; initialisation de la palette
	bsr	init_palettes




	jmp on_zap

; **************************************************************
; ******************* On Affiche l'‚cran titre *****************
; **************************************************************
	move.l	#title_screen+2,a3
	bsr	charge_palette
on_affiche_title_screen:
	move.l	#title_screen+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#160*199/4-1,d7
boucle_title_screen
	move.l	(a0)+,(a1)+
	dbf	d7,boucle_title_screen
	bsr	attendre_une_touche



; *************************************************************
; *************************************************************
; *************************************************************
	;bsr	init_registres
	;move.l	#texte_intro,a0		; adresse du texte
	;move.l	adr_frame_buffer,a1	; adresse ecran
	;move.l	a1,pointeur_ligne_txt
	;move.l	#bin_fonte,a2		; adresse de la fonte
	;move.l	a2,a4
	;add.l	#160*16*5,a4		; adresse du mask de la fonte
	;bsr	on_affiche_le_texte




	bsr	init_fade_out
	jmp	boucle_fade_out
retour_boucle_fade_out




; **************************************************************
; ******************* On Affiche l'‚cran selection**************
; **************************************************************
	move.l	#selection_1+2,a3
	bsr	charge_palette
on_affiche_selection1:
	move.l	#selection_1+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#160*199/4-1,d7
boucle_selection1:
	move.l	(a0)+,(a1)+
	dbf	d7,boucle_selection1
	bsr	attendre_une_touche
	
	on_zap:
; **************************************************************
; ****************** Initialisation du jeu  ********************
; **************************************************************
	bsr	init_du_jeu

; **************************************************************
; ******************* BOUCLE PRINCIPALE ************************
; **************************************************************
	jmp	debut_du_programme



; **************************************************************
; **************************************************************
; **************************  SOURCES    ***********************
; **************************************************************
; **************************************************************
	include	sources\init_jeu.s
	include	sources\main.s
	include sources\link.s
	include sources\link_dr.s
	include	sources\link_ga.s
	include	sources\link_bas.s
	include sources\link_hau.s
	include sources\link_sor.s
	include	sources\link_fiA.s
	include	sources\buissons.s
	include sources\link_fiB.s
	include sources\items.s
	include	sources\hud.s			; affichage du HUD
	include sources\decors.s		; affichage d'un ‚cran de tile
	include sources\scrolldb.s		; Double buffering, boucle secondaire
	include sources\scroll.s		; scrolling changement d'‚cran
	include	sources\lieux.s
	include sources\maisons.s
	include	sources\coll_dec.s
	include	sources\textes.s
	include	trap.s
	include	sources\fade.s			; Fonction TOS
	include	parametr.s
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!!   A VIRER !!!!!!!!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	include debug.s
	include encodage.s
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;***********************************************************
;***********************************************************
;******                  SECTION DATA                 ******
;***********************************************************
;***********************************************************
	SECTION DATA

	include	tables\tbl_anim.s
	include	tables\tbl_door.s		; tableau pour les coordonn‚es d'arriv‚ de link lorsque l'on arrive dans certaine piece
	include	textes\txtintro.s
debut_maptile:	
	include maptiles\maptile1.s		; maptiles de la foret
	

; ===============================================================
; ===============================================================
;
; Les fichiers .pi1, une fois encod‚s en m‚moire peuvent etre 
; r‚cup‚r‚s avec le debugger en executant le programme jusqu'…
; la fin de l'encodage des fichiers PI1, puis, avec la touche 'S',
; il est possible de choisir un nom de fichier et une adresse de
; d‚part puis de fin-1  (il est possible de mettre aussi des noms
; de labels.
;
; ================================================================
; ================================================================


; ---------------------------------------------------
bin_tileset:
	incbin	tilesets\foret.til
bin_tileset2:
	incbin	tilesets\maisons.til
bin_sprites_sfx:
	incbin	sprites\sfx.spr
bin_sprites_items1:
	incbin	sprites\items1.spr
bin_sprites_link:
	incbin	sprites\linkDG.spr
bin_sprites_link_suite:
	incbin	sprites\linkHB.spr
bin_palette_maisons:
	incbin	palettes\maisons.pal
bin_palette_foret:
	incbin	palettes\foret.pal
bin_fonte:
	incbin	fontes\fonte.fnt
;***********************************************************
;***********************************************************
;******                  SECTION BSS                  ******
;***********************************************************
;***********************************************************
	SECTION BSS
	include	variable.s		; variables

palette_foret:
	ds.w	16
palette_chateau
	ds.w	16
palette_autre:
	ds.w	16
palette_autre2:
	ds.w	16
adr_sauve_fond_link:
	ds.l	32*24
adr_sauve_fond_item:
	ds.l	32*16
adr_sauve_fond_sfx:
	ds.l	32*43

;espace_ecrans:
;	ds.b	32000+32000+256
;adr_des_deux_ecrans:
adr_frame_buffer:
	ds.l	1
adr_frame_buffer2:
	ds.l	1



