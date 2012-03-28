#
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#

DVIPSFLAGS = -u +plus-000.map

# Read in font independent definitions.

make_root = ../../../make
include $(make_root)/type3common.mk

# Make `plus-000.t3' first.
# The file `plus-000.proof', which records the time when proofs 
# were created, may not be made before `plus-000.t3'.
# This sequence of makes is required to typeset `plus-000.dvi' correctly.

plus-000.dvi : plus-000.t3 plus-000.proof
