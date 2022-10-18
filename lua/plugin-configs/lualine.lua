local ll = safe_require('lualine')
if not ll then return end

ll.setup {
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            { 'neo-tree', 'packer' }
        },
    },
    extensions = { 'fzf', 'neo-tree', 'toggleterm' },
    -- ]]
}
