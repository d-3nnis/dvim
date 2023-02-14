local mason_null = safe_require("mason-null-ls")
if not mason_null then return end
local null = safe_require("null-ls")
if not null then return end

-- mason_null.setup({
--     automatic_setup = true,
-- })
--
null.setup()

mason_null.setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = true,
})

local stylua_options = {
    indent_type = 'Spaces',
    quote_style = 'AutoPreferSingle',
}

require 'mason-null-ls'.setup_handlers {
    function(source_name, methods)
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    stylua = function(source_name, methods)
        null.register(stylua_options)
    end,
}
