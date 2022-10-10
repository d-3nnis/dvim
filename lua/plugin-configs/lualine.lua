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
    -- [[
    sections = {
        lualine_y = {
            {
                require("noice").api.statusline.message.get_hl,
                cond = require("noice").api.statusline.message.has,
            },
            {
                require("noice").api.statusline.command.get,
                cond = require("noice").api.statusline.command.has,
                color = { fg = "#ff9e64" },
            },
            {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = "#ff9e64" },
            },
            {
                require("noice").api.statusline.search.get,
                cond = require("noice").api.statusline.search.has,
                color = { fg = "#ff9e64" },
            },
        }
    },
    extensions = { 'fzf', 'neo-tree', 'toggleterm' },
    -- ]]
}
