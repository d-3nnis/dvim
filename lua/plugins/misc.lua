local config = {
    {
        'p00f/clangd_extensions.nvim',
        config = function()
            safe_require('clangd_extensions').setup {
                server = {
                    -- init_options = {
                    --     compilationDatabaseDirectory = "/home/dvidovic/co/*/hlos/build/"
                    -- }
                },
                extensions = {
                    autoSetHints = false,

                    inlay_hints = {
                        -- inline = vim.fn.has("nvim-0.10") == 1,
                        parameter_hints_prefix = "  ",
                        other_hints_prefix = " ",
                    }
                }
            }
        end,
    },
    {
        'Badhi/nvim-treesitter-cpp-tools',
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            safe_require('nt-cpp-tools').setup({})
        end
    },
    'famiu/bufdelete.nvim',
    'https://gitlab.com/madyanov/svart.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    {
        'tzachar/local-highlight.nvim',
        config = function()
            safe_require('local-highlight').setup()
            -- file_types = { 'python', 'cpp', 'lua' }
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'windwp/nvim-autopairs',
        config = function()
            local ap = safe_require('nvim-autopairs')
            if not ap then return end

            ap.setup {
                disable_filetype = { "TelescopePrompt" },
                check_ts = true,
            }
        end
    },
    {
        'karb94/neoscroll.nvim',
        config = function()
            local ns = safe_require("neoscroll")
            if ns then
                ns.setup({
                    easing_function = "sine",
                    hide_cursor = false,
                })
            end
        end
    },
    {
        'folke/twilight.nvim',
        config = function()
            local twilight = safe_require("twilight")
            if not twilight then return end
            twilight.setup({
                dimming = {
                    alpha = 0.25, -- amount of dimming
                    -- we try to get the foreground from the highlight groups or fallback color
                    color = { "Normal", "#ffffff" },
                    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                    inactive = true,     -- when true, other windows will be fully dimmed (unless they contain the same buffer)
                },
                context = 20,            -- amount of lines we will try to show around the current line
                exclude = {},            -- exclude these filetypes
            })
        end
    },
    {
        'ojroques/nvim-osc52',
        config = function()
            require('osc52').setup({})
        end
    },
    { "KostkaBrukowa/definition-or-references.nvim" },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",

        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
}
return config
