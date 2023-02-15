local hl = safe_require('local-highlight')
if not hl then return end

hl.setup({
    file_types = { 'python', 'cpp', 'lua' }
})
