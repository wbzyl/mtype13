#! /bin/sh
# This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
random=`date +%m%d%H%M%S`
sed s/1234567890/$random/ divination.tex > your-divination.tex
tex your-divination.tex
dvips -u +t3fonts.map your-divination.dvi -o
