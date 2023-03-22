local configs = safe_require("nvim-treesitter.configs")
if not configs then return end

configs.setup {
    ensure_installed = { "c", "lua", "rust", "cpp", 'org' }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    rainbow = {
        enable = true,
        query = 'rainbow-parens',
        strategy = require 'ts-rainbow'.strategy.global,
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer", desc = 'Select outer function' },
                ["if"] = { query = "@function.inner", desc = 'Select inner function' },
                ["ac"] = { query = "@class.outer", desc = 'Select outer part of class' },
                ["ic"] = { query = "@class.inner", desc = 'Select inner part of class' },
                -- TODO ADD MORE
            },
            include_surrounding_whitespace = true,
        },
    },
}


local tsc = safe_require("treesitter-context")
if not tsc then return end
tsc.setup {}
