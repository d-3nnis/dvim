local cursor = safe_require('smoothcursor')

-- if cursor then
--     cursor.setup {
--         type = "exp",
--         speed = 20,
--     }
-- else


local ns = safe_require("neoscroll")
if ns then
    ns.setup({
        easing_function = "sine",
    })
end

