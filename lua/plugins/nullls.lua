local plugin_name = "null-ls"
local status_ok, nullls = pcall(require, plugin_name)
if not status_ok then
    print(plugin_name .. " could not be loaded")
	return
end

nullls.setup {
    sources = {
        nullls.builtins.formatting.stylua,
        nullls.builtins.diagnostics.eslint,
        nullls.builtins.completion.spell,
    },
}
