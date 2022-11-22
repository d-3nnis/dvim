local onedark = safe_require('onedark')
if onedark
then
    onedark.setup { style = 'deep' }
end

local cat = safe_require('catppuccin')
if cat then
    vim.g.catppuccin_flavour = "frappe"
    cat.setup({
        integrations = {
            cmp = true,
            gitsigns = true,
            neotree = true,
            telescope = true,
            notify = true,
            mini = true,
            mason = true,
            -- lualine = true,
            -- bufferline = true,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end
