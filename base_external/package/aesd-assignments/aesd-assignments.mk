
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# Referencing latest commit from assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 'e92ed9d325cc0cc753542ef13b92d6a7a34f8dde'

# Referencing *ssh* repository URL here to work properly
# with ssh keys and the automated build/test system.
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-anshubreddy.git'
AESD_ASSIGNMENTS_SITE_METHOD = git

AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

# Add aesdsocket application and aesdsocket-start-stop script to /usr/bin directory and
# /etc/init.d/S99aesdsocket respectively
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))
