local bl = safe_require('bufferline')
if not bl then return end

bl.setup{
    options = {
        numbers = 'both',
        separator_style = 'slant',

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
        }
    }
}

