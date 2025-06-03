return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {"bash", "lua", "elixir", "python", "dockerfile", "javascript", "typescript", "html", "css", "json", "yaml", "markdown"},
        sync_install = false,
        highlight = {
          enable = true
        }
      }
    end
  },
}

