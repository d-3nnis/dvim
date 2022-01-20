local which_key = require("which-key")

which_key.register({
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    --["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "Comment" },
    s = {
        name = "Telescope",
        t = {"<cmd>Telescope live_grep<cr>", "Grep files"},
        f = {"<cmd>Telescope find_files<cr>", "Find file"},
        r = {"<cmd>Telescope oldfiles<cr>", "Recent files"},
    },
    e = {
        name = "Tree explorer",
        e = {"<cmd>NvimTreeOpen<cr>", "Open Explorer Pane"},
        c = {"<cmd>NvimTreeClose<cr>", "Close Explorer Pane"},
        r = {"<cmd>NvimTreeRefresh<cr>", "Refresh Explorer Pane"},
    },
    l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostic bufnr=0<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    },
    r = {
        name = "Rust",
        h = { "<cmd>lua require('rust-tools.inlay_hints').toggle_inlay_hints()<cr>", "Toggle Inlay Hints" },
    },
  -- add one for window
  -- add one for barbar
  -- easy access
  ["c"] = {"<cmd>BufferClose<cr>", "Close Buffer"},
  ["f"] = {"<cmd>Telescope find_files<cr>", "Find file"},
  ["h"] = {"<cmd>nohls<cr>", "Hide search highlight"},
}, {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})
--[[
which_key.register({
  ["/"] = { "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment" },
}
, {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})
--]]
