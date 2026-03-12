local m = Map("rustdesk-server", translate("RustDesk 服务器全局设置"))
local s = m:section(NamedSection, "global", "global", translate("基础配置"))

local data_dir = s:option(Value, "data_dir", translate("数据目录"))
data_dir.description = translate("存放 ID/Key 文件的目录")
data_dir.default = "/root/.rustdesk-server"
data_dir.rmempty = false

return m
