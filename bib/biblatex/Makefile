TEXMFLOCAL?=$(shell kpsewhich -var-value TEXMFLOCAL)
dir=$(TEXMFLOCAL)/tex/latex/biblatex-contrib/

install:
	@echo
	@echo Installing in TEXMFLOCAL directory:
	@echo  - TEXMFLOCAL = $(TEXMFLOCAL)
	@echo
	@echo Use  "TEXMFLOCAL=dir  make" to override.
	mkdir -p $(dir)
	rm -f $(dir)/alphabetic-urls-expdoi.bbx
	rm -f $(dir)/numeric-urls-expdoi.bbx
	rm -f $(dir)/numeric-urls.bbx
	ln -s  $(CURDIR)/alphabetic-urls-expdoi.bbx  $(dir)/
	ln -s  $(CURDIR)/numeric-urls-expdoi.bbx  $(dir)/
	ln -s  $(CURDIR)/numeric-urls.bbx $(dir)
	mktexlsr
