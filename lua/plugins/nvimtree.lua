local M = {}

function M.after_setup()
    

    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
      return
    end

    local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
    if not config_status_ok then
      return
    end

    local tree_cb = nvim_tree_config.nvim_tree_callback

    nvim_tree.setup {
      disable_netrw = true,
      hijack_netrw = true,
      open_on_setup = false,
      ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
      },
      auto_close = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = true,
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
        renderer = {
            icons = {
                glyphs = {
default = "",
      symlink = "",
      git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌",
      },
      folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
      },
                },
                show = {
                    git = true,
                    folder = true,
                    file = true,
                    folder_arrow = true,
                },
            },
            highlight_git = true,
            root_folder_modifier = ":t",
        },

      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      filters = {
        dotfiles = false,
        custom = {},
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        mappings = {
          custom_only = false,
          --list = {
            --{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
            --{ key = "h", cb = tree_cb "close_node" },
            --{ key = "v", cb = tree_cb "vsplit" },
          --},
        },
        number = false,
        relativenumber = false,
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },

        actions = {
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = true,
                }
            },
        },
    }
end

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
    require'bufferline.state'.set_offset(30, 'FileTree')
end

function M.on_close()
  local buf = tonumber(vim.fn.expand "<abuf>")
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  if ft == "NvimTree" and package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(0)
  end
end

return M
