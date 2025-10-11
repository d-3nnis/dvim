local config = {
    {
        'alexghergh/nvim-tmux-navigation',
        config = function()
            local tmux_nav = safe_require("nvim-tmux-navigation")
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
                if os.getenv("TMUX") then
                    os.execute("tmux setenv TMUX_VIM 1")
                end
            end

            local function unset_tmux_vim()
                if os.getenv("TMUX") then
                    os.execute("tmux setenv -u TMUX_VIM")
                end
            end

            vim.api.nvim_create_autocmd("FocusGained", {
                callback = set_tmux_vim
            })

            vim.api.nvim_create_autocmd(
                { "FocusLost", "VimLeave" },
                {
                    callback = unset_tmux_vim
                })

            local legendary = safe_require('legendary')
            if not legendary then
                return
            end
            local nav_config = {}
            if tmux_nav then
                nav_config = {
                    { '<C-h>', function() tmux_nav.NvimTmuxNavigateLeft() end,  description = 'Tmux aware move to left window' },
                    { '<C-j>', function() tmux_nav.NvimTmuxNavigateDown() end,  description = 'Tmux aware move to down window' },
                    { '<C-k>', function() tmux_nav.NvimTmuxNavigateUp() end,    description = 'Tmux aware move to up window' },
                    { '<C-l>', function() tmux_nav.NvimTmuxNavigateRight() end, description = 'Tmux aware move to right window' },
                }
            else
                nav_config = {
                    { '<C-h>', '<C-w>h', description = 'Go to left window' },
                    { '<C-j>', '<C-w>j', description = 'Go to down window' },
                    { '<C-k>', '<C-w>k', description = 'Go to up window' },
                    { '<C-l>', '<C-w>l', description = 'Go to right window' },
                }
            end
            legendary.keymaps(nav_config, {})
        end,
        dependencies = {
            'mrjones2014/legendary.nvim',
        }
    }

}
return config
