return {
  {
    'echasnovski/mini.nvim',
    version = false, -- Use latest version
    lazy = false,    -- Load at startup
    config = function()
      -- Configure mini.pick
      require('mini.pick').setup({
        options = {
          -- Use ripgrep as the file finder
          use_default_opts = true,
        },
        mappings = {
          choose_in_tabpage = '<C-t>',  -- Built-in action for opening in new tab
          choose_in_split = '<C-s>',    -- Built-in action for horizontal split
          choose_in_vsplit = '<C-v>',   -- Built-in action for vertical split
        },
      })

      -- Setup other useful mini modules
      require('mini.pairs').setup({})  -- Replaces nvim-autopairs
      require('mini.comment').setup({}) -- Commenting functionality
      require('mini.surround').setup({}) -- Surround text objects
      
      -- File explorer (alternative to nvim-tree)
      require('mini.files').setup({
        windows = {
          width = 30,
        },
      })
    end,
    keys = {
      -- File navigation
      { "<leader>ff",  function() require('mini.pick').builtin.files() end, desc = "Find files" },
      { "<leader>fr", function() require('mini.pick').builtin.files({include_hidden = true}) end, desc = "Recent files" },
      
      -- Search
      { "<leader>fg", function() require('mini.pick').builtin.grep_live() end, desc = "Live grep" },
      { "<leader>fw", function() require('mini.pick').builtin.grep({pattern = vim.fn.expand("<cword>")}) end, desc = "Find word under cursor" },
      
      -- Buffers and help
      { "<leader>fb", function() require('mini.pick').builtin.buffers() end, desc = "Find buffers" },
      { "<leader>fh", function() require('mini.pick').builtin.help() end, desc = "Find help tags" },
      
      -- Files explorer
      { "<leader>t", function() require('mini.files').open() end, desc = "Open file explorer" },
    },
  }
}
