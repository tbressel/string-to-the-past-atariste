; ***********************  MAISON 12 ***********************
conf_maison_12:
; on initialise l'adresse de la piece … afficher
	move.l	adr_frame_buffer,adr_switch_buffer
	move.l	#maison_12+18,adr_piece	
	move.l	#bin_tileset2,adr_tileset
	move.w	#1,flag_presence_porte
	jmp	retour_affiche_porte


; ************************  MAISON 40 ***********************
conf_maison_40:
; on initialise l'adresse de la piece … afficher
	move.l	adr_frame_buffer,adr_switch_buffer
	move.l	#maison_40+18,adr_piece	
	move.l	#bin_tileset2,adr_tileset
	move.w	#0,flag_presence_porte
	jmp	pas_de_porte_a_afficher



