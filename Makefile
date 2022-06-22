include $(TOPDIR)/rules.mk

PKG_NAME:=r8125
PKG_VERSION:=9.009.01
PKG_RELEASE:=$(AUTORELEASE)
PKG_LICENSE:=GPLv2
PKG_MAINTAINER:=Youyuan <youyuanluo@126.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define KernelPackage/r8125
  TITLE:=RealTek RTL-8125 PCIe 2.5 Gigabit Ethernet Adapter kernel support
  SUBMENU:=Network Devices
  DEPENDS:=@PCI_SUPPORT
  FILES:= $(PKG_BUILD_DIR)/r8125.ko
  AUTOLOAD:=$(call AutoProbe,r8125)
endef

define Package/r8125/description
  Kernel modules for RealTek RTL-8125 PCIe 2.5 Gigabit Ethernet adapters
endef

KERNEL_MAKE_FLAGS+=ENABLE_RSS_SUPPORT=y ENABLE_MULTIPLE_TX_QUEUE=y

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(LINUX_DIR) \
		$(KERNEL_MAKE_FLAGS) \
		M=$(PKG_BUILD_DIR) \
		modules
endef

$(eval $(call KernelPackage,r8125))
