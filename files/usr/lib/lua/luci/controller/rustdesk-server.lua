module("luci.controller.rustdesk-server", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/rustdesk-server") then
        return
    end

    entry({"admin", "services", "rustdesk-server"}, 
          alias("admin", "services", "rustdesk-server", "status"), 
          _("RustDesk 服务器"), 95).dependent = true
    
    entry({"admin", "services", "rustdesk-server", "status"},
          template("rustdesk-server/status"), _("状态"), 10).leaf = true
    
    entry({"admin", "services", "rustdesk-server", "global"},
          cbi("rustdesk-server/global"), _("全局设置"), 20).leaf = true
    
    entry({"admin", "services", "rustdesk-server", "instances"},
          cbi("rustdesk-server/instances"), _("实例配置"), 30).leaf = true
    
    entry({"admin", "services", "rustdesk-server", "key"},
          template("rustdesk-server/key"), _("查看 Key"), 40).leaf = true
    
    entry({"admin", "services", "rustdesk-server", "restart"},
          call("action_restart")).leaf = true
end

function action_restart()
    luci.sys.call("/etc/init.d/rustdesk-server restart >/dev/null 2>&1 &")
    luci.http.redirect(luci.dispatcher.build_url("admin/services/rustdesk-server/status"))
end
