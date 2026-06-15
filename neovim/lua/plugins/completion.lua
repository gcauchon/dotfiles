return {
  -- Mason for managing LSP servers, linters, formatters
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },

  -- Mason integration with lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',           -- Lua
          'elixirls',         -- Elixir
          'ruby_lsp',         -- Ruby
          'pyright',          -- Python
          'ts_ls',            -- TypeScript/JavaScript
          'html',             -- HTML
          'cssls',            -- CSS
          'jsonls',           -- JSON
          'yamlls',           -- YAML
          'bashls',           -- Bash
          'dockerls',         -- Docker
          'marksman',         -- Markdown
        },
        -- automatic_enable is false because we call vim.lsp.enable() explicitly below
        automatic_enable = false,
      })
    end
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'saghen/blink.cmp' },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
        callback = function(args)
          local function lsp_map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
          end
          -- gd, K, gi/gri, grn, gra, grr are all provided by Neovim 0.12 defaults
          lsp_map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          lsp_map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
          lsp_map('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, 'Format buffer')
        end,
      })

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config('elixirls', {
        capabilities = capabilities,
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false,
          },
        },
      })

      -- Servers with default config
      local simple_servers = {
        'ruby_lsp', 'pyright', 'ts_ls', 'html', 'cssls',
        'jsonls', 'yamlls', 'bashls', 'dockerls', 'marksman',
      }
      for _, server in ipairs(simple_servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      -- Enable all configured servers
      vim.lsp.enable({
        'lua_ls', 'elixirls', 'ruby_lsp', 'pyright', 'ts_ls',
        'html', 'cssls', 'jsonls', 'yamlls', 'bashls', 'dockerls', 'marksman',
      })
    end
  },

  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local luasnip = require('luasnip')

      -- Load VSCode-style snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Configure snippet behavior
      luasnip.config.set_config({
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
      })
    end
  },

  -- Autocompletion
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'L3MON4D3/LuaSnip' },
    opts = {
      keymap = { preset = 'default' },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      cmdline = {
        sources = { 'cmdline', 'path' },
      },
      completion = {
        menu = {
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'source_name' },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
    },
  },
}
