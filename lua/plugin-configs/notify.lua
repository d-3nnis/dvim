local notify = safe_require('notify')
if not notify then return end
local stages = require("notify.stages.slide")("top_down")
notify.setup {
    render = 'compact',
    background_colour = "#000000",
    stages = {
        function(...)
            local opts = stages[1](...)
            if opts then
                opts.border = "none"
            end
            return opts
        end,
        unpack(stages, 2),
    },
}

vim.notify = notify
