#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

# Read in font independent definitions.

make_root = ../../../make
include $(make_root)/type3common.mk

FONTS = iching-000 iching-a00 iching-b00 iching-d00 iching-e00

DVIPSFLAGS = -u +t3fonts.map

GENERATEDFILES = your-divination.{tex,log,dvi,ps} \
 manual-divination.{tex,log,dvi,ps}

iching-000.dvi : iching-000.t3 iching-000.proof

iching-000.done : iching.mp
	mkfont3 -install-font -install-dvips=t3fonts \
            iching-000.mp
	mkfont3 -install-font -install-dvips=t3fonts \
	  -change-name=iching-a00 -change-mode=iching,iching_a iching-000.mp
	mkfont3 -install-font -install-dvips=t3fonts \
	  -change-name=iching-b00 -change-mode=iching,iching_b iching-000.mp
	mkfont3 -install-font -install-dvips=t3fonts \
	  -change-name=iching-d00 -change-mode=iching,iching_d iching-000.mp
	mkfont3 -install-font -install-dvips=t3fonts \
	  -change-name=iching-e00 -change-mode=iching,iching_e iching-000.mp
	touch iching-000.done

fonts : iching-000.done
