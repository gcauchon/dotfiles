return {
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