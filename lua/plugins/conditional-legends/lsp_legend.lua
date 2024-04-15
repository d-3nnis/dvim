local M = {}

local lsp_telescope_opts = {
    initial_mode = 'normal'
}
M.lsp_legend = {
    -- groups with same itemgroup will be merged
    itemgroup = 'lsps',
    description = 'LSP Server Functions',
    icon = '',
    keymaps = {
        {
            'K',
            '<cmd>lua vim.lsp.buf.hover()<cr>',
            description = 'LSP Show Hover Field',
            opts = {
                buffer = true }
        },
        { 'gl', '<cmd>lua vim.lsp.buf.signature_help()<cr>', description = '', opts = { buffer = true } },
        {
            'gd',
            function()
                require("telescope.builtin").lsp_definitions(lsp_telescope_opts)
            end,
            description = 'Show defintions',
            opts = { buffer = true, },
        },
        {
            'gD',
            '<cmd>lua vim.lsp.buf.declaration()<cr>',
            description = 'Go to declaration',
            opts = { buffer = true },
        },
        {
            'gi',
            '<cmd>lua vim.lsp.buf.implementation()<cr>',
            description = 'Go to implementation',
            opts = { buffer = true },
        },
        {
            'go',
            '<cmd>lua vim.lsp.buf.type_definition()<cr>',
            description = 'Type definition',
            opts = { buffer = true },
        },
        {
            'gr',
            function()
                require "telescope.builtin".lsp_references(lsp_telescope_opts)
            end,
            description = 'Show references',
            opts = { buffer = true },
        },
        {
            'gh',
            '<cmd>lua vim.diagnostic.goto_prev()<cr>',
            description =
            'Go to previous LSP diagnostic',
            opts = { buffer = true },
        },
        {
            'gl',
            '<cmd>lua vim.diagnostic.goto_next()<cr>',
            description = 'Go to next LSP diagnostic',
            opts = {
                buffer = true
            },
        },
        {
            '<F2>',
            '<cmd>lua vim.lsp.buf.rename()<cr>',
            description = 'Buffer rename',
            opts = {
                buffer = true 
            },
        },
        {
            '<F4>',
            '<cmd>lua vim.lsp.buf.code_action()<cr>',
            description = 'Code action',
            opts = {
                buffer = true 
            },
        },
        {
            '<F4>',
            '<cmd>lua vim.lsp.buf.range_code_action()<cr>',
            description = 'Range code action',
            mode = { 'x' },
            opts = { buffer = true },
        },
        {
            'f',
            '<cmd>lua vim.lsp.buf.format({insertFinalNewline = false})<cr>v',
            description = 'Format range',
            mode = { 'v' },
            opts = { buffer = true },
        },
    },
}

return M
