BINS=gplot gp2eps tricktex
HTML=$(addsuffix .html,$(BINS))
all: $(HTML)
%.html: %.1
	man2html $< > $@

.PHONY: all clean

clean:
	rm -f $(HTML)
