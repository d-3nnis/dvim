local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-gq>", "<CMD>gqq<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- There's more in keymaps.lua from neovim from scratch, 02-keymaps branch

-- keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "tt", "<cmd>Telescope live_grep<cr>", opts)

-- comments
keymap('n', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>', opts)
-- keymap('n', '<C-_>', 'gcc', opts)
-- keymap('v', '<C-_>', 'gc', opts)
-- keymap('<C-_>', 'gcc', opts)
-- keymap('v', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_blockwise()<CR>', opts)

-- keymap('t', '<C-t>', '<CMD>ToggleTerm dir=' .. '~' .. ' direction=float<CR>',opts)
local function toggleterm(direction)
    --local curdir = vim.fn.getcwd()
    local size = 0
    if direction == 'horizontal' then
        size = 15
    elseif direction == 'vertical' then
        size = vim.o.columns * 0.4
    end
    return '<CMD>ToggleTerm size=' .. size .. ' dir=git_dir direction=' .. direction .. '<CR>'
end

keymap('n', '<C-t>f', toggleterm('float'), opts)
keymap('n', '<C-t>s', toggleterm('horizontal'), opts)
keymap('n', '<C-t>v', toggleterm('vertical'), opts)

-- combine these two
keymap('n', '<A-s>', '<CMD>ClangdSwitchSourceHeader<CR>', opts)
keymap('i', '<A-s>', '<CMD>ClangdSwitchSourceHeader<CR>', opts)
