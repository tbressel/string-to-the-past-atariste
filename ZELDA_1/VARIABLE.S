; *********************************************************
; ********************  SPRITE DE LINK ********************
; *********************************************************
adr_frame_buffer:
	ds.l	1
adr_frame_buffer2:
	ds.l	1



adr_stack:
	ds.l	1
adr_stack_retour:
	ds.l	1
adr_ecran:
	ds.l	1
adr_switch_buffer:
	ds.l	1
palette_gem:
	ds.w	16
resolution:
	ds.w	1
retour_utilisateur:
	ds.l	1


frame_counter:
	ds.w	1

stock_palette_fade_out:
	ds.w	16	

flag_sequence1:
	ds.w	1


pointeur_triforceG_spr:
	ds.l	1
pointeur_triforceD_spr:
	ds.l	1
pointeur_triforceH_spr:
	ds.l	1
ADR_RAM_TRIFORCE_SPR:
	ds.l	1

pointeur_triforceG_msk:
	ds.l	1
pointeur_triforceD_msk:
	ds.l	1
pointeur_triforceH_msk:
	ds.l	1
ADR_RAM_TRIFORCE_MSK:
	ds.l	1

adr_triforceG_ECRAN:
	ds.l	1
adr_triforceD_ECRAN:
	ds.l	1
adr_triforceH_ECRAN:
	ds.l	1
ADR_ECRAN_TRIFORCE:
	ds.l	1


compteur_anim_triforceG:
	ds.w	1
compteur_anim_triforceD:
	ds.w	1
compteur_anim_triforceH:
	ds.w	1
CMPT_ANIM_TRIFORCE:
	ds.w	1



fond_triforceG:
	ds.b	32*48
fond_triforceD:
	ds.b	32*48
fond_triforceH:
	ds.b	32*48
ADR_FOND_TRIFORCE
	ds.l	1
cmpt:	
	ds.w	1
fond_fee:
	ds.b	16*16



; *************************************************************
; *************************************************************
; *************************************************************
no_menu_fee:
	ds.w	1
compteur_anim_fee:
	ds.w	1
adr_fee_msk:
	ds.l	1
adr_fee_spr:
	ds.l	1
adr_fee_ECRAN:
	ds.l	1
flag_selection:
	ds.w	1
adr_lettre_ECRAN:
	ds.l	1

flag_lettre:
	ds.w	1
pointeur_ligne_txt:
	ds.l	1
vitesse_lettre:
	ds.w	1




tbl_nbr_de_lettre:
	ds.w	1
nbr_de_lettre_j1:
	ds.w	1
nbr_de_lettre_j2:
	ds.w	1
nbr_de_lettre_j3:
	ds.w	1
nbr_de_lettre_j4:
	ds.w	1
nbr_de_lettre_j5:
	ds.w	1

lettre:
	ds.w	1

	
tbl_nom_joueur:
	ds.b	12
nom_du_joueur_j1:
	ds.b	12
nom_du_joueur_j2:
	ds.b	12
nom_du_joueur_j3:
	ds.b	12
nom_du_joueur_j4:
	ds.b	12
nom_du_joueur_j5:
	ds.b	12


pointeur_nom_joueur:
	ds.l	1

pointeur_tbl_nom_joueur:
	ds.l	1

nbr_lettre:
	ds.w	1
flag_saisie:
	ds.w	1


pointeur_epee:
	ds.l	1
adr_epee_ECRAN:
	ds.l	1
adr_epee_RAM:
	ds.l	1	
etape_anim_epee:
	ds.w	1
fond_epee:
	ds.l	6*16*12

wait:
	ds.w	1

etp_eclairs:	
	ds.w	1

adr_eclair_msk:
	ds.l	1
adr_eclair_spr:
	ds.l	1
adr_eclair_ECRAN:
	ds.l	1
choix_eclair:
	ds.w	1

adr_link_msk:
	ds.l	1
adr_link_spr:
	ds.l	1
adr_link_ECRAN:
	ds.l	1

menu_selection:
	ds.w	1	

pointeur_texte:
	ds.l	1
flag_ligne_en_cours:
	ds.w	1


fond_eclair:
	ds.b	8*16