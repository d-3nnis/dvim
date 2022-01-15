local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.bufferline = {
    animation = true,
    clickable = true,
    icons = true
}

local keymap = vim.api.nvim_set_keymap
keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)
keymap("n", "<S-l>", ":BufferNext<CR>", opts)
