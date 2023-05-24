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
                    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Grep files" },
                    c = { "<cmd>Telescope persisted theme=dropdown<cr>", "Session Manager" },
                    z = { "<cmd>Telescope grep_string<cr>", "Grep for string under cursor" },
                    g = { "<cmd>Telescope git_status<cr>", "Git status files" },
                    s = { function()
                        require('telescope.builtin').grep_string { shorten_path = true, word_match = "-w",
                            only_sort_text = true, search = '', prompt_title = 'Fuzzy grep',
                        }
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
                    b = { "<cmd>Telescope buffers theme=dropdown<cr>", "Open buffers" },
                    e = { "<cmd>Telescope projects<cr>", "Projects list" },
                    w = { "<cmd>Telescope resume<cr>", "Resume previous Telescope session" },
                },
                e = {
                    name = "Tree explorer",
                    e = { "<cmd>Neotree filesystem right<cr>", "Open File Tree" },
                    g = { "<cmd>Neotree float source=git_status<cr>", "Open Git Status" },
                    r = { "<cmd>NeoTreeReveal<cr>", "Reveal current file" },
                    c = { "<cmd>NeoTreeClose<cr>", "Close Tree" },
                    -- TODO expand options here
                },
                o = {
                    name = "Misc",
                    q = { "gq", "Reformat line widths" },
                    h = { "<cmd>nohls<cr>", "Hide search highlight" },
                    x = { '<cmd>!chmod +x %<CR>', 'chmod this file for execution' }
                },
                b = {
                    name = "Buffers",
                    l = { "<Cmd>BufferOrderByLanguage<CR>", "Order Buffers by Language" },
                    p = { "<cmd>BufferPin<cr>", "Pin Buffer" },
                    c = { "<cmd>BufferClose<cr>", "Close Buffer" },
                },
                h = {
                    name = "Gitsigns",
                    j = { function() gs.preview_hunk() end, "Preview Hunk" },
                    b = { function() gs.blame_line { full = true } end, "Blame Line" },
                    S = { function() gs.stage_buffer() end, "Stage Buffer" },
                    u = { function() gs.undo_stage_hunk() end, "Undo Stage Hunk" },
                    s = { '<CMD>Gitsigns stage_hunk<CR>', "Stage Hunk", mode = { 'n', 'v' } },
                    r = { '<CMD>Gitsigns reset_hunk<CR>', "Reset Hunk", mode = { 'n', 'v' } },
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
                ["c"] = { function() require('bufdelete').bufdelete(0) end, "Close Buffer" },
                ["n"] = { "<CMD>Navbuddy<CR>", "Open Navbuddy" },
                ["f"] = { "<CMD>Legendary<CR>", "Open command legend" },
                ["u"] = { vim.cmd.UndotreeToggle, "Toggle undo tree" },
                ["p"] = { '"_dP', "Paste without overwrite", mode = "x" },
                ["x"] = { ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
                    'Search and replace with text under cursor' }
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
