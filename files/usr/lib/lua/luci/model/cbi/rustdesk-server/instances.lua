local m = Map("rustdesk-server", translate("RustDesk 实例配置"))

-- hbbs
local s_hbbs = m:section(NamedSection, "hbbs", "instance", translate("hbbs (ID/注册服务器)"))
s_hbbs.addremove = false

s_hbbs:option(Flag, "enabled", translate("启用")).default = 1
local bin_hbbs = s_hbbs:option(Value, "bin", translate("二进制文件路径"))
bin_hbbs.default = "/usr/bin/hbbs"

local relay = s_hbbs:option(Value, "relay", translate("默认中继服务器地址 (-r)"))
relay.placeholder = "1.2.3.4"

s_hbbs:option(Flag, "force_auth", translate("强制认证 (-k _)")).default = 1
s_hbbs:option(Value, "extra_args", translate("额外参数"))

-- hbbr
local s_hbbr = m:section(NamedSection, "hbbr", "instance", translate("hbbr (中继服务器)"))
s_hbbr.addremove = false

s_hbbr:option(Flag, "enabled", translate("启用")).default = 1
local bin_hbbr = s_hbbr:option(Value, "bin", translate("二进制文件路径"))
bin_hbbr.default = "/usr/bin/hbbr"

s_hbbr:option(Flag, "force_auth", translate("强制认证 (-k _)")).default = 1
s_hbbr:option(Value, "extra_args", translate("额外参数"))

return m
