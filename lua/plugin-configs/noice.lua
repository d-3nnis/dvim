local noice = safe_require("noice")
if not noice then return end

noice.setup {
    views = {
        split = {
            enter = true
        }
    },
}

