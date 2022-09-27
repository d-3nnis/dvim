local devi = safe_require('nvim-web-devicons')
if not devi then return end

local function refresh_devicons()
    devi.setup {}
end

refresh_devicons()

vim.api.nvim_create_autocmd({ 'ColorScheme' }, { callback = refresh_devicons })
