return {
  -- Better syntax highlighting for specific languages
  { 
    'sheerun/vim-polyglot',
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- Enable enhanced syntax highlighting
      vim.g.polyglot_disabled = {'sensible'} -- Avoid conflicts with Neovim's sensible defaults
    end,
  },
  
  -- Highlight color codes
  {
    'norcalli/nvim-colorizer.lua',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('colorizer').setup({
        '*'; -- Highlight all files
        css = { css = true; }; -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        html = { names = false; }; -- Disable parsing "names" like Blue or Gray
      })
    end
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },
}
