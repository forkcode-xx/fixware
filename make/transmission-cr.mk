###########################################################
#
# transmission-cr
#
###########################################################

# You must replace "transmission-cr" and "TRANSMISSION-CR" with the lower case name and
# upper case name of your new package.  Some places below will say
# "Do not change this" - that does not include this global change,
# which must always be done to ensure we have unique names.

#
# TRANSMISSION-CR_VERSION, TRANSMISSION-CR_SITE and TRANSMISSION-CR_SOURCE define
# the upstream location of the source code for the package.
# TRANSMISSION-CR_DIR is the directory which is created when the source
# archive is unpacked.
# TRANSMISSION-CR_UNZIP is the command used to unzip the source.
# It is usually "zcat" (for .gz) or "bzcat" (for .bz2)
#
# You should change all these variables to suit your package.
# Please make sure that you add a description, and that you
# list all your packages' dependencies, seperated by commas.
# 
# If you list yourself as MAINTAINER, please give a valid email
# address, and indicate your irc nick if it cannot be easily deduced
# from your name or email address.  If you leave MAINTAINER set to
# "NSLU2 Linux" other developers will feel free to edit.
#
TRANSMISSION-CR_SITE=http://download-origin.transmissionbt.com/files/
TRANSMISSION-CR_VERSION=2.73
TRANSMISSION-CR_SOURCE=transmission-$(TRANSMISSION-CR_VERSION).tar.bz2
TRANSMISSION-CR_DIR=transmission-$(TRANSMISSION-CR_VERSION)
TRANSMISSION-CR_UNZIP=bzcat
TRANSMISSION-CR_MAINTAINER=NSLU2 Linux <nslu2-linux@yahoogroups.com>
TRANSMISSION-CR_SUGGESTS=
TRANSMISSION-CR_CONFLICTS=
TRANSMISSION-CR_DESCRIPTION=Lightweight BitTorrent client and daemon, with web interface bundled.
TRANSMISSION-CR_SECTION=net
TRANSMISSION-CR_PRIORITY=optional
TRANSMISSION-CR_DEPENDS=openssl, libcurl, libevent, zlib

#
# TRANSMISSION-CR_IPK_VERSION should be incremented when the ipk changes.
#
TRANSMISSION-CR_IPK_VERSION=1

#
# TRANSMISSION-CR_CONFFILES should be a list of user-editable files
#TRANSMISSION-CR_CONFFILES=/opt/etc/transmission-cr.conf /opt/etc/init.d/SXXtransmission-cr

#
# TRANSMISSION-CR_PATCHES should list any patches, in the the order in
# which they should be applied to the source code.
#
TRANSMISSION-CR_PATCHES= $(TRANSMISSION-CR_SOURCE_DIR)/libtransmission.patch

#$(TRANSMISSION-CR_SOURCE_DIR)/transmission.h.patch \
#$(TRANSMISSION-CR_SOURCE_DIR)/peer-io.c.patch \
#$(TRANSMISSION-CR_SOURCE_DIR)/rpc-server.c.patch \

#
# If the compilation of the package requires additional
# compilation or linking flags, then list them here.
#
TRANSMISSION-CR_CPPFLAGS=
TRANSMISSION-CR_LDFLAGS=

#
# TRANSMISSION-CR_BUILD_DIR is the directory in which the build is done.
# TRANSMISSION-CR_SOURCE_DIR is the directory which holds all the
# patches and ipkg control files.
# TRANSMISSION-CR_IPK_DIR is the directory in which the ipk is built.
# TRANSMISSION-CR_IPK is the name of the resulting ipk files.
#
# You should not change any of these variables.
#
TRANSMISSION-CR_BUILD_DIR=$(BUILD_DIR)/transmission-cr
TRANSMISSION-CR_SOURCE_DIR=$(SOURCE_DIR)/transmission-cr
TRANSMISSION-CR_IPK_DIR=$(BUILD_DIR)/transmission-cr-$(TRANSMISSION-CR_VERSION)-ipk
TRANSMISSION-CR_IPK=$(BUILD_DIR)/transmission-cr_$(TRANSMISSION-CR_VERSION)-$(TRANSMISSION-CR_IPK_VERSION)_$(TARGET_ARCH).ipk

.PHONY: transmission-cr-source transmission-cr-unpack transmission-cr transmission-cr-stage transmission-cr-ipk transmission-cr-clean transmission-cr-dirclean transmission-cr-check

#
# This is the dependency on the source code.  If the source is missing,
# then it will be fetched from the site using wget.
#
$(DL_DIR)/$(TRANSMISSION-CR_SOURCE):
	$(WGET) -P $(@D) $(TRANSMISSION-CR_SITE)/$(@F) || \
	$(WGET) -P $(@D) $(SOURCES_NLO_SITE)/$(@F)

#
# The source code depends on it existing within the download directory.
# This target will be called by the top level Makefile to download the
# source code's archive (.tar.gz, .bz2, etc.)
#
transmission-cr-source: $(DL_DIR)/$(TRANSMISSION-CR_SOURCE) $(TRANSMISSION-CR_PATCHES)

#
# This target unpacks the source code in the build directory.
# If the source archive is not .tar.gz or .tar.bz2, then you will need
# to change the commands here.  Patches to the source code are also
# applied in this target as required.
#
# This target also configures the build within the build directory.
# Flags such as LDFLAGS and CPPFLAGS should be passed into configure
# and NOT $(MAKE) below.  Passing it to configure causes configure to
# correctly BUILD the Makefile with the right paths, where passing it
# to Make causes it to override the default search paths of the compiler.
#
# If the compilation of the package requires other packages to be staged
# first, then do that first (e.g. "$(MAKE) <bar>-stage <baz>-stage").
#
# If the package uses  GNU libtool, you should invoke $(PATCH_LIBTOOL) as
# shown below to make various patches to it.
#
$(TRANSMISSION-CR_BUILD_DIR)/.configured: $(DL_DIR)/$(TRANSMISSION-CR_SOURCE) $(TRANSMISSION-CR_PATCHES) make/transmission-cr.mk
	$(MAKE) openssl-stage libcurl-stage libevent-stage zlib-stage 
	rm -rf $(BUILD_DIR)/$(TRANSMISSION-CR_DIR) $(@D)
	$(TRANSMISSION-CR_UNZIP) $(DL_DIR)/$(TRANSMISSION-CR_SOURCE) | tar -C $(BUILD_DIR) -xvf -
	if test -n "$(TRANSMISSION-CR_PATCHES)" ; \
		then cat $(TRANSMISSION-CR_PATCHES) | \
		patch -d $(BUILD_DIR)/$(TRANSMISSION-CR_DIR) -p0 ; \
	fi
	if test "$(BUILD_DIR)/$(TRANSMISSION-CR_DIR)" != "$(@D)" ; \
		then mv $(BUILD_DIR)/$(TRANSMISSION-CR_DIR) $(@D) ; \
	fi
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		CPPFLAGS="$(STAGING_CPPFLAGS) $(TRANSMISSION-CR_CPPFLAGS)" \
		LDFLAGS="$(STAGING_LDFLAGS) $(TRANSMISSION-CR_LDFLAGS)" \
		PKG_CONFIG_PATH="$(STAGING_LIB_DIR)/pkgconfig" \
                PKG_CONFIG_LIBDIR="$(STAGING_LIB_DIR)/pkgconfig" \
                $(TRANSMISSION_CONFIG_ENV) \
		./configure \
		--build=$(GNU_HOST_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--target=$(GNU_TARGET_NAME) \
		--prefix=/opt \
		--datadir=/opt/share \
                --disable-gtk \
                --disable-wx \
                --disable-nls \
	)
	$(PATCH_LIBTOOL) $(@D)/libtool
	touch $@

transmission-cr-unpack: $(TRANSMISSION-CR_BUILD_DIR)/.configured

#
# This builds the actual binary.
#
$(TRANSMISSION-CR_BUILD_DIR)/.built: $(TRANSMISSION-CR_BUILD_DIR)/.configured
	rm -f $@
	$(MAKE) -C $(@D)
	touch $@

#
# This is the build convenience target.
#
transmission-cr: $(TRANSMISSION-CR_BUILD_DIR)/.built

#
# If you are building a library, then you need to stage it too.
#
$(TRANSMISSION-CR_BUILD_DIR)/.staged: $(TRANSMISSION-CR_BUILD_DIR)/.built
	rm -f $@
	$(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) install
	touch $@

transmission-cr-stage: $(TRANSMISSION-CR_BUILD_DIR)/.staged

#
# This rule creates a control file for ipkg.  It is no longer
# necessary to create a seperate control file under sources/transmission-cr
#
$(TRANSMISSION-CR_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: transmission-cr" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(TRANSMISSION-CR_PRIORITY)" >>$@
	@echo "Section: $(TRANSMISSION-CR_SECTION)" >>$@
	@echo "Version: $(TRANSMISSION-CR_VERSION)-$(TRANSMISSION-CR_IPK_VERSION)" >>$@
	@echo "Maintainer: $(TRANSMISSION-CR_MAINTAINER)" >>$@
	@echo "Source: $(TRANSMISSION-CR_SITE)/$(TRANSMISSION-CR_SOURCE)" >>$@
	@echo "Description: $(TRANSMISSION-CR_DESCRIPTION)" >>$@
	@echo "Depends: $(TRANSMISSION-CR_DEPENDS)" >>$@
	@echo "Suggests: $(TRANSMISSION-CR_SUGGESTS)" >>$@
	@echo "Conflicts: $(TRANSMISSION-CR_CONFLICTS)" >>$@

#
# This builds the IPK file.
#
# Binaries should be installed into $(TRANSMISSION-CR_IPK_DIR)/opt/sbin or $(TRANSMISSION-CR_IPK_DIR)/opt/bin
# (use the location in a well-known Linux distro as a guide for choosing sbin or bin).
# Libraries and include files should be installed into $(TRANSMISSION-CR_IPK_DIR)/opt/{lib,include}
# Configuration files should be installed in $(TRANSMISSION-CR_IPK_DIR)/opt/etc/transmission-cr/...
# Documentation files should be installed in $(TRANSMISSION-CR_IPK_DIR)/opt/doc/transmission-cr/...
# Daemon startup scripts should be installed in $(TRANSMISSION-CR_IPK_DIR)/opt/etc/init.d/S??transmission-cr
#
# You may need to patch your application to make it use these locations.
#
$(TRANSMISSION-CR_IPK): $(TRANSMISSION-CR_BUILD_DIR)/.built
	rm -rf $(TRANSMISSION-CR_IPK_DIR) $(BUILD_DIR)/transmission-cr_*_$(TARGET_ARCH).ipk
	$(MAKE) -C $(TRANSMISSION-CR_BUILD_DIR) DESTDIR=$(TRANSMISSION-CR_IPK_DIR) install-strip
#	install -d $(TRANSMISSION-CR_IPK_DIR)/opt/etc/
#	install -m 644 $(TRANSMISSION-CR_SOURCE_DIR)/transmission-cr.conf $(TRANSMISSION-CR_IPK_DIR)/opt/etc/transmission-cr.conf
#	install -d $(TRANSMISSION-CR_IPK_DIR)/opt/etc/init.d
#	install -m 755 $(TRANSMISSION-CR_SOURCE_DIR)/rc.transmission-cr $(TRANSMISSION-CR_IPK_DIR)/opt/etc/init.d/SXXtransmission-cr
#	sed -i -e '/^#!/aOPTWARE_TARGET=${OPTWARE_TARGET}' $(TRANSMISSION-CR_IPK_DIR)/opt/etc/init.d/SXXtransmission-cr
	$(MAKE) $(TRANSMISSION-CR_IPK_DIR)/CONTROL/control
#	install -m 755 $(TRANSMISSION-CR_SOURCE_DIR)/postinst $(TRANSMISSION-CR_IPK_DIR)/CONTROL/postinst
#	sed -i -e '/^#!/aOPTWARE_TARGET=${OPTWARE_TARGET}' $(TRANSMISSION-CR_IPK_DIR)/CONTROL/postinst
#	install -m 755 $(TRANSMISSION-CR_SOURCE_DIR)/prerm $(TRANSMISSION-CR_IPK_DIR)/CONTROL/prerm
#	sed -i -e '/^#!/aOPTWARE_TARGET=${OPTWARE_TARGET}' $(TRANSMISSION-CR_IPK_DIR)/CONTROL/prerm
#	if test -n "$(UPD-ALT_PREFIX)"; then \
		sed -i -e '/^[ 	]*update-alternatives /s|update-alternatives|$(UPD-ALT_PREFIX)/bin/&|' \
			$(TRANSMISSION-CR_IPK_DIR)/CONTROL/postinst $(TRANSMISSION-CR_IPK_DIR)/CONTROL/prerm; \
	fi
	echo $(TRANSMISSION-CR_CONFFILES) | sed -e 's/ /\n/g' > $(TRANSMISSION-CR_IPK_DIR)/CONTROL/conffiles
	cd $(BUILD_DIR); $(IPKG_BUILD) $(TRANSMISSION-CR_IPK_DIR)
	$(WHAT_TO_DO_WITH_IPK_DIR) $(TRANSMISSION-CR_IPK_DIR)

#
# This is called from the top level makefile to create the IPK file.
#
transmission-cr-ipk: $(TRANSMISSION-CR_IPK)

#
# This is called from the top level makefile to clean all of the built files.
#
transmission-cr-clean:
	rm -f $(TRANSMISSION-CR_BUILD_DIR)/.built
	-$(MAKE) -C $(TRANSMISSION-CR_BUILD_DIR) clean

#
# This is called from the top level makefile to clean all dynamically created
# directories.
#
transmission-cr-dirclean:
	rm -rf $(BUILD_DIR)/$(TRANSMISSION-CR_DIR) $(TRANSMISSION-CR_BUILD_DIR) $(TRANSMISSION-CR_IPK_DIR) $(TRANSMISSION-CR_IPK)
#
#
# Some sanity check for the package.
#
transmission-cr-check: $(TRANSMISSION-CR_IPK)
	perl scripts/optware-check-package.pl --target=$(OPTWARE_TARGET) $^
