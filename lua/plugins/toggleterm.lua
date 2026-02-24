local config = {
    {
        'akinsho/toggleterm.nvim',
        config = function()
            local tt = safe_require('toggleterm')
            if not tt then return end

            tt.setup {
                float_opts = {
                    border = 'curved'
                }
            }

            local function toggleterm(count, direction)
                local size = 0
                if direction == 'horizontal' then
                    size = 15
                elseif direction == 'vertical' then
                    size = vim.o.columns * 0.4
                end

                if count == 0 then
                    local cwd = vim.fn.getcwd()
                    local hash = 0
                    for i = 1, #cwd do
                        hash = hash + string.byte(cwd, i)
                    end
                    count = (hash % 99) + 1
                end

                return count .. 'ToggleTerm size=' .. size .. ' dir=git_dir direction=' .. direction
            end

            local function toggleterm_exec_cmd(count, cmd)
                return count .. "TermExec cmd='" .. cmd .. "'"
            end

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
            end

            map('n', '<C-t>f', function() vim.cmd(toggleterm(vim.v.count, 'float')) end, 'Open floating terminal')
            map('n', '<C-t>s', function() vim.cmd(toggleterm(vim.v.count, 'horizontal')) end, 'Open horizontal terminal')
            map('n', '<C-t>v', function() vim.cmd(toggleterm(vim.v.count, 'vertical')) end, 'Open vertical terminal')
            map('n', '<C-t>g', function()
                local pwd = vim.fn.getcwd()
                vim.cmd(toggleterm_exec_cmd(vim.v.count, 'cd ' .. pwd))
            end, 'Return to cwd')

            local function set_terminal_keymaps(bufnr)
                local opts = { noremap = true, buffer = bufnr }
                vim.keymap.set('t', '<C-t>', [[<C-\><C-n><CMD>q<CR>]], opts)
                vim.keymap.set('t', '<C-d>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
                vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
                vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
                vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
            end

            local group = vim.api.nvim_create_augroup('toggleterm_keymaps', { clear = true })
            vim.api.nvim_create_autocmd('TermOpen', {
                group = group,
                pattern = 'term://*toggleterm#*',
                callback = function(ev)
                    set_terminal_keymaps(ev.buf)
                end,
                desc = 'ToggleTerm keymaps',
            })
        end
    },
}
return config
