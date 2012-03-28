#
#  This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
#
#  $Date: 2003/11/22 00:04:00 $
#  $Revision: 1.1.1.1 $

include texmf.mk

exec_prefix = /usr/
bindir = $(exec_prefix)/bin

# This package is installed from a working cvs directory.
# Therefore during the install .svn/* files have to be skipped.

bin_progs = $(shell find bin -maxdepth 1 -type f)
doc_dir = $(shell find doc -path '*/.svn' -prune -o -type f -print)
mft_dir = $(shell find mft -path '*/.svn' -prune -o -type f -print)
make_dir = $(shell find make -path '*/.svn' -prune -o -type f -print)
tex_dir = $(shell find tex -path '*/.svn' -prune -o -type f -print)
web2c_dir = $(shell find web2c -path '*/.svn' -prune -o -type f -print)
dvips_dir = $(shell find dvips -path '*/.svn' -prune -o -type f -print)
# exclude Makefiles
metapost_dir = $(shell find metapost \( -path '*/.svn' -o -path '*/make' \) -prune -o -type f ! -name 'Makefile' -print)
mtype13_makefiles = $(shell find metapost -name 'Makefile')
misc_files = INSTALL.linux Makefile mtype13.mk README read-texmf.sh

TEXHASH = mktexlsr
INSTALL = /usr/bin/install -m 644
INSTALL_PROGRAM = /bin/cp --force --preserve --parents
INSTALL_DATA = /bin/cp --force --preserve --parents
MKINSTALLDIRS = /usr/bin/install -m 755 -d

# The standard TeX directory structure is assumed.

bin-install :
	@echo "Installing executable scripts in: $(DESTDIR)$(bindir)"
	$(MKINSTALLDIRS) $(DESTDIR)$(exec_prefix)
	$(INSTALL_PROGRAM) $(bin_progs) $(DESTDIR)$(exec_prefix)

install : bin-install
	@echo "Creating local texmf tree at: $(DESTDIR)$(texmflocal)"
	@$(MKINSTALLDIRS) $(DESTDIR)$(texmflocal)
	@echo "Copying MTYPE13/{dvips,doc,mft,make,metapost,tex,web2c} files to local tree."
	@$(INSTALL_DATA) $(misc_files) $(dvips_dir) $(doc_dir) $(mft_dir) $(make_dir) $(metapost_dir) $(tex_dir) $(web2c_dir) $(DESTDIR)$(texmflocal)
	@echo "Installing Makefiles"
	for file in $(mtype13_makefiles) ; do \
sed -re "s|make_root = .+|make_root = $(DESTDIR)$(texmflocal)/make|" $$file >$(DESTDIR)$(texmflocal)/$$file ; done
	@echo "Copying texmf-local.cnf to $(DESTDIR)$(texmflocal)/web2c/texmf.cnf."
	@$(INSTALL) texmf-local.cnf $(DESTDIR)$(texmflocal)/web2c/texmf.cnf
	$(TEXHASH)
	if test "$(TEXHASH)" != ":" ; then fmtutil --cnffile web2c/mtype13.cnf --all ; fi
# use the fmtutil program; see above
#	$(MAKE) -C web2c -f Makefile.mtype13 type3.mem
#	@$(MKINSTALLDIRS) $(DESTDIR)$(vartexmf)
#	$(INSTALL_DATA) web2c/type3.mem $(DESTDIR)$(vartexmf)
	$(TEXHASH)

uninstall :
	@rm -rf $(DESTDIR)$(package)
	@ $(MAKE) TEXHASH=":" -f mtype13.mk install
	@ - filelist=`find $(DESTDIR) -type f | \
egrep "$(DESTDIR)$(texmflocal)/[a-z]|$(DESTDIR)$(vartexmf)/[a-z]" | \
sed -e "s|$(DESTDIR)||" | \
sort -r` ; \
for file in $$filelist; do rm -f $$file ; done
	@ - dirlist=`find $(DESTDIR) -type d | \
egrep "$(DESTDIR)$(texmflocal)/[a-z]|$(DESTDIR)$(vartexmf)/[a-z]" | \
sed -e "s|$(DESTDIR)||" | \
sort -r` ; \
for dir in $$dirlist; do rmdir $$dir ; done
	@rm -rf $(DESTDIR)$(package)
	mktexlsr
	rm -f $(vartexmf)/type3.{mem,log}
