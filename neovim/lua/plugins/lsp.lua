return {
  -- Treesitter configuration
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "fish", "lua", "bash", "vim", "vimdoc", "query", "regex",
        "python", "rust", "elixir", "heex", "eex", "ruby", "sql",
        "html", "css", "javascript", "typescript",
        "xml", "json", "markdown", "yaml", "toml", "dockerfile",
        "git_config", "git_rebase", "gitignore",
      },
      auto_install = true,
    },
  },

  -- Treesitter textobjects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  },

  -- LSP UI improvements
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup({
        ui = {
          border = 'rounded',
        },
        lightbulb = {
          enable = false,
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    }
  },

  -- Show diagnostics in virtual text
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    config = function()
      require('lsp_lines').setup()
      -- Disable virtual_text since it's redundant due to lsp_lines
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
}
