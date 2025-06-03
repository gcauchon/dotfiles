return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "bash", "lua", "fish", "regex",
          "elixir", "ruby", "python", "javascript", "typescript", "html", "css", "sql",
          "json", "xml", "dockerfile", "markdown", "yaml", "toml",
          "git_config", "git_rebase", "gitignore"
        },
        sync_install = false,
        auto_install = true, -- Auto install missing parsers when entering buffer
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }
    end
  },
}

