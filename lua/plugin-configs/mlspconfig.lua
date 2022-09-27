local mlconfig = safe_require('mason-lspconfig')
if not mlconfig then return end

mlconfig.setup {
    ensure_installed = { 'sumneko_lua' },
    automatic_installation = true,
}

local lspconfig = safe_require('lspconfig')
if not lspconfig then return end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
    capabilities=capabilities,
}


