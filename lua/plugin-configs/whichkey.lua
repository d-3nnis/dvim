local wk = safe_require("which-key")
if not wk then return end

wk.setup {}
local gs = safe_require('gitsigns')
if not gs then return end

wk.register({
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>qa<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "Comment" },
    s = {
        name = "Telescope",
        t = { "<cmd>Telescope live_grep<cr>", "Grep files" },
        f = { "<cmd>Telescope find_files<cr>", "Find file" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps list" },
        h = { "<cmd>Telescope colorscheme<cr>", "List of themes" },
        n = { "<cmd>Telescope notify<cr>", "Notify messages" },
    },
    e = {
        name = "Tree explorer",
        e = { "<cmd>Neotree filesystem left<cr>", "Open Explorer Pane" },
        c = { "<cmd>NeoTreeClose<cr>", "Close Explorer Pane" },
        -- TODO expand options here
    },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = {
            "<cmd>Telescope diagnostics<cr>",
            "Document Diagnostics",
        },
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.format{async = true}<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        j = {
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
    o = {
        name = "Misc",
        q = { "gq", "Reformat line widths" }
    },
    -- add one for window
    -- add one for barbar
    -- easy access
    b = {
        name = "Buffers",
        l = { "<Cmd>BufferOrderByLanguage<CR>", "Order Buffers by Language" },
        p = { "<cmd>BufferPin<cr>", "Pin Buffer" },
        c = { "<cmd>BufferClose<cr>", "Close Buffer" },
    },
    h = {
        name = "Gitsigns",
        j = { function() gs.preview_hunk() end, "Preview Hunk" },
        b = { function() gs.blame_line { full = true } end, "Blame Line" },
        s = { function() gs.stage_hunk() end, "Stage Hunk" },
        S = { function() gs.stage_buffer() end, "Stage Buffer" },
        r = { function() gs.reset_hunk() end, "Reset Hunk" },
        u = { function() gs.undo_stage_hunk() end, "Undo Stage Hunk" },
        --map('n', '<leader>hR', gs.reset_buffer)
        ----map('n', '<leader>tb', gs.toggle_current_line_blame)
        --map('n', '<leader>hd', gs.diffthis)
        --map('n', '<leader>hD', function() gs.diffthis('~') end)
        --map('n', '<leader>td', gs.toggle_deleted)

    },
    ["c"] = { "<cmd>BufferClose<cr>", "Close Buffer" },
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find file" },
    ["m"] = { "<cmd>nohls<cr>", "Hide search highlight" },
}, {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
})
