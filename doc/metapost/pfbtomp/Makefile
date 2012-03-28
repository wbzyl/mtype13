#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

mpsources = Makefile logo10.mp logo10.afm README test-logo.tex

font = logo10

$(font).mp: $(font).pfb
	pfbtomp $<

$(font).132 $(font).165 $(font).169 $(font).170 $(font).177 $(font).178 \
$(font).179 $(font).180 $(font).183 $(font).184 $(font).501 : $(font).mp
	mpost $<

test-logo.dvi : test-logo.tex \
$(font).132 $(font).165 $(font).169 $(font).170 $(font).177 $(font).178 \
$(font).179 $(font).180 $(font).183 $(font).184 $(font).501
	tex $*

test-logo.ps : test-logo.dvi
	dvips $< -o

clean : 
	rm -f *~ \#* CON $(font).[1-9][0-9][0-9] *.log $(font).mp* \
$(font).kpx $(font).pfi piclist.tex *.dvi *.ps
