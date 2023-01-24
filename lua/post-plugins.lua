vim.opt.termguicolors = true

local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

au('TextYankPost', { group = ag('yank_highlight', {}), pattern = '*',
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

local onedark = safe_require('onedark')
if onedark then
    onedark.setup { style = 'deep' }
end

local cat = safe_require('catppuccin')
if cat then
    vim.g.catppuccin_flavour = "latte"
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
    -- vim.api.nvim_command('colorscheme catppuccin')
    -- vim.api.nvim_command('colorscheme catppuccin-latte')
    -- vim.api.nvim_command('colorscheme catppuccin-latte')
    vim.opt.background = 'light'
    vim.api.nvim_command('colorscheme rose-pine')
else
    vim.api.nvim_command([[colorscheme everforest]])
end
