#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

GENERATEDFILES = sfr-test.log sfr-test.dvi sfr-test.ps sfr-test.pdf

MKPROOF1OPT = --translate-file=il2-pl --fmt=mex

# Read in font independent definitions.

make_root = ../../../make
include $(make_root)/type1common.mk

sfr.dvi : sfr.pfb sfr.proof

sfr-test.dvi : sfr.pfb sfr-test.tex

sfr-test.ps : sfr.pfb sfr-test.dvi
	dvips -u +sfr.map sfr-test.dvi -o

sfr-test.pdf : sfr-test.ps
	ps2pdf $<
