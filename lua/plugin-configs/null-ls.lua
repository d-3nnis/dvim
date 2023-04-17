local mason_null = safe_require("mason-null-ls")
if not mason_null then return end
local null = safe_require("null-ls")
if not null then return end

local stylua_options = {
    indent_type = 'Spaces',
    quote_style = 'AutoPreferSingle',
}

mason_null.setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = true,
    handlers = {
        stylua = function(source_name, methods)
            null.register(stylua_options)
        end,
        yamllint = function(source_name, methods)
            -- null.register(yamllint_options)
            mason_null.default_setup(source_name, methods)
        end,
    }
})

null.setup({})

