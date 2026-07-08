return {
  -- Claude Code IDE integration (same WebSocket/MCP protocol as the VS Code extension)
  'coder/claudecode.nvim',
  opts = {
    terminal = {
      provider = "native", -- built-in :terminal, no snacks.nvim dependency
      split_side = "right",
      split_width_percentage = 0.35,
    },
    diff_opts = {
      layout = "vertical", -- side-by-side diffs, like VS Code
      open_in_new_tab = false,
    },
    -- If PATH in :terminal ever lacks ~/.local/bin, uncomment:
    -- terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
  },
  cmd = {
    "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSelectModel",
    "ClaudeCodeAdd", "ClaudeCodeSend",
    "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny",
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue session" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
    -- mini.files integration: add file under cursor from the explorer
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", ft = "minifiles", desc = "Add file to Claude" },
    -- Diff review (in a claudecode diff buffer)
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject diff" },
  },
}
