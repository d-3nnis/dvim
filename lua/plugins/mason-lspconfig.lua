vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, remap = false }

        vim.keymap.set("n", "gd", require("definition-or-references").definition_or_references, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gh", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        require('which-key').add(
            {
                buffer = ev.buf,
                { '<leader>l',  group = 'LSP' },
                { '<leader>la', function() vim.lsp.buf.code_action {} end,                       desc = 'Code Action', },
                { '<leader>ld', function() require('fzf-lua').diagnostics_document() end,        desc = 'Document Diagnostics', },
                { '<leader>lD', function() require('fzf-lua').diagnostics_workspace() end,       desc = 'Workspace Diagnostics', },
                { '<leader>lf', function() vim.lsp.buf.format { async = true } end,              desc = 'Format',                           mode = { 'n', 'v' }, },
                { '<leader>ls', function() vim.diagnostic.open_float() end,                      desc = 'Open floating diagnostics window', },
                { '<leader>li', '<cmd>LspInfo<cr>',                                              desc = 'Info', },
                { '<leader>lj', function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = 'Next Diagnostic', },
                { '<leader>lk', function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = 'Prev Diagnostic', },
                { '<leader>lr', function() vim.lsp.buf.references() end,                         desc = 'References', },
                { '<leader>lR', function() vim.lsp.buf.rename() end,                             desc = 'Rename', },
                { '<leader>lp', function() require('fzf-lua').lsp_document_symbols() end,        desc = 'Document Symbols', },
                { '<leader>lP', function() require('fzf-lua').lsp_live_workspace_symbols() end,  desc = 'Workspace Symbols', },
            })
    end,
})

local config = {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        config = function(_, opts)
            local mlconfig = safe_require('mason-lspconfig')
            if not mlconfig then return end
            local lspconfig = require('lspconfig')
            if not lspconfig then return end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

            mlconfig.setup {
                ensure_installed = { 'lua_ls', 'clangd', 'bashls' },
                automatic_installation = true,
                handlers = {
                    ["*"] = function(server_name)
                        local server_specific_opts = opts.servers[server_name] or {}
                        local final_config = vim.tbl_deep_extend("force", {
                            capabilities = capabilities,
                            -- Add any other common settings here if needed
                            -- on_attach = function(client, bufnr)
                            --     -- Your on_attach logic
                            -- end,
                        }, server_specific_opts)
                        lspconfig[server_name].setup(final_config)
                    end
                }
            }
        end,
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
                },
            },
        },

        dependencies = {
            'williamboman/mason.nvim',
        },
    },
    {
        'neovim/nvim-lspconfig',
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
        },
    }
}

return config
