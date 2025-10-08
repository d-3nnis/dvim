local config = {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        build = "make tiktoken",
        config = function()
            local copilotchat = safe_require('CopilotChat')
            if not copilotchat then return end
            copilotchat.setup {
                mappings = {
                    reset = {
                        normal = '<C-r>',
                        insert = '<C-r>'
                    },
                },
                highlight_headers = false,
                separator = '---',
                error_header = '> [!ERROR] Error',
            }
        end,
    },
}
return config
