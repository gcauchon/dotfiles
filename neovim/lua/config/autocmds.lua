local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto close nvim-tree when it's the last window
autocmd("BufEnter", {
  group = augroup("NvimTreeAutoclose", { clear = true }),
  callback = function()
    local winnr = vim.fn.winnr("$")
    if winnr == 1 and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr() then
      vim.cmd "quit"
    end
  end,
  nested = true,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- File type detection
local filetypes = augroup("FileTypeDetection", { clear = true })

-- ENV files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { ".env", ".env.*", ".envrc" },
  callback = function() vim.opt.filetype = "sh" end,
})

-- Ruby files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { "*.ru", "Gemfile" },
  callback = function() vim.opt.filetype = "ruby" end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = "Procfile",
  callback = function() vim.opt.filetype = "yaml" end,
})

-- tmux files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = ".tmux.conf",
  callback = function() vim.opt.filetype = "tmux" end,
})

-- SASS files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = "*.scss",
  callback = function() vim.opt.filetype = "scss" end,
})

-- Elixir files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = "*.eex",
  callback = function() vim.opt.filetype = "html" end,
})

-- Docker files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = "Dockerfile*",
  callback = function() vim.opt.filetype = "dockerfile" end,
})
