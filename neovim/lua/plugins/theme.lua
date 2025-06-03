return {
  {
    'tanvirtin/monokai.nvim',
    lazy = false,
    priority = 1000, -- Load theme early
    config = function()
      require('monokai').setup {
        palette = require('monokai').pro
      }
    end
  },
}
