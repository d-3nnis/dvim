local notify = safe_require('notify')
if not notify then return end

notify.setup {
    background_colour = "#000000",
}

vim.notify = notify
