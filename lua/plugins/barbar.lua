local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap
keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)
keymap("n", "<S-l>", ":BufferNext<CR>", opts)
keymap("n", "<S-[>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap("n", "<S-]>", "<Cmd>BufferMoveNext<CR>", opts)

