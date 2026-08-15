return {
  "A7Lavinraj/fyler.nvim",
  branch = "stable",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>e",
      function()
        require("fyler").toggle()
      end,
      desc = "Toggle left file explorer",
    },
  },
  opts = {
    views = {
      finder = {
        win = {
          kind = "split_left_most",
        },
      },
    },
  },
}
