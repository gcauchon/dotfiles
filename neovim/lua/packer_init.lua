vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- Shows git diff in the gutter and stages/undoes hunks
  use {'airblade/vim-gitgutter', branch = 'main'}

  -- Treesitter configurations and abstraction layer for Neovim
  use 'nvim-treesitter/nvim-treesitter'

  -- Common configurations for Neovim's built-in language server client
  use 'neovim/nvim-lspconfig'

  -- Completion engine plugin for Neovim
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip'
    },
  }

  -- Super powerful autopair plugin for Neovim
  use 'windwp/nvim-autopairs'


  -- Helps you win at grep
  use 'mhinz/vim-grepper'

  -- Find/Replace from the Quickfix window
  use 'stefandtw/quickfix-reflector.vim'

  -- File explorer for Neovim
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }

  -- Highly extendable fuzzy finder over lists
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons'
    }
  }

  -- File browser extension for telescope.nvim.
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }

  -- Light and configurable statusline/tabline
  use 'itchyny/lightline.vim'

  -- Themes
  use 'tanvirtin/monokai.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
