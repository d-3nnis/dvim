local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup


-- TODO move me to legendary autocmds
au('TextYankPost', {
    group = ag('yank_highlight', {}),
    pattern = '*',
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

vim.api.nvim_command('colorscheme rose-pine')
vim.opt.background = 'light'
vim.cmd("hi link IlluminatedWordRead Search")
