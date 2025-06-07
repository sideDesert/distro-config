return {
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", mode = "n", desc = "Tmux left" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", mode = "n", desc = "Tmux right" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", mode = "n", desc = "Tmux down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", mode = "n", desc = "Tmux up" },
  },
}
