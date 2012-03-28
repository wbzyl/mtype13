#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

# Proofs.

.SUFFIXES:
#.SUFFIXES: .mp .mproof .tex .dvi .ps .pdf
.SUFFIXES: .pdf .ps .dvi .tex .mproof .mp

DVIPSFLAGS ?=

mp-extra ?= test.mp

mp-extra-prefix = $(mp-extra:%.mp=%)

mp-extra-mproof = $(mp-extra:%.mp=%.mproof)
mp-extra-log = $(mp-extra:%.mp=%.log)
mp-extra-dvi = $(mp-extra:%.mp=%.dvi)
mp-extra-ps = $(mp-extra:%.mp=%.ps)
mp-extra-pdf = $(mp-extra:%.mp=%.pdf)

mp-extra-prefix = $(mp-extra:%.mp=%)

bar := \|
empty :=
space := $(empty) $(empty)

mp-extra-list = $(subst $(space),$(bar),$(mp-extra-prefix))

mp-extra-nnn = $(shell find . \
 -regex "\./\($(mp-extra-list)\).[0-9]" -or \
 -regex "\./\($(mp-extra-list)\).[1-9][0-9]" -or \
 -regex "\./\($(mp-extra-list)\).[1-9][0-9][0-9]") \
 -regex "\./\($(mp-extra-list)\).[1-9][0-9][0-9][0-9]")

%.mproof : %.mp
	mpost $*
	touch $@

%.dvi : %.mproof
	tex \\input mproof $(mp-extra-nnn)
	mv mproof.dvi $@

%.ps : %.dvi
	dvips $(DVIPSFLAGS) $* -o

%.pdf : %.ps
	ps2pdf $< $@


.PHONY : clean

clean : 
	rm -f core *~ \#* $(mp-extra-log) $(mp-extra-mproof) \
 $(mp-extra-dvi) $(mp-extra-ps) $(mp-extra-pdf) $(mp-extra-nnn) \
 mproof.{tex,log,dvi} *.mpx mpxerr.tex missfont.log sfont.* *-4a4.ps
