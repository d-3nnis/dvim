local config = {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = safe_require("nvim-treesitter.configs")
            if not configs then return end

            configs.setup {
                ensure_installed = { "c", "lua", "rust", "cpp", 'org', 'regex', 'bash', 'markdown', 'markdown_inline' },
                sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
                highlight = {
                    enable = true,    -- false will disable the whole extension
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true, },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = { query = "@function.outer", desc = 'Select outer function' },
                            ["if"] = { query = "@function.inner", desc = 'Select inner function' },
                            ["aC"] = { query = "@class.outer", desc = 'Select outer part of class' },
                            ["iC"] = { query = "@class.inner", desc = 'Select inner part of class' },
                            ["ac"] = { query = "@comment.outer", desc = 'Select outer part of comment' },
                            ["ic"] = { query = "@comment.inner", desc = 'Select inner part of comment' },
                            ["aP"] = { query = "@parameter.outer", desc = 'Select outer part of parameter' },
                            ["iP"] = { query = "@parameter.inner", desc = 'Select inner part of parameter' },
                            -- TODO ADD MORE
                        },
                        include_surrounding_whitespace = false,
                    },
                },
            }


            local tsc = safe_require("treesitter-context")
            if not tsc then return end
            tsc.setup {
                max_lines = 5,
                min_window_height = 35,
            }
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
        }
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter" },
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('ts_context_commentstring').setup({
                enable_autocmd = false,
            })
        end,
    },
}
return config
