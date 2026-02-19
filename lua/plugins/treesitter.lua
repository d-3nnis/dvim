local config = {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed = { "c", "lua", "rust", "cpp", 'org', 'regex', 'bash', 'markdown', 'markdown_inline' },
        },
        config = function()
            local treesitter = safe_require("nvim-treesitter")
            if not treesitter then return end
            treesitter.install({ "c", "lua", "rust", "cpp", 'regex', 'bash', 'markdown', 'markdown_inline' }):wait(30000)

            --     indent = { enable = true, },
            -- }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            max_lines = 3,
            -- min_window_height = 35,
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
            vim.g.no_plugin_maps = true
        end,
        -- TODO update the keymaps
--             keymaps = {
--                 ["af"] = { query = "@function.outer", desc = 'Select outer function' },
--                 ["if"] = { query = "@function.inner", desc = 'Select inner function' },
--                 ["aC"] = { query = "@class.outer", desc = 'Select outer part of class' },
--                 ["iC"] = { query = "@class.inner", desc = 'Select inner part of class' },
--                 ["ac"] = { query = "@comment.outer", desc = 'Select outer part of comment' },
--                 ["ic"] = { query = "@comment.inner", desc = 'Select inner part of comment' },
--                 ["aP"] = { query = "@parameter.outer", desc = 'Select outer part of parameter' },
--                 ["iP"] = { query = "@parameter.inner", desc = 'Select inner part of parameter' },
--                 -- TODO ADD MORE
--             },
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
