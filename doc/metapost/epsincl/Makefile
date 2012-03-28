#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

mpsources = Makefile testincl.mp testincl.tex testincl0.eps

testincl.100: testincl.mp
	mpost $<

testincl.eps: testincl.100 
	LANG=C epsincl $< > $@

testincl.dvi: testincl.tex testincl.eps
	tex $*

testincl.ps: testincl.dvi
	dvips $< -o

clean : 
	rm -f *~ \#* *.log *.dvi *.ps *.100 testincl.eps
