local config = {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = function ()
        require('undotree').setup()
    end,
}

return config
