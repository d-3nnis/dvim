vim.opt.termguicolors = true
vim.cmd([[colorscheme gruvbox]])

local onedark = safe_require('onedark')
if not onedark then return end

onedark.setup { style = 'deep' }
onedark.load()
