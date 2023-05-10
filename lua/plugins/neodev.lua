local config = {}

config = {
    'folke/neodev.nvim',
    config = function()
        local neodev = safe_require('neodev')
        if not neodev then
            return
        end
        neodev.setup()
    end,
}

return config
