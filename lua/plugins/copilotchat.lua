local select = require('CopilotChat.select')

local config = {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        opts = {
            -- See Configuration section for rest
            -- default mappings
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
        },
    },
}
return config
