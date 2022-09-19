local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("Mason could not be loaded")
	return
end
local status_ok2, lspconfig = pcall(require, "mason-lspconfig")
if not status_ok2 then
    print("mason-lspconfig could not be loaded")
	return
end

mason.setup{
    ui = {
        border = 'double'
    }
}

lspconfig.setup({
    ensure_installed = { "clang", "sumneko_lua", "rust_analyzer", "pyright" },
    automatic_installation = true
})
