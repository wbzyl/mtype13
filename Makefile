#
#  This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#
#  $Date: 2003/11/22 00:03:59 $
#  $Revision: 1.1.1.1 $

version=1.21
package=mtype13-$(version)

.PHONY : all install uninstall help clean no_texmf_mk no_kpsewhich_bin

export DESTDIR =

texmf_mk := $(shell ls -1 texmf.mk 2>/dev/null)
ifneq "texmf.mk" "$(texmf_mk)"
no_texmf_mk :
	@echo "! There is no \`texmf.mk' file in" $(shell pwd)
	@echo "! Please run the \`read-texmf.sh' script first."
	@exit 1
endif

kpsewhich_bin := \
$(shell which --skip-alias --skip-dot --skip-tilde kpsewhich 2>/dev/null)
ifeq "$(kpsewhich_bin)" ""
no_kpsewhich_bin :
	@echo "! There is no \`kpsewhich' on the system."
	@echo "! Please install the \`tetex-3.0' package."
	@exit 1
endif

install : no_texmf_mk no_kpsewhich_bin
	$(MAKE) -f mtype13.mk install

uninstall :
	@./read-texmf.sh quiet
	@ echo "Removing \`$(package)' package."
	$(MAKE) DESTDIR="/tmp/$(package)" TEXHASH=":" -f mtype13.mk uninstall

clean :
	rm -f *~ \#* texmf-local.cnf texmf.mk ls-R
