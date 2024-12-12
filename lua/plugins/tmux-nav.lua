local config = {
    {
        'alexghergh/nvim-tmux-navigation',
        config = function()
            local tmux_nav = safe_require("nvim-tmux-navigation")
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

            -- TODO add these autocmds to legendary?
            -- Set the variable when Neovim starts
            vim.api.nvim_create_autocmd("FocusGained", {
                callback = set_tmux_vim
            })

            -- Unset the variable when Neovim exits
            vim.api.nvim_create_autocmd(
                { "FocusLost", "VimLeave" },
                {
                    callback = unset_tmux_vim
                })

            local legendary = safe_require('legendary')
            -- local tmux_nav = safe_require('nvim-tmux-navigator')
            local lsp_legend = {}
            if tmux_nav then
                lsp_legend = {
                    { '<C-h>', function() tmux_nav.NvimTmuxNavigateLeft() end,  description = 'Tmux aware move to left window' },
                    { '<C-j>', function() tmux_nav.NvimTmuxNavigateDown() end,  description = 'Tmux aware move to down window' },
                    { '<C-k>', function() tmux_nav.NvimTmuxNavigateUp() end,    description = 'Tmux aware move to up window' },
                    { '<C-l>', function() tmux_nav.NvimTmuxNavigateRight() end, description = 'Tmux aware move to right window' },
                }
            else
                lsp_legend = {
                    { '<C-h>', '<C-w>h', description = 'Go to left window' },
                    { '<C-j>', '<C-w>j', description = 'Go to down window' },
                    { '<C-k>', '<C-w>k', description = 'Go to up window' },
                    { '<C-l>', '<C-w>l', description = 'Go to right window' },
                }
            end
            legendary.keymaps(lsp_legend, {})
        end,
        dependencies = {
            'mrjones2014/legendary.nvim',
        }
    }

}
return config
