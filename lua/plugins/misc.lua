
local config = {
    'p00f/clangd_extensions.nvim',
    'famiu/bufdelete.nvim',
    'https://gitlab.com/madyanov/svart.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'HiPhish/nvim-ts-rainbow2',
    { 'numToStr/Comment.nvim',
config = function()
    require('Comment').setup()
end
} ,
}
return config
