local config = {
    {
        "mistricky/codesnap.nvim",
        build = "make",
        config = function()
            require("codesnap").setup({
                save_path="~/codesnap",
                has_breadcrumbs = true,
                mac_window_bar = false,
                bg_x_padding = 20,
                bg_y_padding = 20,
                bg_padding = 10,
                watermark = "",
            })
        end,
    },
}

return config
