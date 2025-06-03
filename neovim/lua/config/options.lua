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
vim.opt.syntax = "on"                      -- Enable syntax highlighting
vim.opt.signcolumn = "yes"                 -- Always show sign column

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

-- Enhanced syntax highlighting related settings
vim.opt.conceallevel = 0                   -- Don't hide quotes in markdown, etc.
vim.g.vim_json_conceal = 0                 -- Don't hide quotes in JSON
