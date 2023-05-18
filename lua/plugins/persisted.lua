local config = {
    "olimorris/persisted.nvim",
    config = function()
        local persist = safe_require('persisted')
        if not persist then return end
        persist.setup({
            use_git_branch = true,
            telescope = {
                layout_config = { width = 0.55, height = 0.55 }
            }
        })
    end,
}

local group = vim.api.nvim_create_augroup("PersistedHooks", {})

vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "PersistedSavePre",
    group = group,
    callback = function()
        local has_toggleterm_open = false
        for _, winid in pairs(vim.api.nvim_list_wins()) do
            local bufid = vim.api.nvim_win_get_buf(winid)
            local bufname = vim.api.nvim_buf_get_name(bufid)
            if string.find(bufname, 'term') then
                has_toggleterm_open = true
                break
            end
        end
        if has_toggleterm_open then
            vim.cmd('ToggleTermToggleAll')
        end
    end,
})

return config
