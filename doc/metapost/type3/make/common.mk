#
# `common.mk' version 1.13, October 2002
#
# This file belongs to MTYPE3 package by Wlodek Bzyl <matwb@univ.gda.pl>

# Eliminate default suffixes and define our suffix list.

# The purpose of the empty target file `<driver file>.proof'
# is to record, with its last-modification time, when the rule's 
# commands were last executed.

.SUFFIXES:
#.SUFFIXES: .mp .vpl .tfm .map .t3 .t1 .proof .stencil .fonts .tex .dvi .ps .pdf
.SUFFIXES: .pdf .ps .dvi .tex .fonts .stencil .proof .t1 .t3 .map .tfm .vpl .mp

# This value is OK, if there is only one MetaPost font program.
# Otherwise it should be overriden.

FONTS ?= $(strip $(basename .mp $(wildcard *.mp)))

GENERATEDFILES ?=
MKPROOF3OPT ?=
DVIPSFLAGS ?= -Ptype3
TEXFLAGS ?=
MPMODE ?= proof

mapfiles = $(FONTS:%=%.map)

mpfiles = $(strip $(basename .mp $(wildcard *.mp))) # without .mp extension


texfiles = $(mpfiles:%=%.tex)
dvifiles = $(mpfiles:%=%.dvi) 

notFONTS = $(filter-out $(FONTS),$(mpfiles))

mpfonts = $(FONTS:%=%.mp)
t3fonts = $(FONTS:%=%.t3)

proofs = $(FONTS:%=%.proof)
stencils = $(FONTS:%=%.stencil)
done = $(FONTS:%=%.done)
tfmfiles = $(FONTS:%=%.tfm) 
t1files = $(FONTS:%=%.t1)
parfiles = $(FONTS:%=%.par)
pcwfiles = $(FONTS:%=%.pcw)
shfiles = $(mpfiles:%=%.sh)
cntfiles = $(mpfiles:%=%.cnt)
lstfiles = $(mpfiles:%=%.lst)

logfiles = $(mpfiles:%=%.log)
dvifiles = $(mpfiles:%=%.dvi)
psfiles = $(mpfiles:%=%.ps)
a4psfiles = $(mpfiles:%=%-4a4.ps)
pdffiles = $(mpfiles:%=%.pdf)
ljfiles = $(mpfiles:%=%.lj)


bar := \|
empty :=
space := $(empty) $(empty)

fonts = $(subst $(space),$(bar),$(FONTS))

glyphs = $(shell find . \
 -regex "\./\($(fonts)\).[0-9]" -or \
 -regex "\./\($(fonts)\).[1-9][0-9]" -or \
 -regex "\./\($(fonts)\).[1-9][0-9][0-9]")


$(tfmfiles): %.tfm : %.mp
	mpost -mem=type3 $*

$(t1files): %.t1 : %.mp
	mpost -mem=type3 $*

$(mapfiles): %.map : %.mp
	mpost -mem=type3 $*
t3fonts.map : $(mapfiles)
	cat $(mapfiles) > $@


$(t3fonts): %.t3 : %.mp
	mkfont3 $(MKPROOF3OPT) $*
$(proofs): %.proof : %.mp
	mpost -mem=type3 '\mode=$(MPMODE); input $*'
	touch $@
$(stencils): %.stencil : %.mp
	mpost -mem=type3 '\mode=proof; input $*'
	if [ -f $*.sh ] ; then sh $*.sh ; fi
	touch $@

$(texfiles) : %.tex : %.mp
	mft -m $* --style=type3
$(dvifiles) : %.dvi : %.tex
	tex $(TEXFLAGS) $*
%.ps : %.dvi
	dvips $(DVIPSFLAGS) $* -o
%.pdf : %.ps
	ps2pdf13 $< $@
%.tfm : %.vpl
	vptovf $*.vpl


# Put four shrinked A4 pages onto one A4 page.

%-4a4.ps : %.ps
	pstops '4:0@.5(0,14.5cm)+1@.5(10.5cm,14.5cm)+2@.5(0,0)+3@.5(10.5cm,0)' $< $@


.PHONY : clean veryclean vclean

clean : 
	rm -f core *~ \#* $(logfiles) $(dvifiles) $(ljfiles) $(glyphs) \
 $(proofs) $(stencils) $(a4psfiles) $(texfiles) $(parfiles) \
 $(pcwfiles) $(mapfiles) $(mproof).{log,dvi,ps} $(psfiles) $(pdffiles) \
 $(cntfiles) $(lstfiles) \
 $(done) *.mpx mpxerr.tex missfont.log sfont.* *-4a4.ps

veryclean vclean : clean
	rm -f $(t3fonts) $(t1files) $(tfmfiles) $(mapfiles) $(GENERATEDFILES)
