; ***********************************************************
; ***********************************************************
; ************************* PARAMETRES **********************
; ***********************************************************
; ***********************************************************


; ***********************************************************
; ************************  AFFICHAGE  **********************
; ***********************************************************
nbr_lignes_par_tile	equ	16	

largeur_hud		equ	5*8	; nbr_tiles x octets d'une tile
largeur_hud_bis		equ	6*8	; utilis‚ pour le calcule avec d‚cr‚mentation



; ----- Scrolling VERTICAL quand on change de piŠce
nbr_rangees_tiles		equ	11	; nbr de rang‚es que l'on d‚place (et non au total)
; ----- Scrolling HORIZONTAL quand on change de piŠce
nbr_colonnes_tiles		equ	14	; nbr de colonnes de l'on d‚place (et non au total)

; ***********************************************************
; *************************** LINK  *************************
; ***********************************************************

hauteur_link	equ	24		; 24 lignes de haut
largeur_link	equ	16		; 16 octets de large	

droite		equ	1		; Link va … droite
droite_sort	equ	$1B		; Link sort de l'‚cran … droite
droite_entre	equ	$1B		; Link revient par la gauche 

gauche		equ	2		; Link va … gauche
gauche_sort	equ	$2B		; Link sort de l'‚cran … gauche	
gauche_entre	equ	$2B		; Link revient par la droite

bas		equ	3		; Link va en bas
bas_sort	equ	$3B		; Link sort de l'‚cran en bas
bas_entre	equ	$3B		; Link revient par le haut

haut		equ	4		; Link va en haut
haut_sort	equ	$4B		; Link sort de l'‚cran en haut
haut_entre	equ	$4B		; Link revient par le bas

fireA		equ	$2A


vitesse_gauche		equ	1	; mis … 0 les mouvement sont bloqu‚s
vitesse_droite		equ	1	; mis … 1 = vitesse maximum
vitesse_haut		equ	1	; mis … 2 = d‚placement toute les 2 frames
vitesse_bas		equ	1
vitesse_choppe_item	equ	10
vitesse_buisson_boom	equ	5

; ***********************************************************
; *************************** ITEMS *************************
; ***********************************************************

hauteur_item	equ	16
largeur_item	equ	16




; **************************************************************
; ************* TILES DE COLLISIONS AVEC LE DECORS *************
; **************************************************************

; ********* Tileset de la foret ********
tile_murs_foret			equ	120
tile_porte_tronc_haut		equ	83
tile_porte_tronc_bas		equ	241	
tile_porte_maison		equ	270
tile_porte_maison_ouverte	equ	28
tile_porte_maison_bas		equ	131
tile_buisson			equ	395
tile_buisson_coupe		equ	4



; ********* Tileset des maisons ********
tile_murs_maison		equ	60


logoEPEE_X	equ	15
logoEPEE_Y	equ	10
logoEPEE_l	equ	3
logoEPEE_h	equ	5

logoTRIF_X	equ	14
logoTRIF_Y	equ	0
logoTRIF_l	equ	6
logoTRIF_h	equ	6

logoZELDA_X	equ	2
logoZELDA_Y	equ	2
logoZELDA_l	equ	10
logoZELDA_h	equ	5