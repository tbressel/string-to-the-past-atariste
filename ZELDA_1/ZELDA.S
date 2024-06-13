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
; on efface l'‚cran 
	bsr	efface_ecran
; initialisation de la palette
	bsr	init_palettes
	




	;jmp	zap
; ***********************************************************
; ***********  SEQUENCE 0 : FISTENDO  Presente  *************
; ***********************************************************
	bsr	fistendo
; ***********************************************************
; ***************** SEQUENCE 1 : LA TRIFORCE ****************
; ***********************************************************
	bsr	triforce
	jmp	triforce_suite
retour_triforce_suite
	bsr	afficher_logoTRIF
; **************************************************************
; ******************* SEQUENCE 2 : LOGO ZELDA ******************
; **************************************************************	
	move.w	#0,frame_counter
	jmp	boucle_fade_in
retour_boucle_fade_in
; **************************************************************
; ****************** SEQUENCE 3 : L'EPEE  **********************
; **************************************************************
	bsr	epee
; **************************************************************
; ***************** SEQUENCES 4 : L'ECRAN TITRE ****************
; **************************************************************
on_affiche_title_screen:
	move.l	#title_screen+2,a3
	bsr	charge_palette
	move.l	#title_screen+34,a0
	move.l	adr_frame_buffer,a1
	move.w	#160*199/4-1,d7
boucle_title_screen
	move.l	(a0)+,(a1)+
	dbf	d7,boucle_title_screen
	move.w	#3,wait
	bsr	on_change_eclair
	bsr	calcul_eclair
	bsr	on_sauve_fond_eclair
	jmp	boucle_eclairs
retour_boucle_eclairs
	bsr	init_fade_out
	jmp	boucle_fade_out
retour_boucle_fade_out
; **************************************************************
; ***************** SEQUENCE 5 : SELECTION JOUEURS *************
; **************************************************************
zap
	move.w	menu_selection,d7
	cmp.w	#1,d7
	beq	il_etait_une_fois
	move.w	#1,menu_selection
	jmp	menu_joueurs
retour_menu_joueur
	bsr	init_fade_out2
	jmp	boucle_fade_out
; *************************************************************
; ****************** SEQUENCE 6 : SCENARIO ********************
; *************************************************************
il_etait_une_fois
	jmp	scenario
retour_scenario



; **************************************************************
; **************************************************************
; **************************  SOURCES    ***********************
; **************************************************************
; **************************************************************
	include	sources\fistendo.s
	include	sources\triforce.s
	include	sources\bcl_trif.s
	include	sources\textes.s
	include sources\lettres.s
	include	trap.s
	include	sources\fade.s			; Fonction TOS
	include	sources\bcl_fee.s
	include	sources\epee.s
	include	sources\logozeld.s
	include	sources\eclairs.s
	include sources\scenario.s
	include	textes\gemtostx.s
	include	parametr.s
	include	adr_sys.s
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!!   A VIRER !!!!!!!!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	;include 	debug.s
	;include	encodage.s
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;***********************************************************
;***********************************************************
;******                  SECTION DATA                 ******
;***********************************************************
;***********************************************************
	SECTION DATA
bin_palette_title:
	incbin	palettes\title.pal
bin_palette_triforce:
	incbin	palettes\triforce.pal
bin_fonte:
	incbin	fontes\fonte3.fnt
bin_triforce_msk:
	incbin	screen\trif1.msk	; fichier de 6x32000 octets
bin_triforce_spr:
	incbin	screen\trif1.spr	; fichier de 6x32000 octets
bin_fee:
	incbin	screen\fee.spr
title_screen:
	incbin	__TEMP__\PI1\title.pi1
selection_1:
	incbin	__TEMP__\PI1\selec.pi1
FNT:
	incbin	__TEMP__\PI1\fonte2.pi1
logo_msk:
	incbin	__TEMP__\PI1\title2m.pi1
logo_spr:
	incbin	__TEMP__\PI1\title3.pi1
img_scenario:
	incbin	__TEMP__\PI1\scenario.pi1
;***********************************************************
;***********************************************************
;******                  SECTION BSS                  ******
;***********************************************************
;***********************************************************
	SECTION BSS
	include	variable.s		; variables
;Y
;enc_palette_title:
;	ds.w	16
;Z
;espace_ecrans:
;	ds.b	32000+32000+256
;adr_des_deux_ecrans:
