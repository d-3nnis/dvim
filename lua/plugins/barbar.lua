local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--map('n', '<S-h>', ':BufferPrevious<cr>', opts)
--map('n', '<S-l>', ':BufferNext<cr>', opts)

vim.g.bufferline = {
    animation = true,
    clickable = true,
    icons = true
}

