return {
  -- Auto pairs
  { 
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  },
  
  -- Grepper
  {
    'mhinz/vim-grepper',
    keys = {
      { "<leader>g", ":Grepper<CR>", desc = "Open Grepper" },
    },
  },
  
  -- Quickfix reflector
  { 'stefandtw/quickfix-reflector.vim' },
}