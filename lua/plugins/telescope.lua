
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
            local actions = require('telescope.actions')

            t.setup {
                defaults = {
                    wrap_results = true,
                    mappings = {
                        n = {
                            ['<M-q>'] = false,
                            ['<C-e>'] = actions.close,
                            ['s'] = actions.smart_send_to_qflist + actions.open_qflist,
                            ['<C-a>'] = actions.smart_add_to_qflist,
                            ['o'] = actions.open_qflist,
                            ['<C-c>'] = actions.complete_tag,
                            ['CR'] = actions.file_edit,
                        },
                    },
                },
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
            }

            vim.api.nvim_create_autocmd({ "User TelescopePreviewerLoaded" }, { command = "setlocal wrap" })

            t.load_extension('ui-select')
            t.load_extension('notify')
            t.load_extension('projects')
            t.load_extension('fzf')
            t.load_extension("persisted")

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
