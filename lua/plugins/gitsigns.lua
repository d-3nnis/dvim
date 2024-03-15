local config = {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gs = safe_require('gitsigns')
            if not gs then return end

            gs.setup {}
        end
    }
}
return config
