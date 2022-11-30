local legend = safe_require('legendary')
if not legend then return end
local wk = safe_require('plugin-configs/whichkey')
if not wk then return end

local keymap = vim.api.nvim_set_keymap
local vmap = vim.keymap.set
local opts = {}

local function toggleterm(direction)
    local size = 0
    if direction == 'horizontal' then
        size = 15
    elseif direction == 'vertical' then
        size = vim.o.columns * 0.4
    end
    return '<CMD>ToggleTerm size=' .. size .. ' dir=git_dir direction=' .. direction .. '<CR>'
end

local function toggle_background()
    if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
    vim.notify("Background is now: " .. vim.opt.background:get())
end

-- TODO check for barbar
local bl = safe_require('bufferline')

-- if bl then
--     keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)
--     keymap("n", "<S-l>", ":BufferNext<CR>", opts)
--     { '<S-[>', '<Cmd>BufferMovePrevious<CR>', description = '', mode = { 'n' } }
--     { '<S-]>', '<Cmd>BufferMoveNext<CR>', description = '', mode = { 'n' } }
-- else
-- end

-- Buffer resize

-- Toggle term
-- LSP


-- Displays a function's signature information


-- gitsigns
local gs = safe_require("gitsigns")
if gs then
    vmap('n', '<C-g>j', function()
        if vim.wo.diff then return '<C-g>j' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, opts)
    vmap('n', '<C-g>k', function()
        if vim.wo.diff then return '<C-g>k' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, opts)
end

local svt = safe_require('svart')
if svt then
    vmap({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>") -- begin exact search
    vmap({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>") -- begin regex search
    vmap({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>") -- repeat with last accepted query
end

-- Colourscheme
vmap('n', 'tb', function() toggle_background() end, opts)

-- local win = safe_require('windows')
-- if win then
--     keymap('n', '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>', opts)
--     keymap('n', '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>', opts)
--     keymap('n', '<C-w>=', '<cmd>WindowsEqualize<CR>', opts)
-- end


legend.setup({
    keymaps = {
        { '<C-h>', '<C-w>h', description = 'Go to left window' },
        { '<C-j>', '<C-w>j', description = 'Go to down window' },
        { '<C-k>', '<C-w>k', description = 'Go to up window' },
        { '<C-l>', '<C-w>l', description = 'Go to right window' },
        { '<C-s>', '<CMD>ClangdSwitchSourceHeader<CR>', description = 'Switch Header/Source', mode = { 'n', 'i' } },
        { 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', description = 'LSP Show Hover Field', mode = { 'n' } },
        { 'gl', '<cmd>lua vim.lsp.buf.signature_help()<cr>', description = '', mode = { 'n' } },
        { 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', description = 'Go to definition', mode = { 'n' } },
        { 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', description = 'Go to declaration', mode = { 'n' } },
        { 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', description = 'Go to implementation', mode = { 'n' } },
        { 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', description = 'Type definition', mode = { 'n' } },
        { 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', description = 'Show references', mode = { 'n' } },
        { 'gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', description = 'Go to previous LSP diagnostic', mode = { 'n' } },
        { 'gj', '<cmd>lua vim.diagnostic.goto_next()<cr>', description = 'Go to next LSP diagnostic', mode = { 'n' } },
        { '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', description = 'Buffer rename', mode = { 'n' } },
        { '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', description = 'Code action', mode = { 'n' } },
        { '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', description = 'Range code action', mode = { 'x' } },
        { 'f', '<cmd>lua vim.lsp.buf.format({insertFinalNewline = false})<cr>', description = 'Format range', mode = { 'v' } },
        { '<S-h>', '<CMD>BufferLineCyclePrev<CR>', description = 'Previous buffer', mode = { 'n' } },
        { '<S-l>', '<CMD>BufferLineCycleNext<CR>', description = 'Next buffer', mode = { 'n' } },
        { '<C-[>', '<CMD>BufferLineMovePrev<CR>', description = 'Move tab left', mode = { 'n' } },
        { '<C-]>', '<CMD>BufferLineMoveNext<CR>', description = 'Move tab right', mode = { 'n' } },

        { '<C-Up>', '<CMD>resize +2<CR>', description = 'Resize +2', mode = { 'n' } },
        { '<C-Down>', '<CMD>resize -2<CR>', description = 'Resize -2', mode = { 'n' } },
        { '<C-Right>', '<CMD>vertical resize +2<CR>', description = 'Vertical resize +2', mode = { 'n' } },
        { '<C-Left>', '<CMD>vertical resize -2<CR>', description = 'Vertical resize -2', mode = { 'n' } },
        { '<C-t>f', toggleterm('float'), description = 'Open floating terminal', mode = { 'n' } },
        { '<C-t>s', toggleterm('horizontal'), description = 'Open horizontal terminal', mode = { 'n' } },
        { '<C-t>v', toggleterm('vertical'), description = 'Open vertical terminal', mode = { 'n' } },

    },
    commands = {

    },
    functions = {
        { function(testval)
            print(testval)
        end, description = "testval" }
    },
    defaults_ops = {
        keymaps = { noremap = true, silent = true },
    }
})

local li = safe_require('legendary.integrations.which-key')
if not li then return end
li.bind_whichkey(wk.whichkey_binds, wk.whichkey_opts, false)
