local config = {
    {
        'alexghergh/nvim-tmux-navigation',
        config = function()
            local tmux_nav = safe_require('nvim-tmux-navigation')
            if not tmux_nav then
                return
            end
            tmux_nav.setup({
                disable_when_zoomed = true,
            })

            -- Check if running inside tmux
            -- TODO when switching from neovim to neovim, could the exit run after the enter, resulting in TMUX_VIM
            -- being unset still?
            local function set_tmux_vim()
                if os.getenv('TMUX') then
                    os.execute('tmux setenv TMUX_VIM 1')
                end
            end

            local function unset_tmux_vim()
                if os.getenv('TMUX') then
                    os.execute('tmux setenv -u TMUX_VIM')
                end
            end

            vim.api.nvim_create_autocmd('FocusGained', {
                callback = set_tmux_vim
            })

            vim.api.nvim_create_autocmd(
                { 'FocusLost', 'VimLeave' },
                {
                    callback = unset_tmux_vim
                })

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
            end

            map('n', '<C-h>', function() tmux_nav.NvimTmuxNavigateLeft() end, 'Tmux aware move to left window')
            map('n', '<C-j>', function() tmux_nav.NvimTmuxNavigateDown() end, 'Tmux aware move to down window')
            map('n', '<C-k>', function() tmux_nav.NvimTmuxNavigateUp() end, 'Tmux aware move to up window')
            map('n', '<C-l>', function() tmux_nav.NvimTmuxNavigateRight() end, 'Tmux aware move to right window')
        end,
    }

}
return config
