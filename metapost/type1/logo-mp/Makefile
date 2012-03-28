#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

FONTS = logobf10 logo8 logo9 logo10 logobs10 logosl10 logoxa30 logoxb10

MKPROOF1OPT = --translate-file=il2-pl --fmt=mex

# Read in font independent definitions.

make_root = ../../../make
include $(make_root)/type1common.mk

logo.ps : logobf10.enc
	mkproof1 logo.mp logo10.mp
