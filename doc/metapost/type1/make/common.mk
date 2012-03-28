#
# METATYPE 1 PACKAGE              Wlodek Bzyl <matwb@univ.gda.pl>
#

# Eliminate default suffixes and define our suffix list.

# The purpose of the empty target file `<driver file>.proof'
# is to record, with its last-modification time, when the rule's 
# commands were last executed.

.SUFFIXES:
#.SUFFIXES: .mp .vpl .pfb .tfm .map .proof .tex .dvi .ps .pdf
.SUFFIXES: .pdf .ps .dvi .tex .proof .map .tfm .pfb .vpl .mp

# This value is OK, if there is only one MetaPost font program.
# Otherwise it should be overriden.

FONTS ?= $(strip $(basename .mp $(wildcard *.mp)))
DRIVER ?= $(firstword $(FONTS))

mpfiles = $(strip $(basename .mp $(wildcard *.mp))) # without .mp extension
notFONTS = $(filter-out $(FONTS),$(mpfiles))
mpfonts = $(FONTS:%=%.mp)

GENERATEDFILES ?=
MKPROOF1OPT ?=

t1fonts = $(FONTS:%=%.pfb)

mapfiles = $(FONTS:%=%.map)
tfmfiles = $(FONTS:%=%.tfm)
afmfiles = $(FONTS:%=%.afm)
encfiles = $(FONTS:%=%.enc)

pfifiles = $(FONTS:%=%.pfi)
kpxfiles = $(FONTS:%=%.kpx)
pfiles = $(FONTS:%=%.p)
pnfiles = $(FONTS:%=%.pn)
cntfiles = $(FONTS:%=%.cnt)

proofs = $(FONTS:%=%.proof)

texfiles = $(mpfiles:%=%.tex) 
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


%.pfb %.tfm %.map %.enc %.afm: %.mp
	mkfont1 $(MPTOT1FLAGS) $*

%.ps : %.mp
	mkproof1 $(MKPROOF1OPT) $*.mp $(DRIVER).mp
	if [ $(DRIVER).ps != $*.ps ] ; then mv -f $(DRIVER).ps $*.ps ; fi
%.pdf : %.ps
	ps2pdf13 $< $@

%.tfm : %.vpl
	vptovf $*.vpl

# Put four shrinked A4 pages onto one A4 page.

%-4a4.ps : %.ps
	pstops '4:0@.5(0,14.5cm)+1@.5(10.5cm,14.5cm)+2@.5(0,0)+3@.5(10.5cm,0)' $< $@

t1fonts.map : $(mapfiles)
	cat $(mapfiles) > $@

.PHONY : clean veryclean vclean

clean : 
	rm -f core *~ \#* $(glyphs) $(GENERATEDFILES) missfont.log \
 *.mpx mpxerr.tex mproof.log sfont.{log,dvi,ps} piclist.{sh,tex} \
 *-4a4.ps *.[AB].{ps,ljet4} \
 $(pfifiles) $(kpxfiles) $(pfiles) $(pnfiles) $(proofs) $(texfiles) \
 $(logfiles) $(dvifiles) $(psfiles) $(a4psfiles) $(pdffiles) $(ljfiles) \
 $(cntfiles) plain_e_.1[0-9][0-9]

veryclean vclean : clean
	rm -f $(t1fonts) $(mapfiles) $(tfmfiles) $(afmfiles) $(encfiles)

