local g = vim.g

-- File explorer
require('nvim-tree').setup {
  view = {
    width = 40
  },
  renderer = {
    icons = {
      git_placement = 'after'
    }
  },
  filters = {
    dotfiles = true
  },
  git = {
    enable = true,
    ignore = false
  },
  diagnostics = {
    enable = true
  }
}

-- Telescope
require('telescope').setup {
  defaults = {
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      grouped = true,
      hidden = true
    }
  }
}
require('telescope').load_extension 'file_browser'

-- Autopair
require('nvim-autopairs').setup{}

-- Git gutter
g.gitgutter_map_keys = 0

-- Monokai
require('monokai').setup {
  palette = require('monokai').pro
}

-- lightline
g.lightline = {coloscheme = 'powerline'}
