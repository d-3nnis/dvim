-- Setup and functions --

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local function toggleterm(direction)
    local size = 0
    if direction == 'horizontal' then
        size = 15
    elseif direction == 'vertical' then
        size = vim.o.columns * 0.4
    end
    return '<CMD>ToggleTerm size=' .. size .. ' dir=git_dir direction=' .. direction .. '<CR>'
end

function toggle_background()
    if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
    vim.notify("Background is now: " .. vim.opt.background:get())
end

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- TODO check for barbar
keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)
keymap("n", "<S-l>", ":BufferNext<CR>", opts)
keymap("n", "<S-[>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap("n", "<S-]>", "<Cmd>BufferMoveNext<CR>", opts)

-- Buffer resize
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Toggle term
-- TODO check for tt
keymap('n', '<C-t>f', toggleterm('float'), opts)
keymap('n', '<C-t>s', toggleterm('horizontal'), opts)
keymap('n', '<C-t>v', toggleterm('vertical'), opts)

-- LSP
keymap('n', '<C-s>', '<CMD>ClangdSwitchSourceHeader<CR>', opts)
keymap('i', '<C-s>', '<CMD>ClangdSwitchSourceHeader<CR>', opts)
-- Displays hover information about the symbol under the cursor
keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

-- Jump to the definition
keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

-- Jump to declaration
keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

-- Lists all the implementations for the symbol under the cursor
keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

-- Jumps to the definition of the type symbol
keymap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

-- Lists all the references
keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

-- Displays a function's signature information
--keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

-- Renames all references to the symbol under the cursor
keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

-- Selects a code action available at the current cursor position
keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
keymap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', opts)

-- Move to the previous diagnostic
keymap('n', 'gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

-- Move to the next diagnostic
keymap('n', 'gj', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

-- Colourscheme
keymap('n', 'tb', '<cmd>toggle_background()<CR>', opts)

keymap('n', '<C-w>z', '<cmd>WindowsMaximize<CR>', opts)
keymap('n', '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>', opts)
keymap('n', '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>', opts)
keymap('n', '<C-w>=', '<cmd>WindowsEqualize<CR>', opts)
