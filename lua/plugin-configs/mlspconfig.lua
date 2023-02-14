local mlconfig = safe_require('mason-lspconfig')
if not mlconfig then return end

mlconfig.setup {
    ensure_installed = {
        'sumneko_lua', 'clangd',
    },
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
    },
}

local ignore_list = { clangd = {} }

local lspconfig = safe_require('lspconfig')
if not lspconfig then return end

local capabilities = vim.lsp.protocol.make_client_capabilities()

mlconfig.setup_handlers({
    function(server_name)
        if ignore_list[server_name] then
            vim.notify("Ignoring setup for: " .. server_name)
        else
            local server_config = setup_values[server_name]
            if not server_config then
                -- vim.notify("No custom server configuration for " .. server_name)
                server_config = {}
            end

            local default_config = { capabilities = capabilities }
            local config = vim.tbl_extend("error", server_config, default_config)
            lspconfig[server_name].setup(config)
        end
    end
})

local clangd_ext = safe_require('clangd_extensions')
if clangd_ext then
    clangd_ext.setup {
        extensions = {
            inlay_hints = {

                parameter_hints_prefix = "  ",
                other_hints_prefix = " ",
            }
        }
    }
end
