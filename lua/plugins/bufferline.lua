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
                diagnostics = 'nvim_lsp',
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
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
},
}
return config
