
# Attaches .bib in the file
%_extra.pdf: %.pdf %_references.bib
	pdftk $< attach_files $^ output $@


# Only pages
# 
# pdftk A=$lyx_produced cat A1-8   output $final_paper
# pdftk A=$lyx_produced cat A9-end output $final_proofs
# 


