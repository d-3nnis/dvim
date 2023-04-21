require('initial-options')
require('bootstrap')
require('globals')
require('keymaps')
-- local lazy_table = require('plugins')
-- local plugins = lazy_table.plugins
-- local opts = lazy_table.opts
--

local lazy_config = {
}
require('lazy').setup('plugins', lazy_config)
require('lspconfig-setup')
require('post-plugins')
