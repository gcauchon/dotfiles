return {
  -- Statusline
  { 
    'itchyny/lightline.vim', 
    event = "VeryLazy",
    config = function()
      vim.g.lightline = {
        colorscheme = 'one',
        active = {
          left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } },
          right = { { 'lineinfo' }, { 'percent' }, { 'filetype', 'fileformat', 'encoding' } }
        },
        component_function = {
          gitbranch = 'FugitiveHead'
        }
      }
    end
  },
  
  -- Theme
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparency = false,
      }
    },
    config = function(_, opts)
      require('onedarkpro').setup(opts)
      vim.cmd.colorscheme('onedark')
    end,
  },
  
  -- Git signs and hunk operations
  { 
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
        current_line_blame = false, -- Toggle with <leader>gtb
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'Next hunk' })
          
          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'Previous hunk' })
          
          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>hs', function() gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, { desc = 'Stage hunk' })
          map('v', '<leader>hr', function() gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, { desc = 'Reset hunk' })
          map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>hb', function() gs.blame_line({full=true}) end, { desc = 'Blame line' })
          map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
          map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
          map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'Toggle deleted' })
          
          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
        end
      })
    end
  },
  
  -- Git commands and integration
  {
    'tpope/vim-fugitive',
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GRename" },
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git status" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
      { "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
    },
  },

  -- Which-key: keybinding popup guide
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      
      wk.setup({
        preset = "modern",
        delay = 500,
        win = {
          border = "rounded",
        },
      })
      
      -- Register leader key groups
      wk.add({
        { "<leader>l", group = "Lazy" },
        { "<leader>m", group = "Mason" },
        { "<leader>t", group = "Tree" },
        { "<leader>v", group = "Buffer" },
        { "<leader>h", group = "Hunk" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>q", group = "Quickfix" },
        { "<leader>e", group = "Error" },
        { "<leader>s", group = "Save" },
      })
    end,
  },
}
