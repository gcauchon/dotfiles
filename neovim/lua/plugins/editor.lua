return {
  -- Auto pairs
  { 
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup{}
    end
  },
  
  -- Grepper
  {
    'mhinz/vim-grepper',
    cmd = "Grepper",
    keys = {
      { "<leader>g", ":Grepper<CR>", desc = "Open Grepper" },
    },
  },
  
  -- Quickfix reflector
  { 
    'stefandtw/quickfix-reflector.vim',
    event = { "BufReadPost quickfix" },
  },
}