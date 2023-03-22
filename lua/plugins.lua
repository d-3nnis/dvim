local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local packer = safe_require('packer')
if not packer then return end

packer.init {
    ensure_dependencies  = true, -- Should packer install plugin dependencies?
    plugin_package       = 'packer', -- The default package for plugins
    max_jobs             = nil, -- Limit the number of simultaneous jobs. nil means no limit
    auto_clean           = true, -- During sync(), remove unused plugins
    compile_on_sync      = true, -- During sync(), run packer.compile()
    opt_default          = false, -- Default to using opt (as opposed to start) plugins
    transitive_opt       = true, -- Make dependencies of opt plugins also opt by default
    transitive_disable   = true, -- Automatically disable dependencies of disabled plugins
    auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
    display              = {
        non_interactive = false, -- If true, disable display windows for all operations
        open_fn         = function()
            return require('packer.util').float { border = "rounded" }
        end,
        open_cmd        = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
        working_sym     = '⟳', -- The symbol for a plugin being installed/updated
        error_sym       = '✗', -- The symbol for a plugin with an error in installation/updating
        done_sym        = '✓', -- The symbol for a plugin which has completed installation/updating
        removed_sym     = '-', -- The symbol for an unused plugin which was removed
        moved_sym       = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym      = '━', -- The symbol for the header line in packer's display
        show_all_info   = true, -- Should packer show all update details automatically?
        prompt_border   = 'double', -- Border style of prompt popups.
        keybindings     = { -- Keybindings for the display window
            quit = 'q',
            toggle_info = '<CR>',
            diff = 'd',
            prompt_revert = 'r',
        }
    },
    log                  = { level = 'warn' },
}


packer.startup(function(use)
    use {
        'wbthomason/packer.nvim',
        opt = false
    }

    use {
        'willothy/flatten.nvim',
    }

    use({
        'mrjones2014/legendary.nvim',
        requires = 'kkharji/sqlite.lua',
    })

    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "MunifTanjim/nui.nvim"

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-context'
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'folke/which-key.nvim'
    use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'sharkdp/fd'
    use { 'ibhagwan/fzf-lua',
        -- optional for icon support
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

    use 'lukas-reineke/indent-blankline.nvim'
    use 'rcarriga/nvim-notify'

    -- TODO check me out in the future
    -- use 'gen740/SmoothCursor.nvim' --TODO add arrows that change direction when moving up or down :)
    use 'karb94/neoscroll.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/toggleterm.nvim'
    use 'numToStr/Comment.nvim'
    use 'ahmedkhalf/project.nvim'
    use 'goolord/alpha-nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'lewis6991/impatient.nvim'
    use { 's1n7ax/nvim-window-picker', tag = 'v1.*', }
    -- doesn't work with toggleterm
    --[[
    use { "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
    }
    --]]
    use {
        'nvim-neorg/neorg',
        requires = "nvim-lua/plenary.nvim",
        run = ":Neorg sync-parsers",
    }
    use({
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    })

    use 'tamton-aquib/duck.nvim'
    use 'windwp/nvim-autopairs'
    use 'gorbit99/codewindow.nvim'

    --use 'mong8se/actually.nvim'  --weirdly bugged
    -- use 'nvim-zh/colorful-winsep.nvim'
    use 'https://gitlab.com/madyanov/svart.nvim'
    use 'famiu/bufdelete.nvim'
    use 'HiPhish/nvim-ts-rainbow2'

    use { 'gennaro-tedesco/nvim-possession',
        dependencies = {
            'ibhagwan/fzf-lua',
        },
    }

    use 'tzachar/local-highlight.nvim'
    use 'folke/twilight.nvim'
    -- add more here --

    -- LSP Plugins --
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        "jose-elias-alvarez/null-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
    }
    -- Snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- Cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- Specific LSP extensions
    use 'p00f/clangd_extensions.nvim'

    -- Colourschemes
    use 'ellisonleao/gruvbox.nvim'
    use 'sainnhe/everforest'
    use 'navarasu/onedark.nvim'
    use {
        "catppuccin/nvim",
        as = "catppuccin",
    }
    use 'rose-pine/neovim'
    use {
        'mcchrish/zenbones.nvim',
        requires = 'rktjmp/lush.nvim'
    }
    use {
        'uloco/bluloco.nvim',
        requires = 'rktjmp/lush.nvim'
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

safe_require('impatient').enable_profile()
require('plugin-configs.flatten')
require('plugin-configs/colourschemes')
require('plugin-configs/notify')
require('plugin-configs/telescope')
require('plugin-configs/treesitter')
require('plugin-configs/whichkey')
require('plugin-configs/legendary')
require('plugin-configs/neotree')
require('plugin-configs/bufferline')
require('plugin-configs/indentline')
require('plugin-configs/mason')
require('plugin-configs/mlspconfig')
require('plugin-configs.null-ls')
require('plugin-configs/smooth-cursor')
require('plugin-configs/devicons')
require('plugin-configs/lualine')
require('plugin-configs/cmp-setup')
require('plugin-configs/toggleterm')
require('plugin-configs/project')
require('plugin-configs/alpha')
require('plugin-configs/gitsigns')
require('plugin-configs/comment')
require('plugin-configs/window-picker')
--require('plugin-configs/windows')
require('plugin-configs/neorg')
require('plugin-configs.noice')
require('plugin-configs/autopairs')
require('plugin-configs.codewindow')
-- require('plugin-configs.winsep')
require('plugin-configs.svart')
require('plugin-configs.possession')
require('plugin-configs.highlight')
require('plugin-configs.twilight')
