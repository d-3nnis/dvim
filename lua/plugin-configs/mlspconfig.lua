local mlconfig = safe_require('mason-lspconfig')
if not mlconfig then return end

mlconfig.setup {
    ensure_installed = { 'sumneko_lua', 'clangd' },
    automatic_installation = true,
}

local setup_values = {
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    }
}

local lspconfig = safe_require('lspconfig')
if not lspconfig then return end

mlconfig.setup_handlers({
    function(server_name)
        local config = setup_values[server_name]
        print(config)
        if not config then
            config = {}
        end
        lspconfig[server_name].setup(config)
    end
})

local clangd_ext = safe_require('clangd_extensions')
if clangd_ext then
    clangd_ext.setup {}
end
