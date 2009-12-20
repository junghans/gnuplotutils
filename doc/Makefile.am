dist_man1_MANS =
wiki_pages =

if GPLOT
dist_man1_MANS += gplot.man
wiki_pages += gplot.gwiki
endif

if GP2EPS
dist_man1_MANS += gp2eps.man
wiki_pages += gp2eps.gwiki
endif

#if TRICKTEX
#dist_man1_MANS += tricktex.man
#endif

gwiki: $(wiki_pages)
SUFFIXES: .t2t .man .gwiki

.t2t.man:
	txt2tags -t man --infile $< --outfile $@

.t2t.gwiki:
	txt2tags --no-header -t gwiki --infile $< --outfile $@
