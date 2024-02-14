local config = {
    {
        'ahmedkhalf/project.nvim',
        config = function()
            safe_require("project_nvim").setup({
                detection_methods = { 'lsp', 'pattern' },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json" },
                ignore_lsp = { "lua_ls", "pyright" },
                show_hidden = false,
                silent_chdir = false,
            })
        end,
    }
}
return config
