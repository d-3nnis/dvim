require('initial-options')
require('bootstrap')
require('globals')
require('keymaps')
local lazy_table = require('plugins')
local plugins = lazy_table.plugins
local opts = lazy_table.opts
require('lazy').setup(plugins)
require('post-plugins')
