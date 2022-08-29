local status_ok, tt = pcall(require, "toggleterm")
if not status_ok then
  return
end

tt.setup {
    float_opts = {
        border = 'curved'
    }
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
    -- I would like this to work differently, if there is already a terminal open, it should just close,
    -- but currently it will still check which one to close, using float or split.
    -- some kind of function
  vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', [[<C-\><C-n><CMD>q<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-d>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
