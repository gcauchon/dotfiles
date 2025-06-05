return {
  -- Statusline
  { 
    'itchyny/lightline.vim', 
    event = "VeryLazy",
    config = function()
      vim.g.lightline = {
        colorscheme = 'solarized',
        active = {
          left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } },
          right = { { 'lineinfo' }, { 'percent' }, { 'filetype', 'fileformat', 'encoding' } }
        },
        component_function = {
          gitbranch = 'FugitiveHead'
        }
      }
    end
  },
  
  -- Theme
  { 
    'altercation/vim-colors-solarized', 
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('solarized')
    end
  },
  
  -- Git indicators
  { 
    'airblade/vim-gitgutter', 
    branch = 'main',
    event = "BufReadPre",
    config = function()
      vim.g.gitgutter_map_keys = 0
    end
  },
  
  -- Git commands and integration
  {
    'tpope/vim-fugitive',
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GRename" },
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git status" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
      { "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
    },
  },
}