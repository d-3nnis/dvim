local config = {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        config = function()
            local copilotchat = safe_require('CopilotChat')
            local select = safe_require('CopilotChat.select')
            if not copilotchat then return end
            copilotchat.setup {
                mappings = {
                    reset = {
                        normal = '<C-r>',
                        insert = '<C-r>'
                    },
                },
                prompts = {
                    Commit = {
                        prompt =
                        'Write commit message for the change. No specific format is required. Just call out the contents of the change. Make sure the title has maximum 50 characters and message is wrapped at 80 characters. Wrap the whole message in code block with language gitcommit.',
                        selection = select.gitdiff,
                    },
                    CommitStaged = {
                        prompt =
                        'Write commit message for the change. No specific format is required. Just call out the contents of the change. Make sure the title has maximum 50 characters and message is wrapped at 80 characters. Wrap the whole message in code block with language gitcommit.',
                        selection = function(source)
                            return select.gitdiff(source, true)
                        end,
                    },
                },
            }
        end,
    },
}
return config
