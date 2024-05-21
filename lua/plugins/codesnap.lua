local config = {
    {
        "mistricky/codesnap.nvim",
        build = "make",
        config = function()
            require("codesnap").setup({
                save_path="~/codesnap",
                has_breadcrumbs = true,
            })
        end,
    },
}

return config
