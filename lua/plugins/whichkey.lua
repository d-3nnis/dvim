local function search_buffers()
    require('fzf-lua').buffers()
end

local config = {
    {
        'folke/which-key.nvim',
        lazy = false,
        opts = {
            spec = {
                { '<leader>q', '<CMD>qa<CR>', desc = 'Quit' },
                { '<leader>w', '<CMD>w!<CR>', desc = 'Save' },
                { '<leader>v', group = 'Focusing' },
                { '<leader>vv', '<cmd>Twilight<CR>', desc = 'Toggle focus' },
                { '<leader>s', group = 'Search everything!', icon = "🔎" },
                {
                    '<leader>st',
                    function()
                        vim.cmd('normal! zt')
                        require('fzf-lua').grep_project()
                    end,
                    desc = "Live Grep files"
                },
                {
                    '<leader>sz',
                    function()
                        require('fzf-lua').grep_cword()
                    end,
                    desc = "Grep for string under cursor",
                },
                {
                    '<leader>sg',
                    function()
                        require('fzf-lua').git_status()
                    end,
                    desc = "Git status files",
                },
                {
                    '<leader>ss',
                    function()
                        vim.cmd('normal! zt')
                        require('fzf-lua').grep()
                    end,
                },
                { '<leader>sf', group = "Specific Searches" },
                {
                    '<leader>sff',
                    function()
                        require('fzf-lua').files()
                    end,
                    desc = "Find files",
                },
                {
                    '<leader>sfb',
                    function()
                        search_buffers()
                    end,
                    desc = "Search buffers",
                },
                {
                    '<leader>sfr',
                    function()
                        require('fzf-lua').oldfiles()
                    end,
                    desc = "Recent files",
                },
                {
                    '<leader>sfk',
                    function()
                        require('fzf-lua').keymaps()
                    end,
                    desc = "Search keymaps",
                },
                {
                    '<leader>sfh',
                    function()
                        require('fzf-lua').colorschemes()
                    end,
                    desc = "Search themes",
                },
                {
                    '<leader>sfe',
                    '<cmd>Telescope projects<cr>',
                    desc = "Search projects",
                },
                {
                    '<leader>sfq',
                    function()
                        require('fzf-lua').resume()
                    end,
                    desc = "Resume previous search session",
                },
                {
                    '<leader>e',
                    group = 'File Explorer',
                },
                {
                    '<leader>ee',
                    '<CMD>Oil<CR>',
                    desc = 'Open File Tree',
                }
            }
        },
        dependencies = {
            'lewis6991/gitsigns.nvim',
        },
    },
}
--[[
        config = function()
            local whichkey_binds = {
                o = {
                    name = 'Misc',
                    q = { 'gq', 'Reformat line widths' },
                    h = { '<cmd>nohls<cr>', 'Hide search highlight' },
                    x = { '<cmd>!chmod +x %<CR>', 'chmod this file for execution' },
                    t = { '<CMD>TSContextToggle<CR>', 'Toggle Treesitter context highlighting' },
                    w = { 'ciW\'\'<ESC>P', 'Wrap WORD in quotes' },
                    r = { '<CMD>set rnu!<CR>', 'Toggle relative line numbers' },
                    p = { function() require('precognition').toggle() end, 'Toggle Precognition' },
                },
                h = {
                    name = 'Gitsigns',
                    j = { function() gs.preview_hunk() end, 'Preview Hunk' },
                    b = { function() gs.blame_line { full = true } end, 'Blame Line' },
                    S = { function() gs.stage_buffer() end, 'Stage Buffer' },
                    u = { function() gs.undo_stage_hunk() end, 'Undo Stage Hunk' },
                    s = {
                        function()
                            if (string.sub(vim.fn.mode(), 1, 1) == 'n') then
                                gs.stage_hunk()
                            elseif (string.sub(vim.fn.mode(), 1, 1) == 'v' or
                                    string.sub(vim.fn.mode(), 1, 1) == 'V') then
                                gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                            end
                        end,
                        'Stage Hunk',
                        mode = { 'v', 'n' }
                    },
                    r = {
                        function()
                            if (vim.fn.visualmode() == '') then
                                gs.reset_hunk()
                            else
                                gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                            end
                        end,
                        'Reset Hunk',
                        mode = { 'v', 'n' }
                    },
                    R = { '<CMD>Gitsigns reset_buffer<CR>', 'Reset Buffer' },
                    d = { function()
                        gs.diffthis()
                    end, 'Diff against index' },
                    D = { function()
                        gs.diffthis('~')
                    end, 'Diff against last commit' },
                    c = { '<CMD>diffoff<CR>', 'Cancel diff' },
                    t = {
                        name = 'To[ggle]',
                        b = { function() gs.toggle_current_line_blame() end, 'Toggle Line Blame' },
                        i = { function()
                            vim.cmd('Gitsigns toggle_linehl')
                            vim.cmd('Gitsigns toggle_numhl')
                            vim.cmd('Gitsigns toggle_word_diff')
                        end, 'Toggle Line Highlighting' },
                        d = { gs.toggle_deleted, 'Toggle showing deleted hunks' }
                    },
                },
                t = {
                    name = 'CopilotChat',
                    e = { '<CMD>CopilotChatExplain<CR>', 'CopilotChat - Explain the selected text' },
                    f = { '<CMD>CopilotChatFix<CR>', 'CopilotChat - Provide a fix for the selected text' },
                    d = { '<CMD>CopilotChatFixDiagnostic<CR>', 'CopilotChat - Provide a fix for the selected diagnostic error' },
                    mode = 'v',
                },
                ['c'] = { function() require('bufdelete').bufdelete(0) end, 'Close Buffer' },
                ['n'] = { '<CMD>Navbuddy<CR>', 'Open Navbuddy' },
                ['f'] = { '<CMD>Legendary<CR>', 'Open command legend' },
                ['u'] = { function() require('undotree').toggle() end, 'Toggle undo tree' },
                ['p'] = { ''_dP', 'Paste without overwrite', mode = 'x' },
                ['x'] = { ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
                    'Search and replace with text under cursor' },
                ['b'] = { function() search_buffers() end, 'Open buffers' },
            }

            local whichkey_opts = {
                mode = 'n',
                prefix = '<leader>',
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }

            wk.setup {
                disable = {
                    filetypes = { 'TelescopePrompt' }
                }
            }

            wk.register(whichkey_binds, whichkey_opts)

        end,
--]]

return config
