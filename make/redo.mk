# Just the code to redo one file with everything (thesis)

# TODO: check main defined

redo-index:
	makeindex $(main)
	makeindex $(main).nlo -s nomencl.ist -o $(main).nls

redo-recompile:
	$(MAKE) -W $(main).tex $(main).pdf
	
redo:
	$(MAKE) clean
	$(MAKE) indices
	$(MAKE) -C commons/bib
	$(MAKE) -C commons/tex
	# first create .tex
	$(MAKE) -B $(main).tex 
	# then used-symbols.yaml
	$(MAKE) -C tex  -B
	-pdflatex $(main)
	$(MAKE) pysnip
	bibtex $(main)
	$(MAKE) redo-index
	-pdflatex $(main)
	-pdflatex $(main)
	$(MAKE) -B $(main).missing-bib.txt
	$(MAKE) -B $(main).missing-ref.txt
	

redo-nomenc:
	$(MAKE) -C tex  -B
	-pdflatex $(main)
	$(MAKE) redo-index
	-pdflatex $(main)

redo-snippets:
	-pdflatex $(main)
	$(MAKE) -B pysnip
	-pdflatex $(main)
