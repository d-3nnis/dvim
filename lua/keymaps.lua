local function has_lsp_inlay_support(bufnr)
    if vim.version().major > 0 then
        return true
    end
    if vim.version().minor < 10 then
        return false
    end

    local inlay_support = false
    if bufnr == nil then
        bufnr = vim.api.nvim_get_current_buf()
    end

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.server_capabilities.inlayHintProvider ~= nil then
            inlay_support = true
            break
        end
    end
    return inlay_support
end

local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map({ 'n', 'i' }, '<C-s>', '<CMD>ClangdSwitchSourceHeader<CR>', 'Switch Header/Source')
map({ 'n', 'i' }, '<C-n>', function()
    if has_lsp_inlay_support() then
        vim.lsp.inlay_hint(0, nil)
    end
end, 'Toggle inlay hint')

map('c', '<C-k>', '<C-p>', 'Previous command')
map('c', '<C-j>', '<C-n>', 'Next command')

map('n', '<C-Up>', '<CMD>resize +2<CR>', 'Resize +2')
map('n', '<C-Down>', '<CMD>resize -2<CR>', 'Resize -2')
map('n', '<C-Right>', '<CMD>vertical resize +2<CR>', 'Vertical resize +2')
map('n', '<C-Left>', '<CMD>vertical resize -2<CR>', 'Vertical resize -2')

map('n', 'tb', '<CMD>ToggleBackground<CR>', 'Toggle background colour')

map({ 'n', 'v', 'x', 'o' }, 'j', function()
    if vim.v.count == 0 then
        vim.cmd('norm! gj')
    else
        vim.cmd(string.format('norm! %dj', vim.v.count))
    end
end, 'Line wrap aware move down')

map({ 'n', 'v', 'x', 'o' }, 'k', function()
    if vim.v.count == 0 then
        vim.cmd('norm! gk')
    else
        vim.cmd(string.format('norm! %dk', vim.v.count))
    end
end, 'Line wrap aware move up')

map('v', 'J', ":m '>+1<CR>gv=gv", 'Move visual range down')
map('v', 'K', ":m '<-2<CR>gv=gv", 'Move visual range up')
map('n', 'J', 'mzJ`z', 'Collapse lines with cursor holding place')

map('n', 'n', 'nzzzv', 'Centered forward search')
map('n', 'N', 'Nzzzv', 'Centered backwards search')
map('n', 'Q', '<nop>', 'Delete me')

map('n', '<F5>', '<CMD>lprev<CR>', 'Previous loclist entry')
map('n', '<F6>', '<CMD>lnext<CR>', 'Next loclist entry')
map('n', '<F7>', '<CMD>cprev<CR>', 'Previous QFList entry')
map('n', '<F8>', '<CMD>cnext<CR>', 'Next QFList entry')

map('n', 'c', '"_c', "Don't pollute unnamed register when ciw")
