local cw = safe_require('codewindow')
if not cw then return end

cw.setup({
    exclude_filetypes = { "TelescopePrompt", "neo-tree" },
})
