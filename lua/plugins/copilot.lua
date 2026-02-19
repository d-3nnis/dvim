local use_copilot = vim.g.enable_copilot or false
local config = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    enabled = use_copilot,
    -- Because the dev server nodejs is too old
    commit = "1a8032a",

    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })
    end
}

return config
