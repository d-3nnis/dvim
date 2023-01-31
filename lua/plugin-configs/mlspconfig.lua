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
        lspconfig[server_name].setup(setup_values[server_name])
    end
})

local clangd_ext = safe_require('clangd_extensions')
if clangd_ext then
    clangd_ext.setup {}
end
