# Neovim Lua Config — Code Patterns

Concrete examples from this config. Use these as templates when adding or modifying configuration.

## Plugin Spec (Eager Load)

```lua
-- Theme: loads immediately, highest priority
{
  'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    options = { transparency = false },
  },
  config = function(_, opts)
    require('onedarkpro').setup(opts)
    vim.cmd.colorscheme('onedark')
  end,
},
```

## Plugin Spec (Lazy Load with Keys)

```lua
-- Loads only when keymap is pressed
{
  'mhinz/vim-grepper',
  cmd = "Grepper",
  keys = {
    { "<leader>g", "<cmd>Grepper<CR>", desc = "Open Grepper" },
  },
},
```

## Plugin Spec (Lazy Load with Event)

```lua
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
    -- setup logic...
  end,
},
```

## Plugin Spec (Simple opts)

```lua
-- When config is just passing options through
{
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = { char = "│" },
    scope = { enabled = true },
  },
},
```

## Keymap Helper

```lua
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Normal mode — use <cmd> for Ex commands, always include desc
map('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })

-- Visual mode (maintain selection after indent)
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv|', { desc = 'Indent right and reselect' })

-- Lua function callback
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })

-- Function callback
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Go to previous diagnostic' })
```

## Autocommands

```lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Strip trailing whitespace on save (pure Lua, with augroup)
autocmd("BufWritePre", {
  group = augroup("StripTrailingWhitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
      local trimmed = line:gsub("%s+$", "")
      if trimmed ~= line then
        vim.api.nvim_buf_set_lines(0, i - 1, i, false, { trimmed })
      end
    end
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Filetype detection with augroup
local filetypes = augroup("FileTypeDetection", { clear = true })

autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { ".env", ".env.*", ".envrc" },
  callback = function() vim.bo.filetype = "sh" end,
})
```

## LSP Configuration (Neovim 0.11+)

```lua
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LspAttach keymaps (with augroup and desc)
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

-- Server with custom settings
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

-- Batch of servers with default config
local simple_servers = { 'ruby_lsp', 'pyright', 'ts_ls', 'html', 'cssls', 'jsonls', 'yamlls', 'bashls', 'dockerls', 'marksman' }
for _, server in ipairs(simple_servers) do
  vim.lsp.config(server, { capabilities = capabilities })
end

-- Enable all
vim.lsp.enable({ 'lua_ls', 'elixirls', 'ruby_lsp', 'pyright', 'ts_ls', 'html', 'cssls', 'jsonls', 'yamlls', 'bashls', 'dockerls', 'marksman' })
```

## Options

```lua
-- Use vim.opt for editor settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.laststatus = 3           -- Global status line

-- Use vim.g for global variables
vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

-- Use vim.bo / vim.wo for buffer/window-local
vim.bo.filetype = "elixir"       -- In autocommand callbacks
```

## Mini.nvim Picker Keymaps (in lazy keys spec)

```lua
keys = {
  { "<leader>ff", function() require('mini.pick').builtin.files() end, desc = "Find files" },
  { "<leader>fg", function() require('mini.pick').builtin.grep_live() end, desc = "Live grep" },
  { "<leader>fb", function() require('mini.pick').builtin.buffers() end, desc = "Find buffers" },
  { "<leader>fh", function() require('mini.pick').builtin.help() end, desc = "Find help tags" },
  { "<leader>fr", function() require('mini.extra').pickers.oldfiles() end, desc = "Recent files" },
  { "<leader>t",  function() require('mini.files').open() end, desc = "Open file explorer" },
},
```

## Treesitter Config

```lua
{
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "lua", "elixir", "ruby", "python", ... },
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    }
  end,
},
```

## Which-Key Group Registration

```lua
local wk = require("which-key")
wk.setup({ preset = "modern", delay = 500, win = { border = "rounded" } })

wk.add({
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git/Grep" },
  { "<leader>h", group = "Hunk" },
  { "<leader>l", group = "LSP" },
  -- Add new groups here when introducing new <leader> keymaps
})
```
