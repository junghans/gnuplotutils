BINS=gplot gp2eps tricktex
HTML=$(addsuffix .html,$(BINS))
all: $(HTML)
%.html: %.1
	groff -mandoc -Thtml $< > $@

.PHONY: all clean

clean:
	rm -f $(HTML)
