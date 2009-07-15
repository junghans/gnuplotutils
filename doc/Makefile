all: gp2eps.man

.SUFFIXES: .t2t .man

.t2t.man:
	txt2tags -t man $<

clean:
	rm -f *.man
