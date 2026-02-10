---
name: neovim-lua-config
description: Guide for configuring and optimizing Neovim using Lua. Use when working on neovim configuration, adding or modifying plugins, keymaps, autocommands, LSP setup, completion, treesitter, or any nvim config file. Triggers include mentions of neovim, nvim, lazy.nvim, plugin spec, keymap, autocmd, LSP server, treesitter, mini.nvim, or any file under neovim/. Ensures pure Lua idioms are used — never Vimscript.
---

# Neovim Configuration & Optimization (Lua)

Pure Lua configuration targeting Neovim 0.11+. No Vimscript.

## Architecture

```
neovim/
├── init.lua                   # Bootstrap lazy.nvim, set leaders, load config + plugins
├── lazy-lock.json             # Plugin lock file (do not edit manually)
└── lua/
    ├── config/
    │   ├── options.lua        # vim.opt / vim.g settings
    │   ├── keymaps.lua        # Global keymaps (map() wrapper)
    │   └── autocmds.lua       # Autocommands with augroup/autocmd API
    └── plugins/
        ├── completion.lua     # Mason, LSP config, nvim-cmp, LuaSnip
        ├── editor.lua         # Grepper, quickfix-reflector
        ├── lsp.lua            # Treesitter, lspsaga, lsp_lines
        ├── mini.lua           # mini.nvim suite (pick, files, pairs, comment, surround, ai, splitjoin, extra)
        ├── syntax.lua         # Colorizer, indent-blankline
        └── ui.lua             # Lightline, onedarkpro, gitsigns, fugitive, which-key
```

Each file in `plugins/` returns a Lua table (or list of tables) of lazy.nvim plugin specs.

## Core Conventions

- **Leader**: `,` — **Local leader**: `\` — set in `init.lua` before lazy loads
- **2-space indent**, spaces not tabs, `smartindent`
- **No swapfiles**, system clipboard (`unnamedplus`)
- **Global statusline** (`laststatus = 3`)
- **OneDark theme** everywhere — `onedarkpro.nvim` with lightline `one` colorscheme
- **FiraCode Nerd Font** — assumed across terminal and editor
- **Rounded borders** on all floating windows (Mason, lspsaga, which-key)

## Writing Plugin Specs

Return a table from each `plugins/*.lua` file. Use lazy.nvim conventions:

```lua
return {
  {
    'author/plugin-name',
    event = 'BufReadPost',              -- Lazy-load trigger
    dependencies = { 'dep/plugin' },
    config = function()
      require('plugin').setup({ ... })
    end,
  },
}
```

- Use `event`, `cmd`, `keys`, or `ft` for deferred loading
- Theme and mini.nvim load eagerly (`lazy = false`)
- Prefer `config = function() ... end` over `opts = {}` when setup needs logic
- Use `opts = {}` for simple pass-through configuration
- Lock versions with `version = 'v2.*'` only when needed

## LSP Configuration

**Use the Neovim 0.11+ native API — NOT `lspconfig[server].setup()`.**

```lua
-- Configure a server
vim.lsp.config('server_name', {
  capabilities = capabilities,
  settings = { ... },
})

-- Enable servers
vim.lsp.enable({ 'server1', 'server2' })
```

- Capabilities come from `require('cmp_nvim_lsp').default_capabilities()`
- Mason manages server installation (`mason.nvim` + `mason-lspconfig.nvim`)
- LSP keymaps are set via an `LspAttach` autocommand, not globally
- Neovim 0.11+ also supports file-based config at `lsp/<server>.lua`, but this config uses the programmatic approach via `vim.lsp.config()`
- Current servers: lua_ls, elixirls, ruby_lsp, pyright, ts_ls, html, cssls, jsonls, yamlls, bashls, dockerls, marksman

## Keymaps

Use the local `map()` helper wrapping `vim.keymap.set`:

```lua
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end
```

- **Every keymap must include `desc`** for which-key discoverability
- **Use `<cmd>...<CR>` for Ex commands**, not `:`. The `:` form enters command-line mode (triggering `CmdlineEnter`/`CmdlineLeave` events); `<cmd>` executes silently without a mode switch.

```lua
-- Good
map('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })
-- Bad — enters command-line mode unnecessarily
map('n', '<leader>s', ':w<CR>')
```

Keymap groups (registered in which-key):

| Prefix | Purpose |
|--------|---------|
| `<leader>f` | Find (mini.pick) |
| `<leader>g` | Git/Grep |
| `<leader>h` | Git hunks |
| `<leader>l` | LSP |
| `<leader>r` | Rename |
| `<leader>c` | Code/Clear |
| `<leader>s` | Save |
| `<leader>t` | File tree (mini.files) |
| `<leader>v` | Buffer delete |
| `<leader>m` | Mason |
| `<leader>e` | Diagnostic float |
| `<leader>q` | Quickfix |
| `>` / `<` | Buffer next/prev |

## Autocommands

Always use the Lua API:

```lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  group = augroup("MyGroup", { clear = true }),
  pattern = "*",
  callback = function()
    -- logic here
  end,
})
```

## Options

Set via the Lua API only:

- `vim.opt.setting = value` for editor options
- `vim.g.variable = value` for global variables
- `vim.bo.setting = value` for buffer-local options
- `vim.wo.setting = value` for window-local options

## Anti-Patterns (Never Do)

- **No Vimscript for configuration**: Never use `vim.cmd` for things that have a Lua API (keymaps, autocommands, options). Note: some mature Vimscript plugins (lightline.vim, vim-fugitive, vim-grepper) are kept as deliberate choices for stability — this rule applies to configuration code, not plugin selection.
- **No `require('lspconfig').server.setup()`**: Use `vim.lsp.config()` + `vim.lsp.enable()`
- **No Telescope**: Use `mini.pick` for fuzzy finding
- **No nvim-tree**: Use `mini.files` for file exploration
- **No `vim.api.nvim_set_keymap`**: Use `vim.keymap.set` (the `map()` wrapper)
- **No Vimscript `autocmd`/`augroup`**: Use `vim.api.nvim_create_autocmd` / `nvim_create_augroup`
- **No `:set` via `vim.cmd`**: Use `vim.opt.*`
- **No `:` in keymap RHS**: Use `<cmd>...<CR>` instead of `:...<CR>` for Ex commands
- **No keymaps without `desc`**: Every keymap must have a description for which-key

## Adding a New Plugin

1. Create a new file in `neovim/lua/plugins/` (or add to an existing one if closely related)
2. Return a lazy.nvim spec table
3. Use lazy-loading (`event`, `cmd`, `keys`) when the plugin doesn't need to be always on
4. Register any new `<leader>` groups in `ui.lua` which-key config
5. Document the addition in `CLAUDE.md`

## Reference

See [lua-patterns.md](lua-patterns.md) for concrete code examples from this config.
