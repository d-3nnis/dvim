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
        -- ["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = 'nvim-cmp',
            },
        },
        ["core.keybinds"] = {},
    }
}
