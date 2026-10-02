return {
  -- Claude Code IDE integration: Claude runs in its own tmux pane, proposed edits open as native diffs here
  {
    'coder/claudecode.nvim',
    lazy = false, -- WebSocket server and lockfile must exist before Claude connects
    opts = {
      terminal = { provider = 'none' }, -- Claude is started by hand in the tmux pane (`/ide` to connect)
      diff_opts = {
        layout = 'vertical',
        open_in_new_tab = true,          -- Keep the current split layout untouched
        on_new_file_reject = 'close_window',
      },
    },
    keys = {
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send selection to Claude' },
      { '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', ft = 'minifiles', desc = 'Add file to Claude' },
    },
  },
}
