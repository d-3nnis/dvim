local nt = safe_require('neo-tree')
local nt_events = safe_require('neo-tree.events')
local bl = safe_require('bufferline.state')
if not nt then return end
if not nt_events then return end
if not bl then return end

local function get_tree_size(args)
    local width = vim.fn.winwidth(args.winid)
    print(width)
    return width
end

nt.setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    default_component_configs = {
        container = {
            enable_character_fade = true
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
        },
        modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖", -- this can only be used in the git_status source
                renamed   = "", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "u",
                staged    = "",
                conflict  = "",
            }
        },
    },
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["o"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "none" -- "none", "relative", "absolute"
                }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        }
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                '*meta-*',
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
            }
        }
    },
    buffers = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
            }
        },
    },
    git_status = {
        window = {
            position = "left",
    --[[
            mappings = {
                ["A"]  = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            }
--]]
        }
    },
    --[[
    event_handlers = {
        {
            event = "neo_tree_window_after_open",
            handler = function(args)
                --print("neo_tree_window_after_open", vim.inspect(args))
                --local width = get_tree_size(args)
                --bl.set_offset(width)
            end
        },
        {
            event = "neo_tree_window_after_close",
            handler = function(args)
                --print("close", vim.inspect(args))
                --bl.set_offset(0)
            end
        }, {
            event = "vim_resized",
            handler = function(args)
                --print_inspect("resized", args)
                --local width = get_tree_size(args)
                --bl.set_offset(width)
            end
        },
    }
--]]
})
