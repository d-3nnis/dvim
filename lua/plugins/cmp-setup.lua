local config = {
    -- cmp plugins
    'hrsh7th/cmp-buffer',       -- buffer completions
    'hrsh7th/cmp-path',         -- path completions
    'hrsh7th/cmp-cmdline',      -- cmdline completions
    'saadparwaiz1/cmp_luasnip', -- snippet completions
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'L3MON4D3/LuaSnip',             --snippet engine
    'rafamadriz/friendly-snippets', -- a bunch of snippets to use
    {
        'hrsh7th/nvim-cmp',         -- The completion plugin
        config = function()
            local cmp = safe_require('cmp')
            if not cmp then return end

            local luasnip = safe_require("luasnip")
            if not luasnip then return end

            local luasnip_loaders = safe_require('luasnip.loaders.from_vscode')
            if not luasnip_loaders then return end
            luasnip_loaders.lazy_load()

            local cmp_ap = safe_require('nvim-autopairs.completion.cmp')
            if not cmp_ap then return end

            cmp.event:on(
                'confirm_done',
                cmp_ap.on_confirm_done()
            )

            local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
            end

            -- local kind_icons = {
            --     Text = "",
            --     Method = "m",
            --     Function = "",
            --     Constructor = "",
            --     Field = "",
            --     Variable = "",
            --     Class = "",
            --     Interface = "",
            --     Module = "",
            --     Property = "",
            --     Unit = "",
            --     Value = "",
            --     Enum = "",
            --     Keyword = "",
            --     Snippet = "",
            --     Color = "",
            --     File = "",
            --     Reference = "",
            --     Folder = "",
            --     EnumMember = "",
            --     Constant = "",
            --     Struct = "",
            --     Event = "",
            --     Operator = "",
            --     TypeParameter = "",
            -- }

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                },
                formatting = {
                    -- fields = { "abbr" },
                    fields = { "kind", "abbr" },
                    -- fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Kind icons
                        vim_item.kind = string.format("%s", vim_item.kind)
                        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    -- { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "buffer",  keyword_length = 3 },
                    { name = "path" },
                    { name = "orgmode" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered(),
                },
                sorting = {
                    comparators = {
                        -- require("copilot_cmp.comparators").prioritize,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    }
                }
            }
        end,
    },
}
return config
