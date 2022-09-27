vim.opt.termguicolors = true

local onedark = safe_require('onedark')
if not onedark then return end

onedark.setup { style = 'deep' }

vim.cmd([[colorscheme gruvbox]])
