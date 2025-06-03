return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    cmd = "Telescope",
    keys = {
      -- File navigation
      { "<leader>p",  "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",   desc = "Recent files" },
      { "<leader>fF", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
      
      -- Search
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "Live grep" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Find word under cursor" },
      
      -- Buffers and help
      { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Find help tags" },
      
      -- Git
      { "<leader>gf", "<cmd>Telescope git_files<CR>",  desc = "Git files" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      
      -- LSP
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Document diagnostics" },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      
      telescope.setup {
        defaults = {
          sorting_strategy = "ascending",
          path_display = { "truncate" },
        },
        
        extensions = {
          file_browser = {
            hijack_netrw = true,
            grouped = true,
            hidden = true
          },
        }
      }
      
      -- Load extensions
      telescope.load_extension('file_browser')
    end,
  },
}