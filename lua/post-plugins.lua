vim.opt.termguicolors = true

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


