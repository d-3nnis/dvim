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

t.load_extension('ui-select')
t.load_extension('notify')
