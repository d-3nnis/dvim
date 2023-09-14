
local function hasLspInlaySupport(bufnr)
    local inlay_support = false
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.server_capabilities.inlayHintProvider ~= nil then
            -- local ft = vim.api.nvim_get_option_value('filetype', {buf = bufnr})
            -- bufnr = bufnr or vim.api.nvim_get_current_buf()
            -- if client.attached_buffers[bufnr] then
            inlay_support = true
            break
            -- end
        end
    end
    return inlay_support
end

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

        local function toggleterm_exec_cmd(count, cmd)
            return count .. "TermExec cmd='" .. cmd .. "'"
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

        local legendary = safe_require('legendary')
        legendary.setup({
            extensions = {
                nvim_tree = true,
            },
            keymaps = {
                {
                    '<C-s>',
                    '<CMD>ClangdSwitchSourceHeader<CR>',
                    description = 'Switch Header/Source',
                    mode = { 'n', 'i' }
                },
                {
                    '<C-n>',
                    function()
                        if hasLspInlaySupport() then
                            vim.lsp.inlay_hint(0, nil)
                        end
                    end,
                    description = 'Toggle inlay hint',
                    mode = { 'n', 'i' },
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
                {
                    '<C-t>g',
                    function()
                        local pwd = vim.fn.getcwd()
                        vim.cmd(toggleterm_exec_cmd(vim.v.count, 'cd ' .. pwd))
                    end,
                    description = 'Return to cwd',
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
                    { 'LspAttach' },
                    function(ev)
                        local bufnr = ev.buf
                        local augroup_name = 'lsp_augroup'
                        vim.api.nvim_create_augroup(augroup_name, { clear = true })
                        vim.api.nvim_create_autocmd("InsertEnter", {
                            buffer = bufnr,
                            callback = function()
                                if hasLspInlaySupport() then
                                    vim.lsp.inlay_hint(bufnr, true)
                                end
                            end,
                            group = augroup_name,
                        })
                        vim.api.nvim_create_autocmd("InsertLeave", {
                            buffer = bufnr,
                            callback = function()
                                if hasLspInlaySupport() then
                                    vim.lsp.inlay_hint(bufnr, false)
                                end
                            end,
                            group = augroup_name,
                        })
                    end,
                    description = 'On LSP attach',
                },
                {
                    { "VimResized" },
                    function()
                        local Job = require 'plenary.job'
                        Job:new({
                            command = "tmux",
                            args = { 'list-panes', '-F', "'#F'" },
                            env = { PATH = vim.env.PATH },
                            on_exit = function(j, return_val)
                                if return_val == 0 then
                                    local result = vim.inspect(j:result())
                                    if (string.find(result, 'Z')) then
                                        vim.g.zoomed_pane_status = 'Zoomed'
                                    else
                                        vim.g.zoomed_pane_status = ''
                                    end
                                else
                                    vim.g.zoomed_pane_status = ''
                                end
                            end,
                        }):sync()
                        return ''
                    end,
                    description = 'Save buffer when exiting or focus lost',
                },
                {
                    { "BufLeave", "FocusLost" },
                    function()
                        if not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
                            vim.api.nvim_command('silent update')
                        end
                    end,
                    description = 'Save buffer when exiting or focus lost',
                },
                {
                    { 'DirChanged' },
                    function()
                        local projects = {
                            {
                                search_string = 'spyglass',
                                name = 'spyglass',
                                icon = '',
                            },
                            {
                                search_string = 'odin',
                                name = 'odin',
                                icon = '',
                            },
                            {
                                search_string = 'rigelvii',
                                name = 'rigelvii',
                                icon = '',
                            },
                            {
                                search_string = 'nvim',
                                name = 'nvim',
                                icon = '',
                            },
                        }
                        local cwd = vim.fn.getcwd()
                        local current_project_name = ''
                        -- local current_project_color = ''
                        for _, project in pairs(projects) do
                            local search = project.search_string
                            if string.find(cwd, search) then
                                local project_name = project.name
                                local project_icon = project.icon
                                current_project_name = project_icon .. ' ' .. project_name
                                break
                            end
                        end
                        vim.g.project_config = current_project_name
                    end,
                    description = 'Updated Lualine when directory changes'
                },
                {
                    { "TextYankPost" },
                    function()
                        -- TODO the register is empty, not '+', and I'm not sure why
                        -- if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
                        if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
                            require('osc52').copy_register('+')
                        end
                    end,
                    description = 'Move all yanked text into system clipboard',
                },
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
