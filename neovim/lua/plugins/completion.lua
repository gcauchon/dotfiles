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
        automatic_installation = true,
      })
    end
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
        callback = function(args)
          local function lsp_map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
          end
          lsp_map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          lsp_map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
          lsp_map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
          lsp_map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
          lsp_map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          lsp_map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
          lsp_map('n', 'gr', vim.lsp.buf.references, 'Find references')
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
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  },
}
