vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, remap = false }

    vim.keymap.set("n", "gd", require("definition-or-references").definition_or_references, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "gh", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gl", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    local wk = safe_require("which-key")
    local whichkey_opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = ev.buf,
        silent = true,
        noremap = true,
        nowait = true,
    }
    wk.register(
        {
            l = {
                name = "LSP",
                a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
                d = {
                    "<cmd>Telescope diagnostics<cr>",
                    "Document Diagnostics",
                },
                f = { "<cmd>lua vim.lsp.buf.format{async = true}<cr>", "Format", mode = { 'n', 'v' } },
                F = { function() vim.diagnostic.open_float() end, "Open floating diagnostics window" },
                i = { "<cmd>LspInfo<cr>", "Info" },
                j = {
                    "<cmd>lua vim.diagnostic.goto_next()<CR>",
                    "Next Diagnostic",
                },
                k = {
                    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                    "Prev Diagnostic",
                },
                r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
                R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                S = {
                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                    "Workspace Symbols",
                },
            }
        }, whichkey_opts)
  end,
})

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
                            hint = {
                                enable = true,
                                arrayIndex = "Disable",
                            },
                        }
                    }
                },
            }

            -- local ignore_list = { clangd = {} }
            local ignore_list = {}

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

                        local default_config = { capabilities = capabilities }
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
                opts = {
                    lsp = { auto_attach = true },
                    inlay_hints = { enabled = true },
                },
            },
            'folke/neodev.nvim',
        },
    }
}

return config
