
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup


-- TODO move me to legendary autocmds
au('TextYankPost', { group = ag('yank_highlight', {}), pattern = '*',
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

    vim.api.nvim_command('colorscheme everforest')
    vim.opt.background = 'light'
    vim.cmd("hi link IlluminatedWordRead Search")
-- local cs = safe_require('zenbones')
-- if cs then
--     vim.opt.background = 'light'
--     vim.api.nvim_command('colorscheme zenbones')
--     vim.api.nvim_command('colorscheme everforest')
--     vim.cmd("hi link IlluminatedWordRead Search")
-- else
--     vim.api.nvim_command([[colorscheme everforest]])
-- end
