#
# TYPE 3 FONTS REPOSITORIUM        Wlodek Bzyl <matwb@univ.gda.pl>
#

# Eliminate default suffixes and define our suffix list.

.SUFFIXES:
.SUFFIXES: .png .eps

# Character names consists from letters only

png = $(shell find . -type f -iregex '^./[a-z]+\.png')
glyphs = $(basename $(png))

%.eps : %.png
	pngtopnm $^ | pnmcrop | pnmtops -rle > $@

.PHONY : crop clean eps

crop :
	@for x in $(glyphs); do \
            pngtopnm $$x.png | pnmcrop | pnmtopng > $$x.cropped ; \
         done
	@for x in $(glyphs); do mv $$x.cropped $$x.png ; done

eps :
	@for x in $(glyphs); do \
            pngtopnm $$x.png | pnmtops -noturn -rle > $$x.eps ; \
         done

clean :
	rm -f *~ \#* *.eps
