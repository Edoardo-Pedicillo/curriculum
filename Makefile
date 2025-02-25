SHELL := /bin/bash
output = main.pdf
paper = main.tex

bibfile = references.bib

figures = $(wildcard figures/*.pdf)

LC = pdflatex
FPFLAGS = "-shell-escape"
LPFLAGS = "-shell-escape"
BC = bibtex
arxivtar = paper.tar


.PHONY: all clean clean_latex arxiv pdf

all: $(output)

arxiv: $(arxivtar)

pdf: $(output)

%.pdf : %.tex $(bibfile) $(figures) | %.bbl
	@$(LC) $(FPFLAGS) $< > /dev/null
	@$(LC) $(LPFLAGS) $<


%.bbl : %.aux $(bibfile)
	@echo "Generating bibliography"
	@echo $<
	@$(BC) $<

%.aux : %.tex
	@echo "First pass"
	@$(LC) $(FPFLAGS) $< > /dev/null

%.tar: %.tex %.bbl
	@echo "Creating arxiv tar"
	tar -cf $@ $^ figures

clean_latex:
	@echo "Removing all latex byproducts"
	@rm -f *.{log,aux,bbl,bcf,blg,ilg,toc,tdo,fls,fdb_latexmk,lof,lot,idx,ind,snm,out,nav,synctex.gz,bak,xml,dvi,spl}

clean: clean_latex
	@echo "Removing latex pdf and arxiv tar"
	@rm -f $(output) $(arxivtar)
