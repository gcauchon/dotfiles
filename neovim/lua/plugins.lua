local g = vim.g

-- Autopair
require('nvim-autopairs').setup{}

-- File explorer
require('nvim-tree').setup {
  view = {
    width = 40
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = true,
    ignore = false
  },
  diagnostics = {
    enable = true
  }
}

-- Git gutter
g.gitgutter_map_keys = 0

-- Monokai
require('monokai').setup {
  palette = require('monokai').pro
}

-- lightline
g.lightline = {colorscheme = 'powerline'}
