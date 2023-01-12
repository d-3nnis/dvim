local no = safe_require('neorg')
if not no then return end

no.setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        },
        ["core.norg.concealer"] = {
            config = {
                icon_preset = 'diamond',
                folds = false,
            }
        },
        ["core.norg.completion"] = {
            config = {
                engine = 'nvim-cmp',
            },
        },
        ["core.keybinds"] = {},
        ["core.highlights"] = {},
    }
}
