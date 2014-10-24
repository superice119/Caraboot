export BUILD_TOPDIR=$(PWD)
export STAGING_DIR=$(BUILD_TOPDIR)/tmp
export TOPDIR=$(PWD)
export UBOOTDIR=$(TOPDIR)/u-boot

### Toolchain config ###
#buildroot
CONFIG_TOOLCHAIN_PREFIX=/opt/build/toolchain-mipsbe-4.7.3/bin/mips-linux-

#openwrt NOT YET
#CONFIG_TOOLCHAIN_PREFIX=mips-openwrt-linux-uclibc-
#export PATH:=$(BUILD_TOPDIR)/toolchain/bin/:$(PATH)

########################

export CROSS_COMPILE=$(CONFIG_TOOLCHAIN_PREFIX)
export MAKECMD=make ARCH=mips

export UBOOT_GCC_4_3_3_EXTRA_CFLAGS=-fPIC
export BUILD_TYPE=squashfs

BOARD_TYPE=carambola2
export COMPRESSED_UBOOT=0
export FLASH_SIZE=16
export NEW_DDR_TAP_CAL=1
export CONFIG_HORNET_XTAL=40
export CARABOOT_RELEASE=v2.1-dev

IMAGEPATH=$(BUILD_TOPDIR)/bin
UBOOT_BINARY=u-boot.bin
UBOOTFILE=$(BOARD_TYPE)_u-boot.bin

all:
	cd $(UBOOTDIR) && $(MAKECMD) distclean
	cd $(UBOOTDIR) && $(MAKECMD) $(BOARD_TYPE)_config
	cd $(UBOOTDIR) && $(MAKECMD) all
	@echo Copy binaries to $(IMAGEPATH)/$(UBOOTFILE)
	mkdir -p $(IMAGEPATH)
	cp -f $(UBOOTDIR)/$(UBOOT_BINARY) $(IMAGEPATH)/$(UBOOTFILE)

	@echo Done
	
clean:
	cd $(UBOOTDIR) && $(MAKECMD) distclean