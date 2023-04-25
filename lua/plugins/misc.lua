local config = {
    'p00f/clangd_extensions.nvim',
    'famiu/bufdelete.nvim',
    'https://gitlab.com/madyanov/svart.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    { 'HiPhish/nvim-ts-rainbow2', lazy = true },
    'mbbill/undotree',
    'mong8se/actually.nvim',
    {
        'tzachar/local-highlight.nvim',
        config = function()
            local hl = safe_require('local-highlight')
            if not hl then return end

            hl.setup()
                -- file_types = { 'python', 'cpp', 'lua' }
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gs = safe_require('gitsigns')
            if not gs then return end

            gs.setup {}
        end
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
                })
            end
        end
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            local tt = safe_require('toggleterm')
            if not tt then return end

            tt.setup {
                float_opts = {
                    border = 'solid'
                }
            }

            function _G.set_terminal_keymaps()
                local opts = { noremap = true }
                vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', [[<C-\><C-n><CMD>q<CR>]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-d>', [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
            end

            vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
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
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim'
        },
    },

}
return config
