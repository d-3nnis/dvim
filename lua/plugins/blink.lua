local config = {
    'saghen/blink.cmp',
    dependencies = {
        "giuxtaposition/blink-cmp-copilot",
        'rafamadriz/friendly-snippets',
    },

    -- doesn't work on glibc 2.27
    -- https://github.com/Saghen/blink.cmp/issues/160#issuecomment-2645998283
    -- use a release tag to download pre-built binaries
    version = '*',

    opts = {
        fuzzy = {
            -- prebuilt_binaries = {
            --     download = not vim.fn.filereadable(vim.fn.stdpath("data") ..
            --         "/lazy/blink.cmp/target/release/libblink_cmp_fuzzy.so") == 1,
            -- },
            implementation = 'lua',
        },
        keymap = {
            preset = 'default',
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-e>'] = { 'cancel' },
        },
        completion = {
            documentation = {
                auto_show = true,
            },
            ghost_text = {
                enabled = true,
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                }
            }
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
            -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
            kind_icons = {
                Copilot = "",
                Text = '󰉿',
                Method = '󰊕',
                Function = '󰊕',
                Constructor = '󰒓',

                Field = '󰜢',
                Variable = '󰆦',
                Property = '󰖷',

                Class = '󱡠',
                Interface = '󱡠',
                Struct = '󱡠',
                Module = '󰅩',

                Unit = '󰪚',
                Value = '󰦨',
                Enum = '󰦨',
                EnumMember = '󰦨',

                Keyword = '󰻾',
                Constant = '󰏿',

                Snippet = '󱄽',
                Color = '󰏘',
                File = '󰈔',
                Reference = '󰬲',
                Folder = '󰉋',
                Event = '󱐋',
                Operator = '󰪚',
                TypeParameter = '󰬛',
            },
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                    transform_items = function(_, items)
                        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                        local kind_idx = #CompletionItemKind + 1
                        CompletionItemKind[kind_idx] = "Copilot"
                        for _, item in ipairs(items) do
                            item.kind = kind_idx
                        end
                        return items
                    end,
                },
            },

        },
        -- optionally disable cmdline completions
        -- cmdline = {},

        -- experimental signature help support
        -- signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
}
return config
