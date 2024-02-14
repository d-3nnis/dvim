local function search_buffers()
    require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true, })
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
                    name = "Telescope",
                    t = {
                        function()
                            vim.cmd('normal! zt')
                            require('telescope.builtin').live_grep(require('telescope.themes').get_ivy { theme = 'ivy', })
                        end,
                        "Grep files" },
                    c = { "<cmd>Telescope persisted theme=dropdown<cr>", "Session Manager" },
                    z = { "<cmd>Telescope grep_string<cr>", "Grep for string under cursor" },
                    g = { "<cmd>Telescope git_status<cr>", "Git status files" },
                    s = { function()
                        vim.cmd('normal! zt')
                        require('telescope.builtin').grep_string(require('telescope.themes').get_ivy {
                            shorten_path = true, word_match = "-w",
                            only_sort_text = true, search = '', prompt_title = 'Fuzzy grep', theme = 'ivy',
                        })
                    end, "Fuzzy grep" },
                    f = {
                        name = 'Fine tuned file search',
                        a = {
                            function()
                                require 'telescope.builtin'.find_files({
                                    find_command = { 'fd', '--hidden', '--no-ignore' } })
                            end,
                            "Search ALL files" },
                        d = {
                            function()
                                require 'telescope.builtin'.find_files({
                                    find_command = { 'fd', '--no-ignore', '-E', '.git' } })
                            end,
                            "Search files including gitignore" },
                        f = { "<cmd>Telescope find_files<cr>", "Find file" },
                    },
                    r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
                    a = { "<cmd>Telescope frecency<cr>", "Frecency search" },
                    k = { "<cmd>Telescope keymaps<cr>", "Keymaps list" },
                    h = { "<cmd>Telescope colorscheme theme=dropdown<cr>", "List of themes" },
                    n = { "<cmd>Telescope notify<cr>", "Notify messages" },
                    b = { function() search_buffers() end, "Open Buffers" },
                    e = { "<cmd>Telescope projects<cr>", "Projects list" },
                    q = { "<cmd>Telescope resume<cr>", "Resume previous Telescope session" },
                    j = { "<cmd>Telescope termfinder<cr>", "List toggleterm terminals" },
                },
                e = {
                    name = "Tree explorer",
                    e = { "<CMD> Oil <CR>", "Open File Tree" },
                },
                o = {
                    name = "Misc",
                    q = { "gq", "Reformat line widths" },
                    h = { "<cmd>nohls<cr>", "Hide search highlight" },
                    x = { '<cmd>!chmod +x %<CR>', 'chmod this file for execution' }
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
                    e = { "<cmd>Telescope git_status<cr>", "Git status files" },
                },
                ["c"] = { function() require('bufdelete').bufdelete(0) end, "Close Buffer" },
                ["n"] = { "<CMD>Navbuddy<CR>", "Open Navbuddy" },
                ["f"] = { "<CMD>Legendary<CR>", "Open command legend" },
                ["u"] = { function () require('undotree').toggle() end, "Toggle undo tree" },
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
