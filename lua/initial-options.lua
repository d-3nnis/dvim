--local o = vim.o
local o = vim.opt

-- LEADER --
vim.g.mapleader = " "
o.timeoutlen = 300
o.updatetime = 300

-- File Management --
o.fileencoding = "utf-8"
o.undofile = true
o.swapfile = false

-- Buffer Options --
o.splitbelow = true
o.splitright = true
-- TODO add autocmd for buffer reload update

-- Indentation --
o.smartcase = true
o.ignorecase = true
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.title = true
o.cursorline = true

-- Visual Options --
o.cmdheight = 2
o.termguicolors = true
o.scrolloff = 8
o.sidescrolloff = 8
o.textwidth = 120
o.formatoptions = "cq"
o.list = true

-- Misc Options --
o.clipboard = "unnamedplus"
o.number = true
o.mouse = 'a'
--vim.cmd([[colorscheme gruvbox]])
