
local M = {}

M.plugins = {
    'willothy/flatten.nvim',

    
    'sharkdp/fd',


    -- TODO check me out in the future
    -- 'gen740/SmoothCursor.nvim', --TODO add arrows that change direction when moving up or down :)
    'karb94/neoscroll.nvim',
    'nvim-lualine/lualine.nvim',
    'akinsho/toggleterm.nvim',

    'lewis6991/gitsigns.nvim',

    -- TODO does window picker do anything?
    { 's1n7ax/nvim-window-picker', version = 'v1.*', },
    -- doesn't work with toggleterm
    --{ "anuvyklack/windows.nvim",
        --dependencies = {
            --"anuvyklack/middleclass",
            --"anuvyklack/animation.nvim"
        --},
    --},
    {
        'nvim-neorg/neorg',
        dependencies = "nvim-lua/plenary.nvim",
        build = ":Neorg sync-parsers",
    },

    'tamton-aquib/duck.nvim',
    'windwp/nvim-autopairs',
    'gorbit99/codewindow.nvim',

    --'mong8se/actually.nvim',  --weirdly bugged
    -- 'nvim-zh/colorful-winsep.nvim',
    'famiu/bufdelete.nvim',

    'tzachar/local-highlight.nvim',
    'folke/twilight.nvim',
    {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim'
        },
    },
    -- add more here --

    -- LSP Plugins --
    {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        "jose-elias-alvarez/null-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    -- Snippets
    'L3MON4D3/LuaSnip',             --snippet engine
    'rafamadriz/friendly-snippets', -- a bunch of snippets to use

    -- Cmp plugins
    'hrsh7th/nvim-cmp',         -- The completion plugin
    'hrsh7th/cmp-buffer',       -- buffer completions
    'hrsh7th/cmp-path',         -- path completions
    'hrsh7th/cmp-cmdline',      -- cmdline completions
    'saadparwaiz1/cmp_luasnip', -- snippet completions
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',

    -- Specific LSP extensions
    'p00f/clangd_extensions.nvim',
}

-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ] ]

-- packer.startup(function(use)
--
--     if PACKER_BOOTSTRAP then
--         require('packer').sync()
--     end
-- end)

--[[
require('plugin-configs.flatten')
require('plugin-configs/colourschemes')
require('plugin-configs/notify')
require('plugin-configs/telescope-config')
require('plugin-configs/indentline')
require('plugin-configs/mason')
require('plugin-configs/mlspconfig')
require('plugin-configs.null-ls')
require('plugin-configs/smooth-cursor')
require('plugin-configs/devicons')
require('plugin-configs/lualine')
require('plugin-configs/cmp-setup')
require('plugin-configs/toggleterm-config')
require('plugin-configs/project')
require('plugin-configs/alpha')
require('plugin-configs/gitsigns')
require('plugin-configs/window-picker')
--require('plugin-configs/windows')
require('plugin-configs/neorg')
require('plugin-configs.noice-config')
require('plugin-configs/autopairs')
require('plugin-configs.codewindow-config')
-- require('plugin-configs.winsep')
require('plugin-configs.svart')
require('plugin-configs.highlight')
require('plugin-configs.twilight')
require('plugin-configs.nav-buddy')
]]
return M
