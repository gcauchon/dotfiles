local g = vim.g
local opt = vim.opt

-- Change leader to a comma
g.mapleader = ','

-- General
opt.shell = 'fish'
opt.mouse = 'a'                        -- Enable mouse support
opt.clipboard = 'unnamedplus'          -- Copy/paste to system clipboard
opt.swapfile = false                   -- Don't use swapfile
opt.completeopt = 'menuone,noselect'   -- Autocomplete options

-- Memory, CPU
opt.hidden = true                      -- Enable background buffers
opt.history = 100                      -- Remember N lines in history
opt.lazyredraw = true                  -- Faster scrolling
opt.synmaxcol = 240                    -- Max column for syntax highlight
opt.updatetime = 400                   -- ms to wait for trigger 'document_highlight'

-- UI
opt.number = true                      -- Show line number
opt.showmatch = true                   -- Highlight matching parenthesis
opt.ignorecase = true                  -- Ignore case letters when search
opt.smartcase = true                   -- Ignore lowercase for the whole pattern
opt.whichwrap = "h,l,~,[,],<,>"        -- Which caracters to wrap
opt.linebreak = true                   -- Wrap on word boundary
opt.termguicolors = true               -- Enable 24-bit RGB colors

-- Tabs, indent
opt.expandtab = true                   -- Use spaces instead of tabs
opt.tabstop = 2                        -- 1 tab == 2 spaces
opt.smartindent = true                 -- Autoindent new lines
opt.shiftwidth = 2                     -- Shift 2 spaces when tab
opt.backspace = "indent,eol,start"     -- Backspace delete over line breaks and indentation

-- Status
opt.laststatus = 2
opt.showmode = false                   -- Mode is included in Lightline

-- Theme
--opt.colorscheme = 'onedark'
opt.background = 'dark'
opt.cursorline = true

-- Splits
opt.splitright = true                  -- Vertical split to the right
opt.splitbelow = true                  -- Orizontal split to the bottom

-- Search
opt.ignorecase = true                  -- Ignore case when searching
opt.smartcase = true                   -- Smart-case search mode
opt.incsearch  = true                  -- Start to search as soon as we type

-- Disable builtins plugins
local disabled_built_ins = {
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
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- Remove whitespace on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]
