TEXMFLOCAL?=$(shell kpsewhich -var-value TEXMFLOCAL)
dir=$(TEXMFLOCAL)/tex/latex/
file=IEEEconf.cls

install:
	@echo
	@echo Installing in TEXMFLOCAL directory:
	@echo  - TEXMFLOCAL = $(TEXMFLOCAL)
	@echo
	@echo Use  "TEXMFLOCAL=dir  make" to override.
	mkdir -p $(dir)
	rm -f $(dir)/$(file)
	ln -s  $(CURDIR)/$(file)  $(dir)/
	mktexlsr
