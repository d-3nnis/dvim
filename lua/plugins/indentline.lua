local config = {
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {},
        config = function()
            local ts = safe_require('nvim-treesitter')
            if ts then
                -- vim.opt.listchars = { eol = '﬋', tab = '--', trail = '·' }
            end

            local il = safe_require('ibl')
            if not il then return end

            il.setup {}
        end
    }
}

return config
