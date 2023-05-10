-- local wk = safe_require('plugin-configs/whichkey')
-- if not wk then return end
-- local keymap = vim.api.nvim_set_keymap

local config = {
    'mrjones2014/legendary.nvim',
    dependencies = {
        'kkharji/sqlite.lua',
    },
    config = function()
        local vmap = vim.keymap.set
        local opts = {}

        local function toggleterm(count, direction)
            local size = 0
            if direction == 'horizontal' then
                size = 15
            elseif direction == 'vertical' then
                size = vim.o.columns * 0.4
            end
            return count .. 'ToggleTerm size=' .. size .. ' dir=git_dir direction=' .. direction
        end

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

        local lsp_telescope_opts = {
            initial_mode = 'normal'
        }
        local legendary = safe_require('legendary')
        legendary.setup({
            extensions = {
                nvim_tree = true,
            },
            keymaps = {
                { '<C-h>', '<C-w>h', description = 'Go to left window' },
                { '<C-j>', '<C-w>j', description = 'Go to down window' },
                { '<C-k>', '<C-w>k', description = 'Go to up window' },
                { '<C-l>', '<C-w>l', description = 'Go to right window' },
                {
                    '<C-s>',
                    '<CMD>ClangdSwitchSourceHeader<CR>',
                    description = 'Switch Header/Source',
                    mode = { 'n', 'i' }
                },
                { '<S-h>',    '<CMD>BufferLineCyclePrev<CR>', description = 'Previous buffer' },
                { '<S-l>',    '<CMD>BufferLineCycleNext<CR>', description = 'Next buffer' },
                { '<C-[>',    '<CMD>BufferLineMovePrev<CR>',  description = 'Move tab left' },
                { '<C-]>',    '<CMD>BufferLineMoveNext<CR>',  description = 'Move tab right' },
                { '<C-Up>',   '<CMD>resize +2<CR>',           description = 'Resize +2' },
                { '<C-Down>', '<CMD>resize -2<CR>',           description = 'Resize -2' },
                {
                    '<C-Right>',
                    '<CMD>vertical resize +2<CR>',
                    description = 'Vertical resize +2'
                },
                {
                    '<C-Left>',
                    '<CMD>vertical resize -2<CR>',
                    description = 'Vertical resize -2'
                },
                {
                    '<C-t>f',
                    function() vim.cmd(toggleterm(vim.v.count, 'float')) end,
                    description = 'Open floating terminal',
                },
                {
                    '<C-t>s',
                    function() vim.cmd(toggleterm(vim.v.count, 'horizontal')) end,
                    description = 'Open horizontal terminal'
                },
                {
                    '<C-t>v',
                    function() vim.cmd(toggleterm(vim.v.count, 'vertical')) end,
                    description = 'Open vertical terminal',
                },
                { 'tb', '<CMD>ToggleBackground<CR>', description = 'Toggle background colour' },
                {
                    'j',
                    function()
                        if vim.v.count == 0 then
                            vim.cmd('norm! gj')
                        else
                            vim.cmd(string.format('norm! %dj', vim.v.count))
                        end
                    end,
                    description = 'Line wrap aware move down',
                    mode = { 'n', 'v', 'x', 'o' },
                },
                {
                    'k',
                    function()
                        if vim.v.count == 0 then
                            vim.cmd('norm! gk')
                        else
                            vim.cmd(string.format('norm! %dk', vim.v.count))
                        end
                    end,
                    description = 'Line wrap aware move up',
                    mode = { 'n', 'v', 'x', 'o' }
                },
                {
                    "S",
                    "<Cmd>SvartRegex<CR>",
                    description = 'Svart regex search',
                    mode = {
                        'n', 'x', 'o' }
                },
                {
                    "gs",
                    "<Cmd>SvartRepeat<CR>",
                    description = 'Svart search repeat',
                    mode = {
                        'n', 'x', 'o' }
                },
                { "J",  ":m '>+1<CR>gv=gv",          description = 'Move visual range down',  mode = { 'v' } },
                { "K",  ":m '<-2<CR>gv=gv",          description = 'Move visual range up',    mode = { 'v' } },
                {
                    "J",
                    "mzJ`z",
                    description = 'Collapse lines with cursor holding place',
                    mode = {
                        'n' }
                },
                -- { "<C-d>", "<C-d>zz", description = 'Centered jump down', mode = { 'n' } },
                -- { "<C-u>", "<C-u>zz", description = 'Centered jump up',   mode = { 'n' } },
                {
                    "s",
                    "<Cmd>Svart<CR>",
                    description = 'Svart search',
                    mode = {
                        'n', 'x', 'o' }
                },
                { 'n', 'nzzzv', description = 'Centered forward search',   mode = { 'n' } },
                { 'N', 'Nzzzv', description = 'Centered backwards search', mode = { 'n' } },
                { 'Q', '<nop>', description = 'Delete me',                 mode = { 'n' } },
            },
            commands = {
                {
                    '<CMD>ToggleBackground',
                    function()
                        if vim.opt.background:get() == 'dark' then
                            vim.opt.background = 'light'
                        else
                            vim.opt.background = 'dark'
                        end
                        vim.notify("Background is now: " .. vim.opt.background:get())
                    end,
                    description = 'Toggle the background colour'
                },
                {
                    '<CMD>CloseCurrentTab<CR>',
                    function()
                        safe_require('bufdelete').bufdelete(0, false);
                    end,
                    description = 'Close the current tab',
                },
                {
                    '<CMD>CloseTab<CR>',
                    function(input)
                        if input.fargs then
                            safe_require('bufdelete').bufdelete(tonumber(input.fargs[1]), false);
                        end
                    end,
                    description = 'Close the current tab',
                    unfinished = true,
                    opts = { nargs = 1 --[[ , complete = 'buffer' ]] }
                },
            },
            funcs = {

            },
            autocmds = {
                {
                    { "BufLeave", "FocusLost" },
                    function()
                        if not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
                            vim.api.nvim_command('silent update')
                        end
                    end,
                    description = 'Save buffer when exiting or focus lost',
                }

            },
            defaults_ops = {
                keymaps = { noremap = true, silent = true },
            },
            sort = {
                frecency = {
                    -- the directory to store the database in
                    db_root = string.format('%s/legendary/', vim.fn.stdpath('data')),
                    -- the maximum number of timestamps for a single item
                    -- to store in the database
                    max_timestamps = 10,
                },
            }
        })

        -- local li = safe_require('legendary.integrations.which-key')
        -- if not li then return end
        -- li.bind_whichkey(wk.whichkey_binds, wk.whichkey_opts, false)
    end,
}

return config
