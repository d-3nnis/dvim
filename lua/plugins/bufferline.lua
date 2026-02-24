local config = { {
    'akinsho/bufferline.nvim',
    lazy = false,
    config = function()
        local bl = safe_require('bufferline')
        if not bl then return end

        bl.setup {
            options = {
                separator_style = 'slant',
                max_name_length = 100,
                indicator = {
                    style = 'underline',
                },
                -- diagnostics = 'nvim_lsp',
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'File Explorer',
                        highlight = 'Directory',
                    }
                },
                custom_filter = function(buf_number, _)
                    if vim.bo[buf_number].filetype ~= "qf"
                    then
                        return true
                    end
                end
            }
        }

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
        end

        map('n', '<S-h>', '<CMD>BufferLineCyclePrev<CR>', 'Previous buffer')
        map('n', '<S-l>', '<CMD>BufferLineCycleNext<CR>', 'Next buffer')
        map('n', '<C-(>', '<CMD>BufferLineMovePrev<CR>', 'Move tab left')
        map('n', '<C-)>', '<CMD>BufferLineMoveNext<CR>', 'Move tab right')
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
},
}
return config
