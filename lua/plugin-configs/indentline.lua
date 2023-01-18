local ts = safe_require('nvim-treesitter')
if ts then
    vim.opt.listchars = { eol = '﬋', tab = '--', trail = '·' }
end
		
local il = safe_require('indent_blankline')
if not il then return end

il.setup {
    show_current_context = true,
    show_current_context_start = true,
}
