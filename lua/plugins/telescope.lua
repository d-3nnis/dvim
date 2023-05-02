local config = {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        version = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        config = function()
            local t = safe_require('telescope')
            if not t then return end

            t.setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    },
                    fzf = {},
                    frecency = {
                        db_root = "~/.local/share/nvim/",
                        show_scores = true,
                    }
                },
                -- pickers = {
                --     -- find_files = {
                --     --     find_command = { 'fd', '--no-ignore', '-E', '.git' },
                --     -- },
                -- },
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
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require "telescope".load_extension("frecency")
        end,
        dependencies = { "kkharji/sqlite.lua" },
    },
}


return config
