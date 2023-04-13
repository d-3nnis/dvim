local nb = safe_require('nvim-navbuddy')
if not nb then return end

nb.setup {
    lsp = {
        auto_attach = true,
    },
}
