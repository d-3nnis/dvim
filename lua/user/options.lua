-- :help options
local opt = vim.opt
vim.opt.cmdheight = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false
vim.opt.timeoutlen = 100                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300
vim.opt.termguicolors = true

opt.smartcase = true
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.smarttab = true
opt.title = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.textwidth = 100
opt.formatoptions = "cq"
