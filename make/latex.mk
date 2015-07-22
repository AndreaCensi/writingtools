DEPDIR?=.deps
tex_files?=
tex_subdirs?=


.PHONY: texhide

# Main tex files (not lyx)
tex_base=$(subst .tex,, $(tex_files))
tex_targets=$(subst .tex,.pdf, $(tex_files))
tmp_exts:=.fdb_latexmk .toc .fls .loa .lof .lot .unused-labels.txt .unused-fig.txt .unused-def.txt .unused-lem.txt .missing-bib.txt .missing-ref.txt .run.xml -blx.bib .nlo .nls .idx .ind .ilg .d .4ct .4tc .auxlock .aux .idv .atfi .tmp .lg .log .bbl .blg .brf .out .lyx~ .xref .lyx\# .dvi .pyg

#tmp_files:=$(wildcard $(foreach ext,$(tmp_exts),*.$(ext))*)
tmp_files:=$(foreach base, $(tex_base), $(foreach ext,$(tmp_exts), $(base)$(ext)))

tex_targets+=$(addsuffix .missing-ref.txt, $(tex_base))
tex_targets+=$(addsuffix .missing-bib.txt, $(tex_base))
tex_targets+=$(addsuffix .unused-labels.txt, $(tex_base))
tex_targets+=$(addsuffix .unused-def.txt, $(tex_base))
tex_targets+=$(addsuffix .unused-fig.txt, $(tex_base))
tex_targets+=$(addsuffix .unused-lem.txt, $(tex_base))


all:: $(tex_targets)
clean:: texclean



latex_args=-halt-on-error  -interaction=errorstopmode

$(DEPDIR)/%.tex.d: %.tex
	@echo "Creating dependencies file $@"
	@mkdir -p $(DEPDIR)
	@/bin/echo -n "$*.pdf: $*.tex " > $@
	@tex-deps $< >> $@
	@# note >> after
	@/bin/echo -n "$(DEPDIR)/$*.tex.d: $*.tex " >> $@
	@tex-deps $< >> $@

# if not given hypehn it shows alarming message
# http://www.makelinux.net/make3/make3-CHP-2-SECT-7
-include $(addprefix $(DEPDIR)/,$(subst .tex,.tex.d, $(tex_files)))


pdflatex?=pdflatex -shell-escape
#pdflatex=xelatex -shell-escape

%.pdf: %.tex
	latexmk -pdflatex="$(pdflatex)" -pdf $*.tex
	@# $(pdflatex) $(latex_args) $*
	@# - bibtex $*
	@# $(pdflatex) $(latex_args) $*
	@# $(pdflatex) $(latex_args) $*
	@# do not delete aux,blg,bbl for cross-references
	@# Hide temporary files
	@$(MAKE) texhide

%.missing-ref.txt: 
	-cat $*.log | grep 'Latex warning: Reference' > $@

%.missing-bib.txt: 
	-cat $*.log | grep 'Latex warning: Citation' > $@

%.unused-labels.txt: 
	-cat $*.log | grep 'RefCheck' > $@

%.unused-fig.txt:  %.unused-labels.txt
	-cat $< | grep 'fig:' > $@

%.unused-def.txt:  %.unused-labels.txt
	-cat $< | grep 'def:' > $@

%.unused-lem.txt:  %.unused-labels.txt
	-cat $< | grep 'lem:' > $@

texclean-%: 
	@$(MAKE) -C $* texclean
	
texclean:: $(foreach s, $(tex_subdirs), texclean-$s)
	@echo Cleaning LaTeX temporary files in $(CURDIR)
	@-rm -f $(tmp_files)
	
texhide::
	@-chflags hidden $(tmp_files)  2>/dev/null || true
	
