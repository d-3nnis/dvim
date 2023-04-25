
local M = {}

M.plugins = {
    'willothy/flatten.nvim',

    'sharkdp/fd',

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
    'gorbit99/codewindow.nvim',

    --'mong8se/actually.nvim',  --weirdly bugged
    -- 'nvim-zh/colorful-winsep.nvim',

    'tzachar/local-highlight.nvim',
    -- add more here --

    -- LSP Plugins --
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     "jay-babu/mason-null-ls.nvim",
    -- },

    -- Specific LSP extensions
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
