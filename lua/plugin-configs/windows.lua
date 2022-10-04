local win = safe_require('windows')
if not win then return end

vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
win.setup{}
