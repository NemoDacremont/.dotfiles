PANDOCFLAGS += --template eisvogel.latex

PHONY += all
all: build

PHONY += build
build: main.pdf

main.pdf: main.md
	pandoc -o $@ $(PANDOCFLAGS) $^

PHONY += setup_document
setup_document: eisvogel.latex main.md

eisvogel.latex: $(HOME)/Templates/eisvogel.latex
	cp $^ $@

PHONY += setup_beamer
setup_beamer: eisvogel.beamer main.md

eisvogel.beamer: $(HOME)/Templates/eisvogel.beamer
	cp $^ $@

main.md:
	[ -f $@ ] || touch $@

PHONY += clean
clean:
	$(RM) main.pdf

.PHONY: $(PHONY)
