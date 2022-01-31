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
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- consider moving all the packer stuff out into a different file
packer = require 'packer'
packer.init {
  ensure_dependencies   = true, -- Should packer install plugin dependencies?
  plugin_package = 'packer', -- The default package for plugins
  max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
  auto_clean = true, -- During sync(), remove unused plugins
  compile_on_sync = true, -- During sync(), run packer.compile()
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  transitive_opt = true, -- Make dependencies of opt plugins also opt by default
  transitive_disable = true, -- Automatically disable dependencies of disabled plugins
  auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
  display = {
    non_interactive = false, -- If true, disable display windows for all operations
    open_fn  = function()
        return require('packer.util').float {border = "rounded"}
    end,
    open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
    working_sym = '⟳', -- The symbol for a plugin being installed/updated
    error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
    done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '-', -- The symbol for an unused plugin which was removed
    moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = '━', -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = 'double', -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = 'q',
      toggle_info = '<CR>',
      diff = 'd',
      prompt_revert = 'r',
    }
  },
  log = { level = 'warn' },
}

return packer.startup(function(use)
  use {
    'wbthomason/packer.nvim',
    opt = false
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'}, {"BurntSushi/ripgrep"}}
  }

  use {
    "nvim-lua/popup.nvim",
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use "numToStr/Comment.nvim" -- Easily comment stuff

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function()
            require('plugins.nvimtree').setup()
        end
    }

    use 'nvim-lualine/lualine.nvim'

  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup {
      }
    end
  }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
        require'nvim-web-devicons'.setup()
    end
  }

  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

    -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    end
  }

    use 'lewis6991/impatient.nvim'
    use "lukas-reineke/indent-blankline.nvim"

    use 'goolord/alpha-nvim'
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
  }

  use 'JoosepAlviste/nvim-ts-context-commentstring'

  --[[
  use {
    'ms-jpq/coq_nvim'
  }
  --]]
    -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  use {
    'simrat39/rust-tools.nvim',
    config = function ()
        require('rust-tools').setup({})
    end
  }

  -- Colourschemes
  -- use 'lunarvim/colorschemes'
  use 'romgrk/doom-one.vim'

  if PACKER_BOOTSTRAP then
      require('packer').sync()
  end

end)

