
all: all.bib all_only_one.bib andrea_nopdfdoi.bib

# andrea=src-andrea/papers/andrea.bib src-andrea/papers/andrea_drafts.bib
andrea=
andrea+=src-andrea/web/regular.bib
andrea+=src-andrea/web/preprints.bib

all.bib: src/*bib  $(andrea)
	cat $^ > all.bib

# all_only_doi.bib: all.bib
# 	bib2bib --remove url --remove pdf -ob  $@ <  $<  > /dev/null

# Remove URL and PDF if DOI is present
remove=--remove pages --remove month
all_only_one.bib:  all.bib 
	cat $^ | bib2bib $(remove) -c "?doi" --remove url --remove pdf > $@
	cat $^ | bib2bib $(remove) -c "!?doi"  >> $@

ieeetrurl.bst: /usr/local/texlive/2010/texmf-dist/bibtex/bst/base/ieeetr.bst
	./urlbst-0.6-4/urlbst --nohyperlinks --hyperref --pubmed --doi  $< > $@


andrea_nopdfdoi.bib: src-andrea/papers/andrea.bib src-andrea/papers/andrea_drafts.bib
	cat $^ | bib2bib $(remove)  --remove url  --remove note --remove doi > $@
