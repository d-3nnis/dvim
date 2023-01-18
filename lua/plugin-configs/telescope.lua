local t = safe_require('telescope')
if not t then return end

t.setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        },
        fzf = {}
    }
}

vim.api.nvim_create_autocmd({ "User TelescopePreviewerLoaded" }, { command = "setlocal wrap" })

t.load_extension('ui-select')
t.load_extension('notify')
t.load_extension('projects')
t.load_extension('fzf')

local noice = safe_require('noice')
if noice then
    t.load_extension('noice')
end
