BINS=gplot gp2eps tricktex
HTML=$(addsuffix .html,$(BINS))
all: $(HTML)
%.html: %.1
	groff -mandoc -Thtml $< | sed '/^<!-- Creat/d' > $@

.PHONY: all clean

clean:
	rm -f $(HTML)
