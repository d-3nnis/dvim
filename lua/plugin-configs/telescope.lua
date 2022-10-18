local t = safe_require('telescope')
if not t then return end

t.setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    }
}

vim.api.nvim_create_autocmd({"User TelescopePreviewerLoaded"}, { command = "setlocal wrap" })

t.load_extension('ui-select')
t.load_extension('notify')
t.load_extension('projects')
