local cursor = safe_require('smoothcursor')
if not cursor then return end

cursor.setup {
    type = "exp", -- define cursor movement calculate function, "default" or "exp" (exponential).
    fancy = {
        enable = true, -- enable fancy mode
        --head = { cursor = "ﰲ", texthl = "SmoothCursor", linehl = nil },
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
        body = {
            { cursor = "", texthl = "SmoothCursorRed" },
            { cursor = "", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" }
    },
    speed = 20, -- max is 100 to stick to your current position
}
