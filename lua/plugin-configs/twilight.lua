local twilight = safe_require("twilight")
if not twilight then return end
twilight.setup({
    dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 20, -- amount of lines we will try to show around the current line
    exclude = {}, -- exclude these filetypes
})
