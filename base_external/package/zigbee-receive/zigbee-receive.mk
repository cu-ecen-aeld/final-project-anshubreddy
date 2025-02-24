##############################################################
#
# ZIGBEE-RECEIVE
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
ZIGBEE_RECEIVE_VERSION = '74803ab918904f5c66010f202c87c474664cbf0a'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
ZIGBEE_RECEIVE_SITE = 'git@github.com:anshubreddy/final-project-anshubreddy-hw.git'
ZIGBEE_RECEIVE_SITE_METHOD = git
ZIGBEE_RECEIVE_GIT_SUBMODULES = YES

define ZIGBEE_RECEIVE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/zigbee/zigbee_receive all
endef

# TODO add the Zigbee receiver utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/zigbee/zigbee_receive/zigbee_receive $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
