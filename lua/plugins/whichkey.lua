local function search_buffers()
    require('fzf-lua').buffers()
end

local config = {
    {
        'folke/which-key.nvim',
        lazy = false,
        config = function()
            local wk = safe_require("which-key")
            local gs = safe_require('gitsigns')
            -- if not gs then return end
            local whichkey_binds = {
                ["w"] = { "<cmd>w!<CR>", "Save" },
                ["q"] = { "<cmd>qa<CR>", "Quit" },
                v = {
                    name = "Focusing",
                    v = { '<cmd>Twilight<CR>', 'Toggle focus' },
                },
                s = {
                    name = "Search everything!",
                    t = {
                        function()
                            vim.cmd('normal! zt')
                            -- require('telescope.builtin').live_grep(require('telescope.themes').get_ivy { theme = 'ivy', })
                            require('fzf-lua').grep_project()
                        end,
                        "Grep files in project" },
                    z = { function() require('fzf-lua').grep_cword() end, "Grep for string under cursor" },
                    g = { function() require('fzf-lua').git_status() end, "Git status files" },
                    s = { function()
                        vim.cmd('normal! zt')
                        -- require('telescope.builtin').grep_string(require('telescope.themes').get_ivy {
                        --     shorten_path = true, word_match = "-w",
                        --     only_sort_text = true, search = '', prompt_title = 'Fuzzy grep', theme = 'ivy',
                        -- })
                        require('fzf-lua').grep()
                    end, "Non-live grep" },
                    f = {
                        name = 'Fine tuned file search',
                        f = {
                            function()
                                require('fzf-lua').files()
                                -- require 'telescope.builtin'.find_files({
                                --     find_command = { 'fd', '--no-ignore', '-E', '.git' } })
                            end,
                            "Find file" },
                    },
                    r = { function()
                        require('fzf-lua').oldfiles()
                    end, "Recent files" },
                    k = { function()
                        require('fzf-lua').keymaps()
                    end, "Keymaps list" },
                    h = { function()
                        require('fzf-lua').colorschemes()
                    end, "List of themes" },
                    b = { function()
                        search_buffers()
                    end, "Open Buffers" },
                    e = { "<cmd>Telescope projects<cr>", "Projects list" },
                    q = { function()
                        require('fzf-lua').resume()
                    end, "Resume previous search session" },
                },
                e = {
                    name = "Tree explorer",
                    e = { "<CMD> Oil <CR>", "Open File Tree" },
                },
                o = {
                    name = "Misc",
                    q = { "gq", "Reformat line widths" },
                    h = { "<cmd>nohls<cr>", "Hide search highlight" },
                    x = { '<cmd>!chmod +x %<CR>', 'chmod this file for execution' },
                    t = { "<CMD>TSContextToggle<CR>", "Toggle Treesitter context highlighting" },
                    w = { "ciW\"\"<ESC>P", "Wrap WORD in quotes" },
                    r = { "<CMD>set rnu!<CR>", "Toggle relative line numbers" },
                    p = { function() require('precognition').toggle() end, "Toggle Precognition" },
                },
                h = {
                    name = "Gitsigns",
                    j = { function() gs.preview_hunk() end, "Preview Hunk" },
                    b = { function() gs.blame_line { full = true } end, "Blame Line" },
                    S = { function() gs.stage_buffer() end, "Stage Buffer" },
                    u = { function() gs.undo_stage_hunk() end, "Undo Stage Hunk" },
                    s = {
                        function()
                            if (string.sub(vim.fn.mode(), 1, 1) == 'n') then
                                gs.stage_hunk()
                            elseif (string.sub(vim.fn.mode(), 1, 1) == 'v' or
                                    string.sub(vim.fn.mode(), 1, 1) == 'V') then
                                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                            end
                        end,
                        "Stage Hunk",
                        mode = { 'v', 'n' }
                    },
                    r = {
                        function()
                            if (vim.fn.visualmode() == '') then
                                gs.reset_hunk()
                            else
                                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                            end
                        end,
                        "Reset Hunk",
                        mode = { 'v', 'n' }
                    },
                    R = { '<CMD>Gitsigns reset_buffer<CR>', "Reset Buffer" },
                    d = { function()
                        gs.diffthis()
                    end, "Diff against index" },
                    D = { function()
                        gs.diffthis('~')
                    end, "Diff against last commit" },
                    c = { '<CMD>diffoff<CR>', "Cancel diff" },
                    t = {
                        name = 'To[ggle]',
                        b = { function() gs.toggle_current_line_blame() end, 'Toggle Line Blame' },
                        i = { function()
                            vim.cmd('Gitsigns toggle_linehl')
                            vim.cmd('Gitsigns toggle_numhl')
                            vim.cmd('Gitsigns toggle_word_diff')
                        end, "Toggle Line Highlighting" },
                        d = { gs.toggle_deleted, "Toggle showing deleted hunks" }
                    },
                },
                t = {
                    name = 'CopilotChat',
                    e = { "<CMD>CopilotChatExplain<CR>", "CopilotChat - Explain the selected text" },
                    f = { "<CMD>CopilotChatFix<CR>", "CopilotChat - Provide a fix for the selected text" },
                    d = { "<CMD>CopilotChatFixDiagnostic<CR>", "CopilotChat - Provide a fix for the selected diagnostic error" },
                    mode = "v",
                },
                ["c"] = { function() require('bufdelete').bufdelete(0) end, "Close Buffer" },
                ["n"] = { "<CMD>Navbuddy<CR>", "Open Navbuddy" },
                ["f"] = { "<CMD>Legendary<CR>", "Open command legend" },
                ["u"] = { function() require('undotree').toggle() end, "Toggle undo tree" },
                ["p"] = { '"_dP', "Paste without overwrite", mode = "x" },
                ["x"] = { ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
                    'Search and replace with text under cursor' },
                ["b"] = { function() search_buffers() end, "Open buffers" },
            }

            local whichkey_opts = {
                mode = "n",
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }

            wk.setup {
                disable = {
                    filetypes = { "TelescopePrompt" }
                }
            }

            wk.register(whichkey_binds, whichkey_opts)

        end,
        dependencies = {
            'lewis6991/gitsigns.nvim',
        }
    },
}


return config
