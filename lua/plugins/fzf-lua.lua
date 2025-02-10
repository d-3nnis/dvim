local config = {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local actions = require('fzf-lua.actions')
            require("fzf-lua").setup({
                keymap = {
                    builtin = {
                        ["<C-d>"] = "preview-page-down",
                        ["<C-u>"] = "preview-page-up",
                        ["<F1>"]  = "toggle-help",
                        ["<F2>"]  = "toggle-fullscreen",
                    },
                    fzf = {
                        ["ctrl-w"] = "toggle-all",
                        ["ctrl-d"] = "preview-page-down",
                        ["ctrl-u"] = "preview-page-up",
                    }
                },
                defaults = {
                    formatter = "path.filename_first",
                },
                winopts = {
                    fullscreen = true,
                    preview = {
                        wrap = 'wrap',
                        layout = 'vertical',
                        title_pos = 'left',
                    },
                },
                oldfiles = {
                    include_current_session = true,
                },
                git = {
                    status = {
                        actions = {
                            ["ctrl-l"] = { fn = actions.git_unstage, reload = true },
                            ["ctrl-h"] = { fn = actions.git_stage, reload = true },
                            ["ctrl-x"] = { fn = actions.git_reset, reload = true },
                        },
                    },
                },
                previewers = {
                    builtin = {
                        syntax_limit_b = 1024 * 100,
                    },
                },
            })
        end
    }
}
return config
