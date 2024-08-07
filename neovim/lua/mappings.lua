local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
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
map('n', 'u', '<undo>')
map('n', 'U', ':redo<CR>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- File explorer
map('n', '<leader>t', ':NvimTreeToggle<CR>')
map('n', '<leader>f', ':NvimTreeFindFile<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')

-- Telescope
map('n', '<leader>p', ':Telescope find_files hidden=true<CR>')
map('n', '<leader>ff', ':Telescope find_files hidden=true<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
map('n', '<leader>fh', ':Telescope help_tags<CR>')
map('n', '<leader>fg', ':Telescope live_grep hidden=true<CR>')

-- Grepper
map('', '<leader>g', ':Grepper<CR>')

