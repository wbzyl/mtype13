#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

# Eliminate default suffixes and define our suffix list.


.SUFFIXES:
#.SUFFIXES: .mp .tex .dvi .ps
.SUFFIXES: .ps .dvi .tex .mp

%.tex : %.mp
	mft -m -style=type3 $*
%.dvi : %.tex
	tex $*
%.ps : %.dvi
	dvips $* -o


.PHONY : clean

clean :
	rm -f *~ *.log *.dvi *.ps *.mf *.tex
