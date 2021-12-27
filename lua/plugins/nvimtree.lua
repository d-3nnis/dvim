
local M = {}

function M.setup()
    local tree_view = require "nvim-tree.view"
    local open = tree_view.open

    tree_view.open = function()
        M.on_open()
        open()
    end
    vim.cmd "au WinClosed * lua require('plugins/nvimtree').on_close()"
    require("nvim-tree").setup {
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        }
    }
end

function M.on_open()
    require'bufferline.state'.set_offset(31, 'FileTree')
    --print(vim.inspect(require'nvim-tree'))
    --require'nvim-tree'.find_file(true)
end

function M.on_close_old()
   require'bufferline.state'.set_offset(0)
   require'nvim-tree'.close()
end

function M.on_close()
  local buf = tonumber(vim.fn.expand "<abuf>")
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  if ft == "NvimTree" and package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(0)
  end
end

return M
