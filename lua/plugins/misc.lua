local config = {
    'p00f/clangd_extensions.nvim',
    'famiu/bufdelete.nvim',
    'https://gitlab.com/madyanov/svart.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'HiPhish/nvim-ts-rainbow2',
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

}
return config
