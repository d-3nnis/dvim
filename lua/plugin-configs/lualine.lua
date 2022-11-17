local ll = safe_require('lualine')
if not ll then return end


-- TODO customize me more! move some stuff to the left?
ll.setup {
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            { 'neo-tree', 'packer' }
        },
    },
    extensions = { 'fzf', 'neo-tree', 'toggleterm' },
    sections = {
        lualine_x = {
            {
                require("noice").api.status.message.get_hl,
                cond = require("noice").api.status.message.has,
            },
            {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has,
                color = { fg = "#ff9e64" },
            },
            {
                require("noice").api.status.mode.get,
                cond = require("noice").api.status.mode.has,
                color = { fg = "#ff9e64" },
            },
            {
                require("noice").api.status.search.get,
                cond = require("noice").api.status.search.has,
                color = { fg = "#ff9e64" },
            }, 'encoding', 'fileformat', 'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
    },
}
