local config = {
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    -- lazy = true,
    enabled = true,
    config = function()
        local rd = safe_require('rainbow-delimiters')
        if not rd then return end
        local rds = safe_require('rainbow-delimiters.setup')
        if not rds then return end
        rds.setup {
            strategy = {
                [''] = rd.strategy['global'],
                vim = rd.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },

        }
    end,
}
return config
