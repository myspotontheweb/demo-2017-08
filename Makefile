OUTDIR = docs
BINDIR = bin

SRC  = $(wildcard *.adoc)
HTML = $(OUTDIR)/$(SRC:.adoc=.html)

default: html

html: $(HTML)

$(BINDIR)/asciidoctor-reveal.js: 
	mkdir $(BINDIR)
	curl -L https://github.com/asciidoctor/asciidoctor-reveal.js/archive/v1.1.3.tar.gz | tar zx
	mv -f asciidoctor-reveal.js-1.1.3 $@

$(OUTDIR)/reveal.js: 
	mkdir $(OUTDIR)
	curl -L https://github.com/hakimel/reveal.js/archive/3.6.0.tar.gz | tar zx
	mv -f reveal.js-3.6.0 $@

$(OUTDIR)/%.html: %.adoc $(BINDIR)/asciidoctor-reveal.js $(OUTDIR)/reveal.js
	asciidoctor -T $(BINDIR)/asciidoctor-reveal.js/templates -r asciidoctor-diagram -b revealjs $< -o $@

clean:
	rm -f $(OUTDIR)/*.html

clean-all: 
	rm -rf $(OUTDIR)
	rm -rf $(BINDIR)
