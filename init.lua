require('initial-options')
require('bootstrap')
require('globals')
require('keymaps')

-- If opening from inside neovim terminal then do not load all the other plugins
if os.getenv("NVIM") ~= nil then
    require('lazy').setup {
        {'willothy/flatten.nvim', config = true },
    }
    return
end
local lazy_config = {
}
require('lazy').setup('plugins', lazy_config)
require('lspconfig-setup')
require('post-plugins')
