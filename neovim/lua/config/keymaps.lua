local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Fast saving with <leader> and s
map('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })
map('i', '<leader>s', '<C-c><cmd>w<CR>', { desc = 'Save file' })

-- Indentation
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv|', { desc = 'Indent right and reselect' })
map('v', '<tab>', '>gv|', { desc = 'Indent right and reselect' })
map('v', '<s-tab>', '<gv', { desc = 'Indent left and reselect' })

-- Delete without yanking (default behavior)
map({ 'n', 'v' }, 'd', '"_d', { desc = 'Delete (black hole)' })
map({ 'n', 'v' }, 'D', '"_D', { desc = 'Delete to end (black hole)' })
map({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete char (black hole)' })

-- Cut (delete + yank) using m
map({ 'n', 'v' }, 'm', 'd', { desc = 'Cut' })
map({ 'n', 'v' }, 'M', 'D', { desc = 'Cut to end' })
map('n', 'mm', 'dd', { desc = 'Cut line' })

-- Buffer navigation
map('n', '>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>v', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })

-- QuickFix (ie Search, Linter, etc...)
map('', '<leader>q', '<cmd>copen<CR>', { desc = 'Open quickfix' })
map('', '<leader>Q', '<cmd>cclose<CR>', { desc = 'Close quickfix' })

-- Undo/Redo
map('n', 'U', '<cmd>redo<CR>', { desc = 'Redo' })

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', '<cmd>nohl<CR>', { desc = 'Clear search highlight' })

-- Diagnostic navigation
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Go to previous diagnostic' })
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Go to next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
map('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })

-- Mason
map('n', '<leader>m', '<cmd>Mason<CR>', { desc = 'Open Mason' })

-- Lazy
map('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open Lazy' })
