vim.opt.termguicolors = true

local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

au('TextYankPost', { group = ag('yank_highlight', {}), pattern = '*', callback = function() vim.highlight.on_yank { higroup='IncSearch', timeout=300 } end, })

local onedark = safe_require('onedark')
if onedark
then
    onedark.setup { style = 'deep' }
end
local cat = safe_require('catppuccin')
if cat
then
    vim.g.catppuccin_flavour = "latte"
    cat.setup()
    vim.api.nvim_command('colorscheme catppuccin')
else
    vim.cmd([[colorscheme everforest]])
end


