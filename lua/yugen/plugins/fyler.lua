return {
  "A7Lavinraj/fyler.nvim",
  branch = "stable",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", "<Cmd>Fyler<CR>", desc = "Open Fyler View" },
  },
  opts = {
    win = {
      kind = "split_right",
    },
  },
}
