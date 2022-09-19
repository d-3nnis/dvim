local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    print("Could not load lspconfig")
	return
end
--[[ 
require("mason-lspconfig").setup_handlers {
    -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
    function (server_name)
       lspconfig[server.name].setup {}
   end,
} ]]
--require("plugins.lsp.lsp-installer")
--require("plugins.lsp.handlers").setup()
--[[ require("handlers") ]]
require("plugins.lsp.servers")
