local mlconfig = safe_require('mason-lspconfig')
if not mlconfig then return end

mlconfig.setup {
    ensure_installed = { 'sumneko_lua', 'clangd' },
    automatic_installation = true,
}

local lspconfig = safe_require('lspconfig')
if not lspconfig then return end

--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
    capabilities = capabilities,
}

lspconfig.bashls.setup {}

local clangd_server_vars = {
    capabilities = capabilities,
}

local clangd_ext = safe_require('clangd_extensions')
if not clangd_ext then
    lspconfig.clangd.setup(clangd_server_vars)
else
    clangd_ext.setup {
        server = clangd_server_vars,
    }
end


