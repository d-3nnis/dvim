local config = {
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            local ll = safe_require('lualine')
            if not ll then return end

            local function trailing_space()
                local space = vim.fn.search([[\s\+$]], 'nwc')
                return space ~= 0 and "TW:" .. space or ""
            end

            local function macro_recording_status()
                local register = vim.fn.reg_recording()
                if register ~= '' then
                    return 'Recording: ' .. register
                else
                    return ''
                end
            end

            local function which_project()
                return vim.g.project_config
            end

            local function mixed_indents()
                local space_pat = [[\v^ +]]
                local tab_pat = [[\v^\t+]]
                local space_indent = vim.fn.search(space_pat, 'nwc')
                local tab_indent = vim.fn.search(tab_pat, 'nwc')
                local mixed = (space_indent > 0 and tab_indent > 0)
                local mixed_same_line
                if not mixed then
                    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
                    mixed = mixed_same_line > 0
                end
                if not mixed then return '' end
                if mixed_same_line ~= nil and mixed_same_line > 0 then
                    return 'MI:' .. mixed_same_line
                end
                local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
                local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
                if space_indent_cnt > tab_indent_cnt then
                    return 'MI:' .. tab_indent
                else
                    return 'MI:' .. space_indent
                end
            end

            local line_x = {};
            local noice = safe_require('noice')
            if noice then
                line_x = {
                    -- this shows the status of things, like search results, errors and buffer saves
                    -- {
                    --     require("noice").api.status.message.get_hl,
                    --     cond = require("noice").api.status.message.has,
                    -- },
                    -- this shows the last command, but inconsistently
                    -- {
                    --     require("noice").api.status.command.get,
                    --     cond = require("noice").api.status.command.has,
                    --     color = { fg = "#ff9e64" },
                    -- },
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                    },
                }
            end

            ll.setup {
                options = {
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        { 'neo-tree', 'packer', 'noice' }
                    },
                    theme = 'auto',
                },
                extensions = { 'fzf', 'neo-tree', 'toggleterm' },
                sections = {
                    lualine_a = { 'mode', trailing_space, 'branch' },
                    lualine_b = { 'diagnostics', },
                    lualine_c = {
                        mixed_indents,
                    },
                    lualine_x = line_x,
                    -- lualine_y = { 'encoding', 'fileformat', 'filetype', },
                    lualine_y = {},
                    lualine_z = { which_project, macro_recording_status }
                },
                inactive_sections = {
                    lualine_a = { 'filename' },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_z = { 'location' },
                },
            }
        end,
    },

}

return config
