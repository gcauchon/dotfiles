local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')
map('i', '<leader>s', '<C-c>:w<CR>')

-- Indentation
map('v', '<', '<gv')
map('v', '>', '>gv|')
map('v', '<tab>', '>gv|')
map('v', '<s-tab>', '<gv')

-- Destructive 'delete'
map('', '<leader>x', '"_x')
map('', '<leader>d', '"_d')
map('', '<leader>dd', '"_dd')

-- Buffer navigation
map('n', '>', ':bnext<CR>')
map('n', '<', ':bprevious<CR>')
map('n', '<leader>v', ':bdelete<CR>')

-- QuickFix (ie Search, Linter, etc...)
map('', '<leader>q', ':copen<CR>')
map('', '<leader>Q', ':cclose<CR>')

-- " Undo/Redo
map('n', 'U', '<cmd>redo<CR>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- LSP keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
map('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })

-- Mason
map('n', '<leader>m', ':Mason<CR>', { desc = 'Open Mason' })
