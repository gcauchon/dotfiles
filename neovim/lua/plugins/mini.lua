return {
  {
    'echasnovski/mini.nvim',
    version = false, -- Use latest version
    lazy = false,    -- Load at startup
    config = function()
      -- Configure mini.pick
      require('mini.pick').setup({
        mappings = {
          choose_in_tabpage = '<C-t>',
          choose_in_split = '<C-s>',
          choose_in_vsplit = '<C-v>',
        },
      })

      -- Extra pickers (oldfiles, etc.)
      require('mini.extra').setup({})

      -- Setup other useful mini modules
      require('mini.pairs').setup({})  -- Replaces nvim-autopairs
      require('mini.comment').setup({}) -- Commenting functionality
      require('mini.surround').setup({}) -- Surround text objects
      
      -- Enhanced text objects (quotes, brackets, function calls, etc.)
      require('mini.ai').setup({
        n_lines = 500, -- Search up to 500 lines for text objects
        custom_textobjects = {
          -- Additional custom text objects
          o = require('mini.ai').gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = require('mini.ai').gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = require('mini.ai').gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- HTML tags
        },
      })
      
      -- Smart split/join (split function arguments, array elements, etc.)
      require('mini.splitjoin').setup({
        mappings = {
          toggle = 'gS', -- Toggle between split and join
        },
      })
      
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
      { "<leader>fr", function() require('mini.extra').pickers.oldfiles() end, desc = "Recent files" },
      
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
