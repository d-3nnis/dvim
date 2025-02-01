local config = {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        version = '0.1.8',
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
                            ['<Down>'] = false,
                            ['<Up>'] = false,
                            ['L'] = false,
                            ['M'] = false,
                            ['H'] = false,
                            ['<PageDown>'] = false,
                            ['<PageUp>'] = false,
                            ['<C-X>'] = false,
                            ['<C-T>'] = false,
                            ['<C-V>'] = false,
                            ['<C-Q>'] = false,
                            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_previous,
                            ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
                            ['q'] = actions.close,
                            -- ['s'] = actions.smart_send_to_qflist + actions.open_qflist,
                            ['<C-a>'] = actions.smart_send_to_loclist + actions.open_loclist,
                            -- ['o'] = actions.open_qflist,
                            -- ['<C-c>'] = actions.complete_tag,
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
                        show_scores = true,
                        auto_validate = false,
                    }
                },
            }


            t.load_extension('ui-select')
            t.load_extension('notify')
            t.load_extension('projects')
            t.load_extension('fzf')
            t.load_extension("termfinder")

            local noice = safe_require('noice')
            if noice then
                t.load_extension('noice')
            end

            vim.api.nvim_create_autocmd("User", { pattern = "TelescopePreviewerLoaded", command = "setlocal wrap" })
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
    },
}


return config
