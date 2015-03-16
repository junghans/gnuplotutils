PREFIX=/usr
BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/share/man

INSTALL=install

BINS=gplot gp2eps tricktex
MANS=$(addsuffix .1,$(BINS))
all: $(BINS) $(MANS)

%.1: %
	help2man --no-info --output $@ --opt-include=$<.incl ./$< 

.PHONY: all clean install

clean:
	rm -f $(MANS)

install: all
	for i in $(BINS); do \
		$(INSTALL) -m0755 -D $$i $(DESTDIR)/$(BINDIR)/$$i; \
	done
	for i in $(MANS); do \
		$(INSTALL) -m0755 -D $$i $(DESTDIR)/$(MANDIR)/man1/$$i; \
	done
