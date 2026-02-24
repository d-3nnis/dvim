local config = {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gs = safe_require('gitsigns')
            if not gs then return end

            gs.setup {
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                }
            }

            local function map(mode, lhs, rhs, desc, extra)
                local opts = { noremap = true, silent = true, desc = desc }
                if extra then
                    for k, v in pairs(extra) do
                        opts[k] = v
                    end
                end
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            map('n', '<C-g>j', function()
                if vim.wo.diff then return '<C-g>j' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, 'Next hunk', { expr = true })
            map('n', '<C-g>k', function()
                if vim.wo.diff then return '<C-g>k' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, 'Previous hunk', { expr = true })
        end
    }
}
return config
