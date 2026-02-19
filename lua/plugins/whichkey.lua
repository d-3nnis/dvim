local function search_buffers()
    require('fzf-lua').buffers()
end

local function grep_then_files()
    local fzf = require('fzf-lua')
    local path = require('fzf-lua.path')
    local fzf_config = require('fzf-lua.config')

    local function grep_query(opts)
        return opts.last_query or fzf_config.__resume_data.last_query
    end

    local function collect_files(grep_output)
        local files = {}
        local seen = {}
        local lines = vim.split(grep_output or '', '\n', { trimempty = true })
        for _, line in ipairs(lines) do
            local file = line:match('^(.-):%d+:%d+:')
            if file and not seen[file] then
                seen[file] = true
                table.insert(files, file)
            end
        end
        return files
    end

    local function pick_files(files)
        if #files == 0 then
            vim.notify('No matches found', vim.log.levels.INFO)
            return
        end

        fzf.fzf_exec(files, {
            prompt = 'Files> ',
            previewer = 'builtin',
            actions = {
                ['default'] = function(selected)
                    local file = path.entry_to_file(selected[1], {})
                    local p = file and file.path or selected[1]
                    if p then
                        vim.cmd('edit ' .. vim.fn.fnameescape(p))
                    end
                end,
            },
        })
    end

    fzf.live_grep({
        prompt = 'Grep> ',
        fzf_opts = {
            ['--multi'] = true,
        },
        keymap = {
            fzf = {
                ['ctrl-s'] = 'select-all+accept',
            },
        },
        actions = {
            ['ctrl-s'] = false,
            ['default'] = function(_, opts)
                local query = grep_query(opts)
                if not query or query == '' then
                    vim.notify('No grep query found', vim.log.levels.ERROR)
                    return
                end

                vim.system({ 'rg', '--vimgrep', query }, { text = true }, function(result)
                    vim.schedule(function()
                        if result.code ~= 0 and (not result.stdout or result.stdout == '') then
                            local msg = result.stderr ~= '' and result.stderr or 'ripgrep failed'
                            vim.notify(msg, vim.log.levels.ERROR)
                            return
                        end

                        pick_files(collect_files(result.stdout))
                    end)
                end)
            end,
        },
    })
end

local function files_then_grep()
    local fzf = require('fzf-lua')
    local path = require('fzf-lua.path')

    fzf.files({
        fzf_opts = {
            ['--multi'] = true,
        },
        keymap = {
            fzf = {
                ['ctrl-s'] = 'select-all+accept',
            },
        },
        actions = {
            ['ctrl-s'] = false,
            ['default'] = function(selected, opts)
                if not selected or #selected == 0 then
                    return
                end

                local files = {}
                for _, entry in ipairs(selected) do
                    local file = path.entry_to_file(entry, opts)
                    table.insert(files, file and file.path or entry)
                end

                if #files == 0 then
                    vim.notify('No files selected', vim.log.levels.INFO)
                    return
                end

                fzf.live_grep({
                    prompt = 'Grep> ',
                    search_paths = files,
                })
            end,
        },
    })
end

local function git_branches_dv()
    require('fzf-lua').git_branches({
        cmd = [[git branch --all --color -vv --list '*dv.*' ]]
            .. [[--sort=-'committerdate' --sort='refname:rstrip=-2' --sort=-'HEAD']],
    })
end

local function git_main_branch()
    local result = vim.fn.systemlist('git symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null')
    if vim.v.shell_error == 0 and result[1] then
        return result[1]:gsub('^refs/remotes/origin/', '')
    end
    return nil
end

local function rebase_on_main()
    local current = vim.fn.systemlist('git branch --show-current 2>/dev/null')[1]
    if vim.v.shell_error ~= 0 or not current or current == '' then
        vim.notify('Not in a git repo or no current branch', vim.log.levels.ERROR)
        return
    end

    local main = git_main_branch()
    if not main then
        vim.notify('Could not resolve origin/HEAD to determine main branch', vim.log.levels.ERROR)
        return
    end
    if current == main then
        vim.notify('Already on ' .. main .. '; nothing to rebase', vim.log.levels.INFO)
        return
    end

    vim.notify('Fetching origin/' .. main .. '...', vim.log.levels.INFO)
    vim.system({ 'git', 'fetch', 'origin', main }, { text = true }, function(fetch_result)
        if fetch_result.code ~= 0 then
            vim.notify(fetch_result.stderr ~= '' and fetch_result.stderr or 'git fetch failed', vim.log.levels.ERROR)
            return
        end

        vim.notify('Rebasing onto origin/' .. main .. '...', vim.log.levels.INFO)
        vim.system({ 'git', 'rebase', 'origin/' .. main }, { text = true }, function(rebase_result)
            if rebase_result.code ~= 0 then
                vim.notify(rebase_result.stderr ~= '' and rebase_result.stderr or 'git rebase failed',
                    vim.log.levels.ERROR)
                return
            end
            vim.notify('Rebase complete', vim.log.levels.INFO)
        end)
    end)
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
                { '<leader>sn', git_branches_dv, desc = "Git branches matching dv." },
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
                { '<leader>sfr', grep_then_files, desc = 'Grep then filter files' },
                { '<leader>sfe', files_then_grep, desc = 'Find files then grep' },
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
                    '<leader>sB',
                    function()
                        require('fzf-lua').git_branches()
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
                { '<leader>hJ', function() require('gitsigns').preview_hunk_inline() end, desc = 'Preview Hunk Inline', },
                { '<leader>hb', function() require('gitsigns').blame_line { full = true } end, desc = 'Blame Line', },
                { '<leader>hS', function() require('gitsigns').stage_buffer() end, desc = 'Stage Buffer', },
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
                        if (string.sub(vim.fn.mode(), 1, 1) == 'n') then
                            require('gitsigns').reset_hunk()
                        elseif (string.sub(vim.fn.mode(), 1, 1) == 'v' or
                                string.sub(vim.fn.mode(), 1, 1) == 'V') then
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
                { '<leader>htB', function() require('gitsigns').blame() end, desc = 'Toggle Buffer Blame', },
                {
                    '<leader>hti',
                    function()
                        vim.cmd('Gitsigns toggle_linehl')
                        vim.cmd('Gitsigns toggle_numhl')
                        vim.cmd('Gitsigns toggle_word_diff')
                    end,
                    desc = 'Toggle Line Highlighting',
                },
                { '<leader>g', group = 'Git', icon = "" },
                { '<leader>gr', rebase_on_main, desc = 'Rebase current branch on main', },
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
                { '<leader>b', function() search_buffers() end, desc = 'Toggle undo tree', },
                { '<leader>x', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', desc = 'Search and replace with word under cursor', },
                { '<leader>X', ':%s/<C-r><C-a>/<C-r><C-a>/gI<Left><Left><Left>', desc = 'Search and replace with WORD under cursor', },
                { '<leader>r', group = 'Copilot', icon = '' },
                {
                    '<leader>rd',
                    function()
                        require('CopilotChat').ask(
                            "@copilot #buffer #selection Write documentation for the function(s) under cursor.")
                    end,
                    desc = 'Ask Copilot to write documentation for the function(s) under cursor',
                    mode = 'nv'
                },
                {
                    '<leader>od',
                    function()
                        require('CopilotChat').ask(
                            '@copilot #buffer #selection Provide documentation for any diagnostic error(s)')
                    end,
                    desc = 'CopilotChat - Provide a fix for any diagnostic errors',
                    mode = 'nv'
                },
            }
        },
    },
}

return config
