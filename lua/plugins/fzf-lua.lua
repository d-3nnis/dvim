local config = {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local actions = require('fzf-lua.actions')
            require("fzf-lua").setup({
                keymap = {
                    builtin = {
                    },
                }
            })
        end
    }
}
return config
