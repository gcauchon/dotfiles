local g = vim.g

-- Monokai
require('monokai').setup {
  palette = require('monokai').pro
}

-- File explorer
require'nvim-tree'.setup {
  view = {
    width = 40
  }
}

-- Git gutter
g.gitgutter_map_keys = 0

-- lightline
g.lightline = {colorscheme = 'powerline'}
