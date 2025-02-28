SHELL := /bin/bash

# Variables
OUTPUT = curriculum_Edoardo_Pedicillo
PAPER = main.tex
NAME_OUT = -jobname=$(OUTPUT)
LATEX = pdflatex $(NAME_OUT) $(PAPER)
BIBTEX = bibtex $(OUTPUT)

# File extensions to clean
LATEX_BYPRODUCTS = *.{log,aux,bbl,bcf,blg,ilg,toc,tdo,fls,fdb_latexmk,lof,lot,idx,ind,snm,out,nav,synctex.gz,bak,xml,dvi,spl}
PDF = $(OUTPUT).pdf

# Targets
.PHONY: all clean clean_latex

all: $(OUTPUT).pdf

$(OUTPUT).pdf: $(PAPER)
	$(LATEX)
	$(BIBTEX)1-blx
	$(BIBTEX)2-blx
	$(LATEX)
	$(LATEX)  # Run LaTeX again to ensure references are resolved

clean:
	@echo "Removing all LaTeX byproducts..."
	@rm -f $(LATEX_BYPRODUCTS)
	@rm -f *blx.bib

cleaa_all: clean_latex
	@echo "Removing generated PDF..."
	@rm -f $(PDF)
