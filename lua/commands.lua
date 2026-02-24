vim.api.nvim_create_user_command('ToggleBackground', function()
    if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
    vim.notify('Background is now: ' .. vim.opt.background:get())
end, { desc = 'Toggle the background colour' })

vim.api.nvim_create_user_command('CloseCurrentTab', function()
    safe_require('bufdelete').bufdelete(0, false)
end, { desc = 'Close the current tab' })

vim.api.nvim_create_user_command('CloseTab', function(input)
    if input.fargs then
        safe_require('bufdelete').bufdelete(tonumber(input.fargs[1]), false)
    end
end, { desc = 'Close the current tab', nargs = 1 })
