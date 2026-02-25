local M = {}

local function lsp_info()
    vim.cmd('checkhealth vim.lsp')
end

local function lsp_keymaps(bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', 'gd', require('definition-or-references').definition_or_references, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gh', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set('n', 'gl', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

    require('which-key').add({
        buffer = bufnr,
        { '<leader>l',  group = 'LSP' },
        { '<leader>la', function() vim.lsp.buf.code_action() end, desc = 'Code Action', mode = { 'n', 'v' } },
        {
            '<leader>lc',
            function()
                require('fzf-lua').diagnostics_document({
                    severity_limit = vim.diagnostic.severity.ERROR
                })
            end,
            desc = 'Document Diagnostics, ERROR or more severe',
        },
        {
            '<leader>lC',
            function()
                require('fzf-lua').diagnostics_workspace({
                    severity_limit = vim.diagnostic.severity.ERROR
                })
            end,
            desc = 'Workspace Diagnostics, ERROR or more severe',
        },
        { '<leader>ld', function() require('fzf-lua').diagnostics_document() end,         desc = 'Document Diagnostics', },
        { '<leader>lD', function() require('fzf-lua').diagnostics_workspace() end,        desc = 'Workspace Diagnostics', },
        { '<leader>lf', function() vim.lsp.buf.format { async = true } end,               desc = 'Format',                           mode = { 'n', 'v' }, },
        { '<leader>ls', function() vim.diagnostic.open_float() end,                       desc = 'Open floating diagnostics window', },
        { '<leader>li', lsp_info,                                                         desc = 'Info', },
        { '<leader>lj', function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = 'Next Diagnostic', },
        { '<leader>lJ', function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = 'Prev Diagnostic', },
        { '<leader>lr', function() vim.lsp.buf.references() end,                          desc = 'References', },
        { '<leader>lR', function() vim.lsp.buf.rename() end,                              desc = 'Rename', },
        { '<leader>lp', function() require('fzf-lua').lsp_document_symbols() end,         desc = 'Document Symbols', },
        { '<leader>lP', function() require('fzf-lua').lsp_live_workspace_symbols() end,   desc = 'Workspace Symbols', },
        { '<leader>lS', function() vim.lsp.buf.signature_help() end,                      desc = 'Signature Help' },
        { '<leader>lI', function() vim.lsp.buf.implementation() end,                      desc = 'Implementation' },
    })
end

function M.setup()
    require('lsp.diagnostics').setup()
    require('lsp.servers').setup()
    vim.lsp.enable({ 'lua_ls', 'clangd', 'bashls', 'rust_analyzer' })

    local group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        callback = function(ev)
            lsp_keymaps(ev.buf)
        end,
    })
end

return M
