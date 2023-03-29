local cursor = safe_require('smoothcursor')
local ns = safe_require("neoscroll")

if cursor then
    cursor.setup {
        type = "exp",
        speed = 20,
    }
elseif ns then
    ns.setup({
        easing_function = "sine",
    })
end

