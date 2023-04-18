
local M = {}

M.plugins = {
    'willothy/flatten.nvim',
    {
        'mrjones2014/legendary.nvim',
        dependencies = {

            'kkharji/sqlite.lua',
        },
        config = function() 
local ret = require('plugin-configs/legendary')
local legend = safe_require('legendary')
            legend.setup(ret.config)
        end
    },

    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require('plugin-configs/neotree')
        end
    },

    { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
require('plugin-configs/treesitter')
    end},
    'nvim-treesitter/nvim-treesitter-context',
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies =  {"nvim-treesitter"},
    },
    'JoosepAlviste/nvim-ts-context-commentstring',
    { 'folke/which-key.nvim',
    config = function()
        require('plugin-configs/whichkey')
    end,
    },

    { 'akinsho/bufferline.nvim',
        config = function()
            require('plugin-configs/bufferline')
        end,
        dependencies = 'nvim-tree/nvim-web-devicons', },

    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    'sharkdp/fd',
    { 'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    'nvim-telescope/telescope-ui-select.nvim',
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require "telescope".load_extension("frecency")
        end,
        dependencies = { "kkharji/sqlite.lua" },
    },
    { 'nvim-telescope/telescope.nvim',
    version = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
},

    'lukas-reineke/indent-blankline.nvim',
    'rcarriga/nvim-notify',

    -- TODO check me out in the future
    -- 'gen740/SmoothCursor.nvim', --TODO add arrows that change direction when moving up or down :)
    'karb94/neoscroll.nvim',
    'nvim-lualine/lualine.nvim',
    'akinsho/toggleterm.nvim',
    { 'numToStr/Comment.nvim',
config = function()
    local cfg = require('plugin-configs/comment')
    require('Comment').setup(cfg)
end
} ,
    'ahmedkhalf/project.nvim',
    'goolord/alpha-nvim',
    'lewis6991/gitsigns.nvim',
    'lewis6991/impatient.nvim',

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
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require('plugin-configs.noice-config')
        end,
    },

    'tamton-aquib/duck.nvim',
    'windwp/nvim-autopairs',
    'gorbit99/codewindow.nvim',

    --'mong8se/actually.nvim',  --weirdly bugged
    -- 'nvim-zh/colorful-winsep.nvim',
    'https://gitlab.com/madyanov/svart.nvim',
    'famiu/bufdelete.nvim',
    'HiPhish/nvim-ts-rainbow2',

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
        'williamboman/mason.nvim',
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

    -- Colourschemes
    'ellisonleao/gruvbox.nvim',
    'sainnhe/everforest',
    'navarasu/onedark.nvim',
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },
    'rose-pine/neovim',
    {
        'mcchrish/zenbones.nvim',
        dependencies = 'rktjmp/lush.nvim',
    },
    {
        'uloco/bluloco.nvim',
        dependencies = 'rktjmp/lush.nvim',
    },
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
safe_require('impatient').enable_profile()
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
