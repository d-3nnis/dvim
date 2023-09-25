local config = {
    "stevearc/oil.nvim",
    config = function()
        local oil = safe_require("oil")
        if not oil then return end
        oil.setup {
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-c>"] = "actions.close",
                ["<ESC>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["<BS>"] = "actions.parent",
                ["gw"] = "actions.open_cwd",
                ["."] = "actions.cd",
                ["gy"] = "actions.copy_entry_path",
                ["gs"] = "actions.change_sort",
                ["J"] = "actions.toggle_hidden",
            },
            use_default_keymaps = false,
        }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

return config
