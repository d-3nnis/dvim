local function on_attach()
    local legendary = safe_require('legendary')
    if not legendary then
        return
    end
    local lsp_legend = require('plugins.conditional-legends.lsp_legend').lsp_legend
    legendary.keymaps(lsp_legend, { buffer = true })
end

local config = {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        config = function()
            local mlconfig = safe_require('mason-lspconfig')
            if not mlconfig then return end

            mlconfig.setup {
                ensure_installed = { 'lua_ls', 'clangd' },
                automatic_installation = true,
            }

            local setup_values = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace"
                            },
                            workspace = {
                                checkThirdParty = false,
                            },
                        }
                    }
                },
            }

            local ignore_list = { clangd = {} }

            local lspconfig = require('lspconfig')
            -- if not lspconfig then return end

            local capabilities = vim.lsp.protocol.make_client_capabilities()

            mlconfig.setup_handlers({
                function(server_name)
                    if ignore_list[server_name] then
                        -- vim.notify("Ignoring setup for: " .. server_name)
                    else
                        local server_config = setup_values[server_name]
                        if not server_config then
                            -- vim.notify("No custom server configuration for " .. server_name)
                            server_config = {}
                        end

                        local default_config = { on_attach = on_attach, capabilities = capabilities }
                        local extended_config = vim.tbl_extend("error", server_config, default_config)
                        lspconfig[server_name].setup(extended_config)
                    end
                end
            })
        end,
        dependencies = {
            'williamboman/mason.nvim',
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } },
            },
        },
    }
}

return config
