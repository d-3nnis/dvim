local which_key = require("which-key")

which_key.register({
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
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
  },
  -- add one for window
  -- add one for barbar
  -- easy access
  ["c"] = {"<cmd>BufferClose<cr>", "Close Buffer"},
  ["f"] = {"<cmd>Telescope find_files<cr>", "Find file"},
}, {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})

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

