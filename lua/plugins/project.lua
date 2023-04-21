local config = {

    {'ahmedkhalf/project.nvim',
        config = function()
local project = safe_require("project_nvim")

project.setup({
    detection_methods = { 'lsp', 'pattern' },
    detection_methods = { 'pattern' },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = true,
    silent_chdir = false,
    -- scope_chdir = 'win',
}) 
        end,
    }
}
return config
