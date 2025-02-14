local config = {
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            local noice = safe_require("noice")
            if not noice then return end

            noice.setup {
                presets = {
                    long_message_to_split = true,
                },
                cmdline = {
                },
                -- routes = {
                --     {
                --         view = 'mini',
                --         opts = {
                --             timeout = 10000,
                --         },
                --         filter = { event = 'msg_showmode' }
                --     },
                -- },
                views = {
                    cmdline_popup = {
                        position = {
                            row = 5,
                            col = "50%",
                        },
                        size = {
                            width = "auto",
                            height = "auto",
                        },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = 10,
                        },
                        border = {
                            style = "solid",
                            padding = { 0, 1 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                    },
                },

                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                messages = {
                    enabled = true,
                    view_history = "popup",
                    view_search = false,
                },
            }
        end,
    },
}
return config
