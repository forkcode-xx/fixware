###########################################################
#
# php
#
###########################################################

#
# PHP54_VERSION, PHP54_SITE and PHP54_SOURCE define
# the upstream location of the source code for the package.
# PHP54_DIR is the directory which is created when the source
# archive is unpacked.
# PHP54_UNZIP is the command used to unzip the source.
# It is usually "zcat" (for .gz) or "bzcat" (for .bz2)
#
PHP54_SITE=http://cn2.php.net/distributions/
PHP54_VERSION=5.4.13
PHP54_SOURCE=php-$(PHP54_VERSION).tar.bz2
PHP54_DIR=php-$(PHP54_VERSION)
PHP54_UNZIP=bzcat
PHP54_MAINTAINER=Josh Parsons <jbparsons@ucdavis.edu>
PHP54_DESCRIPTION=The php scripting language
PHP54_SECTION=net
PHP54_PRIORITY=optional
PHP54_DEPENDS=bzip2, openssl, zlib, libxml2, libxslt, gdbm, libdb, pcre
ifeq (openldap, $(filter openldap, $(PACKAGES)))
PHP54_DEPENDS+=, cyrus-sasl-libs, openldap-libs
endif

#
# PHP54_IPK_VERSION should be incremented when the ipk changes.
#
PHP54_IPK_VERSION=2

#
# PHP54_CONFFILES should be a list of user-editable files
#
PHP54_CONFFILES=/opt/etc/php.ini

#
# PHP54_LOCALES defines which locales get installed
#
PHP54_LOCALES=

#
# PHP54_CONFFILES should be a list of user-editable files
#PHP54_CONFFILES=/opt/etc/php.conf /opt/etc/init.d/SXXphp

#
# PHP54_PATCHES should list any patches, in the the order in
# which they should be applied to the source code.
#
PHP54_PATCHES=\
         $(PHP_SOURCE_DIR)/configure.in.patch \
         $(PHP_SOURCE_DIR)/threads.m4.patch \
#
# If the compilation of the package requires additional
# compilation or linking flags, then list them here.
#
PHP54_CPPFLAGS=-I$(STAGING_INCLUDE_DIR)/libxml2 -I$(STAGING_INCLUDE_DIR)/libxslt -I$(STAGING_INCLUDE_DIR)/libexslt 
PHP54_LDFLAGS=-L$(STAGING_LIB_DIR)/mysql -Wl,-rpath=/opt/lib/mysql -ldl -lpthread

#
# PHP54_BUILD_DIR is the directory in which the build is done.
# PHP54_SOURCE_DIR is the directory which holds all the
# patches and ipkg control files.
# PHP54_IPK_DIR is the directory in which the ipk is built.
# PHP54_IPK is the name of the resulting ipk files.
#
# You should not change any of these variables.
#
PHP54_BUILD_DIR=$(BUILD_DIR)/php54
PHP54_SOURCE_DIR=$(SOURCE_DIR)/php54
PHP54_IPK_DIR=$(BUILD_DIR)/php54-$(PHP54_VERSION)-ipk
PHP54_IPK=$(BUILD_DIR)/php_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_DEV_IPK_DIR=$(BUILD_DIR)/php54-dev-$(PHP54_VERSION)-ipk
PHP54_DEV_IPK=$(BUILD_DIR)/php54-dev_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_EMBED_IPK_DIR=$(BUILD_DIR)/php54-embed-$(PHP54_VERSION)-ipk
PHP54_EMBED_IPK=$(BUILD_DIR)/php54-embed_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_CURL_IPK_DIR=$(BUILD_DIR)/php54-curl-$(PHP54_VERSION)-ipk
PHP54_CURL_IPK=$(BUILD_DIR)/php54-curl_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_GD_IPK_DIR=$(BUILD_DIR)/php54-gd-$(PHP54_VERSION)-ipk
PHP54_GD_IPK=$(BUILD_DIR)/php54-gd_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_ICONV_IPK_DIR=$(BUILD_DIR)/php54-iconv-$(PHP54_VERSION)-ipk
PHP54_ICONV_IPK=$(BUILD_DIR)/php54-iconv_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_IMAP_IPK_DIR=$(BUILD_DIR)/php54-imap-$(PHP54_VERSION)-ipk
PHP54_IMAP_IPK=$(BUILD_DIR)/php54-imap_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_LDAP_IPK_DIR=$(BUILD_DIR)/php54-ldap-$(PHP54_VERSION)-ipk
PHP54_LDAP_IPK=$(BUILD_DIR)/php54-ldap_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_MBSTRING_IPK_DIR=$(BUILD_DIR)/php54-mbstring-$(PHP54_VERSION)-ipk
PHP54_MBSTRING_IPK=$(BUILD_DIR)/php54-mbstring_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_MSSQL_IPK_DIR=$(BUILD_DIR)/php54-mssql-$(PHP54_VERSION)-ipk
PHP54_MSSQL_IPK=$(BUILD_DIR)/php54-mssql_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_MYSQL_IPK_DIR=$(BUILD_DIR)/php54-mysql-$(PHP54_VERSION)-ipk
PHP54_MYSQL_IPK=$(BUILD_DIR)/php54-mysql_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_PGSQL_IPK_DIR=$(BUILD_DIR)/php54-pgsql-$(PHP54_VERSION)-ipk
PHP54_PGSQL_IPK=$(BUILD_DIR)/php54-pgsql_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_ODBC_IPK_DIR=$(BUILD_DIR)/php54-odbc-$(PHP54_VERSION)-ipk
PHP54_ODBC_IPK=$(BUILD_DIR)/php54-odbc_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_PEAR_IPK_DIR=$(BUILD_DIR)/php54-pear-$(PHP54_VERSION)-ipk
PHP54_PEAR_IPK=$(BUILD_DIR)/php54-pear_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_XMLRPC_IPK_DIR=$(BUILD_DIR)/php54-xmlrpc-$(PHP54_VERSION)-ipk
PHP54_XMLRPC_IPK=$(BUILD_DIR)/php54-xmlrpc_$(PHP54_VERSION)-$(PHP54_IPK_VERSION)_$(TARGET_ARCH).ipk

PHP54_CONFIGURE_ARGS=--enable-maintainer-zts
PHP54_CONFIGURE_ENV=
PHP54_TARGET_IPKS = \
	$(PHP54_IPK) \
	$(PHP54_DEV_IPK) \
	$(PHP54_EMBED_IPK) \
	$(PHP54_CURL_IPK) \
	$(PHP54_GD_IPK) \
	$(PHP54_IMAP_IPK) \
	$(PHP54_MBSTRING_IPK) \
	$(PHP54_MSSQL_IPK) \
	$(PHP54_MYSQL_IPK) \
	$(PHP54_ODBC_IPK) \
	$(PHP54_PGSQL_IPK) \
	$(PHP54_PEAR_IPK) \
	$(PHP54_XMLRPC_IPK) \

# We need this because openldap does not build on the wl500g.
ifeq (openldap, $(filter openldap, $(PACKAGES)))
PHP54_CONFIGURE_ARGS += \
		--with-ldap=shared,$(STAGING_PREFIX) \
		--with-ldap-sasl=$(STAGING_PREFIX)
PHP54_CONFIGURE_ENV += LIBS=-lsasl2
PHP54_TARGET_IPKS += $(PHP54_LDAP_IPK)
endif

ifeq (glibc, $(LIBC_STYLE))
PHP54_CONFIGURE_ARGS +=--with-iconv=shared
else
  ifeq (libiconv, $(filter libiconv, $(PACKAGES)))
PHP54_CONFIGURE_ARGS +=--with-iconv=shared,$(STAGING_PREFIX)
  else
PHP54_CONFIGURE_ARGS +=--without-iconv
  endif
endif

ifeq (, $(filter --without-iconv, $(PHP54_CONFIGURE_ARGS)))
PHP54_TARGET_IPKS += $(PHP54_ICONV_IPK)
endif

.PHONY: php54-source php54-unpack php php54-stage php54-ipk php54-clean php54-dirclean php54-check

#
# Automatically create a ipkg control file
#
$(PHP54_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: $(PHP54_DESCRIPTION)" >>$@
	@echo "Depends: $(PHP54_DEPENDS)" >>$@

$(PHP54_DEV_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-dev" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: php native development environment" >>$@
	@echo "Depends: php" >>$@

$(PHP54_EMBED_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-embed" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: php embedded library - the embed SAPI" >>$@
	@echo "Depends: php" >>$@

$(PHP54_CURL_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-curl" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: libcurl extension for php" >>$@
	@echo "Depends: php, libcurl" >>$@

$(PHP54_GD_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-gd" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: libgd extension for php" >>$@
	@echo "Depends: php, libgd" >>$@

$(PHP54_ICONV_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-iconv" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: libiconv extension for php" >>$@
ifeq (libiconv,$(filter libiconv, $(PACKAGES)))
	@echo "Depends: php, libiconv" >>$@
else
	@echo "Depends: php" >>$@
endif

$(PHP54_IMAP_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-imap" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: imap extension for php" >>$@
	@echo "Depends: php, imap-libs" >>$@

$(PHP54_LDAP_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-ldap" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: ldap extension for php" >>$@
	@echo "Depends: php, openldap-libs" >>$@

$(PHP54_MBSTRING_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-mbstring" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: mbstring extension for php" >>$@
	@echo "Depends: php" >>$@

$(PHP54_MYSQL_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-mysql" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: mysql extension for php" >>$@
	@echo "Depends: php, mysql" >>$@

$(PHP54_PEAR_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-pear" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: PHP Extension and Application Repository" >>$@
	@echo "Depends: php" >>$@

$(PHP54_PGSQL_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-pgsql" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: pgsql extension for php" >>$@
	@echo "Depends: php, postgresql" >>$@

$(PHP54_MSSQL_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-mssql" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: mssql extension for php" >>$@
	@echo "Depends: php, freetds" >>$@

$(PHP54_ODBC_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-odbc" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: odbc extension for php" >>$@
	@echo "Depends: php, unixodbc" >>$@

$(PHP54_XMLRPC_IPK_DIR)/CONTROL/control:
	@install -d $(@D)
	@rm -f $@
	@echo "Package: php54-xmlrpc" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PHP54_PRIORITY)" >>$@
	@echo "Section: $(PHP54_SECTION)" >>$@
	@echo "Version: $(PHP54_VERSION)-$(PHP54_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PHP54_MAINTAINER)" >>$@
	@echo "Source: $(PHP54_SITE)/$(PHP54_SOURCE)" >>$@
	@echo "Description: xmlrpc extension for php" >>$@
ifeq (libiconv,$(filter libiconv, $(PACKAGES)))
	@echo "Depends: php, libiconv" >>$@
else
	@echo "Depends: php" >>$@
endif

#
# This is the dependency on the source code.  If the source is missing,
# then it will be fetched from the site using wget.
#
$(DL_DIR)/$(PHP54_SOURCE):
	$(WGET) -P $(@D) $(PHP54_SITE)/$(@F) || \
	$(WGET) -P $(@D) $(SOURCES_NLO_SITE)/$(@F)

#
# The source code depends on it existing within the download directory.
# This target will be called by the top level Makefile to download the
# source code's archive (.tar.gz, .bz2, etc.)
#
php54-source: $(DL_DIR)/$(PHP54_SOURCE) $(PHP54_PATCHES)

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
$(PHP54_BUILD_DIR)/.configured: $(DL_DIR)/$(PHP54_SOURCE) $(PHP54_PATCHES) make/php54.mk
	$(MAKE) bzip2-stage 
	$(MAKE) gdbm-stage 
	$(MAKE) libcurl-stage
	$(MAKE) libdb-stage
	$(MAKE) libgd-stage 
ifeq (libiconv, $(filter libiconv, $(PACKAGES)))
	$(MAKE) libiconv-stage
endif
	$(MAKE) libxml2-stage 
	$(MAKE) libxslt-stage 
	$(MAKE) openssl-stage 
	$(MAKE) mysql-stage
	$(MAKE) postgresql-stage
	$(MAKE) freetds-stage
	$(MAKE) unixodbc-stage
	$(MAKE) imap-stage
	$(MAKE) libpng-stage
	$(MAKE) libjpeg-stage
	$(MAKE) pcre-stage
ifeq (openldap, $(filter openldap, $(PACKAGES)))
	$(MAKE) openldap-stage
	$(MAKE) cyrus-sasl-stage
endif
	rm -rf $(BUILD_DIR)/$(PHP54_DIR) $(@D)
	$(PHP54_UNZIP) $(DL_DIR)/$(PHP54_SOURCE) | tar -C $(BUILD_DIR) -xvf -
	mv $(BUILD_DIR)/$(PHP54_DIR) $(@D)
	rm -rf $(@D)/aclocal.m4
	autoreconf $(@D)
	if test -n "$(PHP54_PATCHES)"; \
	    then cat $(PHP54_PATCHES) | patch -p0 -bd $(@D); \
	fi
ifneq ($(HOSTCC), $(TARGET_CC))
	sed -i \
	    -e 's|`$$PG_CONFIG --includedir`|$(STAGING_INCLUDE_DIR)|' \
	    -e 's|`$$PG_CONFIG --libdir`|$(STAGING_LIB_DIR)|' \
	    $(@D)/ext/*pgsql/*.m4
endif
ifeq (glibc, $(LIBC_STYLE))
	sed -i -e 's|/usr/local /usr|$(shell cd $(TARGET_INCDIR)/..; pwd)|' $(@D)/ext/iconv/config.m4
endif
	autoreconf -vif $(@D)
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		CPPFLAGS="$(STAGING_CPPFLAGS) $(PHP54_CPPFLAGS)" \
		LDFLAGS="$(STAGING_LDFLAGS) $(PHP54_LDFLAGS)" \
		CFLAGS="$(STAGING_CPPFLAGS) $(PHP54_CPPFLAGS) $(STAGING_LDFLAGS) $(PHP54_LDFLAGS)" \
		PATH="$(STAGING_DIR)/bin:$$PATH" \
		PHP54_LIBXML_DIR=$(STAGING_PREFIX) \
		EXTENSION_DIR=/opt/lib/php/extensions \
		ac_cv_func_memcmp_working=yes \
		cv_php_mbstring_stdarg=yes \
		STAGING_PREFIX="$(STAGING_PREFIX)" \
		$(PHP54_CONFIGURE_ENV) \
		./configure \
		--build=$(GNU_HOST_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--target=$(GNU_TARGET_NAME) \
		--prefix=/opt \
		--with-config-file-scan-dir=/opt/etc/php.d \
		--with-layout=GNU \
		--disable-static \
		--disable-phar \
		--enable-bcmath=shared \
		--enable-calendar=shared \
		--enable-dba=shared \
		--enable-embed=shared \
		--enable-exif=shared \
		--enable-ftp=shared \
		--enable-mbstring=shared \
		--enable-pdo=shared \
		--enable-shmop=shared \
		--enable-sockets=shared \
		--enable-sysvmsg=shared \
		--enable-sysvshm=shared \
		--enable-sysvsem=shared \
		--enable-xml=shared \
		--enable-xmlreader=shared \
		--with-bz2=shared,$(STAGING_PREFIX) \
		--with-curl=shared,$(STAGING_PREFIX) \
		--with-db4=$(STAGING_PREFIX) \
		--with-dom=shared,$(STAGING_PREFIX) \
		--with-gdbm=$(STAGING_PREFIX) \
		--with-gd=shared,$(STAGING_PREFIX) \
		--with-imap=shared,$(STAGING_PREFIX) \
		--with-mysql=shared,$(STAGING_PREFIX) \
		--with-mysql-sock=/tmp/mysql.sock \
		--with-mysqli=shared,$(STAGING_PREFIX)/bin/mysql_config \
		--with-pgsql=shared,$(STAGING_PREFIX) \
		--with-mssql=shared,$(STAGING_PREFIX) \
		--with-unixODBC=shared,$(STAGING_PREFIX) \
		--with-openssl=shared,$(STAGING_PREFIX) \
		--with-pdo-mysql=shared,$(STAGING_PREFIX) \
		--with-pdo-pgsql=shared,$(STAGING_PREFIX) \
		--with-pdo-sqlite=shared \
		--with-xsl=shared,$(STAGING_PREFIX) \
		--with-zlib=shared,$(STAGING_PREFIX) \
		--with-libxml-dir=$(STAGING_PREFIX) \
		--with-jpeg-dir=$(STAGING_PREFIX) \
		--with-png-dir=$(STAGING_PREFIX) \
		--with-freetype-dir=$(STAGING_PREFIX) \
		--with-zlib-dir=$(STAGING_PREFIX) \
		--with-pcre-regex=$(STAGING_PREFIX) \
		$(PHP54_CONFIGURE_ARGS) \
		--without-pear \
		--with-xmlrpc=shared \
	)
	$(PATCH_LIBTOOL) $(@D)/libtool
	touch $@

php54-unpack: $(PHP54_BUILD_DIR)/.configured

#
# This builds the actual binary.  You should change the target to refer
# directly to the main binary which is built.
#
$(PHP54_BUILD_DIR)/.built: $(PHP54_BUILD_DIR)/.configured
	rm -f $@
	$(MAKE) -C $(@D)
	touch $@

#
# You should change the dependency to refer directly to the main binary
# which is built.
#
php: $(PHP54_BUILD_DIR)/.built

#
# If you are building a library, then you need to stage it too.
#
$(PHP54_BUILD_DIR)/.staged: $(PHP54_BUILD_DIR)/.built
	rm -f $@
	$(MAKE) -C $(@D) INSTALL_ROOT=$(STAGING_DIR) program_prefix="" install
	cp $(STAGING_PREFIX)/bin/php54-config $(STAGING_DIR)/bin/php54-config
	cp $(STAGING_PREFIX)/bin/phpize $(STAGING_DIR)/bin/phpize
	sed -i -e 's!prefix=.*!prefix=$(STAGING_PREFIX)!' $(STAGING_DIR)/bin/phpize
	chmod a+rx $(STAGING_DIR)/bin/phpize
	touch $@

php54-stage: $(PHP54_BUILD_DIR)/.staged

#
# This builds the IPK file.
#
# Binaries should be installed into $(PHP54_IPK_DIR)/opt/sbin or $(PHP54_IPK_DIR)/opt/bin
# (use the location in a well-known Linux distro as a guide for choosing sbin or bin).
# Libraries and include files should be installed into $(PHP54_IPK_DIR)/opt/{lib,include}
# Configuration files should be installed in $(PHP54_IPK_DIR)/opt/etc/php/...
# Documentation files should be installed in $(PHP54_IPK_DIR)/opt/doc/php/...
# Daemon startup scripts should be installed in $(PHP54_IPK_DIR)/opt/etc/init.d/S??php
#
# You may need to patch your application to make it use these locations.
#
$(PHP54_TARGET_IPKS): $(PHP54_BUILD_DIR)/.built
	rm -rf $(PHP54_IPK_DIR) $(BUILD_DIR)/php_*_$(TARGET_ARCH).ipk
	install -d $(PHP54_IPK_DIR)/opt/var/lib/php/session
	chmod a=rwx $(PHP54_IPK_DIR)/opt/var/lib/php/session
	$(MAKE) -C $(PHP54_BUILD_DIR) INSTALL_ROOT=$(PHP54_IPK_DIR) program_prefix="" install
	$(STRIP_COMMAND) $(PHP54_IPK_DIR)/opt/bin/php
	$(STRIP_COMMAND) $(PHP54_IPK_DIR)/opt/lib/*.so
	$(STRIP_COMMAND) $(PHP54_IPK_DIR)/opt/lib/php/extensions/*.so
	rm -f $(PHP54_IPK_DIR)/opt/lib/php/extensions/*.a
	install -d $(PHP54_IPK_DIR)/opt/etc
	install -d $(PHP54_IPK_DIR)/opt/etc/php.d
	install -m 644 $(PHP54_SOURCE_DIR)/php.ini $(PHP54_IPK_DIR)/opt/etc/php.ini
	### now make php54-dev
	rm -rf $(PHP54_DEV_IPK_DIR) $(BUILD_DIR)/php54-dev_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_DEV_IPK_DIR)/CONTROL/control
	install -d $(PHP54_DEV_IPK_DIR)/opt/lib/php
	mv $(PHP54_IPK_DIR)/opt/lib/php/build $(PHP54_DEV_IPK_DIR)/opt/lib/php/
	mv $(PHP54_IPK_DIR)/opt/include $(PHP54_DEV_IPK_DIR)/opt/
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_DEV_IPK_DIR)
	### now make php54-embed
	rm -rf $(PHP54_EMBED_IPK_DIR) $(BUILD_DIR)/php54-embed_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_EMBED_IPK_DIR)/CONTROL/control
	install -d $(PHP54_EMBED_IPK_DIR)/opt/lib/
	mv $(PHP54_IPK_DIR)/opt/lib/libphp5.so $(PHP54_EMBED_IPK_DIR)/opt/lib
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_EMBED_IPK_DIR)
	### now make php54-curl
	rm -rf $(PHP54_CURL_IPK_DIR) $(BUILD_DIR)/php54-curl_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_CURL_IPK_DIR)/CONTROL/control
	install -d $(PHP54_CURL_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_CURL_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/curl.so $(PHP54_CURL_IPK_DIR)/opt/lib/php/extensions/curl.so
	echo extension=curl.so >$(PHP54_CURL_IPK_DIR)/opt/etc/php.d/curl.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_CURL_IPK_DIR)
	### now make php54-gd
	rm -rf $(PHP54_GD_IPK_DIR) $(BUILD_DIR)/php54-gd_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_GD_IPK_DIR)/CONTROL/control
	install -d $(PHP54_GD_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_GD_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/gd.so $(PHP54_GD_IPK_DIR)/opt/lib/php/extensions/gd.so
	echo extension=gd.so >$(PHP54_GD_IPK_DIR)/opt/etc/php.d/gd.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_GD_IPK_DIR)
ifeq (, $(filter --without-iconv, $(PHP54_CONFIGURE_ARGS)))
	### now make php54-iconv
	rm -rf $(PHP54_ICONV_IPK_DIR) $(BUILD_DIR)/php54-iconv_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_ICONV_IPK_DIR)/CONTROL/control
	install -d $(PHP54_ICONV_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_ICONV_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/iconv.so $(PHP54_ICONV_IPK_DIR)/opt/lib/php/extensions/iconv.so
	echo extension=iconv.so >$(PHP54_ICONV_IPK_DIR)/opt/etc/php.d/iconv.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_ICONV_IPK_DIR)
endif
	### now make php54-imap
	rm -rf $(PHP54_IMAP_IPK_DIR) $(BUILD_DIR)/php54-imap_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_IMAP_IPK_DIR)/CONTROL/control
	install -d $(PHP54_IMAP_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_IMAP_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/imap.so $(PHP54_IMAP_IPK_DIR)/opt/lib/php/extensions/imap.so
	echo extension=imap.so >$(PHP54_IMAP_IPK_DIR)/opt/etc/php.d/imap.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_IMAP_IPK_DIR)
ifeq (openldap, $(filter openldap, $(PACKAGES)))
	### now make php54-ldap
	rm -rf $(PHP54_LDAP_IPK_DIR) $(BUILD_DIR)/php54-ldap_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_LDAP_IPK_DIR)/CONTROL/control
	install -d $(PHP54_LDAP_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_LDAP_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/ldap.so $(PHP54_LDAP_IPK_DIR)/opt/lib/php/extensions/ldap.so
	echo extension=ldap.so >$(PHP54_LDAP_IPK_DIR)/opt/etc/php.d/ldap.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_LDAP_IPK_DIR)
endif
	### now make php54-mbstring
	rm -rf $(PHP54_MBSTRING_IPK_DIR) $(BUILD_DIR)/php54-mbstring_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_MBSTRING_IPK_DIR)/CONTROL/control
	install -d $(PHP54_MBSTRING_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_MBSTRING_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/mbstring.so $(PHP54_MBSTRING_IPK_DIR)/opt/lib/php/extensions/mbstring.so
	echo extension=mbstring.so >$(PHP54_MBSTRING_IPK_DIR)/opt/etc/php.d/mbstring.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_MBSTRING_IPK_DIR)
	### now make php54-mysql
	rm -rf $(PHP54_MYSQL_IPK_DIR) $(BUILD_DIR)/php54-mysql_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_MYSQL_IPK_DIR)/CONTROL/control
	install -d $(PHP54_MYSQL_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_MYSQL_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/*mysql*.so $(PHP54_MYSQL_IPK_DIR)/opt/lib/php/extensions/
	echo extension=mysql.so >$(PHP54_MYSQL_IPK_DIR)/opt/etc/php.d/mysql.ini
	echo extension=mysqli.so >>$(PHP54_MYSQL_IPK_DIR)/opt/etc/php.d/mysql.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_MYSQL_IPK_DIR)
	### now make php54-pear
	rm -rf $(PHP54_PEAR_IPK_DIR) $(BUILD_DIR)/php54-pear_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_PEAR_IPK_DIR)/CONTROL/control
	install -m 644 $(PHP54_SOURCE_DIR)/postinst.pear $(PHP54_PEAR_IPK_DIR)/CONTROL/postinst
	install -m 644 $(PHP54_SOURCE_DIR)/prerm.pear $(PHP54_PEAR_IPK_DIR)/CONTROL/prerm
	install -d $(PHP54_PEAR_IPK_DIR)/opt/etc
	install -m 644 $(PHP54_SOURCE_DIR)/pear.conf $(PHP54_PEAR_IPK_DIR)/opt/etc/pear.conf.new
	install -d $(PHP54_PEAR_IPK_DIR)/opt/etc/pearkeys
	install -d $(PHP54_PEAR_IPK_DIR)/opt/tmp
	cp -a $(PHP54_BUILD_DIR)/pear $(PHP54_PEAR_IPK_DIR)/opt/tmp
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_PEAR_IPK_DIR)
	### now make php54-pgsql
	rm -rf $(PHP54_PGSQL_IPK_DIR) $(BUILD_DIR)/php54-pgsql_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_PGSQL_IPK_DIR)/CONTROL/control
	install -d $(PHP54_PGSQL_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_PGSQL_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/*pgsql*.so $(PHP54_PGSQL_IPK_DIR)/opt/lib/php/extensions/
	echo extension=pgsql.so >$(PHP54_PGSQL_IPK_DIR)/opt/etc/php.d/pgsql.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_PGSQL_IPK_DIR)
	### now make php54-mssql
	rm -rf $(PHP54_MSSQL_IPK_DIR) $(BUILD_DIR)/php54-mssql_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_MSSQL_IPK_DIR)/CONTROL/control
	install -d $(PHP54_MSSQL_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_MSSQL_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/mssql.so $(PHP54_MSSQL_IPK_DIR)/opt/lib/php/extensions/
	echo extension=mssql.so >$(PHP54_MSSQL_IPK_DIR)/opt/etc/php.d/mssql.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_MSSQL_IPK_DIR)
	### now make php54-odbc
	rm -rf $(PHP54_ODBC_IPK_DIR) $(BUILD_DIR)/php54-odbc_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_ODBC_IPK_DIR)/CONTROL/control
	install -d $(PHP54_ODBC_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_ODBC_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/odbc.so $(PHP54_ODBC_IPK_DIR)/opt/lib/php/extensions/
	echo extension=odbc.so >$(PHP54_ODBC_IPK_DIR)/opt/etc/php.d/odbc.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_ODBC_IPK_DIR)
	### now make php54-xmlrpc
	rm -rf $(PHP54_XMLRPC_IPK_DIR) $(BUILD_DIR)/php54-xmlrpc_*_$(TARGET_ARCH).ipk
	$(MAKE) $(PHP54_XMLRPC_IPK_DIR)/CONTROL/control
	install -d $(PHP54_XMLRPC_IPK_DIR)/opt/lib/php/extensions
	install -d $(PHP54_XMLRPC_IPK_DIR)/opt/etc/php.d
	mv $(PHP54_IPK_DIR)/opt/lib/php/extensions/xmlrpc.so $(PHP54_XMLRPC_IPK_DIR)/opt/lib/php/extensions/
	echo extension=xmlrpc.so >$(PHP54_XMLRPC_IPK_DIR)/opt/etc/php.d/xmlrpc.ini
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_XMLRPC_IPK_DIR)
	### finally the main ipkg
	$(MAKE) $(PHP54_IPK_DIR)/CONTROL/control
	echo $(PHP54_CONFFILES) | sed -e 's/ /\n/g' > $(PHP54_IPK_DIR)/CONTROL/conffiles
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PHP54_IPK_DIR)

#
# This is called from the top level makefile to create the IPK file.
#
php54-ipk: $(PHP54_TARGET_IPKS)

#
# This is called from the top level makefile to clean all of the built files.
#
php54-clean:
	-$(MAKE) -C $(PHP54_BUILD_DIR) clean

#
# This is called from the top level makefile to clean all dynamically created
# directories.
#
php54-dirclean:
	rm -rf $(BUILD_DIR)/$(PHP54_DIR) $(PHP54_BUILD_DIR) \
	$(PHP54_IPK_DIR) $(PHP54_IPK) \
	$(PHP54_DEV_IPK_DIR) $(PHP54_DEV_IPK) \
	$(PHP54_EMBED_IPK_DIR) $(PHP54_EMBED_IPK) \
	$(PHP54_CURL_IPK_DIR) $(PHP54_CURL_IPK) \
	$(PHP54_GD_IPK_DIR) $(PHP54_GD_IPK) \
	$(PHP54_IMAP_IPK_DIR) $(PHP54_IMAP_IPK) \
	$(PHP54_MBSTRING_IPK_DIR) $(PHP54_MBSTRING_IPK) \
	$(PHP54_MSSQL_IPK_DIR) $(PHP54_MSSQL_IPK) \
	$(PHP54_MYSQL_IPK_DIR) $(PHP54_MYSQL_IPK) \
	$(PHP54_PEAR_IPK_DIR) $(PHP54_PEAR_IPK) \
	$(PHP54_PGSQL_IPK_DIR) $(PHP54_PGSQL_IPK) \
	$(PHP54_ODBC_IPK_DIR) $(PHP54_ODBC_IPK) \
	;
ifeq (, $(filter --without-iconv, $(PHP54_CONFIGURE_ARGS)))
	rm -rf $(PHP54_ICONV_IPK_DIR) $(PHP54_ICONV_IPK)
endif
ifeq (openldap, $(filter openldap, $(PACKAGES)))
	rm -rf $(PHP54_LDAP_IPK_DIR) $(PHP54_LDAP_IPK)
endif


#
# Some sanity check for the package.
#
php54-check: $(PHP54_TARGET_IPKS)
	perl scripts/optware-check-package.pl --target=$(OPTWARE_TARGET) $^
