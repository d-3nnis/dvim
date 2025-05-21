local config = {
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-c>"] = "actions.close",
            ["<ESC>"] = "actions.close",
            ["q"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            ["<BS>"] = "actions.parent",
            ["gw"] = "actions.open_cwd",
            ["."] = "actions.cd",
            ["gy"] = {
                callback = function()
                    local osc52 = safe_require("osc52")
                    if not osc52 then
                        require('oil.actions').copy_entry_path.callback()
                        return
                    end
                    local entry = require("oil").get_cursor_entry()
                    local dir = require("oil").get_current_dir()
                    if not entry or not dir then
                        return
                    end
                    local full_path = dir .. entry.name
                    osc52.copy(full_path)
                end,
                desc = "osc52 copy full path",
                mode = "n"
            },
            ["gs"] = "actions.change_sort",
            ["J"] = "actions.toggle_hidden",
        },
        extra_scp_args = { "-O" },
        use_default_keymaps = false,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

return config
