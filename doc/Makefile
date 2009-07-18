all: gp2eps.man gplot.man

.SUFFIXES: .t2t .man

.t2t.man:
	txt2tags -t man $<

clean:
	rm -f *.man
