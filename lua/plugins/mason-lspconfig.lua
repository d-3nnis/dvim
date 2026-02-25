local config = {
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = { 'lua_ls', 'clangd', 'bashls', 'rust_analyzer' },
        },

        dependencies = {
            'williamboman/mason.nvim',
            "neovim/nvim-lspconfig",
        },
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lsp').setup()
        end,
        dependencies = {
            'saghen/blink.cmp',
            {
                "hasansujon786/nvim-navbuddy",
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
