local config = {
    {
        'ahmedkhalf/project.nvim',
        config = function()
            safe_require("project_nvim").setup({
                detection_methods = { 'lsp', 'pattern' },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                show_hidden = false,
                silent_chdir = false,
                -- scope_chdir = 'win',
            })
        end,
    }
}
return config
