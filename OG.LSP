(defun c:og()
	(setq stupod (getvar "aunits"))
	(setvar "aunits" 0)
	(setq stupre (getvar "auprec"))
	(setvar "auprec" 4)

	(if (not razm)
		(setq razm (/ (getreal "\nUnesite imenilac razmere: ") 1000.0))
	)
	(if (not razmak)
		(setq razmak (* razm (getreal "\nUnesite razmak: ")))
	)
	(setq iblok (getstring "\nIme simbola: "))
	(setq es (entsel "\nPokazite liniju: "))
	(setq en (car es))
	(redraw en 3)
	(setq ed (entget en))
	(setq poc (cdr(assoc 10 ed)))
	(setq kraj (cdr(assoc 11 ed)))
	(setq ang (angle poc kraj))
	(setq p1 (getpoint "\nPokazite stranu: "))
	(setq ang1 (+ ang (* pi 0.5)))
	(setq p2 (polar p1 ang1 0.1))
	(setq pres (inters poc kraj p1 p2 nil))
	(setq ang1 (angle pres p1))
	(if (> ang pi)
		(setq ug (- ang pi))
		(setq ug ang)
	)
	(setq ug1 (+ ug (* pi 0.5)))
	(if (> ug1 (* 2 pi))(setq ug1 (- ug1 (* 2 pi))))
	(setq ug2 (- ug (* pi 0.5)))
	(if (< ug2 0)(setq ug2 (+ ug2 (* 2 pi))))
	(cond
		((equal ang1 ug1 0.000101)(setq rot ug))
		((equal ang1 ug2 0.000101)(setq rot (+ ug pi)))
	)
	(setq ang2 (angtos rot 0 8))
	(setq duz (distance poc kraj))
	(setq l razmak)
	(if (< duz (* 2 razmak))
		(progn
			(setq pt (polar poc ang (/ duz 2.0)))
			(command "insert" iblok pt razm razm ang2)
		)
		(progn
			(while (< l duz)
				(setq pt (polar poc ang l))
				(command "insert" iblok pt razm razm ang2)
                                (setq l (+ l razmak))
			)
		)
	)
	(setvar "aunits" stupod)
	(setvar "auprec" stupre)
	(princ)
)
