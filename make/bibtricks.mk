#bib:
#	make -C commons/bib

%.aux: %.tex
	pdflatex $<

%_references.bib: %.aux
	aux2bib $< > $@

