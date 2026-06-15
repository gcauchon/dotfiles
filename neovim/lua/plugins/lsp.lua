-- Use Neovim 0.11+ native virtual_lines instead of lsp_lines.nvim
vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = false,
  severity_sort = true,
  signs = true,
  underline = true,
})

return {
  -- Treesitter configuration (nvim-treesitter main-branch API)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      -- Install parsers (idempotent — skips already-installed ones)
      require('nvim-treesitter').install({
        "fish", "lua", "bash", "vim", "vimdoc", "query", "regex",
        "python", "rust", "elixir", "heex", "eex", "ruby", "sql",
        "html", "css", "javascript", "typescript",
        "xml", "json", "markdown", "yaml", "toml", "dockerfile",
        "git_config", "git_rebase", "gitignore",
      })

      -- Enable highlighting + treesitter-backed indent per filetype
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
        callback = function(args)
          if pcall(vim.treesitter.start) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Textobjects configuration
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move  = { set_jumps = true },
      })

      -- Textobject select keymaps
      local sel = require('nvim-treesitter-textobjects.select')
      local select_map = {
        af = '@function.outer', ['if'] = '@function.inner',
        ac = '@class.outer',    ic = '@class.inner',
        aa = '@parameter.outer', ia = '@parameter.inner',
      }
      for key, capture in pairs(select_map) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          sel.select_textobject(capture, 'textobjects')
        end, { silent = true, desc = 'TS select ' .. capture })
      end

      -- Textobject move keymaps
      local mov = require('nvim-treesitter-textobjects.move')
      local move_map = {
        [']m']  = { 'goto_next_start',     '@function.outer' },
        [']]']  = { 'goto_next_start',     '@class.outer'    },
        [']M']  = { 'goto_next_end',       '@function.outer' },
        ['][']  = { 'goto_next_end',       '@class.outer'    },
        ['[m']  = { 'goto_previous_start', '@function.outer' },
        ['[[']  = { 'goto_previous_start', '@class.outer'    },
        ['[M']  = { 'goto_previous_end',   '@function.outer' },
        ['[]']  = { 'goto_previous_end',   '@class.outer'    },
      }
      for key, spec in pairs(move_map) do
        local fn, capture = spec[1], spec[2]
        vim.keymap.set({ 'n', 'x', 'o' }, key, function()
          mov[fn](capture, 'textobjects')
        end, { silent = true, desc = 'TS ' .. fn .. ' ' .. capture })
      end
    end
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

}
