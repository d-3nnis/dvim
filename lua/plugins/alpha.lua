local config = {
    {
        'goolord/alpha-nvim',
        enabled = false,
        config = function()
            local alpha = safe_require('alpha')
            if not alpha then return end

            local dashboard = safe_require("alpha.themes.dashboard")
            if not dashboard then return end

            dashboard.section.header.val = {
                [[  /\ \              __                  ]],
                [[  \_\ \    __  __  /\_\     ___ ___     ]],
                [[  /'_` \  /\ \/\ \ \/\ \  /' __` __`\   ]],
                [[ /\ \L\ \ \ \ \_/ | \ \ \ /\ \/\ \/\ \  ]],
                [[ \ \___,_\ \ \___/   \ \_\\ \_\ \_\ \_\ ]],
                [[  \/__,_ /  \/__/     \/_/ \/_/\/_/\/_/ ]],
            }
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file", function() require('fzf-lua').files() end),
                dashboard.button("e", "  Find project", ":Telescope projects <CR>"),
                dashboard.button("r", "󱫤  Recently used files", function() require('fzf-lua').oldfiles() end),
                dashboard.button("v", "  Edit dvim", ":e ~/.config/nvim/init.lua <CR>"),
            }

            local function footer()
                return "https://github.com/d-3nnis/dvim"
            end

            dashboard.section.footer.val = footer()

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end,
        priority = 3
    }
}

return config
