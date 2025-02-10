local config = {

    'ellisonleao/gruvbox.nvim',
    'sainnhe/everforest',
    {
        'navarasu/onedark.nvim',
        opts = {
            style = 'deep',
        }
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
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
                    },
                })
            end
        end,
    },
    {'rose-pine/neovim', name = 'rose-pine'},
    {
        'mcchrish/zenbones.nvim',
        dependencies = 'rktjmp/lush.nvim',
    },
    {
        'uloco/bluloco.nvim',
        dependencies = 'rktjmp/lush.nvim',
    },
    {
        'Verf/deepwhite.nvim',
        lazy = false,
    },
    { 'projekt0n/caret.nvim' },
    { 'aktersnurra/no-clown-fiesta.nvim' }
}
return config
