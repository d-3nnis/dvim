"lua require('bootstrap/packer')
nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"
" local mapreader?
lua require('user.options')
lua require('user.keymaps')
lua require('plugins')
lua require('user.colourscheme')
lua require('plugins.cmp')
lua require('plugins.lsp')
lua require('plugins.telescope')

lua require('plugins/whichkey')
lua require('plugins/barbar')
"lua require('plugins/coq')


set timeoutlen=400
set linebreak

" Vim settings
"nnoremap j gj
"nnoremap k gk
set textwidth=80
" 4 spaces for a tab
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" do something smart in lua? like in https://jeffkreeftmeijer.com/vim-number/
set number relativenumber

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

