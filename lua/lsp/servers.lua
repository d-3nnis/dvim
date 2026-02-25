local M = {}

function M.setup()
    vim.lsp.config('clangd', {
        cmd = {
            'clangd',
            '--clang-tidy',
            '--background-index',
            '--offset-encoding=utf-8',
        },
    })

    vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    checkThirdParty = false,
                },
            },
        },
    })

end

return M
