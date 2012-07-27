
TEXMFLOCAL=`kpsewhich  -var-value TEXMFLOCAL`
dir=$(TEXMFLOCAL)/tex/latex/biblatex-contrib/

install:
	mkdir -p $(dir)
	rm -f $(dir)/numeric-urls-expdoi.bbx
	rm -f $(dir)/numeric-urls.bbx
	ln -s  $(CURDIR)/numeric-urls-expdoi.bbx  $(dir)/
	ln -s  $(CURDIR)/numeric-urls.bbx $(dir)
	mktexlsr   
