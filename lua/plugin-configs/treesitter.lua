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
}


local tsc = safe_require("treesitter-context")
if not tsc then return end
tsc.setup {}
