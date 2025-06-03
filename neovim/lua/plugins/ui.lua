return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeFocus", "NvimTreeRefresh", "NvimTreeCollapse" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in explorer" },
      { "<leader>r", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
      { "<leader>c", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
      { "<leader>o", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
    },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 40,
          side = "left",
        },
        renderer = {
          icons = {
            git_placement = 'after',
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
          highlight_git = true,
          indent_markers = {
            enable = true,
          },
        },
        filters = {
          dotfiles = true,
          custom = { "^.git$", "^node_modules$", "^.cache$" },
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "󰌵",
            info = "",
            warning = "",
            error = "",
          },
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = true,
            },
            resize_window = true,
          },
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
      }
    end,
  },
  
  -- Statusline
  { 
    'itchyny/lightline.vim', 
    event = "VeryLazy",
    config = function()
      vim.g.lightline = {
        colorscheme = 'powerline',
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
  -- { 
  --   'tanvirtin/monokai.nvim', 
  --   lazy = false,
  --   config = function()
  --     require('monokai').setup {
  --       palette = require('monokai').pro
  --     }
  --   end
  -- },
  
  -- Git indicators
  { 
    'airblade/vim-gitgutter', 
    branch = 'main',
    event = "BufReadPre",
    config = function()
      vim.g.gitgutter_map_keys = 0
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
}