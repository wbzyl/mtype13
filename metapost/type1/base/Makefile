#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

# Read in font independent definitions.

make_root = ../../../make
include $(make_root)/type1common.mk

FONTS =
GENERATEDFILES = plain-ex.cnt type1.cnt

type1.ps : type1.mp
	mkproof1 --skip-type1 --skip-proofs \
                 --fmt=mex --translate-file=il2-pl $*

plain-ex.ps : plain-ex.mp
	mpost plain_e_.mp
	mkproof1 --skip-type1 --skip-proofs \
                 --fmt=mex --translate-file=il2-pl $*
