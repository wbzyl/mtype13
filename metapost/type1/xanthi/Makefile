#
#  This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#
#  $Revision: 1.2 $
#  $Date: 2004/08/23 09:40:34 $


# We can compile all glyphs or part of them

FONTS = xanthi xanthi-wbzyl

MKPROOF1OPT = --skip-type1 --style=type1 --style=xanthi
#MKPROOF1OPT = --skip-type1 --style=type1 --style=xanthi --translate-file=il2-pl --fmt=mex 

#MKFONT1OPT = --skip-subroutine
no_proofs = --skip-proofs $(MKPROOF1OPT)


# Metatype1 font independent definitions

make_root = ../../../make
include $(make_root)/type1common.mk

# Xanthi

data_files = xanthi.mp xanthi-param.mp \
 xanthi-pfi.mp xanthi-enc.mp xanthi-metric.mp

remove-overlap: xanthi.pfb
	remove-overlap.pe $<

xanthi.pfb : $(data_files) $(mpfonts)

xanthi.ps : xanthi.mp
	mkproof1 $(no_proofs) $<

xanthi-wbzyl.ps : $(data_files) xanthi-wbzyl.mp

xanthi-param.ps : xanthi-param.mp
	mkproof1 $(no_proofs) $*

xanthi-pfi.ps : xanthi-pfi.mp
	mkproof1 $(no_proofs) $*

xanthi-metric.ps : xanthi-metric.mp
	mkproof1 $(no_proofs) $*

xanthi-driver.ps : # texmf/metapost/xanthi-driver.mp
	mkproof1 $(no_proofs) $*

xanthi-base.ps : # texmf/metapost/xanthi-base.mp
	mkproof1 $(no_proofs) $*


# Cleaning and testing

GENERATEDFILES = test-xanthi.{log,dvi,ps} \
xanthi-fmt.{tex,log,dvi,ps,cnt} \
xanthi-base.{tex,log,dvi,ps,cnt} \
enctex.{log,fmt} test-trans.{log,dvi,ps,eps} \
xanthi.{pfb,tfm} Xanthi-Regular.{afm,enc,tfm,pfb}

test-xanthi.dvi : test-xanthi.tex xanthi.pfb

test-xanthi.ps : test-xanthi.dvi
	dvips -u +xanthi.map $*

enctex.fmt : enctex.ini
	tex -enc -ini $<

test-trans.eps : test-trans.dvi
	dvips -E -u +xanthi.map test-trans.dvi -o test-trans.eps

test-trans.ps : test-trans.dvi
	dvips -u +xanthi.map test-trans.dvi -o test-trans.ps
