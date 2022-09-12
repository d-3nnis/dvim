"lua require('bootstrap/packer')
nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = ";"
lua require('user.options')
lua require('user.keymaps')

lua require('plugins')
lua require('user.colourscheme')
lua require('plugins.cmp')
lua require('plugins.lsp')
lua require('plugins.telescope')
lua require('plugins.treesitter')
lua require('plugins.comment')
lua require('plugins.nvimtree')
lua require('plugins.lualine')
lua require('plugins.project')
lua require('plugins.impatient')
lua require('plugins.indentline')
lua require('plugins.alpha')
lua require('plugins.gitsigns')
lua require('plugins.whichkey')
lua require('plugins.barbar')
lua require('plugins.toggleterm')

set linebreak

" Vim settings
" do something smart in lua? like in https://jeffkreeftmeijer.com/vim-number/
set number relativenumber

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

