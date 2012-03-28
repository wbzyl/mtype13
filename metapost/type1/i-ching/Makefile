#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

FONTS = ichingr ichings

GENERATEDFILES = your-divination.{tex,log,dvi,ps}

make_root = ../../../make
include $(make_root)/type1common.mk

ichingr.ps : iching.mp ichingr.mp
	mkproof1 -u +t1fonts.map $^

ichings.ps : iching.mp ichings.mp
	mkproof1 -u +t1fonts.map $*

fonts :
	mkfont1 --install-font -tree-prefix=texmf ichingr.mp
	mkfont1 --install-font -tree-prefix=texmf ichings.mp
