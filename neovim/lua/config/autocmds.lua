local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove whitespace on save
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

-- File type detection (only for types not detected by Neovim)
local filetypes = augroup("FileTypeDetection", { clear = true })

-- ENV files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { ".env", ".env.*", ".envrc" },
  callback = function() vim.bo.filetype = "sh" end,
})

-- Procfile as yaml
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = "Procfile",
  callback = function() vim.bo.filetype = "yaml" end,
})

-- mix.lock as elixir
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = "mix.lock",
  callback = function() vim.bo.filetype = "elixir" end,
})
