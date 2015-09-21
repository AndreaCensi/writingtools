sources=$(wildcard old/*.tex)

targets = \
	summary.pdf  \
	all_symbols.tex \
	all_symbols_highlight.tex \
	all_symbols_markfirst.tex 


all: $(targets) 

clean: 
	rm -f $(targets)

summary.pdf: all_symbols.tex tables/full/all.tex tables/mini/all.tex highlight_deprecated.tex

all_symbols.tex: $(sources)
	rm -f $@
	lsm_symbols $^  > $@.tmp
	mv $@.tmp $@ 


all_symbols_markfirst.tex: $(sources)
	rm -f $@
	lsm_symbols --markfirst $^  > $@.tmp
	mv $@.tmp $@ 

all_symbols_highlight.tex: $(sources)
	rm -f $@
	lsm_symbols --color=symbol-highlight $^  > $@.tmp
	mv $@.tmp $@ 

highlight_deprecated.tex: $(sources)
	rm -f $@
	lsm_symbols --select=deprecated --color=red $^  > $@.tmp
	mv $@.tmp $@ 



%.pdf: %.tex
	pdflatex $*
	# bibtex $*
	pdflatex $*
	rm -f $*.aux 
	rm -f $*.log
	rm -f $*.blg
	rm -f $*.bbl
	rm -f $*.out
	rm -f $*.brf


tables/full/all.tex: $(sources)
	rm -f $@
	lsm_table --style full $^ > $@.tmp
	mv $@.tmp $@

tables/mini/all.tex: $(sources)
	rm -f $@
	lsm_table --style minimal $^ > $@.tmp
	mv $@.tmp $@

# tables/full/%.tex: old/%.tex
# 	mkdir -p tables/full
# 	lsm_table --style full $^  > $@

# tables/mini/%.tex: old/%.tex
# 	mkdir -p tables/mini
# 	lsm_table --style minimal $^  > $@

