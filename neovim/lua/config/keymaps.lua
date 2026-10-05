local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Fast saving with <leader> and s
map('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })

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

-- Buffer navigation ([b / ]b are built in), delete without closing the window
map('n', '<leader>v', function() require('mini.bufremove').delete() end, { desc = 'Delete buffer' })

-- QuickFix (ie Search, Linter, etc...)
map('', '<leader>q', '<cmd>copen<CR>', { desc = 'Open quickfix' })
map('', '<leader>Q', '<cmd>cclose<CR>', { desc = 'Close quickfix' })

-- Undo/Redo
map('n', 'U', '<cmd>redo<CR>', { desc = 'Redo' })

-- Clear search highlighting
map('n', '<Esc>', '<cmd>nohl<CR>', { desc = 'Clear search highlight' })

-- Diagnostic navigation
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Go to previous diagnostic' })
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Go to next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
map('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })

-- Mason
map('n', '<leader>m', '<cmd>Mason<CR>', { desc = 'Open Mason' })

-- Lazy
map('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open Lazy' })
