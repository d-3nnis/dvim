local ap = safe_require('nvim-autopairs')
if not ap then return end

ap.setup {
    disable_filetype = { "TelescopePrompt" },
    check_ts = true,
}
