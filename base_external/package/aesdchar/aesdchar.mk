
##############################################################
#
# AESDCHAR
#
##############################################################

# Referencing latest commit from assignment 3 git contents
AESDCHAR_VERSION = 'd16b64277f1871f19bde7e0a8fc107f959485706'

# Referencing *ssh* repository URL here to work properly
# with ssh keys and the automated build/test system.
AESDCHAR_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-anshubreddy.git'
AESDCHAR_SITE_METHOD = git

AESDCHAR_GIT_SUBMODULES = YES
AESDCHAR_MODULE_SUBDIRS = aesd-char-driver

# Add aesdchar modules and aesdchar-start-stop script to /bin directory and
# /etc/init.d/S97aesdchar respectively
define AESDCHAR_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/bin
        $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/bin
        $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar-start-stop.sh $(TARGET_DIR)/etc/init.d/S97aesdchar
endef

$(eval $(kernel-module))
$(eval $(generic-package))
