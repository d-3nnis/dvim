local sep = safe_require('colorful-winsep')
if not sep then return end

sep.setup({
    no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "neo-tree" },
})
