##############################################################
#
# LDD
#
##############################################################

# Referencing latest commit from assignment 7 git contents
LDD_VERSION = '5d15b3c45269159da0ae261cbc3d5968f938d798'

# Referencing *ssh* repository URL here to work properly
# with ssh keys and the automated build/test system.
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-anshubreddy.git'
LDD_SITE_METHOD = git

LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = scull misc-modules
LDD_MODULE_MAKE_OPTS = KERNELDIR=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))
