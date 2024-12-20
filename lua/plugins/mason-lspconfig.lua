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
        require('which-key').add(
            {
                buffer = ev.buf,
                { '<leader>l',  group = 'LSP' },
                { '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>',                       desc = 'Code Action', },
                { '<leader>ld', function() require('fzf-lua').diagnostics_document() end,       desc = 'Document Diagnostics', },
                { '<leader>lf', function() vim.lsp.buf.format { async = true } end,             desc = 'Format',                           mode = { 'n', 'v' }, },
                { '<leader>lF', function() vim.diagnostic.open_float() end,                     desc = 'Open floating diagnostics window', },
                { '<leader>li', '<cmd>LspInfo<cr>',                                             desc = 'Info', },
                { '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<CR>',                      desc = 'Next Diagnostic', },
                { '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>',                      desc = 'Prev Diagnostic', },
                { '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>',                        desc = 'References', },
                { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>',                            desc = 'Rename', },
                { '<leader>ls', function() require('fzf-lua').lsp_document_symbols() end,       desc = 'Document Symbols', },
                { '<leader>lS', function() require('fzf-lua').lsp_live_workspace_symbols() end, desc = 'Workspace Symbols', },
            })
    end,
})

local config = {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    -- {
    --     'williamboman/mason-lspconfig.nvim',
    --     lazy = false,
    --     config = function()
    --         local mlconfig = safe_require('mason-lspconfig')
    --         if not mlconfig then return end
    --
    --         mlconfig.setup {
    --             ensure_installed = { 'lua_ls', 'clangd' },
    --             automatic_installation = true,
    --         }
    --
    --         local setup_values = {
    --             lua_ls = {
    --                 settings = {
    --                     Lua = {
    --                         completion = {
    --                             callSnippet = "Replace"
    --                         },
    --                         workspace = {
    --                             checkThirdParty = false,
    --                         },
    --                         hint = {
    --                             enable = true,
    --                             arrayIndex = "Disable",
    --                         },
    --                     }
    --                 }
    --             },
    --         }
    --
    --         -- local ignore_list = { clangd = {} }
    --         local ignore_list = {}
    --
    --         local lspconfig = require('lspconfig')
    --         -- if not lspconfig then return end
    --
    --         local capabilities = vim.lsp.protocol.make_client_capabilities()
    --
    --         mlconfig.setup_handlers({
    --             function(server_name)
    --                 if ignore_list[server_name] then
    --                     -- vim.notify("Ignoring setup for: " .. server_name)
    --                 else
    --                     local server_config = setup_values[server_name]
    --                     if not server_config then
    --                         -- vim.notify("No custom server configuration for " .. server_name)
    --                         server_config = {}
    --                     end
    --
    --                     local default_config = { capabilities = capabilities }
    --                     local extended_config = vim.tbl_extend("error", server_config, default_config)
    --                     lspconfig[server_name].setup(extended_config)
    --                 end
    --             end
    --         })
    --     end,
    --     dependencies = {
    --         'williamboman/mason.nvim',
    --     },
    -- },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
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
                }
            },
        },
        config = function(_, opts)
            local lspconfig = safe_require('lspconfig')
            if not lspconfig then return end
            -- local capabilities = vim.lsp.protocol.make_client_capabilities()
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end,
        dependencies = {
            'saghen/blink.cmp',
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
