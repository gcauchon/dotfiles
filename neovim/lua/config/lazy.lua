-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

-- General
vim.opt.shell = 'fish'
vim.opt.mouse = 'a'                        -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'          -- Copy/paste to system clipboard
vim.opt.swapfile = false                   -- Don't use swapfile
vim.opt.completeopt = 'menuone,noselect'   -- Autocomplete options

-- Memory, CPU
vim.opt.hidden = true                      -- Enable background buffers
vim.opt.history = 100                      -- Remember N lines in history
vim.opt.lazyredraw = true                  -- Faster scrolling
vim.opt.synmaxcol = 240                    -- Max column for syntax highlight
vim.opt.updatetime = 400                   -- ms to wait for trigger 'document_highlight'

-- UI
vim.opt.number = true                      -- Show line number
vim.opt.showmatch = true                   -- Highlight matching parenthesis
vim.opt.ignorecase = true                  -- Ignore case letters when search
vim.opt.smartcase = true                   -- Ignore lowercase for the whole pattern
vim.opt.whichwrap = "h,l,~,[,],<,>"        -- Which caracters to wrap
vim.opt.linebreak = true                   -- Wrap on word boundary
vim.opt.termguicolors = true               -- Enable 24-bit RGB colors

-- Tabs, indent
vim.opt.expandtab = true                   -- Use spaces instead of tabs
vim.opt.tabstop = 2                        -- 1 tab == 2 spaces
vim.opt.smartindent = true                 -- Autoindent new lines
vim.opt.shiftwidth = 2                     -- Shift 2 spaces when tab
vim.opt.backspace = "indent,eol,start"     -- Backspace delete over line breaks and indentation

-- Status
vim.opt.laststatus = 3                     -- Global status line (Neovim 0.7+)
vim.opt.showmode = false                   -- Mode is included in Lightline

-- Theme
--vim.opt.colorscheme = 'onedark'
vim.opt.background = 'dark'
vim.opt.cursorline = true

-- Splits
vim.opt.splitright = true                  -- Vertical split to the right
vim.opt.splitbelow = true                  -- Orizontal split to the bottom

-- Filetype settings
vim.g.do_filetype_lua = 1                   -- Use filetype.lua
vim.g.did_load_filetypes = 0                -- Don't use filetype.vim

-- Search
vim.opt.ignorecase = true                  -- Ignore case when searching
vim.opt.smartcase = true                   -- Smart-case search mode
vim.opt.incsearch  = true                  -- Start to search as soon as we type

-- Remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false,               -- Load plugins on startup by default
    version = false,            -- Use latest git commit
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "onedark"} },
  -- automatically check for plugin updates
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "tutor",
        "man",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
        "shada_plugin",
        "rplugin",
        "syntax_completion",
      },
    },
  },
})
