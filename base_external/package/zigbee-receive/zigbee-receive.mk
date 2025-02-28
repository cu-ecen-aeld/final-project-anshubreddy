##############################################################
#
# ZIGBEE-RECEIVE
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
ZIGBEE_RECEIVE_VERSION = '723053fa824bc248452b1142462b3fc1276e040c'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
ZIGBEE_RECEIVE_SITE = 'git@github.com:anshubreddy/final-project-anshubreddy-hw.git'
ZIGBEE_RECEIVE_SITE_METHOD = git
ZIGBEE_RECEIVE_GIT_SUBMODULES = YES

define ZIGBEE_RECEIVE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/zigbee_server all
endef

# TODO add the Zigbee receiver utilities/scripts to the installation steps below
define ZIGBEE_RECEIVE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/zigbee_server/zigbee_server $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
