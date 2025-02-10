local config = {
    "folke/snacks.nvim",
    priority = 1000,
    enabled = true,
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },

                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "v", desc = "Edit init.lua", action = ":e ~/.config/nvim/init.lua" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                header = [[
██████╗ ██╗   ██╗██╗███╗   ███╗
██╔══██╗██║   ██║██║████╗ ████║
██║  ██║██║   ██║██║██╔████╔██║
██║  ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
            },

            sections = {
                { section = 'header', },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            },
            formats = {
                header = { "%s", align = "center" },
            }
        },
    },
}

return config
