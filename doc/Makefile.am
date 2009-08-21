dist_man1_MANS = 

if GPLOT
dist_man1_MANS += gplot.man
endif

if GP2EPS
dist_man1_MANS += gp2eps.man
endif

#if TRICKTEX
#dist_man1_MANS += tricktex.man
#endif

SUFFIXES: .t2t

.t2t.man:
	txt2tags -t man --infile $< --outfile $@

