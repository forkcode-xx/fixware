###########################################################
#
# <foo>
#
###########################################################

# You must replace "<foo>" and "$UPC" with the lower case name and
# upper case name of your new package.  Some places below will say
# "Do not change this" - that does not include this global change,
# which must always be done to ensure we have unique names.

#
# $UPC_VERSION, $UPC_SITE and $UPC_SOURCE define
# the upstream location of the source code for the package.
# $UPC_DIR is the directory which is created when the source
# archive is unpacked.
# $UPC_UNZIP is the command used to unzip the source.
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
$UPC_SITE=http://$(SOURCEFORGE_MIRROR)/sourceforge/<foo>
$UPC_VERSION=3.2.1
$UPC_SOURCE=<foo>-$($UPC_VERSION).tar.gz
$UPC_DIR=<foo>-$($UPC_VERSION)
$UPC_UNZIP=zcat
$UPC_MAINTAINER=NSLU2 Linux <nslu2-linux@yahoogroups.com>
$UPC_DESCRIPTION=Describe <foo> here.
$UPC_SECTION=
$UPC_PRIORITY=optional
$UPC_DEPENDS=
$UPC_SUGGESTS=
$UPC_CONFLICTS=

#
# $UPC_IPK_VERSION should be incremented when the ipk changes.
#
$UPC_IPK_VERSION=1

#
# $UPC_CONFFILES should be a list of user-editable files
#$UPC_CONFFILES=/opt/etc/<foo>.conf /opt/etc/init.d/SXX<foo>

#
# $UPC_PATCHES should list any patches, in the the order in
# which they should be applied to the source code.
#
$UPC_PATCHES=$($UPC_SOURCE_DIR)/configure.patch

#
# If the compilation of the package requires additional
# compilation or linking flags, then list them here.
#
$UPC_CPPFLAGS=
$UPC_LDFLAGS=

#
# $UPC_BUILD_DIR is the directory in which the build is done.
# $UPC_SOURCE_DIR is the directory which holds all the
# patches and ipkg control files.
# $UPC_IPK_DIR is the directory in which the ipk is built.
# $UPC_IPK is the name of the resulting ipk files.
#
# You should not change any of these variables.
#
$UPC_BUILD_DIR=$(BUILD_DIR)/<foo>
$UPC_SOURCE_DIR=$(SOURCE_DIR)/<foo>
$UPC_IPK_DIR=$(BUILD_DIR)/<foo>-$($UPC_VERSION)-ipk
$UPC_IPK=$(BUILD_DIR)/<foo>_$($UPC_VERSION)-$($UPC_IPK_VERSION)_$(TARGET_ARCH).ipk

.PHONY: <foo>-source <foo>-unpack <foo> <foo>-stage <foo>-ipk <foo>-clean <foo>-dirclean <foo>-check

#
# This is the dependency on the source code.  If the source is missing,
# then it will be fetched from the site using wget.
#
$(DL_DIR)/$($UPC_SOURCE):
	$(WGET) -P $(@D) $($UPC_SITE)/$(@F) || \
	$(WGET) -P $(@D) $(SOURCES_NLO_SITE)/$(@F)

#
# The source code depends on it existing within the download directory.
# This target will be called by the top level Makefile to download the
# source code's archive (.tar.gz, .bz2, etc.)
#
<foo>-source: $(DL_DIR)/$($UPC_SOURCE) $($UPC_PATCHES)

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
$($UPC_BUILD_DIR)/.configured: $(DL_DIR)/$($UPC_SOURCE) $($UPC_PATCHES) make/<foo>.mk
	$(MAKE) <bar>-stage <baz>-stage
	rm -rf $(BUILD_DIR)/$($UPC_DIR) $(@D)
	$($UPC_UNZIP) $(DL_DIR)/$($UPC_SOURCE) | tar -C $(BUILD_DIR) -xvf -
	if test -n "$($UPC_PATCHES)" ; \
		then cat $($UPC_PATCHES) | \
		patch -d $(BUILD_DIR)/$($UPC_DIR) -p0 ; \
	fi
	if test "$(BUILD_DIR)/$($UPC_DIR)" != "$(@D)" ; \
		then mv $(BUILD_DIR)/$($UPC_DIR) $(@D) ; \
	fi
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		CPPFLAGS="$(STAGING_CPPFLAGS) $($UPC_CPPFLAGS)" \
		LDFLAGS="$(STAGING_LDFLAGS) $($UPC_LDFLAGS)" \
		./configure \
		--build=$(GNU_HOST_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--target=$(GNU_TARGET_NAME) \
		--prefix=/opt \
		--disable-nls \
		--disable-static \
	)
	$(PATCH_LIBTOOL) $(@D)/libtool
	touch $@

<foo>-unpack: $($UPC_BUILD_DIR)/.configured

#
# This builds the actual binary.
#
$($UPC_BUILD_DIR)/.built: $($UPC_BUILD_DIR)/.configured
	rm -f $@
	$(MAKE) -C $(@D)
	touch $@

#
# This is the build convenience target.
#
<foo>: $($UPC_BUILD_DIR)/.built

#
# If you are building a library, then you need to stage it too.
#
$($UPC_BUILD_DIR)/.staged: $($UPC_BUILD_DIR)/.built
	rm -f $@
	$(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) install
	touch $@

<foo>-stage: $($UPC_BUILD_DIR)/.staged

#
# This rule creates a control file for ipkg.  It is no longer
# necessary to create a seperate control file under sources/<foo>
#
$($UPC_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: <foo>" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $($UPC_PRIORITY)" >>$@
	@echo "Section: $($UPC_SECTION)" >>$@
	@echo "Version: $($UPC_VERSION)-$($UPC_IPK_VERSION)" >>$@
	@echo "Maintainer: $($UPC_MAINTAINER)" >>$@
	@echo "Source: $($UPC_SITE)/$($UPC_SOURCE)" >>$@
	@echo "Description: $($UPC_DESCRIPTION)" >>$@
	@echo "Depends: $($UPC_DEPENDS)" >>$@
	@echo "Suggests: $($UPC_SUGGESTS)" >>$@
	@echo "Conflicts: $($UPC_CONFLICTS)" >>$@

#
# This builds the IPK file.
#
# Binaries should be installed into $($UPC_IPK_DIR)/opt/sbin or $($UPC_IPK_DIR)/opt/bin
# (use the location in a well-known Linux distro as a guide for choosing sbin or bin).
# Libraries and include files should be installed into $($UPC_IPK_DIR)/opt/{lib,include}
# Configuration files should be installed in $($UPC_IPK_DIR)/opt/etc/<foo>/...
# Documentation files should be installed in $($UPC_IPK_DIR)/opt/doc/<foo>/...
# Daemon startup scripts should be installed in $($UPC_IPK_DIR)/opt/etc/init.d/S??<foo>
#
# You may need to patch your application to make it use these locations.
#
$($UPC_IPK): $($UPC_BUILD_DIR)/.built
	rm -rf $($UPC_IPK_DIR) $(BUILD_DIR)/<foo>_*_$(TARGET_ARCH).ipk
	$(MAKE) -C $($UPC_BUILD_DIR) DESTDIR=$($UPC_IPK_DIR) install-strip
#	install -d $($UPC_IPK_DIR)/opt/etc/
#	install -m 644 $($UPC_SOURCE_DIR)/<foo>.conf $($UPC_IPK_DIR)/opt/etc/<foo>.conf
#	install -d $($UPC_IPK_DIR)/opt/etc/init.d
#	install -m 755 $($UPC_SOURCE_DIR)/rc.<foo> $($UPC_IPK_DIR)/opt/etc/init.d/SXX<foo>
#	sed -i -e '/^#!/aOPTWARE_TARGET=${OPTWARE_TARGET}' $($UPC_IPK_DIR)/opt/etc/init.d/SXX<foo>
	$(MAKE) $($UPC_IPK_DIR)/CONTROL/control
#	install -m 755 $($UPC_SOURCE_DIR)/postinst $($UPC_IPK_DIR)/CONTROL/postinst
#	sed -i -e '/^#!/aOPTWARE_TARGET=${OPTWARE_TARGET}' $($UPC_IPK_DIR)/CONTROL/postinst
#	install -m 755 $($UPC_SOURCE_DIR)/prerm $($UPC_IPK_DIR)/CONTROL/prerm
#	sed -i -e '/^#!/aOPTWARE_TARGET=${OPTWARE_TARGET}' $($UPC_IPK_DIR)/CONTROL/prerm
#	if test -n "$(UPD-ALT_PREFIX)"; then \
		sed -i -e '/^[ 	]*update-alternatives /s|update-alternatives|$(UPD-ALT_PREFIX)/bin/&|' \
			$($UPC_IPK_DIR)/CONTROL/postinst $($UPC_IPK_DIR)/CONTROL/prerm; \
	fi
	echo $($UPC_CONFFILES) | sed -e 's/ /\n/g' > $($UPC_IPK_DIR)/CONTROL/conffiles
	cd $(BUILD_DIR); $(IPKG_BUILD) $($UPC_IPK_DIR)
	$(WHAT_TO_DO_WITH_IPK_DIR) $($UPC_IPK_DIR)

#
# This is called from the top level makefile to create the IPK file.
#
<foo>-ipk: $($UPC_IPK)

#
# This is called from the top level makefile to clean all of the built files.
#
<foo>-clean:
	rm -f $($UPC_BUILD_DIR)/.built
	-$(MAKE) -C $($UPC_BUILD_DIR) clean

#
# This is called from the top level makefile to clean all dynamically created
# directories.
#
<foo>-dirclean:
	rm -rf $(BUILD_DIR)/$($UPC_DIR) $($UPC_BUILD_DIR) $($UPC_IPK_DIR) $($UPC_IPK)
#
#
# Some sanity check for the package.
#
<foo>-check: $($UPC_IPK)
	perl scripts/optware-check-package.pl --target=$(OPTWARE_TARGET) $^
