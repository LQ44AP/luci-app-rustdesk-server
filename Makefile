include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-rustdesk-server
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0
PKG_MAINTAINER:=Your Name <email@example.com>

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-rustdesk-server
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI interface for RustDesk Server
  DEPENDS:=+luci-compat
  PKGARCH:=all
endef

define Package/luci-app-rustdesk-server/description
  LuCI interface for RustDesk Server (hbbs/hbbr)
endef

define Build/Prepare
	# Nothing to prepare
endef

define Build/Configure
	# Nothing to configure
endef

define Build/Compile
	# Nothing to compile
endef

define Package/luci-app-rustdesk-server/install
	# 安装控制器
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/rustdesk-server.lua $(1)/usr/lib/lua/luci/controller/

	# 安装 CBI 模型
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/rustdesk-server
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/rustdesk-server/global.lua $(1)/usr/lib/lua/luci/model/cbi/rustdesk-server/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/rustdesk-server/instances.lua $(1)/usr/lib/lua/luci/model/cbi/rustdesk-server/

	# 安装视图模板
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/rustdesk-server
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/rustdesk-server/status.htm $(1)/usr/lib/lua/luci/view/rustdesk-server/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/rustdesk-server/key.htm $(1)/usr/lib/lua/luci/view/rustdesk-server/

	# 安装配置文件
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/rustdesk-server $(1)/etc/config/

	# 安装 init.d 脚本
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/rustdesk-server $(1)/etc/init.d/
endef

define Package/luci-app-rustdesk-server/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
    rm -rf /tmp/luci-*
    /etc/init.d/rustdesk-server enable
    killall -HUP rpcd 2>/dev/null || true
}
exit 0
endef

define Package/luci-app-rustdesk-server/prerm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
    /etc/init.d/rustdesk-server stop || true
    /etc/init.d/rustdesk-server disable || true
}
exit 0
endef

$(eval $(call BuildPackage,luci-app-rustdesk-server))
