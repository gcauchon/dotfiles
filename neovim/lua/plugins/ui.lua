return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 40,
          adaptive_size = false,
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
      
      -- Auto close nvim-tree when it's the last window
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NvimTreeAutoclose", { clear = true }),
        callback = function()
          local winnr = vim.fn.winnr("$")
          if winnr == 1 and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr() then
            vim.cmd "quit"
          end
        end,
        nested = true,
      })
    end,
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in explorer" },
      { "<leader>r", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
      { "<leader>c", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
      { "<leader>o", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
    },
  },
  
  -- Statusline
  { 
    'itchyny/lightline.vim', 
    lazy = false,
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
    config = function()
      vim.g.gitgutter_map_keys = 0
    end
  },
  
  -- Git commands and integration
  {
    'tpope/vim-fugitive',
    lazy = false,
    config = function()
      -- Optional configuration here
    end,
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git status" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
      { "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      local actions = require('telescope.actions')
      
      require('telescope').setup {
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
              ["<C-u>"] = false, -- clear the selection
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
          },
          path_display = { "truncate" },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
          },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              }
            }
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            grouped = true,
            hidden = true
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }
      
      -- Load extensions
      require('telescope').load_extension('file_browser')
      pcall(require('telescope').load_extension, 'fzf')
    end,
    keys = {
      -- Original keymaps
      { "<leader>p", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help tags" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      
      -- Additional useful keymaps
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fF", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Find word under cursor" },
      { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Document diagnostics" },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
}