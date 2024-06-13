	;dc.w	<no_piece>,<PosY_arrivee1_haut>,<PosY_arrivee2_haut>,<PosY_arrivee1_bas>,<PosY_arrivee2_bas>,<PosX_arrivee1_gauche>,<PosX_arrivee2_gauche>,<PosX_arrivee1_droite>,<PosX_arrivee2_droite>

resultat_scroll_piece_en_cours:
PosY_arrivee1_haut:
	ds.w	1

PosY_arrivee2_haut:
	ds.w	1

PosY_arrivee1_bas:
	ds.w	1

PosY_arrivee2_bas:
	ds.w	1

PosX_arrivee1_gauche:
	ds.w	1

PosX_arrivee2_gauche:
	ds.w	1

PosX_arrivee1_droite:
	ds.w	1

PosX_arrivee2_droite:
	ds.w	1



tbl_scroll_piece
	dc.w	002,$0C,000,000,000,000,000,000,000
	dc.w	003,$18,000,000,000,000,000,000,000
	dc.w	007,$0C,000,000,000,000,000,000,000
	dc.w	008,000,000,$3C,000,000,000,000,000
	dc.w	009,$24,000,$3C,000,000,000,000,000
	dc.w	010,$24,000,000,000,000,000,000,000
	dc.w	013,000,000,$3C,000,000,000,000,000
	dc.w	014,$6C,000,000,000,000,000,000,000
	dc.w	015,000,000,$48,000,000,000,000,000
	dc.w	016,000,000,$48,000,000,000,000,000
	dc.w	020,000,000,$9C,000,000,000,000,000

	dc.w	000,000,000,000,000,000,000,000,000
