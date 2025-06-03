return {
  {
    'tanvirtin/monokai.nvim',
    lazy = false,
    priority = 1000, -- Load theme early
    config = function()
      require('monokai').setup {
        palette = require('monokai').pro,
        custom_hlgroups = {
          -- Enhance specific syntax elements
          TSKeyword = { style = 'bold' },
          TSString = { style = 'italic' },
          TSComment = { style = 'italic' },
          TSFuncBuiltin = { style = 'italic' },
          TSVariableBuiltin = { style = 'italic' },
        }
      }
    end
  },
}
