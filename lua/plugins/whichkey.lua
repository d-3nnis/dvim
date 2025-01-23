local function search_buffers()
    require('fzf-lua').buffers()
end

local config = {
    {
        'folke/which-key.nvim',
        lazy = false,
        opts = {
            icons = {
                mappings = false,
            },
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
                    desc = "Grep for the word under cursor",
                },
                {
                    '<leader>sZ',
                    function()
                        require('fzf-lua').grep_cWORD()
                    end,
                    desc = "Grep for the WORD under cursor",
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
                    desc = "Normal grep"
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
                    '<leader>sb',
                    function()
                        search_buffers()
                    end,
                    desc = "Search buffers",
                },
                {
                    '<leader>sr',
                    function()
                        require('fzf-lua').oldfiles()
                    end,
                    desc = "Recent files",
                },
                {
                    '<leader>sk',
                    function()
                        require('fzf-lua').keymaps()
                    end,
                    desc = "Search keymaps",
                },
                {
                    '<leader>sh',
                    function()
                        require('fzf-lua').colorschemes()
                    end,
                    desc = "Search themes",
                },
                {
                    '<leader>se',
                    function()
                        local projects_list = require('project_nvim').get_recent_projects()
                        local fzf_lua = require('fzf-lua')
                        fzf_lua.fzf_exec(projects_list,
                            {
                                actions = {
                                    ['default'] = function(selected, _)
                                        local picked = selected[1]
                                        if vim.fn.isdirectory(picked) == 1 then
                                            fzf_lua.files({ cwd = picked })
                                        else
                                            print('Project path does not exist: ' .. picked)
                                        end
                                    end,
                                }
                            }
                        )
                    end,
                    desc = "Search projects",
                },
                {
                    '<leader>sq',
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
                },
                { '<leader>h', group = 'Gitsigns', icon = "" },
                { '<leader>hj', function() require('gitsigns').preview_hunk() end, desc = 'Preview Hunk', },
                { '<leader>hb', function() require('gitsigns').blame_line { full = true } end, desc = 'Blame Line', },
                { '<leader>hS', function() require('gitsigns').stage_buffer() end, desc = 'Stage Buffer', },
                { '<leader>hu', function() require('gitsigns').undo_stage_hunk() end, desc = 'Undo Stage Hunk', },
                {
                    '<leader>hs',
                    function()
                        if (string.sub(vim.fn.mode(), 1, 1) == 'n') then
                            require('gitsigns').stage_hunk()
                        elseif (string.sub(vim.fn.mode(), 1, 1) == 'v' or
                                string.sub(vim.fn.mode(), 1, 1) == 'V') then
                            require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                        end
                    end,
                    desc = 'Stage Hunk',
                    mode = { 'v', 'n' },
                },
                {
                    '<leader>hr',
                    function()
                        if (vim.fn.visualmode() == '') then
                            require('gitsigns').reset_hunk()
                        else
                            require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                        end
                    end,
                    desc = 'Reset Hunk',
                    mode = { 'v', 'n' },
                },
                { '<leader>hR', '<CMD>Gitsigns reset_buffer<CR>', desc = 'Reset Buffer', },
                { '<leader>hd', function() require('gitsigns').diffthis() end, desc = 'Diff against index', },
                { '<leader>hD', function() require('gitsigns').diffthis('~') end, desc = 'Diff against last commit', },
                { '<leader>hc', '<CMD>diffoff<CR>', desc = 'Cancel diff', },
                { '<leader>ht', group = 'Gitsigns toggles', icon = "" },
                { '<leader>htb', function() require('gitsigns').toggle_current_line_blame() end, desc = 'Toggle Line Blame', },
                {
                    '<leader>hti',
                    function()
                        vim.cmd('Gitsigns toggle_linehl')
                        vim.cmd('Gitsigns toggle_numhl')
                        vim.cmd('Gitsigns toggle_word_diff')
                    end,
                    desc = 'Toggle Line Highlighting',
                },
                { '<leader>htd', function() require('gitsigns').toggle_deleted() end, desc = 'Toggle showing deleted hunks', },
                { '<leader>o', group = 'Misc', icon = "" },
                { '<leader>oq', 'gq', desc = 'Reformat line widths', },
                { '<leader>oh', '<cmd>nohls<cr>', desc = 'Hide search highlight', },
                { '<leader>ox', '<cmd>!chmod +x %<CR>', desc = 'chmod this file for execution', },
                { '<leader>ot', '<CMD>TSContextToggle<CR>', desc = 'Toggle Treesitter context highlighting', },
                { '<leader>ow', 'ciW\'\'<ESC>P', desc = 'Wrap WORD in quotes', },
                { '<leader>or', '<CMD>set rnu!<CR>', desc = 'Toggle relative line numbers', },
                { '<leader>op', function() require('precognition').toggle() end, desc = 'Toggle Precognition', },
                { '<leader>n', '<CMD>Navbuddy<CR>', desc = 'Open Navbuddy', },
                { '<leader>f', '<CMD>Legendary<CR>', desc = 'Open command legend', },
                { '<leader>p', '_dP', desc = 'Paste without overwrite', mode = 'x', },
                { '<leader>c', function() require('bufdelete').bufdelete(0) end, desc = 'Close Buffer', },
                { '<leader>u', function() require('undotree').toggle() end, desc = 'Open buffers', },
                { '<leader>b', function() search_buffers() end, desc = 'Toggle undo tree', },
                { '<leader>x', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', desc = 'Search and replace with text under cursor', },
            }
        },
    },
}
--[[
        config = function()
            local whichkey_binds = {
                t = {
                    name = 'CopilotChat',
                    {'<leader>oe', '<CMD>CopilotChatExplain<CR>', desc = 'CopilotChat - Explain the selected text', },
                    {'<leader>of', '<CMD>CopilotChatFix<CR>', desc = 'CopilotChat - Provide a fix for the selected text', },
                    {'<leader>od', '<CMD>CopilotChatFixDiagnostic<CR>', desc = 'CopilotChat - Provide a fix for the selected diagnostic error', },
                    mode = 'v',
                },
            }

            local whichkey_opts = {
                mode = 'n',
                prefix = '<leader>',
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }
--]]

return config
