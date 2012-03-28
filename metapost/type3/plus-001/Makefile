#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

GENERATEDFILES = plus-y01.ps

DVIPSFLAGS = -u +plus-001.map

# Read in font independent definitions.

make_root = ../../../make
include $(make_root)/type3common.mk

plus-001.dvi : plus-001.t3 plus-001.proof

plus-y01.ps : 
	mft -m plus-001 --style=type3
	mkfont3 --change-mode=yellow,plus_yellow plus-001
	mpost -mem=type3 '\mode=proof; input plus-001'
	tex  plus-001
	dvips -u +plus-001.map plus-001 -o plus-y01.ps
