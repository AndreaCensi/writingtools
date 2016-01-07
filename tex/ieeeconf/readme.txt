
Install
-------


Copy  to /usr/local/texlive/2015/texmf-dist/tex/latex/IEEEconf/IEEEconf.cls 

Also need to add this *after* everything else in the preamble:

	\let\IEEEproof\proof 

And somewhere:
	
	\IEEEoverridecommandlockouts  % Otherwise \thanks doens't work in IEEEconf


Changes inside ieeeconf.cls  (2015-07)
------------------

This version adds at the end:

	\let\proof\relax
	\let\endproof\relax 

enumitem:

	\let\labelindent\relax


