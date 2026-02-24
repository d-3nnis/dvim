local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

local lsp_augroup = ag('lsp_augroup', { clear = true })
local tmux_zoom_augroup = ag('tmux_zoom_status', {})
local autosave_augroup = ag('autosave', {})
local osc52_augroup = ag('osc52_yank', {})
local yank_highlight_augroup = ag('yank_highlight', {})

au('LspAttach', {
    group = lsp_augroup,
    callback = function(ev)
        local bufnr = ev.buf
        au('InsertEnter', {
            buffer = bufnr,
            callback = function()
            end,
            group = lsp_augroup,
        })
        au('InsertLeave', {
            buffer = bufnr,
            callback = function()
            end,
            group = lsp_augroup,
        })
    end,
    desc = 'On LSP attach',
})

au({ 'VimResized' }, {
    group = tmux_zoom_augroup,
    callback = function()
        local Job = require 'plenary.job'
        Job:new({
            command = 'tmux',
            args = { 'list-panes', '-F', "'#F'" },
            env = { PATH = vim.env.PATH },
            on_exit = function(j, return_val)
                if return_val == 0 then
                    local result = vim.inspect(j:result())
                    if (string.find(result, 'Z')) then
                        vim.g.zoomed_pane_status = 'Zoomed'
                    else
                        vim.g.zoomed_pane_status = ''
                    end
                else
                    vim.g.zoomed_pane_status = ''
                end
            end,
        }):sync()
        return ''
    end,
    desc = 'Update tmux zoom status',
})

au({ 'BufLeave', 'FocusLost' }, {
    group = autosave_augroup,
    callback = function()
        if vim.bo.readonly or vim.bo.buftype ~= '' then
            return
        end

        local path = vim.api.nvim_buf_get_name(0)
        if path == '' then
            return
        end

        if vim.uv.fs_stat(path) == nil then
            return
        end

        vim.cmd('silent update')
    end,
    desc = 'Save buffer when exiting or focus lost',
})

au('TextYankPost', {
    group = osc52_augroup,
    callback = function()
        -- TODO the register is empty, not '+', and I'm not sure why
        -- if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
        if vim.v.event.operator == 'y' and vim.v.event.regname == '' and vim.fn.has('wsl') == 0 then
            require('osc52').copy_register('+')
        end
    end,
    desc = 'Move all yanked text into system clipboard',
})

au('TextYankPost', {
    group = yank_highlight_augroup,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
    end,
    desc = 'Highlight yanked text',
})
