local M = {}
M.lsp_legend = {
    -- groups with same itemgroup will be merged
    itemgroup = 'lsps',
    description = 'LSP Server Functions',
    icon = '',
    keymaps = {
        { 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>',          description = 'LSP Show Hover Field' },
        { 'gl', '<cmd>lua vim.lsp.buf.signature_help()<cr>', description = '' },
        {
            'gd',
            function()
                require("telescope.builtin").lsp_definitions(lsp_telescope_opts)
            end,
            description = 'Show defintions'
        },
        { 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',     description = 'Go to declaration' },
        { 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',  description = 'Go to implementation' },
        { 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', description = 'Type definition' },
        {
            'gr',
            function()
                require "telescope.builtin".lsp_references(lsp_telescope_opts)
            end,
            description = 'Show references'
        },
        {
            'gh',
            '<cmd>lua vim.diagnostic.goto_prev()<cr>',
            description =
            'Go to previous LSP diagnostic'
        },
        { 'gl',   '<cmd>lua vim.diagnostic.goto_next()<cr>', description = 'Go to next LSP diagnostic', },
        { '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',       description = 'Buffer rename' },
        { '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',  description = 'Code action' },
        {
            '<F4>',
            '<cmd>lua vim.lsp.buf.range_code_action()<cr>',
            description = 'Range code action',
            mode = { 'x' }
        },
        {
            'f',
            '<cmd>lua vim.lsp.buf.format({insertFinalNewline = false})<cr>v',
            description = 'Format range',
            mode = { 'v' }
        },
    },
}

return M
