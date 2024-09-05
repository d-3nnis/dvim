require('initial-options')
require('bootstrap')
require('globals')
local config_path = vim.fn.expand('~/.local/local_config.lua')
local local_config_loaded = pcall(dofile, config_path)
if not local_config_loaded then
    print('No local configuration file found at ' .. config_path)
end

require('keymaps')

-- If opening from inside neovim terminal then do not load all the other plugins
if os.getenv("NVIM") ~= nil then
    require('lazy').setup {
        { 'willothy/flatten.nvim', config = true },
    }
end
local lazy_config = {}
require('lazy').setup('plugins', lazy_config)
require('post-plugins')
